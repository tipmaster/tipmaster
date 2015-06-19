#! /usr/bin/perl

# dieses Skript erstellt die Datendateien der einzelnen Runden der
# Champions-League (Q1,Q2,G1,G2,AC,VI,HA,FI)

# Ausgewertet wird die ID-Datei, bzw. die vorangegangene DATA-Datei

use lib "/tmapp/tmsrc/cgi-bin/cl";
use lib qw {.};
use Clteam;
do 'library.pl';
do '/tmapp/tmsrc/cgi-bin/cl/library.pl';

if (!-e "$verz/ID.dat") {
  $verz = $verz;
}

# check if library has run
if (!$derzeitige_runde) {
	print "Library not run. Exiting\n";
	exit 1;
} else {
	print "Derzeitige Runde laut library: $derzeitige_runde\n";
}

$runde = shift @ARGV;

if ($runde eq "Q1") {
  
  # Stelle den ersten Qualifikationsrundenspielplan her
   @team_ids = (74..117);
  
  # Randomisieren
  @tmp = randomize_array(@team_ids);
  @team_ids = @tmp; @tmp = ();
  
  # Ausstieg, falls Daten schon vorhanden
  if (-e "$verz/DATA_Q1.DAT") { print "Datendatei schon vorhanden. Erst loeschen!\n"; exit 1;}
  
  open (H,">$verz/DATA_Q1.DAT");
  # 22 Qualifikationsspiele
  for (1..22) {
    print H eval($_-1),"&$team_ids[$_*2-2]&$team_ids[$_*2-1]&-:-&-:-\n";
  }
  close(H);

} elsif ($runde eq "Q2") {

  ## Schnapp die Daten aus Q1, ermittle die Sieger,
  ## dazu 50 Q2-Einsteiger. und daraus 36 Paarungen

  open(G,"<$verz/DATA_Q1.DAT");
  @team_ids = ();@freis = ();
  @team_ids = (24..73);

  while(<G>) {
    ($lfd,$gegner[1],$gegner[2],$erg1,$erg2) = split(/&/,$_);
    print "$gegner[1] vs $gegner[2]\n";
    if ($gegner[2] eq "FREILOS") {
      $winner = 1;
    } else {
      ($winner,undef,undef,undef) = &whowins($erg1,$erg2);
      if (!$winner) {close(G); die "Kein Sieger bei Spiel $lfd eingetragen\n";}
    }
    push @team_ids,$gegner[$winner];
    print "Pushed ",$gegner[$winner],"\n";
  }
  close(G);
  
  $ok = 0;
  while (!$ok) {
      @tmp = randomize_array(@team_ids);
#      $ok = &checkFree(\@tmp,\@freis,5);
      $ok = 1;
  }
  @team_ids = @tmp; @tmp = ();
  
  open (H,">$verz/DATA_Q2.DAT") || die "Cannot open DATA_Q2: $!";
  # 36 Runde-2-Qualifikationsspiele
  for (1..36) {
      print H eval($_-1),"&$team_ids[$_*2-2]&$team_ids[$_*2-1]&-:-&-:-\n";
  }
  close(H);


} elsif ($runde eq "Q3") {
   # 36 Sieger + 6 Rankings + 12 Meister 
  ## Schnapp die Daten aus Q1, ermittle die Sieger und daraus 16 Paarungen, 5 Freilose
  open(G,"<$verz/DATA_Q2.DAT");
  @team_ids = ();@freis = ();

  @team_ids = (6..23);

  while(<G>) {
    ($lfd,$gegner[1],$gegner[2],$erg1,$erg2) = split(/&/,$_);
    print "$gegner[1] vs $gegner[2]\n";
    if ($gegner[2] eq "FREILOS") {
      $winner = 1;
    } else {
      ($winner,undef,undef,undef) = &whowins($erg1,$erg2);
      if (!$winner) {close(G); die "Kein Sieger bei Spiel $lfd eingetragen\n";}
    }
    push @team_ids,$gegner[$winner];
    print "Pushed ",$gegner[$winner],"\n";
  }
  close(G);
  
  $ok = 0;
  while (!$ok) {
      @tmp = randomize_array(@team_ids);
#      $ok = &checkFree(\@tmp,\@freis,7);
      $ok = 1;
  }
  @team_ids = @tmp; @tmp = ();
  
  open (H,">$verz/DATA_Q3.DAT");
  # 27 Runde-2-Qualifikationsspiele
  for (1..27) {
      print H eval($_-1),"&$team_ids[$_*2-2]&$team_ids[$_*2-1]&-:-&-:-\n";
  }	
  close(H);    

} elsif ($runde eq "G1") {
  @team_ids = (1..5);
  
  ## Schnapp die Daten aus Q3, ermittle die Sieger und rein in den String
  open(G,"<$verz/DATA_Q3.DAT");
  while(<G>) {
    ($lfd,$gegner[1],$gegner[2],$erg1,$erg2) = split(/&/,$_);
    if ($gegner[2] eq "FREILOS") {
      $winner = 1;
    } else {
      ($winner,undef,undef,undef) = &whowins($erg1,$erg2);
      if (!$winner) {close(G); die "Kein Sieger bei Spiel $lfd eingetragen\n";}
    }
    push @team_ids,$gegner[$winner];
  }
  close(G);

  print "Read data:",@team_ids," now grouping\n";
  # Jetzt die Gruppenaufteilung. Aufpassen, dass keine 2 Laender in dieselbe
  # Gruppe kommen.
  
  $reshuffle = 1;
  
  while ($reshuffle) {
    $reshuffle = 0;
    @tmp = randomize_array(@team_ids);
    @team_ids = @tmp; @tmp = ();

   print "Teamstring: @team_ids\n";
   print "id2nat: ",%id2nat," \n";
    for ($i=1;$i<=8;$i++) {
      ($t1,$t2,$t3,$t4) = @team_ids[$i*4-4..$i*4-1];
      print "Shuffling with $t1, $t2, $t3, $t4\n";
      if (sameNat($t1,$t2) || sameNat($t1,$t3) || sameNat($t1,$t4) 
	  || sameNat($t2,$t4)  || sameNat($t2,$t3) || sameNat($t3,$t4)) {
	$reshuffle = 1;
	$i = 8;
      }
    }
  }

  # Write out data file
  open(K,">$verz/DATA_G1.DAT") or die "Cannot write G1 data";
  #Format: Group&Slot&Id&s1&s2&s3&s4&s5&s6
  my $reststring = "&" . ("-:-&"x 5) . "-:-\n";
  for (1..8) {
    print "$_ : ";
    for ($j = 1; $j <= 4; $j++) {
 #     print "Group $_, Slot $j: ";
      my $key = $team_ids[($_*4)-$j]; 
      print "Key $key ",$id2team{"$key"}," ",(25-length($id2team{"$key"}))x" ";
      print "(",$id2nat{"$key"},") - ";
      print K $_,"&",$j,"&",$key,$reststring;
    }
    print "\n";
  }
  close(K);

} elsif ($runde eq "AC") {
  # ACHTELFINALE
  # Feststellen, wer die Gruppenersten und zweiten sind,
  # dann Acht spiele auslosen.

  # Gruppendaten einlesen
  &readGroupInfo();
  
  # Tabellen berechnen
  for (my $grp = 1; $grp<=8; $grp++) {
    my @teams = @grptms[($grp-1)*4..$grp*4-1];
    my @sorteams = sort {compare2teams($b,$a)} @teams;

  # jede Gruppe checken auf 2==3 -> 2==4 u 1==3 -> warnung
    if (compare2teams($sorteams[1],$sorteams[2]) == 0) {
      print "Warning! Group $grp, Teams 2 and 3 are equal, check manually!\n";
      if (compare2teams($sorteams[0],$sorteams[1]) == 0) {
	print "Warning! Group $grp First three teams are equal!\n";
      }
      if (compare2teams($sorteams[2],$sorteams[3]) == 0) {
	print "Warning! Group $grp last three teams are equal\n";
      }
    }

    push @team_ids,$sorteams[0]->id;
    push @team_ids,$sorteams[1]->id;
  }
  # mischen und neue Daten raus.
  @tmp = randomize_array(@team_ids);
  @team_ids = @tmp; @tmp = ();
  
  open (H,">$verz/DATA_AC.DAT");
  # 8 x Achtelfinale
  for (1..8) {
    print H $_-1,"&$team_ids[$_*2-2]&$team_ids[$_*2-1]&-:-&-:-\n";
  }	
  
  close(H);


} elsif ($runde eq "VI" || $runde eq "HA" || $runde eq "FI") {
  @refs = ("AC","VI","HA");
  %corr = ("VI",0,"HA",1,"FI",2);

  $anz = 2**(2-$corr{$runde});

  my $inname = "$verz/DATA_".$refs[$corr{$runde}].".DAT";
  my $outname = "$verz/DATA_".$runde.".DAT";

  open(G,"<$inname") or die "Cannot read from $inname: $!";
  @team_ids = ();
  while(<G>) {
    ($lfd,$gegner[1],$gegner[2],$erg1,$erg2) = split(/&/,$_);
    if ($gegner[2] eq "FREILOS") {
      $winner = 1;
    } else {
      ($winner,undef,undef,undef) = &whowins($erg1,$erg2);
      if (!$winner) {close(G); die "Kein Sieger bei Spiel $lfd eingetragen\n";}
    }
    push @team_ids,$gegner[$winner];
  }
  close(G);
  # Ab Viertelfinale ist niemand mehr gesetzt. Auch Landsmanner duerfen aufeinander treffen
  @tmp = randomize_array(@team_ids);
  @team_ids = @tmp; @tmp = ();
  
  open (H,">$outname") or die "Cannot write to $outname: $!";
  # 1 bis 4 Spiele, je nach Runde
  for (1..$anz) {
    print $_-1,"&$team_ids[$_*2-2]&$team_ids[$_*2-1]&-:-&-:-\n";
    if ($anz > 1) {
    print H $_-1,"&$team_ids[$_*2-2]&$team_ids[$_*2-1]&-:-&-:-\n";
    } else {
    print H $_-1,"&$team_ids[$_*2-2]&$team_ids[$_*2-1]&-:-\n";
    }
  }  
  
  close(H);

}  else {
  
  print "Unbekannte Runde\n";

  print &welchetips(62,"G2","C"),"\n";
  print &welchetips(7,"G2","C"),"\n";
  print &welchetips(10,"G2","C"),"\n";


}

sub sameNat {
  my $t1 = shift;
  my $t2 = shift;
  $tn1 = $id2nat{"$t1"};
  $tn2 = $id2nat{"$t2"};
  $tn1 =~ s/_.+//;
  $tn2 =~ s/_.+//;
  my $ret =  ($tn1 == $tn2);
  print "Compared $tn1 to $tn2,($t1 / $t2) returning $ret\n";
  if (($tn1 == 00 && $tn2 == 25) || ($tn1 == 25 && $tn2 == 00)) {
    return 0;
  }
  return $ret;
  
}



#### Hilfsfunktionen

sub randomize_array {
  # Spuckt den uebergebenen Array in zufaelliger Reihenfolge aus
  @arr = @_;
  foreach $a_arr (@arr) {
    $rand[$a_arr] = rand 10000;
  }
  return sort {$rand[$a] <=> $rand[$b] } @arr;
}


