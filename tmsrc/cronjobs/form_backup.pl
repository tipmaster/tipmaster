#! /usr/bin/perl

use File::Copy qw(copy);

# config part
print "Start auto backup of forms\n";


use lib "/tmapp/tmsrc/cgi-bin/cl";

my @rounds = ("Q1","Q2","Q3","G1","G2","AC","VI","HA","FI");
my %roundnr = ("Q1",1,"Q2",2,"Q3",3,"G1",4,"G2",5,"AC",6,"VI",7,"HA",8,"FI",9);
my %filenameprefix = ("U","UEFA","C","DATA");


my @domains = ("btm","tmi");
my $changed = 0;
foreach my $ad (@domains) {
	my $data_dir = "/tmdata/".$ad;	
	for (1..9) {
	my $round = $_;
	  my $formnameOrig = $data_dir."/formular".$round.".txt";
	  my $formnameBack = $data_dir."/formular".$round."_backup.txt";
	  if (!-e $formnameOrig) {
		print $formnameOrig . " does not exist. Ignore Backup!\n";
	  } else {

		  my $backupFill = countFilledGames($formnameBack);
		  my $origFill = countFilledGames($formnameOrig);
	  
		  if ($origFill > $backupFill or !-e $formnameBack) {
		# copy backup over
			print "Aenderung an $formnameOrig festgestellt. Mache backup!\n";
			copy $formnameOrig, $formnameBack;
			$changed++;
		  }
		}
	}
}
print "Made backup of $changed form files\n";
exit 0;


sub countFilledGames() {
  
  my $formname = shift;
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
  return $fullcount;
}

