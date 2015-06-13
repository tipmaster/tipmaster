#! /usr/bin/perl

# dieses Skript erstellt die Datendateien der einzelnen Runden der
# Champions-League (Q1,Q2,G1,G2,AC,VI,HA,FI)

# Ausgewertet wird die ID-Datei, bzw. die vorangegangene DATA-Datei

do '/tmapp/tmsrc/cgi-bin/cl/library.pl';
if (!-e "$verz/ID.dat") {
  $verz = "/tmdata/cl"; 
}

$runde = shift @ARGV;

if ($runde eq "Q1") {
  print "Initial data build\n";  
  # Stelle den ersten Qualifikationsrundenspielplan her
  # Schnapp die Teams 2-107 und teile auf in 53 Spiele
  
  @team_ids = (2..107);
  
  # Randomisieren
  @tmp = randomize_array(@team_ids);
  @team_ids = @tmp; @tmp = ();
  
  # Ausstieg, falls Daten schon vorhanden
  if (-e "$verz/UEFA_Q1.DAT") { print "Datendatei schon vorhanden. Erst loeschen!\n"; exit 1;}
  
  open (H,">$verz/UEFA_Q1.DAT");
  # 40 Qualifikationsspiele
  for (1..53) {
    print H eval($_-1),"&$team_ids[$_*2-2]&$team_ids[$_*2-1]&-:-&-:-\n";
  }
  close(H);
  } elsif ($runde eq "Q2") {

  ##################################################################################################
  ## Schnapp die Daten aus Q1, ermittle die Sieger und dazu CL-Loser

  open(G,"<$verz/UEFA_Q1.DAT");
  @team_ids = ();
  ## Der TV
  @team_ids = (1);

  while(<G>) {
    ($lfd,$gegner[1],$gegner[2],$erg1,$erg2) = split(/&/,$_);
    if ($gegner[2] eq "FREILOS") {
      $winner = 1;
    } else {
      ($winner,undef,undef,undef) = &whowins($erg1,$erg2);
      if (!$winner) {close(G); die "Kein Sieger bei Spiel $lfd eingetragen\n";}
    }
    push @team_ids,$gegner[$winner];
    print "Qualifiziert: ",$gegner[$winner]," nun ",$#team_ids," Teams \n";
  }
  close(G);

  # Einlesen CL-DAten
  open(K,"<$verz/ID.dat");
  while(<K>) {
    $_ =~ /(.*?)&(.*)/;
    $uefaids[$1] = $2;
    #print "ID Nr $1 ist $2\n";
  }
  close(K);
  $uid = 107;

  open(J,">>$verz/UEFA_ID.dat");
  print J "\n";
  open(G,"<$verz/DATA_Q1.DAT");
  while(<G>) {
    ($lfd,$gegner[1],$gegner[2],$erg1,$erg2) = split(/&/,$_);
    if ($gegner[2] eq "FREILOS") {
      next;
    } else {
      ($winner,undef,undef,undef) = &whowins($erg1,$erg2);
      if (!$winner) {close(G); die "Kein Sieger bei Spiel $lfd eingetragen\n";}
    }

    $uid++;
    push @team_ids,$uid;
    print J $uid,"&",$uefaids[$gegner[3-$winner]],"\n";
    print "Qualifiziert: ",$gegner[$winner],"--> $uid\n";
  }
  close(G);
  close(J);

  print $#team_ids," Teams fuer Runde 2 erkannt\n";
  @tmp = randomize_array(@team_ids);
  @team_ids = @tmp; @tmp = ();
  
  print $#team_ids," gemischte Teams fuer Runde 2 erkannt\n";

  open (H,">$verz/UEFA_Q2.DAT");
  # 38 Runde-2-Qualifikationsspiele
  for (1..38) {
     print H eval($_-1),"&$team_ids[$_*2-2]&$team_ids[$_*2-1]&-:-&-:-\n";
  }	
  close(H);
} elsif ($runde eq "Q3") {

  #####################################################################################################
  ## Schnapp die Daten aus Q2, ermittle die Sieger und dazu die CL-Loser
  open(G,"<$verz/UEFA_Q2.DAT");

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

 ## die CL-Loser
  # Einlesen CL-DAten
  open(K,"<$verz/ID.dat");
  while(<K>) {
    $_ =~ /(.*?)&(.*)/;
    $uefaids[$1] = $2;
    #print "ID Nr $1 ist $2\n";
  }
  close(K);
  $uid = 129;

  open(J,">>$verz/UEFA_ID.dat");
  print J "\n";
  open(G,"<$verz/DATA_Q2.DAT");
  while(<G>) {
    ($lfd,$gegner[1],$gegner[2],$erg1,$erg2) = split(/&/,$_);
    if ($gegner[2] eq "FREILOS") {
      next;
    } else {
      ($winner,undef,undef,undef) = &whowins($erg1,$erg2);
      if (!$winner) {close(G); die "Kein Sieger bei Spiel $lfd eingetragen\n";}
    }

    $uid++;
    push @team_ids,$uid;
    print J $uid,"&",$uefaids[$gegner[3-$winner]],"\n";
    print "Qualifiziert: ",$gegner[3-$winner],"--> $uid\n";
  }
  close(G);
  close(J);

  print $#team_ids," Teams fuer Runde 3 erkannt\n";

  
  @tmp = randomize_array(@team_ids);
  @team_ids = @tmp; @tmp = ();

  ## Teste Datensatz

  foreach $a_id (@team_ids) {
    $caught{"$a_id"}++;
    if ($caught{"$a_id"}>1) {
      print "DOPPELT: $a_id\n";
    }
  }

  
  open (H,">$verz/UEFA_Q3.DAT");
  # 37 Runde-3-Qualifikationsspiele
  for (0..36) {
    print H "$_&$team_ids[$_*2]&$team_ids[$_*2+1]&-:-&-:-\n";
  }
  close(H);

###################################################################

  } elsif ($runde eq "G1") {
    ## Schnapp die Daten aus Q3, dazu CL-Loser

    open(G,"<$verz/UEFA_Q3.DAT");
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

 ## die CL-Loser
  # Einlesen CL-DAten
  open(K,"<$verz/ID.dat");
  while(<K>) {
    $_ =~ /(.*?)&(.*)/;
    $uefaids[$1] = $2;
    #print "ID Nr $1 ist $2\n";
  }
  close(K);
  $uid = 165;

  open(J,">>$verz/UEFA_ID.dat");
  print J "\n";
  open(G,"<$verz/DATA_Q3.DAT");
  while(<G>) {
    ($lfd,$gegner[1],$gegner[2],$erg1,$erg2) = split(/&/,$_);
    if ($gegner[2] eq "FREILOS") {
      next;
    } else {
      ($winner,undef,undef,undef) = &whowins($erg1,$erg2);
      if (!$winner) {close(G); die "Kein Sieger bei Spiel $lfd eingetragen\n";}
    }

    $uid++;
    push @team_ids,$uid;
    print J $uid,"&",$uefaids[$gegner[3-$winner]],"\n";
    print "Qualifiziert: ",$gegner[3-$winner],"--> $uid\n";
  }
  close(G);
  close(J);

  print $#team_ids," Teams fuer Runde 4 erkannt\n";




    @tmp = randomize_array(@team_ids);
    @team_ids = @tmp; @tmp = ();

    open (H,">$verz/UEFA_G1.DAT");
    # 32 Runde-3-Qualifikationsspiele
    for (1..32) {
      print H "$_&$team_ids[$_*2-2]&$team_ids[$_*2-1]&-:-&-:-\n";
    }	
	
    close(H);

  } elsif ($runde eq "G2" || $runde eq "AC" || $runde eq "VI" || $runde eq "HA" || $runde eq "FI") {
    @refs = ("G1","G2","AC","VI","HA");
  %corr = ("G2",0,"AC",1,"VI",2,"HA",3,"FI",4);

  $anz = 2**(4-$corr{$runde});

  my $inname = "$verz/UEFA_".$refs[$corr{$runde}].".DAT";
  my $outname = "$verz/UEFA_".$runde.".DAT";

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
  
  @tmp = randomize_array(@team_ids);
  @team_ids = @tmp; @tmp = ();
  
  open (H,">$outname") or die "Cannot write to $outname: $!";
  # $anz KO-finals
  for (1..$anz) {
    if ($anz > 1) {
    print H $_-1,"&$team_ids[$_*2-2]&$team_ids[$_*2-1]&-:-&-:-\n";
    } else {
    print H $_-1,"&$team_ids[$_*2-2]&$team_ids[$_*2-1]&-:-\n";
    }
  }  
  
  close(H);
} else {
    print "Unknown modus\n";
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
    
    
