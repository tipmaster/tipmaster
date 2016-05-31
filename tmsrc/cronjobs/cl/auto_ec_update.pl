#! /usr/bin/perl

# This script automagically looks for possible EC 
# evaluations and updates

# config part
my $data_dir = "/tmdata/cl";
use lib "/tmapp/tmsrc/cgi-bin/cl";

my $DATA_MISSING = 1;
my $DATA_EMPTY = 2;
my $DATA_FULL = 3;
my $DATA_ERROR = 4;

# constants
my @rounds = ("Q1","Q2","Q3","G1","G2","AC","VI","HA","FI");
my %roundnr = ("Q1",1,"Q2",2,"Q3",3,"G1",4,"G2",5,"AC",6,"VI",7,"HA",8,"FI",9);
my %filenameprefix = ("U","UEFA","C","DATA");

### do not run before saison has started
my $now = time;
my $limit = 1451994591;
if ($now < $limit) { #di jan 5, 2016
	print "No round change, $now vs $limit, timestamp for activation not reached yet!\n";
	exit;
}

gofillout();
gocreate();
checkSoftLink();
exit;

sub gofillout() {
    foreach $a_round (@rounds) {
      if (isFormFull($a_round) && &checkData($a_round,"U") == $DATA_EMPTY) {
	fillout($a_round,"U");
      }
      if (isFormFull($a_round) && &checkData($a_round,"C") == $DATA_EMPTY) {
	fillout($a_round,"C");
      }
    }
}

sub gocreate() {
  foreach $a_nr (0..8) {
    if (checkData($rounds[$a_nr],"C") == $DATA_FULL &&
	checkData($rounds[$a_nr+1],"C") == $DATA_MISSING) {
      createCL($rounds[$a_nr+1]);
    }
    if (checkData($rounds[$a_nr],"U") == $DATA_FULL &&
	checkData($rounds[$a_nr+1],"U") == $DATA_MISSING) {
      createUefa($rounds[$a_nr+1]);
    }
  }
}

sub checkSoftLink() {
	my $filetocheck = "/tmdata/cl/DATA_G1.DAT";
	my $secondfile = "/tmdata/cl/DATA_G2.DAT";
	if (-e $filetocheck) {
		if (!-e $secondfile) {
			my $command = "ln -s $filetocheck $secondfile";
			`$command`;
		}
	}

}

sub createCL() {
  my $round = shift;
  if ($round eq "G2") {
    print "Could create G2... but we don't need that. Should never happen...";
  }
  print "Creating data for CL / round $round\n";
  # TODO: Create CL Data File
  my $cmd = "/tmapp/tmsrc/cgi-bin/cl/datenerstellung.pl $round";
  print "Doing $cmd!\n";
  `$cmd`;
}

sub createUefa() {
  my $round = shift;
  print "Creating data for UEFA / round $round\n";
  # TODO: Create UEFA Data File
  my $cmd = "/tmapp/tmsrc/cgi-bin/cl/uefa_datenerstellung.pl $round";
  print "Doing $cmd!\n";
  `$cmd`;
}

sub fillout() {
  my $round = shift;
  my $uorc = shift;
  print "Filling out $round / $uorc\n";
  # TODO: Fill out results.
  my $cmd = "/tmapp/tmsrc/cgi-bin/cl/auswerter.pl $round $uorc";
  print "Doing $cmd!\n";
  `$cmd`;
}


sub test() {
  foreach $a_round (@rounds) {
    print "Round $a_round. FormFull: ",&isFormFull($a_round),"\n";
    print "Data UEFA: ",&checkData($a_round,"U"),"\n";
    print "DATA CL  : ",&checkData($a_round,"C"),"\n";
  }
}



## check whether data file is there/empty/full
sub checkData() {
  my $uorc = shift;
  my $round = shift;



  if ($round eq "C" || $round eq "U") {
    my $x = $round; $round = $uorc; $uorc = $x;
  }

  print "Checking $round / $uorc\n";

  if (!$round or !$uorc) {
    return $DATA_ERROR;
  }

  my $dataname = $data_dir."/".$filenameprefix{$uorc}."_".$round.".DAT";
  if (!-e $dataname) {
    #print "File not found: $dataname\n";
    return $DATA_MISSING;
  }

  open(K,"<$dataname") or die "Not missing but not opening. Strange: $!";
  my $fullline = 0;my $lines = 0;
  while (<K>) {
    chomp;
    my $line = $_;
    $lines++;

    if ($line =~  /\d&\d+&\d+&/) {
      if ($uorc eq "U" or ($round ne "G1" && $round ne "G2")) {
	if ($line =~ /-:-/) {
	  close(K);
	  return $DATA_EMPTY;
	}
	if ($line =~ /\d+&\d+&\d+&(\d+|-1):(\d+|-1)/) {
	  $fullline++;
	}
	
      } else {
	# must be a cl group file
	if ($line =~ /-:-&-:-&-:-&-:-&-:-&-:-/) {
	  # this is an empty line
	  close(K);
	  return $DATA_EMPTY;
	}
	if ($line =~ /(\d+|-1):(\d+|-1)&(\d+|-1):(\d+|-1)&(\d+|-1):(\d+|-1)&-:-/) {
	  # this is a half filled line
	  if ($round eq "G1") {
	    #print "Line $line is full for G1\n";
	    $fullline++;
	  } else {
	    close(K);
	    return $DATA_EMPTY;
	  }
	}
	if ($line =~ /(\d+|-1):(\d+|-1)&(\d+|-1):(\d+|-1)&(\d+|-1):(\d+|-1)&(\d+|-1):(\d+|-1)/) {
	  #print "Line $line is full\n";
	  # this is a fully filled line
	  $fullline++;
	}
      }
    }
  }
  close(K);
  if ($fullline == $lines) {
    return $DATA_FULL;
  }
  return $DATA_ERROR;
}


## check whether form is full

sub isFormFull() {
  my $round = shift;
  if (!$round) {
    #print "No Round given.\n";
    return 0;
  }
  $formname = $data_dir."/formular".$round.".txt";
  if (!-e $formname) {
    #print "Form for $round ($formname) does not exist\n";
    return 0;
  }
  open(K,"<$formname") or return 0;
  my $fullcount = 0;
  while (<K>) {
    chomp;
    my $line = $_;
    if ($line =~ /\d+&\d+&\d+/) {
      @entries = split(/&/,$line);
      #print "Found entry ",$entries[5]," (Game ",$entries[1],")\n";
      if ($entries[5] > 0) {
	$fullcount++;
      }
    }
  }
  close(K);
  if ($fullcount == 25) {
    #print "Formular $round is completed\n";
    return 1;
  } else {
    #print "Formular has only $fullcount entries\n";
    return 0;
  }
}

