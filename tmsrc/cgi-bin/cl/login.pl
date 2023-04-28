#! /usr/bin/perl

use lib '/tmapp/tmsrc/cgi-bin/';

use CGI;
use TMSession;
use CLLibrary;

my $devmode = 1;
my $query = new CGI;
$query->header;

my $modus = $query->param('modus');

my $session = TMSession::getSession("tmi_login");
# if no session found, try a btm session
if (!$session) {
	$session = TMSession::getSession("btm_login");
}
my $cllib = new CLLibrary;

# Suche nach uebergebenen Keys oder Cookies
#my $sessionkey = $query->param('sessionkey');
#my $name = $query->param('name');
#my $passwd = $query->param('passwd');

my $name = $session->getUser();


my $id = $query->param('id');
my $referrer = $query->param('referrer');
my $runde = $query->param('runde');
if (!$runde) {$runde = $cllib->getCurrentCLRound();}
if (!$referrer) {$referrer = "tmi";}

if (!$session->isUserAuthenticated()) {
	TMAuthenticationController::error_needslogin();
}


# Match & determine Team or unmatch and goto login-Page
if (!$modus || $modus eq "mainpage") {
  # Team rausfinden.
  $team = $cllib->getTeamForTrainer("$name");
 
  print "<HTML><HEAD><TITLE>Tipmaster Europacup Hauptseite</TITLE></HEAD>\n";
  print "<!-- TimeLimit is : ",$cllib->getTimeLimit(),", Runde ist $currentRound / $runde//-->\n";
  print "<BODY>\n";

  if ($tagplace) {
    require "$tagplace";
    require "$tagplace2";
    print "<br>";
  }
  $devmode && print "<font size=3>Beim Tipmaster und im EC gab es einige technische Änderungen. <br> Wir sind noch in der Erprobung. <br>Bitte auftretende Fehler umgehend an <a href=\"mailto:info\@tipmaster.de\">info\@tipmaster.de</a> melden. <br>Dankeschön! </font><br>\n";
  print "<font face=verdana size=1><br>Hallo $name<br>\n";
  print "Ihr Verein im Europacup: $team<br>\n";
  #print "Ihr Key: $sessionkey<br>\n";

  (my $uorc,my $currentRoundName, my $mynation, my $myId) = $cllib->getCurrentCompetitionInfo($name);
  print "<!-- Ihre ID: $myId  Ihr UORC= $uorc  Nation $mynation \n<br><br> //-->";
  print "Sie spielen ",$cllib->getExplicitWhere($uorc)," derzeitiger Stand im Wettbewerb: ",$currentRoundName,"<hr>\n";
  
  
  # Navigationslinks
  $cllib->printNavigation("Europacup Home");
#INPUT NOTE TP
#print"<br><br><font color=darkred>Temporaere Probleme mit der Auslosung der 2.Qualifikationsrunde beim Europacup ! Wir hoffen das Problem sobald wie moeglich zu loesen !<br>Bitte regelmaessig die Seite wiederbesuchen !<font color=black>";
#####
  print "<hr>";
  print "Champions League";
  print $cllib->form("rundenansicht.pl"),"\n";
  print "<input type=hidden name=uorc value=\"C\">\n";
  print "<input type=hidden name=id value=$cl_id>\n";
  print "<input type=hidden name=nation value=$mynation>\n";
  print "<select name=\"runde\">\n";
  &selector_rounds("C");
  print "</select>\n";
  print "<input type=submit value=\"Zur Ansicht der Spiele/Ergebnisse\">\n";
  print "</form>\n"; 
  
  if ($uorc eq "C") {
    print $cllib->form("tipabgabe.pl"),"\n";
    print "<input type=hidden name=uorc value=\"C\">\n";
    print "<input type=hidden name=id value=$cl_id>\n";
    print "<input type=submit value=\"Zur Tipabgabe\">\n";
    print "</form>\n";
  }
  print "<hr>";
	
  print "UEFA-Cup";
  print $cllib->form("rundenansicht.pl"),"\n";
  print "<input type=hidden name=uorc value=\"U\">\n";
  print "<input type=hidden name=id value=$uefa_id>\n";
  print "<input type=hidden name=nation value=$mynation>\n";
  print "<select name=\"runde\">\n";
  &selector_rounds("U");  
  print "</select>\n";
  print "<input type=submit value=\"Zur Ansicht der Spiele/Ergebnisse\">\n";
  print "</form>\n"; 
  

  if ($uorc eq "U") {
    print $cllib->form("tipabgabe.pl"),"\n";
    print "<input type=hidden name=uorc value=\"U\">\n";
    print "<input type=hidden name=id value=$uefa_id>\n";
    print "<input type=submit value=\"Zur Tipabgabe\">\n";
    print "</form>\n";
  }
  print "</BODY></HTML><!-- end //-->\n";

}

exit 0;


sub selector_rounds {
  $uorc = shift;
  $other = "";
  @rds = ("Q1","Q2","Q3","G1","G2","AC","VI","HA","FI");
  $curr = 0;$weiter = 1;
  while ($weiter) {
   if ($rds[$curr] eq "FI" || $rds[$curr] eq $runde) {
      $weiter = 0;$other = "selected";
    }
    print "<option value=\"",$rds[$curr],"\" $other> ";
    if ($uorc eq "U") {
      print $CLLibrary::uefarunde{"$rds[$curr]"},"\n";
    } else {
      print $CLLibrary::clrunde{"$rds[$curr]"},"\n";
    }
 
    $curr++;   
  }
}



