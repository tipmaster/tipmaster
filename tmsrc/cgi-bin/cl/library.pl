#No longer used!!
#!/usr/bin/perl
# Die Library - Funktionen, die aus mehreren Skripten benutzt werden

%rundenfolge = ("Q1",1,"Q2",2,"Q3",3,"G1",4,"G2",5,"AC",6,"VI",7,"HA",8,"FI",9);

#### Status des Wettbewerbs
my $debug = 0;
if ($debug) {print "<!--Starting to fucking read Library!//-->\n";}

# 0 = Spielrunde laeuft, Tipabgabe abgeschlossen
# 1 = Tipabgabe ist noch offen

$tipabgabe_offen = "1";
$currentTime = time;


%btm_tipper = ();
$debug = 0;

####

@natcount = ("ITA",8,"ENG",8,"SPA",8,"FRA",8,"NED",6,"POR",6,"BEL",6,"SUI",6,"AUT",6,"SCO",6,"TUR",6,"IRL",4,"NIR",4,"WAL",4,"DEN",4,"NOR",4,"SWE",4,"FIN",4,"ISL",4,"POL",4,"CZE",4,"HUN",4,"ROM",4,"SLO",4,"CRO",4,"YUG",4,"BHZ",4,"BUL",4,"GRE",4,"RUS",4,"EST",4,"UKR",4,"MOL",4,"ISR",4,"LUX",4,"SLK",3,"MAK",3,"LIT",3,"LET",3,"BLR",3,"MAL",3,"CYP",3,"ALB",2,"GEO",2,"ARM",2,"AZB",2,"AND",2,"FAR",1,"SMA",1);

#old... until 01/4 @nation = ("GER","ITA","ITA","ITA","ITA","ENG","ENG","ENG","ENG","SPA","SPA","SPA","SPA","FRA","FRA","FRA","FRA","NED","NED","NED","NED","POR","POR","POR","POR","BEL","BEL","BEL","BEL","SUI","SUI","SUI","SUI","AUT","AUT","AUT","AUT","SCO","SCO","SCO","SCO","TUR","TUR","TUR","TUR","IRL","IRL","NIR","NIR","WAL","WAL","DEN","DEN","NOR","NOR","SWE","SWE","FIN","FIN","ISL","ISL","POL","POL","CZE","CZE","SLK","SLK","HUN","HUN","ROM","ROM","SLO","SLO","CRO","CRO","YUG","YUG","BHZ","BHZ","MAK","MAK","ALB","ALB","BUL","BUL","GRE","GRE","RUS","RUS","EST","EST","LIT","LIT","LET","LET","BLR","BLR","UKR","UKR","MOL","MOL","GEO","GEO","ARM","ARM","AZB","AZB","ISR","ISR","AND","AND","LUX","LUX","MAL","MAL","CYP","CYP","FAR","SMA","---");  
 
@nation = ("GER","ITA","ITA","ITA","ITA","ITA","ITA","ITA","ITA","ENG","ENG","ENG","ENG","ENG","ENG","ENG","ENG","SPA","SPA","SPA","SPA","SPA","SPA","SPA","SPA","FRA","FRA","FRA","FRA","FRA","FRA","FRA","FRA","NED","NED","NED","NED","NED","NED","POR","POR","POR","POR","POR","POR","BEL","BEL","BEL","BEL","BEL","BEL","SUI","SUI","SUI","SUI","SUI","SUI","AUT","AUT","AUT","AUT","AUT","AUT","SCO","SCO","SCO","SCO","SCO","SCO","TUR","TUR","TUR","TUR","TUR","TUR","IRL","IRL","IRL","IRL","NIR","NIR","NIR","NIR","WAL","WAL","WAL","WAL","DEN","DEN","DEN","DEN","NOR","NOR","NOR","NOR","SWE","SWE","SWE","SWE","FIN","FIN","FIN","FIN","ISL","ISL","ISL","ISL","POL","POL","POL","POL","CZE","CZE","CZE","CZE","HUN","HUN","HUN","HUN","ROM","ROM","ROM","ROM","SLO","SLO","SLO","SLO","CRO","CRO","CRO","CRO","YUG","YUG","YUG","YUG","BHZ","BHZ","BHZ","BHZ","BUL","BUL","BUL","BUL","GRE","GRE","GRE","GRE","RUS","RUS","RUS","RUS","EST","EST","EST","EST","UKR","UKR","UKR","UKR","MOL","MOL","MOL","MOL","ISR","ISR","ISR","ISR","LUX","LUX","LUX","LUX","SLK","SLK","SLK","MAK","MAK","MAK","LIT","LIT","LIT","LET","LET","LET","BLR","BLR","BLR","MAL","MAL","MAL","CYP","CYP","CYP","ALB","ALB","GEO","GEO","ARM","ARM","AZB","AZB","AND","AND","FAR","SMA","---");

