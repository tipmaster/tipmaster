#! /usr/bin/perl

# Tipabgabe - stellt das Tipformular dar und ermittelt, welche Tips 
# der angegebene Tipper abzugeben hat. Danach wird der Tip geprueft und abgespeichert.

use lib '/tmapp/tmsrc/cgi-bin/';

use CGI;
use CLLibrary;
use CLTeam;
use TMSession;


@tips = ();
my $doubler = 1;

$query = new CGI;
print $query->header;

my $session = TMSession::getSession("tmi_login");
# if no session found, try a btm session
if (!$session) {
	$session = TMSession::getSession("btm_login");
}
if (!$session->isUserAuthenticated()) {
	TMAuthenticationController::error_needslogin();
}
my $cllib = new CLLibrary;
my $name = $session->getUser();

$modus = $query->param('modus');
$uorc = $query->param('uorc');
(my $uorcByName,my $currentRoundName, my $mynation, my $tipper_id) = $cllib->getCurrentCompetitionInfo($name);
if (!$uorc) {
	$uorc = $uorcByName;
}



$error = "";
if (!$modus) {$modus = "abgabe";}
if (!$runde) {$runde = $cllib->getCurrentCLRound();}
if ($cllib->readFormular($runde) eq "no") {$error = "Tipformular steht noch nicht bereit";}
my $spielref = $cllib->readFormular($runde);
my %spiel = %$spielref;

print "<HTML><HEAD>\n";
print "<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/tm.css\" media=\"all\">\n";

print "</HEAD><BODY><!-- MODUS: $modus  RUNDE: $runde, UORC: $uorc, ID: $tipper_id//-->\n";

if ($error) {
  $cllib->printNavigation();
  print $error,"<br></BODY></HTML>\n";
  exit 0;
}

# abzugebende tips ermitteln

@tips_to_give = $cllib->welchetips($tipper_id,$runde,$uorc);
$spname[4] = "Ausw&auml;rtsspiel";
$spname[5] = "Heimspiel";



