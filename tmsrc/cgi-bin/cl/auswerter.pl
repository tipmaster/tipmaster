#! /usr/bin/perl

# Auswerteskript fuer den Europapokal
# nur per Kommandozeile bedienbar.
#
# schreibt Daten final in DATA_xx bzw UEfA_xx rein,
# und ermoeglicht dadurch neue Auslosung.

my $debug = 0;
use lib "/tmapp/tmsrc/cgi-bin";

use CLTeam;
use CLLibrary;

#Parameter
my $runde = shift @ARGV;
my $uorc = shift @ARGV;

my $cllib = new CLLibrary();

my $verz = $CLLibrary::verz;

if ($runde eq "C" || $runde eq "U") {
  $hlp = $runde; $runde = $uorc; $uorc = $hlp;
}

if (!$runde) {
  $runde = $cllib->getCurrentCLRound();
}

my @data_strings = ();

# Alle Eintraege der Daten abarbeiten, Ergebnisse
# zusammensuchen und in den Datenstring eintragen.
# Nicht angetreten fuehrt zu -1

my $frm = $cllib->readFormular($runde);
@data_strings = ();
print "Auswertung fuer Runde $runde\n";

if ($uorc eq "C") {

  if ($runde ne "G1" && $runde ne "G2" && $runde ne "G3") {
    #KO-Auswertung.
    open(K,"<$verz/DATA_${runde}.DAT") or die "Cannot access data file";
    while(<K>) {
      (my $lfd,my $team1id,my $team2id,my $erg1,my $erg2) = split(/&/,$_);
      if ($lfd >= 0 && !$team1id eq "" && !$team2id eq "") {
	if ($team2id ne "FREILOS") {
	  $data_strings[$lfd] = "$lfd&$team1id&$team2id&".calcTips($team1id, $team2id,$uorc,"C")."\n";
	  print $data_strings[$lfd];
	} else {
	  $data_strings[$lfd] = $_;
	  print $data_strings[$lfd];	  
	}
      }
    }
    close(K);
    if ($runde eq "FI") {
	$data_strings[0] =~ s/0&0://g;
    }	
    open (X,">$verz/DATA_${runde}.DAT") or die "Cannot write new data file";
    foreach $a_ds (@data_strings) {
      print X $a_ds;
    }
    close(X);

  } else {
    @grptms = $cllib->readGroupInfo();
    #Rundenauswertung, Version fuer 2 Spielrunden
    if ($runde eq "G1") {$horr = 1;} else {$horr = 2;}
    print "Horr is $horr\n";
    for (my $grp = 1; $grp <=8 ;$grp++) {
      for (my $sptag = $horr*3-2; $sptag <= $horr*3; $sptag++) {
	for ($s = 1; $s <= 2; $s++) {
	  (my $k1, my $k2) = $cllib->getSlot($sptag,$s);
	  #print "<!-- Hashval: ",$grptms[($grp-1)*4+$k1-1]," //-->\n";
	  my $heim = $grptms[($grp-1)*4+$k1-1];
	  my $gast = $grptms[($grp-1)*4+$k2-1];
	  $result = calcTips($heim->id, $gast->id,$uorc,"C",$sptag);
	  #print "Got result $result for ",$heim->team," - ",$gast->team," \n";
	  $heim->insertGame($sptag,$result);
	  ($t1,$t2) = split(/:/,$result);
	  $gast->insertGame($sptag,"$t2:$t1");
	}
      }
    }
    my $grp_ref = \@grptms;
    print "Now writing group info with $grp_ref,  CLLIB is ",$cllib,"\n";
    $cllib->writeGroupInfo($grp_ref);
  }

} elsif ($uorc eq "U") {
  # Works for all instances
  open(K,"<$verz/UEFA_${runde}.DAT") or die "Cannot access data file";
  while(<K>) {
    (my $lfd,my $team1id,my $team2id,my $erg1,my $erg2) = split(/&/,$_);
    if ($lfd >= 0) {
      if ($team2id ne "FREILOS") {
	$data_strings[$lfd] = "$lfd&$team1id&$team2id&".calcTips($team1id, $team2id,$uorc,"U")."\n";
	print $data_strings[$lfd];
      } else {
	$data_strings[$lfd] = $_;
	print $data_strings[$lfd];
      }
    }
  }
    if ($runde eq "FI") {
        $data_strings[0] =~ s/0&0://g;
    }

  close(K);
  open (X,">$verz/UEFA_${runde}.DAT") or die "Cannot write new data file";
  foreach $a_ds (@data_strings) {
    print X $a_ds;
  }
  close(X);
  
  
} 

sub calcTips {
  my $t1id = shift;
  my $t2id = shift;
  my $rund = shift;
  my $uorc = shift;
  my $gamenum = shift;

  my $retstring = "";

  $filename1 = "$verz/tips/${uorc}_${runde}_$t1id.TIP";
  $filename2 = "$verz/tips/${uorc}_${runde}_$t2id.TIP";

  my $formularerg = $cllib->readFormular($runde);
 
  print "<!-- gamenum: $gamenum $f1: $filename1 / $filename2 //-->\n";
 
  # Hinspiel
  if (!$gamenum) {
    $g1 = 1; $g2 = 2;
  } else {
    if ($gamenum>3) {$gamenum -=3;}
    $g1 = $gamenum; $g2 = $gamenum;
  }

  @tips1 = $cllib->getTipsFromFile($filename1,$g1);
  @tips2 = $cllib->getTipsFromFile($filename2,$g2);
  

  @tips1 = $cllib->fillTip(5,@tips1);
  @tips2 = $cllib->fillTip(4,@tips2);

  ($pkt1,undef) = $cllib->games($formularerg,@tips1);
  ($pkt2,undef) = $cllib->games($formularerg,@tips2);
  
  print "<!-- Called games: Erg is $pkt1 / $pkt2 //-->\n";

  $retstring = "$pkt1:$pkt2";

  if ($runde =~ /G\d/ && $uorc eq "C") {
    return $retstring;
  }

  #Rueckspiel
  @tips1 = $cllib->getTipsFromFile($filename1,2);
  @tips2 = $cllib->getTipsFromFile($filename2,1);
  @tips2 = $cllib->fillTip(5,@tips2);
  @tips1 = $cllib->fillTip(4,@tips1);
  
  ($pkt1,undef) = $cllib->games($formularerg,@tips1);
  ($pkt2,undef) = $cllib->games($formularerg,@tips2);
  $retstring .= "&$pkt1:$pkt2";

  return $retstring;
}




sub einpflegen {
  my $teamnr = shift;
  my $result = shift;
  my $sptag = shift;
  print "Einpflegen called with $teamnr, $result, $sptag\n";
  my $team = $grptms[$teamnr];
  print "Spielstring von ",$team->team,"(",$team->id,"): ",$team->games,"\n";
  my @gams = $team->games;
  $gams[$sptag-1] = $result;
  $team->games(join("&",@gams));
  print "Now it is: ",$team->games," - ";
  ($grptms[$teamnr])->games(join("&",@gams));
  print "From source: ",($grptms[$teamnr])->exportstring,"\n";
  print "Check vs 1 : ",($grptms[1])->exportstring,"\n";
}
