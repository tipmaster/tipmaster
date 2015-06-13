#! /usr/bin/perl


use CGI;

do 'library.pl';
$query = new CGI;
#print $query->header;
$modus = $query->param('modus');

# Suche nach uebergebenen Keys oder Cookies
$sessionkey = $query->param('sessionkey');
$name = $query->param('name');
$passwd = $query->param('passwd');
$id = $query->param('id');
$referrer = $query->param('referrer');
$runde = $query->param('runde');
if (!$runde) {$runde = $derzeitige_runde;}
if (!$referrer) {$referrer = "tmi";}

if ($sessionkey && !checkKey($name,$sessionkey)) {$modus = "wronglogin";}

# Match & determine Team or unmatch and goto login-Page

if ($modus eq "") {$modus = "checklogin";}
if (!$name) {$modus = "showlogin";}

if ($modus eq "checklogin") {
  # validify versus pass.txt


  if ($referrer eq "tmi") {$passver = $tmiverz;}
  if ($referrer eq "btm") {$passver = $btmverz;}


    open (G,"</tmdata/pass.txt") or die "Cannot access /tmdata/pass.txt: $!";
    $notfound = 1;$auth = 0;
    while (<G>) {
      if (!$notfound) {next;}
      my $lines = $_;
      chomp $lines;
      #print "A Doing |$lines| with $name_in and $passwd_in found<br>\n";  
      (undef,$name_in,$passwd_in,undef) = split(/&/,$lines);
      
      #print "B Doing |$lines| with $name_in and $passwd_in found<br>\n";
      if ($name eq $name_in) {
	#print "Found Name $1 - \n";
	$notfound = 0;
	if ($passwd eq $passwd_in) {
	  #print "Found Matching password $2 - \n";
	  $auth = 1;
	} else {
	  #print "Password does not match: $passwd vs $2 - \n";
	  $auth = 0;
	}
      }
    }
  
  
  close(G);

 
  
  if ($auth) {
    $sessionkey = generateKey($name);
    $modus = "mainpage";


  } else {

    $modus = "wronglogin";
  }
  
}


if ($modus eq "wronglogin") {
  $msg = "Ihr Login war ung&uuml;ltig oder ihre Session ist abgelaufen<br>Bitte melden Sie sich erneut an<br>\n";
  $modus = "showlogin";
}


if ($modus eq "showlogin") {


  print "<HTML><HEAD><TITLE>Loginseite Europacup</TITLE>\n";
  print "<link rel=\"stylesheet\" type=\"text/css\" href=\"/tm.css\" media=\"all\">\n";
  print "</HEAD>\n";

  print "<BODY bgcolor=#eeeeee>\n";

  if ($tagplace) {
    # Besten Dank , Thomas :-) !
    require "$tagplace";
    require "$tagplace2";
    print "<br>";
  }

  print "<H1>Tipmaster Europacup</H1>\n";
  if ($msg) {print "<H3>$msg</H3>\n";}
  &printNavigation("Europacup Home");
  print "<H3>Bitte identifizieren Sie sich:</H3>\n";
  
  print "<FORM action = \"$cgiverz/login.pl\" method=post>\n";
  print "<input type=hidden name=\"runde\" value=\"$runde\">\n";
  print "<input type=hidden name=\"modus\" value=\"checklogin\">\n";
  print "<input type=hidden name=\"referrer\" value=\"$referrer\">\n";
  
  print "<TABLE><TR><TD>Name</TD><TD><input type=text name=\"name\"></TD></TR>\n";
  print "<TR><TD>Password</TD><TD><input type=password name=\"passwd\"></TD></TR>\n";
  print "<TR><TD><input type=submit value=\"Login\"></TD><TD>&nbsp;</TD></TR>\n";
  print "</table>\n";
  print "</form>\n";

  
  print "</BODY></HTML>\n";
}