# Spielplan fuer Rundenspiele
@spielplan = (1,2,3,4,4,1,2,3,2,4,3,1);

$loc = "tipmaster"; # bruckner tipmaster boeser laptop
if ($loc eq "tipmaster") {
  $verz = "/tmdata/cl";
  if (!-e $verz) {$verz = "/tmdata/cl";}
  $cgiverz = "/cgi-bin/cl";
  $tmiverz = "/tmdata/tmi";
  $btmverz = "/tmdata/btm";
  $tagplace = "/tmapp/tmsrc/cgi-bin/tag.pl";
  $tagplace2 = "/tmapp/tmsrc/cgi-bin/tag_small.pl";
  $images = "/img";
}

# runde wie unten definiert
#$derzeitige_runde = "Q1";
my $filename = "<${verz}/runde.dat";
open(K,$filename) or die "Cannot determine runde from file $filename: $!";
$derzeitige_runde = <K>;
chomp $derzeitige_runde;
close(K);



%clrunde = ("Q1","1. Qualifikationsrunde",
	    "Q2","2. Qualifikationsrunde",
	    "Q3","3. Qualifikationsrunde",
	    "G1","Gruppenspiele Hinrunde",
	    "G2","Gruppenspiele Rueckrunde",
	    "AC","Achtelfinale",
	    "VI","Viertelfinale",
	    "HA","Halbfinale",
	    "FI","Finale");

%uefarunde = ("Q1","1.Qualifikationsrunde",
	      "Q2","2 Qualifikationsrunde",
	      "Q3","1. Hauptrunde",
	      "G1","2. Hauptrunde",
	      "G2","3. Hauptrunde",
	      "AC","Achtelfinale",
	      "VI","Viertelfinale",
	      "HA","Halbfinale",
	      "FI","Finale");

## Navigation entries
@navsort = ("Europacup Home","BTM Home","TMI Home","Europacup Hall of Fame","Offensiv-Nationenwertung","UEFA-5-Jahreswertung","Europacup-Regelwerk");

%navigation = ( "Europacup-Regelwerk","/ecrules.html",
		"UEFA-5-Jahreswertung","/uefa_ranking.html",
		"Offensiv-Nationenwertung","/offensiv_ranking.html",
		"Europacup Hall of Fame","/halloffame.html",
		"TMI Home","/cgi-mod/tmi/login.pl",
		"BTM Home","/cgi-mod/btm/login.pl",
		"Europacup Home","$cgiverz/login.pl?name=#name#&key=#key#&modus=mainpage");

%ecparms = ();
my $conffilename = "$verz/EC.conf";
open(L,"<$conffilename") or die "Cannot read parameter file\n";
while(<L>) {
    chomp $_;
    my $iline = $_;
    ($par,$valu) = split(/=/,$iline);
    $ecparms{"$par"} = $valu;
}
close(L);


