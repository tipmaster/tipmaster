#! /usr/bin/perl

# Auswerteskript fuer den Europapokal
# nur per Kommandozeile bedienbar.
#
# schreibt Daten final in DATA_xx bzw UEfA_xx rein,
# und ermoeglicht dadurch neue Auslosung.

my $debug = 0;
use lib "/tmapp/tmsrc/cgi-bin/cl";

use Clteam;

#Parameter
$runde = shift @ARGV;
$uorc = shift @ARGV;

do '/tmapp/tmsrc/cgi-bin/cl/library.pl';
if (!-e "$verz/ID.dat") {
	$verz = "/tmdata/cl"; 
}

if ($runde eq "C" || $runde eq "U") {
  $hlp = $runde; $runde = $uorc; $uorc = $hlp;
}

if (!$runde) {
  $runde = $derzeitige_runde;
}

@data_strings = ();

# Alle Eintraege der Daten abarbeiten, Ergebnisse
# zusammensuchen und in den Datenstring eintragen.
# Nicht angetreten fuehrt zu -1

my $frm = readFormular($runde);
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
    &readGroupInfo();
    #Rundenauswertung, Version fuer 2 Spielrunden
    if ($runde eq "G1") {$horr = 1;} else {$horr = 2;}
    print "Horr is $horr\n";
    for (my $grp = 1; $grp <=8 ;$grp++) {
      for (my $sptag = $horr*3-2; $sptag <= $horr*3; $sptag++) {
	for ($s = 1; $s <= 2; $s++) {
	  (my $k1, my $k2) = &getSlot($sptag,$s);
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
    writeGroupInfo();
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

  my $formularerg = &readFormular($runde);
 
  print "<!-- gamenum: $gamenum $f1: $filename1 / $filename2 //-->\n";
 
  # Hinspiel
  if (!$gamenum) {
    $g1 = 1; $g2 = 2;
  } else {
    if ($gamenum>3) {$gamenum -=3;}
    $g1 = $gamenum; $g2 = $gamenum;
  }

  @tips1 = &getTipsFromFile($filename1,$g1);
  @tips2 = &getTipsFromFile($filename2,$g2);
  

  @tips1 = fillTip(5,@tips1);
  @tips2 = fillTip(4,@tips2);

  ($pkt1,undef) = &games($formularerg,@tips1);
  ($pkt2,undef) = &games($formularerg,@tips2);
  
  print "<!-- Called games: Erg is $pkt1 / $pkt2 //-->\n";

  $retstring = "$pkt1:$pkt2";

  if ($runde =~ /G\d/ && $uorc eq "C") {
    return $retstring;
  }

  #Rueckspiel
  @tips1 = &getTipsFromFile($filename1,2);
  @tips2 = &getTipsFromFile($filename2,1);
  @tips2 = fillTip(5,@tips2);
  @tips1 = fillTip(4,@tips1);
  
  ($pkt1,undef) = &games($formularerg,@tips1);
  ($pkt2,undef) = &games($formularerg,@tips2);
  $retstring .= "&$pkt1:$pkt2";

  return $retstring;
}


sub readFormular_local {
  my $runde = shift;

  #dummy-eintrag.
  $tipgame{10}{match} = "Kein Tip abgegeben";
  $tipgame{10}{erg} = 8;

  $formularname = "$verz/formular${runde}.txt";
  open(G,"<$formularname") or die "Cannot open formular $formularname: $!";
  $lfd = 10;
  while(<G>) {
    $line = $_;
    if ($line =~ /4&(a.*?)&/) {  
        my $subst = $1;
      $line =~ s/$subst/_ : _/;
      $line =~ s/abge./_ : _/;
      $line =~ s/ausg./_ : _/;
    }
    
    if ($line =~ /&(.*?)&(\d+)&(\d+)&(\d+)&(\d)&(\d|_) ?: ?(\d|_)&/ ) {
      $lfd++;
      $tipgame{$lfd}{match} = $1;
      $tipgame{$lfd}->{1}  = $2;
      $tipgame{$lfd}->{0}  = $3;
      $tipgame{$lfd}->{2}  = $4;
      print "<!-- Now checking $1, lfd $lfd, Eingetragen $5, $6, $7&nbsp;\n";
      $debug && print "<!-- Now checking $1, lfd $lfd, Eingetragen $5, $6, $7&nbsp;\n";
      if ($5 < 4) {
	if ($6>$7) { $tipgame{$lfd}->{erg} = 1;}
	if ($6==$7) {$tipgame{$lfd}->{erg} = 0;}
	if ($6<$7) { $tipgame{$lfd}->{erg} = 2;}
	if ($6 eq "_") {$tipgame{$lfd}->{erg} = 3;}
      } else {
	$tipgame{$lfd}->{erg} = 9;
      }
      print "Result: ",$tipgame{$lfd}->{erg},"//-->\n";
      $debug && print "Result: ",$tipgame{$lfd}->{erg},"//-->\n";
    }
  }
  close(G);
}



# extract tip numbers from tipfile
sub getTipsFromFile_local {
  my $filename = shift;
  my $tipno = shift;
  my @tips = ();
  
  # iterate over tokens and look for tipno
  if (-e $filename) {
    open (G,"<$filename");
    $spstring = <G>;
    chomp $spstring;
    close(G);
    my @t = split(/&/,$spstring);
    for (1..25) {
      (my $spnum,my $erg) = split(/_/,$t[$_]);
	#print "Hit $t[$_] on searching $tipno => $erg<br>\n";
      if ($spnum == $tipno) {
	push @tips,"${_}_$erg";
      }
    }
    $debug && print "<!-- Returning from $filename: @tips //-->\n";
    return @tips;
  } else {
    $debug && print "<!-- File not found: $filename! //-->\n";
    return ();
  }
}


sub games_local {
  my @tips = @_;
  my $pts = 0;

  $valid_tip = 0;
  $ret = "<TABLE BORDER=0 cellpadding=0 cellspacing=0>\n";
  foreach $a_tip (@tips) {
    $class = "";
    ($lfd,$guess) = split(/_/,$a_tip);
    $lfd+=10;

    if ($tipgame{$lfd}{erg} == 9) {
      $pts+=10;
      $printpts = 10;
      $class = "lightgrey";
    } else {
      $printpts = $tipgame{$lfd}->{$guess};
      $class = "black";
    }   

    if ($tipgame{$lfd}{erg} == $guess) {
      $pts+=$tipgame{$lfd}->{$guess};
      $class = "bold";
    } elsif ($tipgame{$lfd}{erg} == 3) {
      $class = "grey";
    }
    $debug && print "<!-- Lfd ist: $lfd, Tip ist $guess //-->\n";
    if ($guess != 5) {
      $ret .= "<TR class=\"$class\"><TD>&nbsp;".$tipgame{$lfd}{match}."&nbsp;</TD><TD>&nbsp;$guess&nbsp;</TD><TD>&nbsp;( $printpts ) &nbsp;</TD></TR>\n";
      $valid_tip = 1;
    } else {
      $ret .= "<TR><TD colspan=3> ----- Kein Tip abgegeben ----- </TD></TR>\n";
    }
  }
  if ($#tips == 3) {
    $ret .= "<TR><TD colspan=3> &nbsp; </TD></TR>\n";
  }
  $ret .= "</TABLE>\n";

  if (!$valid_tip) {$pts = -1;}
  return ($pts,$ret);
}

sub writeGroupInfo {
  open(G,">$verz/DATA_${runde}.DAT") or die "Cannot write to group info\n";
  for ($grp = 1;$grp<=8;$grp++) {
    for ($slot=1;$slot<=4;$slot++) {
      my $team = $grptms[($grp-1)*4+$slot-1];
      print G "$grp&$slot&",$team->id,"&",$team->exportstring,"\n";
    }
  }
  close(G);
}

sub readGroupInfo {
  open(G,"<$verz/DATA_${runde}.DAT") or die "Cannot open Groupinfo\n";
  while (<G>) {
    my $line = $_;
    chomp $line;
    if ($line =~ /^(\d+)\&(\d+)\&(\d+)/) {
      (my $grp, my $slot,my $id,my @gms) = split(/&/,$line);
      my $cteam = Clteam->new();
      $cteam->slot($slot);
      $cteam->id($id);
      $cteam->team( $id2team{"$id"} );
      my $gamestring =  join("&",@gms);
      $cteam->games( $gamestring );
      $grptms[($grp-1)*4+$slot-1] = $cteam;
    }
  }
  close(G);
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