if ($modus eq "mainpage") {

  # Team rausfinden.
  $team = $trainer2team{"$name"};
  
  $uefa_id = $uteam2id{"$team"}*1;
  $cl_id = $team2id{"$team"}*1;
 
  if (!$team) {
    $uefa_id = 0;
    $cl_id = 0;
  }
 
  print "<HTML><HEAD><TITLE>Tipmaster Europacup Hauptseite</TITLE></HEAD>\n";
  print "<!-- TimeLimit is : $timeLimit, Runde ist $currentRound / $derzeitige_runde //-->\n";
  print "<BODY>\n";

  if ($tagplace) {
    require "$tagplace";
    require "$tagplace2";
    print "<br>";
  }
  print "<font face=verdana size=1><br>Hallo $name<br>\n";
  print "Ihr Verein im Europacup: $team<br>\n";
  #print "Ihr Key: $sessionkey<br>\n";
  print "<!-- Ihre ID: $cl_id / $uefa_id \n<br><br> //-->";
  if ($cl_id) {$where = "in der Champions League\n"; $currentRound = $clrunde{$runde}; $mynation = $id2nat{"$cl_id"};}
  if ($uefa_id) {$where = "im UEFA-Cup\n"; $currentRound = $uefarunde{$runde}; $mynation = $uid2nat{"$uefa_id"}; }
  if (!$where) {$where = "in keinem europ&auml;ischen Wettbewerb\n";}
  
  print "Sie spielen $where, derzeitiger Stand im Wettbewerb: ",$currentRound,"<hr>\n";
  
  
  # Navigationslinks
  &printNavigation("Europacup Home");
#INPUT NOTE TP
#print"<br><br><font color=darkred>Temporaere Probleme mit der Auslosung der 2.Qualifikationsrunde beim Europacup ! Wir hoffen das Problem sobald wie moeglich zu loesen !<br>Bitte regelmaessig die Seite wiederbesuchen !<font color=black>";
#####
  print "<hr>";
  print "Champions League";
  print &form("rundenansicht.pl"),"\n";
  print "<input type=hidden name=uorc value=\"C\">\n";
  print "<input type=hidden name=id value=$cl_id>\n";
  print "<input type=hidden name=nation value=$mynation>\n";
  print "<select name=\"runde\">\n";
  &selector_rounds("C");
  print "</select>\n";
  print "<input type=submit value=\"Zur Ansicht der Spiele/Ergebnisse\">\n";
  print "</form>\n"; 
  
  if ($cl_id && !$uefa_id) {
    print &form("tipabgabe.pl"),"\n";
    print "<input type=hidden name=uorc value=\"C\">\n";
    print "<input type=hidden name=id value=$cl_id>\n";
    print "<input type=submit value=\"Zur Tipabgabe\">\n";
    print "</form>\n";
  }
  print "<hr>";
	
  print "UEFA-Cup";
  print &form("rundenansicht.pl"),"\n";
  print "<input type=hidden name=uorc value=\"U\">\n";
  print "<input type=hidden name=id value=$uefa_id>\n";
  print "<input type=hidden name=nation value=$mynation>\n";
  print "<select name=\"runde\">\n";
  &selector_rounds("U");  
  print "</select>\n";
  print "<input type=submit value=\"Zur Ansicht der Spiele/Ergebnisse\">\n";
  print "</form>\n"; 
  

  if ($uefa_id) {
    print &form("tipabgabe.pl"),"\n";
    print "<input type=hidden name=uorc value=\"U\">\n";
    print "<input type=hidden name=id value=$uefa_id>\n";
    print "<input type=submit value=\"Zur Tipabgabe\">\n";
    print "</form>\n";
  }
  print "<hr>";

  print "</BODY></HTML>\n";
}

exit 0;

sub form {
  $scriptname = shift;
  my $ret = "<FORM name=bla action=\"$cgiverz/$scriptname\" method=post>\n";
  $ret = "$ret <input type=hidden name=\"name\" value=\"$name\">\n";
  $ret = "$ret <input type=hidden name=\"sessionkey\" value=\"$sessionkey\">\n";
  return $ret;
}


sub selector_rounds {
  $uorc = shift;
  $other = "";
  @rds = ("Q1","Q2","Q3","G1","G2","AC","VI","HA","FI");
  $curr = 0;$weiter = 1;
  while ($weiter) {
   if ($rds[$curr] eq "FI" || $rds[$curr] eq $derzeitige_runde) {
      $weiter = 0;$other = "selected";
    }
    print "<option value=\"",$rds[$curr],"\" $other> ";
    if ($uorc eq "U") {
      print $uefarunde{"$rds[$curr]"},"\n";
    } else {
      print $clrunde{"$rds[$curr]"},"\n";
    }
 
    $curr++;   
  }
}