#CHANGEME_2#
#Zeitzaehler hochsetzen: aus der zahl nach derzeitige_runde eine um
#9 groessere Zahl machen (10 wenn eine Woche pause war), also 84 -> 93.
#Check: per Browser die rundenansicht.pl anschaun und in den HTML-Quelltext
#schauen, dort wird angezeigt, in wievielen Minuten die CL-Abgabe automatisch
#schliesst.
#$timeLimit = 1004112000+(($rundenfolge{$derzeitige_runde}+168)*7*86400); #primed for 04/1
# Fuer Winterzeitprobleme den hier aktivieren:

#$timeLimit = 1004112000+(($rundenfolge{$derzeitige_runde}+432)*7*86400+3720); #primed for 04/1
my @nsparm = split(/\//,$ecparms{"neueSaison"});
my $lfdsais = $nsparm[1];
# adjustment for saisons. 2013 had 5 saisons, 2014 had 6 seasons
$lfdsais +=11;
my $weekctr = ($lfdsais*9)+425+46+2+55+54+1;

### forget this after dec 30, 2013, then, increase weekctr statically
my $dec28      = 1388271471; 
my $dec28_2014 = 1419721200;
my $nowis = time;
if ($nowis > $dec28) {
	$weekctr++;
}

#same stunt for 2014
if ($nowis > $dec28_2014) {
        $weekctr++;
}



#####

my $winterzeit = 1;
$timeLimit = 1004112000+(($rundenfolge{$derzeitige_runde}+$weekctr)*7*86400+120+$winterzeit*3600); #primed for 04/1


#Changeme wenn die tipabgabe generell offen/zu sein soll
my $immerzu = 0;
my $immeroffen = 0;

if ($currentTime > $timeLimit || $immerzu) {
  $tipabgabe_offen = "0";
}
if ($immeroffen) {
  $tipabgabe_offen = 1;
}

print "<!-- Runde: $derzeitige_runde  Abgabe: $tipabgabe_offen   Time: $currentTime  Limit: $timeLimit //-->\n";
open (K,"<$verz/ID.dat");
%id2team = ();%id2nat = ();%team2trainer = (); %trainer2team = (); %team2id = ();
while(<K>) {
    ($lfd,$natkey,$teamname) = split(/&/,$_);
    $teamname =~ s/\s*$//;
    ($natkey, $natnr) = split(/_/,$natkey);
    $id2nr{"$lfd"} = $natnr;
    $id2nat{"$lfd"} = $natkey;
    #print "id2nat: nat for $lfd is $natkey\n";
    $id2team{"$lfd"} = $teamname;
    $team2id{"$teamname"} = $lfd;
    if ($natkey eq "0") {
#	print "<!-- added $teamname from ID.dat to btm_tipper //-->\n";
	$btm_tipper{"$teamname"} = 3;
    }
}
close(K);

## Filling the ID Array
open (K,"<$verz/UEFA_ID.dat") || die "cannot find UEFA_ID.dat";
%uid2team = ();%uid2nat = ();%uteam2id = (); %uid2nr = ();
while(<K>) {
    ($lfd,$natkey,$teamname) = split(/&/,$_);
    $teamname =~ s/\s*$//;
    ($natkey, $natnr) = split(/_/,$natkey);
    $uid2nat{"$lfd"} = $natkey;
    $uid2nr{"$lfd"} = $natnr;
    $uid2team{"$lfd"} = $teamname;
    $uteam2id{"$teamname"} = $lfd;
    if ($natkey eq "0") {

	#print "<!-- added $teamname from UEFA_ID.dat to btm_tipper //-->\n";
        $btm_tipper{"$teamname"} = 3;
    }

}
close(K);

if ($debug) { print "<!--Internal ID arrays filled !//-->\n"; }

# Filling the team/name translation, first btm then tmi

open (K,"<$btmverz/history.txt");
while(<K>) {
  $line = $_; chomp $line;
  @entries = split(/&/,$line);
  if ($entries[0] =~ /x(\d+)/) {
    $key1 = $1;
  }
  if ($key1 == "01" or $key1 == "02" or $key1 == "03" or $key1 == "12" or $key1 == "27" or $key1 == "60") {
    foreach $a_key (keys %btm_tipper) {
      #print "<!-- keys in btm_tipper: $a_key //-->\n";
    }
    for (1..18) {
      my $subkey1 = $entries[($_-1)*3+1];
	$subkey1 =~ s/\s*$//g;
      my $subkey2 = $entries[($_-1)*3+2];
      $team2trainer{"$subkey1"} = $subkey2;
      $trainer2team{"$subkey2"} = $subkey1;
      $btmteamid{"$subkey1"} = "0_".eval($_+($key1-1)*18);
      if ($btm_tipper{"$subkey1"} eq 3) {
	# auch noch den Namen dazu rein
        #print "<!-- becakse of $subkey1 : BTM_TIPPER subkey added: $subkey2 . Entry was ",$btm_tipper{"$subkey1"},"//-->\n";
	$btm_tipper{"$subkey2"} = 1;
      }
    }
  } 
}
close(K);


open (K,"<$tmiverz/history.txt");
while(<K>) {
  $line = $_; chomp $line;
  @entries = split(/&/,$line);
  if ($entries[0] =~ /x(\d+)/) {
    $key1 = $1;
  }

  for (1..18) {
    my $subkey1 = $entries[($_-1)*3+1];

	$subkey1 =~ s/\s*$//g;
    my $subkey2 = $entries[($_-1)*3+2];
    # Aber keine Trainer aus dem BTM-Feld...
    if (!$btm_tipper{"$subkey2"}) {
      $team2trainer{"$subkey1"} = $subkey2;
      $trainer2team{"$subkey2"} = $subkey1;
      $tmiteamid{"$subkey1"} = $key1."_".eval($_*1);
    }
    
  } 

}
close(K);




if ($debug) { print "<!--Library successfully read!//-->\n";}
return 1;

sub getParam {
	my $parm = shift;
	return $ecparms{"$parm"};
}


sub p2t {
    $punkte = shift;
    if ($punkte<15) {return 0};
    if ($punkte<40) {return 1};
    if ($punkte<60) {return 2};
    if ($punkte<80) {return 3};
    if ($punkte<105) {return 4};
    if ($punkte<130) {return 5};
    if ($punkte<155) {return 6};
    return 7;
}


sub whowins {
  $erg1 = shift;
  $erg2 = shift;
  
  $debug && print "<!-- Approaching whowins with $erg1 $erg2 //-->\n";

  if (!$erg1 || !$erg2 || $erg1 eq "-:-" || $erg2 eq "-:-") {return(0,"- : -","- : -",""); } 
  
  if ($erg1 =~ /(\-?\d+):(\-?\d+)/) {
    $p1 = $1; $p2 = $2;
  }
  
  if ($erg2 =~ /(\-?\d+):(\-?\d+)/) {
    $p3 = $1; $p4 = $2;
  }

  $debug && print "<!-- Inside whowhin with $p1 $p2 $p3 $p4 //-->\n";

  $t1 = p2t($p1);
  $t2 = p2t($p2);
  $t3 = p2t($p3);
  $t4 = p2t($p4);

  $dec = "";
  # who is the winner?
  if ($p1<0 || $p2<0) {
    $winner = 1;
    if ($p1<0) {
      $winner = 2; $p1 = 0; $p3 = 0;
    } 
    if ($p2<0) {
      $winner = 1; $p2 = 0;$p4 = 0;
    }
  } elsif (($t1+$t3)*10+$t3 > ($t2+$t4)*10+$t2) {
    $winner = 1;
  } elsif ($t1 == $t4 && $t2 == $t3) {
      if (abs($p1+$p3-$p2-$p4) > 5) {
	$dec = "n.V.";
      } else {
	$dec = "i.E.";
      }

      # wer hat mehr Punkte;
      if (($p1+$p3)*100+$p3 > ($p2+$p4)*100+$p2) {
	$winner = 1;
      } elsif ($p1 == $p4 && $p2 == $p3) {
	# Absolut gleich => erstes Team gewinnt (Zufall schon bei Auslosung)
	$winner = 1;
      } else {
	$winner = 2;
      }
    
  } else {
    $winner = 2;
  }
 
  if ($dec eq "n.V.") {
    if ($winner == 1) {
      $dec = ($t3+1)." : $t4 n.V.";
    } else {
      $dec = "$t3 : ".($t4+1)." n.V.";
    }
  } elsif ($dec eq "i.E.") {
    if ($winner == 1) {
      $dec = "6 : 5 i.E.";
    } else {
      $dec = "5 : 6 i.E.";
    }
  }

  return ($winner, "<b>$t1 : $t2</b> ($p1 - $p2)", "<b>$t3 : $t4</b> ($p3 - $p4)", $dec);
}


sub generateKey {
  $name = shift;
  $namesum = 0;
  @chars = split(//,$name);
  $key = 7;
  foreach $a_lett (@chars) {
    $hoch = ((ord($a_lett) % 7) + 1);
    $namesum += ord($a_lett);
    $zwischen = $key ** $hoch;
    #print "$key ** $hoch = $zwischen\n";
    $key = (($key ** ((ord($a_lett) % 4)+1)) +ord($a_lett)) % 473 + 5;
  }
  $checksum = $key*$namesum;
   #Uhrzeit drauf
  return $checksum + &currentTime;
}

sub checkKey {
  my $name = shift;
  my $keyToCheck = shift;
 
  my $versus = generateKey($name);

  #print "CheckKey for |$name|: |$versus| - |$keyToCheck|<br>\n";

  if (abs($versus - $keyToCheck) < 3) {return 1;}

  return 0;
}

sub currentTime {
  ($h,$d) =  (localtime(time)) [2,3];
  return ($d*100+$h);
}

sub welchetips {
  # spuckt einen array mit der anzahl zu tippender Tips aus.
  my $id = shift;
  my $mode = shift;
  my $uorc = shift;
  my @ret = ();


  if ($uorc eq "U") {$datafile = "UEFA_${mode}.DAT";} else {$datafile = "DATA_${mode}.DAT";}

  open(G,"<$verz/$datafile") or die "Cannot open $datafile: $!";
  while(<G>) {
    if ($mode =~ /G(\d)/ && $uorc eq "C") {
      # return the groups games
      $rundenid = $1;
      if ($_ =~ /^\d+\&(\d+)\&(\d+)/) {
	$grpid = $1; $t1 = $2;
	if ($t1 eq $id) {
	  close(G);
          if ($rundenid == 1) {
            if ($grpid == 1) {@arr = (5,4,4);}
            if ($grpid == 2) {@arr = (4,5,5);}
            if ($grpid == 3) {@arr = (5,4,5);}
            if ($grpid == 4) {@arr = (4,5,4);}
          } else {
            if ($grpid == 2) {@arr = (5,4,4);}
            if ($grpid == 1) {@arr = (4,5,5);}
            if ($grpid == 4) {@arr = (5,4,5);}
            if ($grpid == 3) {@arr = (4,5,4);}
          }
# Version for 3 Group rounds
#	  if ($rundenid == 1) {
#	    if ($grpid == 1) {@arr = (5,4);}
#	    if ($grpid == 2) {@arr = (4,5);}
#	    if ($grpid == 3) {@arr = (5,4);}
#	    if ($grpid == 4) {@arr = (4,5);}
#	  } elsif ($rundenid == 2) {
#	    if ($grpid == 1) {@arr = (4,4);}
#	    if ($grpid == 2) {@arr = (5,5);}
#	    if ($grpid == 3) {@arr = (5,4);}
#	    if ($grpid == 4) {@arr = (4,5);}
#	  } elsif ($rundenid == 3) {
#	    if ($grpid == 1) {@arr = (5,5);}
#	    if ($grpid == 2) {@arr = (4,4);}
#	    if ($grpid == 3) {@arr = (5,4);}
#	    if ($grpid == 4) {@arr = (4,5);}
#	  }
	  return @arr;
	}
      }
    } else {
      if ($_ =~ /^\d+\&(\d+)\&(.+?)&/) {
	$t1 = $1; $t2 = $2;
	if ($t1 eq $id || $t2 eq $id) {
	  close(G);
	  if ($t2 eq "FREILOS") {
	    return (0);
	  } else {
  	    if ($mode eq "FI") {return (5);}
	    return (5,4);
	  }
	}
      }
    }
  }
  return @ret;
}

sub fillTip {
  my $anz = shift;
  my @arr = @_;
  for ($i=0;$i<$anz;$i++) {
    if (!$arr[$i]) {
      $arr[$i] = "0_5";
      $debug && print "<!-- Filled Tip $i with Zero //-->\n";
    }
  }
  return @arr;
}

sub getSlot {
  my $self = shift;
  my $stag = shift;
  my $sp = shift;
  my $flip = 0;
  if ($stag>3) {$stag -=3; $flip = 1;}
  my $key = ($stag-1)*4+($sp-1)*2;
  if ($flip) {
    return ($spielplan[$key+1],$spielplan[$key]);
  } else {
    return ($spielplan[$key],$spielplan[$key+1]);
  }
}
  
sub readGroupInfo {
  print "<!-- Reading Group Info //-->\n";
  @grptms = ();
	$datei = "$verz/DATA_G1.DAT";
	if (!-e $datei) {
	$datei = $datei;
	}
  open(G,"<$datei") or die "Problem reading $datei: $!";
  while (<G>) {
    my $line = $_;
    chomp $line;
    if ($line =~ /^(\d+)\&(\d+)\&(\d+)/) {
      (my $grp, my $slot,my $id,my @gms) = split(/&/,$line);
      my $cteam = Clteam->new();
      $cteam->slot($slot);
      $cteam->id($id);
      $cteam->team( $id2team{"$id"} );
      $cteam->games( join("&",@gms) );
      #print "<!-- Reference for $grp/$slot is ",$cteam," //-->\n";
      $grptms[($grp-1)*4+$slot-1] = $cteam;
    }
  }
  close(G);
}  



sub compare2teams {
  my $self = shift;
  my $team1 = shift;
  my $team2 = shift;

  my $a = $team1->{PP}; 
  my $b = $team2->{PP};

  if ($team1->{PP} <=> $team2->{PP}) {
    return ($team1->{PP} <=> $team2->{PP});
  } elsif (($team1->{PT} - $team1->{MT}) <=> ($team2->{PT} - $team2->{MT})) {
    return ($team1->{PT} - $team1->{MT}) <=> ($team2->{PT} - $team2->{MT});
  } else {
    return $team1->{PT} <=> $team2->{PT};
  }
}


## navigation - to be inserted on every page.
## the called name will not be displayed

sub printNavigation {
  $notShow = shift;
  foreach $a_title (@navsort) {
    if ($notShow ne "$a_title") {
      #replace name and key
      my $target = $navigation{"$a_title"};
      $target =~ s/key=\#key\#/sessionkey=$sessionkey/;
      $target =~ s/name=\#name\#/name=$name/;
      $target =~ s/ /%20/g;
	
      doLink($target,$a_title);
    }
  }
}

sub doLink {
  my $link = shift;
  my $titel = shift;
  print "<a href=\"$link\"><font face=Verdana size=-2>$titel</font></a>&nbsp;&nbsp;\n";
}  

# extract tip numbers from tipfile
sub getTipsFromFile {
  my $filename = shift;
  my $tipno = shift;
  my @tips = ();
  
  # iterate over tokens and look for tipno
  if (-e $filename) {
    open (G2,"<$filename");
    $spstring = <G2>;
    chomp $spstring;
    close(G2);
    my @t = split(/&/,$spstring);
    for (1..25) {
      (my $spnum,my $erg) = split(/_/,$t[$_]);
	#print "Hit $t[$_] on searching $tipno => $erg<br>\n";
      if ($spnum == $tipno) {
	push @tips,"${_}_$erg";
      }
    }
    return @tips;
  } else {
    return ();
  }
}

sub readFormular {
  my $runde = shift;

  my %tipgame = ();

  #dummy-eintrag.
  $tipgame{10}{match} = "Kein Tip abgegeben";
  $tipgame{10}{erg} = 8;

  my $formularname = "$verz/formular${runde}.txt";
  

  
  if (!-e $formularname) {return "no";}
  open(G3,"<$formularname") or die "Cannot open formular $formularname: $!";
  my $lfd = 10;
  while(<G3>) {
    my $line = $_;
    if ($line =~ /4&(a.*?)&/) {
	my $subst = $1;
      $line =~ s/$subst/_ : _/;
      $line =~ s/abge./_ : _/;
      $line =~ s/ausg./_ : _/;
    }
    #print "<!-- Line read: $line //-->\n";
    if ($line =~ /&(.*?)&(\d+)&(\d+)&(\d+)&(\d)&(\d|_) ?(:|\-) ?(\d|_)&/ ) {
      $lfd++;
      $tipgame{$lfd}{match} = $1;
      $tipgame{$lfd}->{1}  = $2;
      $tipgame{$lfd}->{0}  = $3;
      $tipgame{$lfd}->{2}  = $4;
      #print "<!-- Now checking $1, lfd $lfd, Eingetragen $5, $6, $7 $8&nbsp;\n";
      if ($5 < 4) {
	if ($6>$8) { $tipgame{$lfd}->{erg} = 1;}
	if ($6==$8) {$tipgame{$lfd}->{erg} = 0;}
	if ($6<$8) { $tipgame{$lfd}->{erg} = 2;}
	if ($6 eq "_") {$tipgame{$lfd}->{erg} = 3;}
      } else {
	$tipgame{$lfd}->{erg} = 9;
      }
      #print "Result: ",$tipgame{$lfd}->{erg},"//-->\n";
    }
  }
  close(G3);
  return \%tipgame;
}


sub games {
  my $tgref = shift;
  my %tipgame = %{$tgref};
  $debug && print "<!-- In games. Tipgame is ",%tipgame,"\n";

  my @tips = @_;
  my $pts = 0;
  my $printpts = 0;
  my $ret = "<TABLE width=\"100%\" BORDER=0 cellpadding=0 cellspacing=0>\n";
  #for (1..25) {
  #  my $lfd = $_;
  #  print "<!-- Lfd1 ist: $lfd, Tip $tips[$lfd] and game is ",$tipgame{$lfd}{match},"//-->\n";
  #}
  my $a_tip = "";
  foreach $a_tip (@tips) {
    my $class = "";
    (my $lfd,my $guess) = split(/_/,$a_tip);
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
    #print "<!-- Lfd2 ist: $lfd, Tip ist $guess game is $tipgame{$lfd}{match}//-->\n";
    if ($guess != 5) {
      $ret .= "<TR class=\"$class\"><TD class=\"tga\" width=\"78%\" align=\"left\">&nbsp;".$tipgame{$lfd}{match}."&nbsp;</TD><TD class=\"tga\" width=\"3%\" align=\"right\">&nbsp;$guess&nbsp;</TD><TD class=\"tga\" align=\"right\" width=\"19%\">&nbsp;( $printpts ) &nbsp;</TD></TR>\n";
    } else {
      $ret .= "<TR><TD class=\"tga\" colspan=\"3\" align=\"center\"> ----- Kein Tip abgegeben ----- </TD></TR>\n";
    }
  }
  if ($#tips == 3) {
    $ret .= "<TR><TD class=\"tga\" colspan=3> &nbsp; </TD></TR>\n";
  }
  $ret .= "</TABLE>\n";

  print "<!-- End of games. Erg is $pts //-->\n";
  return ($pts,$ret);
}