if ($modus eq "abgabe") {
  #$submittext = "Tip speichern - Vorsicht! Tipabgabe erst nach Saisonumstellung durchfuehren.!";
  $submittext = "Tip speichern";
  # check if there is a tip already - if yes, preselect the
  # choices
  @tip = $cllib->readTips($tipper_id,$runde,$uorc);  
  print "<!--<br>Eingelesene Tips: ",@tip," //-->\n";
  if (!@tips_to_give) {
    print "Sie m&uuml;ssen diese Runde keinen Tip abgeben!";
    $show_submit = 0;
  } elsif ($tips_to_give[0] == 0) {
    print "Sie haben in dieser Runde ein Freilos!\n";
    $show_submit = 0;
    @tips_to_give = ();
  } else {
    # Build Javascript online to check current tip on numbers.
    # yet to do
    $show_submit = 1;
  print "<H1>Europacup Tipabgabe</h1><hr>\n";
  $cllib->printNavigation();
  print "<hr>\n";

    print "Sie m&uuml;ssen in dieser Runde ",$#tips_to_give+1," Tips abgeben:<br>\n";
    $lfd = 0;
    foreach $a_tipnum (@tips_to_give) {
      print ++$lfd,". Spiel: ",$spname[$a_tipnum]," (",$a_tipnum," Tips)<br>\n";
    }
  }
    
  print $cllib->form("tipabgabe.pl"),"\n";
  print "<input type=hidden name=modus value=\"speichern\">";
  print "<HR>\n";
  print "<table border=0 colpadding=0 colspacing=0 rowpadding = 0 rowspacing=0 >\n";
  $lfd = 0; $lfd2 = 0;
  print "<tr bgcolor=#BBBBBB><td>Match</td><td align=center>1</td><td align=center>0</td><td align=center>2</td>\n";
  foreach $a_y (@tips_to_give) {
	$lfd2++;
	print "<td align=center>Spiel $lfd2</td>\n";
  }
  print "</tr>\n";
  delete $spiel{10};

  my $tipsprinted = 0;

  foreach $a_le (keys %spiel) {
   print "<!-- Spiel $a_le -- $spiel{$a_le} //-->\n";
  }
  foreach $a_match (sort keys %spiel) {
    $lfd++;
    $z = "FFFFFF"; if ($lfd % 2 == 0) {$z = "EEEEEE";}
    if ($lfd > 25) {next;}
    # Spielname und Quoten ausgeben
    print "<tr bgcolor=#$z><td width=\"300\">",$spiel{$a_match}->{match},"</td>\n";
    for $key (1,0,2) {
      print "<td width=\"30\" align=center>",$spiel{$a_match}{$key},"</td>";
    }
    print "\n";

    $tipsprinted++;

    #select-felder zum tipeintragen
    $lfd_tip=0;
    foreach $a_x (@tips_to_give) {
      $lfd_tip++;
      print "<td> <select name=\"S${lfd}T${lfd_tip}\">\n";
      
      print "<option value = \"3\">----\n";
      for $l (1,0,2) {
	$vgl = &returnTip($lfd,$lfd_tip,@tip);
	#print "<br>Compare $vgl to $l -->\n";
	if ($vgl == $l) {
	  $submittext = "Tip erneut speichern";
	  $isselected = "selected";
	} else {
	  $isselected = "";
	}
	print "<option value = \"$l\" $isselected>$l - ",$spiel{$a_match}{$l},"\n";
      }
      print "</select></td>\n";
    }
    print "</tr>\n";
  }
  if ($show_submit) {
    if ($cllib->isFormularOpen() && $tipsprinted == 25) {
      print "<tr><td colspan=3> <input type=submit value=\"$submittext\"> </td> </tr>\n";
    } else {
      my $msgtet = "Die Tipabgabe ist bereits geschlossen";
      if ($tipsprinted != 25) {
	$msgtet = "Es liegt ein Problem mit dem Tipformular vor. Bitte im Forum oder der Spielleitung melden!";
      }
      print "<tr><td colspan=3>", $msgtet," </td></tr>\n";
    }
  }
  print "</table>\n";
  
  print "</form></body></html>\n";
  exit 0;


} elsif ($modus =~ /speichern/) {
  print "<H1>Tipabgabe verbuchen</H1>\n";
  print "<hr>\n";
	$cllib->printNavigation();
  print "<hr><br>\n";
  print "<!-- Jetzt im Modus speichern: Tipabgabe is $tipabgabe_offen //-->\n";
  if (!$cllib->isFormularOpen()) {
    print "Die Tipabgabe ist schon geschlossen\n";
    print "</BODY></HTML>\n";
    exit 0;
  }
  # haue die uebergebenen Tips in eine Tipdatei.
  #print "Abspeichern der Tips: f&uuml;r $tipper_id in Runde $runde <br>\n";
  #auslesen der Variablen
  @tips = ();@anzeige = ();@tipcount = (0,0,0,0,0);
  for (1..25) {
    $lfd_tip = 0;
    foreach $a_tipnum (@tips_to_give) {
      $lfd_tip++;
      my $key = "S".$_ . "T" . $lfd_tip;
      my $entered = $query->param($key);
      if ($entered >= 0 && $entered <= 2 && $entered ne "") {
        $lfdin[$lfd_tip]++;
	$tipsforgame[$_]++;
	$tips[$_] = $lfd_tip."_".$entered;
	$tipcount[$lfd_tip]++;
	$paarung = $spiel{$_+10}->{match};
	$quote = $spiel{$_+10}{$entered};
        $bcol="EEEEEE"; if ($lfdin[$lfd_tip]% 2 == 0) {$bcol = "FFFFFF";}
	$anzeige[$lfd_tip] .= "<tr bgcolor=#$bcol><td width=300>$paarung</td><td width=60 align=center>$entered</td><td width=60 align=center>$quote</td></tr>";
      }
    }
  }

  # Pruefen des Tips:
  $error = "";
  $ttg = 0;
  while($tips_to_give[$ttg] > 0) {
    if ($tips_to_give[$ttg] != $tipcount[$ttg+1]) {
      $error = "$error<br>In Spiel ".eval($ttg+1).": ".$tipcount[$ttg+1]." Tips abgegeben, notwendig sind ".$tips_to_give[$ttg];
  
    }
    $ttg++;
  }
  
  for (1..25) {
    if ($tipsforgame[$_] > 1) {
      $error = "$error<br> Spiel ".$spiel{$_+10}->{match}." wird in mehreren Tips verwendet!";
    }
  }

  if ($error ne "") {
    print "<H1>Fehlerhafte Tipabgabe:</H1>\n";
    print $error,"\n";
    print "</BODY></HTML>\n";
    exit 1;
  }
  
  print "<!-- Now going to write tips //-->\n";

  $cllib->writeTips($tipper_id,$runde,$uorc,@tips);

  print "<!-- Tips are written, now show them //-->\n";

  # Anzeige der abgegebenen Tips
  print "Abgegebene Tips:<br>\n";
  $lfd_tip = 0;
  foreach $a_tipnum (@tips_to_give) {
    $lfd_tip++;
    print "<table>\n";
    print "<tr bgcolor=\"#BBBBBB\"><td>Spiel $lfd_tip</td><td align=center>Getippt</td><td align=center>Quote</td></tr>\n";
    print $anzeige[$lfd_tip],"\n";
    print "</table><br>\n";
  }
  
  print "</body></html>\n";
  print "<!-- Sucessfully saved tips //-->\n";

  exit 0;
} else {
  print "Ung&uuml;ltige Anfrage!\n";
  exit 0;

}

## Hilfsroutinen:




sub readFormularLocal {
  my $runde = shift;
  my $formularname = "$verz/formular${runde}.txt";
  open(G,"<$formularname") or return 1; 
  my $lfd = 10;
  while(<G>) {
    if ($_ =~ /&(.*?)&(\d+)&(\d+)&(\d+)&/ ) {
      $lfd++;
      $spiel{$lfd}{match} = $1;
      $spiel{$lfd}->{1}  = $2;
      $spiel{$lfd}->{0}  = $3;
      $spiel{$lfd}->{2}  = $4;
    }
  }
  close(G);
 return 0;
}
    





sub returnTip {
  my $spielx = shift;
  my $game = shift;
  my @tips = @_;
  #print "Tips ist: ",@tips,"\n";
  #print "Request for $spielx / $game versus ",$tips[$spielx],"<br>\n";
  my $ret = "3";
  if ($tips[$spielx] =~ /(.)\_(.)/) {
    #print "Found $1 / $2 positive\n";
    if ($1 eq "$game") {$ret = $2;}
  }
  if ($ret eq "") {$ret = "3";}
  #print "Returning $ret<br>\n";
  return $ret;
}


sub error {
  $msg = shift;
  print "<!-- $msg //-->\n</BODY></HTML>\n";
  exit 1;
}

