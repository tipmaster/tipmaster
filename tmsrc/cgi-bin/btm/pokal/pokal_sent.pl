#!/usr/bin/perl

=head1 NAME
	BTM pokal_sent.pl

=head1 SYNOPSIS
	TBD
	
=head1 AUTHOR
	admin@socapro.com

=head1 CHANGELOG
	2015-06-09 Thomas: Added Session Management

=head1 COPYRIGHT
	Copyright (c) 2015, SocaPro Inc.
	Created 2015-06-09

=cut

use lib '/tmapp/tmsrc/cgi-bin/'; 
use TMSession;
my $session = TMSession::getSession(btm_login => 1);
my $trainer = $session->getUser();
my $leut = $trainer;

use CGI;


use CGI;
$query = new CGI;
$url = $query->param('url');
$tip[1] = $query->param('30....');
$tip[2] = $query->param('31....');
$tip[3] = $query->param('32....');
$tip[4] = $query->param('33....');
$tip[5] = $query->param('34....');
$tip[6] = $query->param('35....');
$tip[7] = $query->param('36....');
$tip[8] = $query->param('37....');
$tip[9] = $query->param('38....');
$tip[10] = $query->param('39....');
$tips = $query->param('tips');


print "Content-type: text/html\n\n";

open(D7,"/tmdata/btm/pokal/tip_status.txt");
$tip_status = <D7> ;
chomp $tip_status;
close(D7);

if ( $tip_status != 1 ) {

print "<title>Pokal Tipabgabe</title><font face=verdana size=2><br><br><br><br><br><b>Die Tipabgabefrist ist bereits abgelaufen ...\n";
exit ;
}




print "<form name=Testform action=/cgi-mod/btm/login.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=pass value=\"$pass\"></form>";
print "<script language=JavaScript>";
print"   function AbGehts()";
print"   {";
print"    document.Testform.submit();";
print"    }";
print"   window.setTimeout(\"AbGehts()\",7000);";
print"  </script>";

print "<p align=left><body bgcolor=white text=black link=darkred link=darkred>&nbsp;&nbsp;&nbsp;<img src=/img/ort.jpg border=0>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";

require "/tmapp/tmsrc/cgi-bin/tag.pl" ;

$agb = 0;

for ($x=1 ; $x<=10 ; $x++ ) {
if ( $tip[$x] ne "0&0" ) { $abg++ }
$reihe = $reihe . $tip[$x] . '.' ;
}

if ( $abg != $tips ) {
print "<font face=verdana size=2><br><br><br><br><br><b>Die Anzahl Ihrer abgegebenen Tips ist nicht korrekt ...<br>Sie haben $abg Tips anstatt der korrekten $tips Tips abgegeben .<br>Bitte kehren Sie zur Tipabgabe zurueck und korregieren Sie Ihre Tipabgabe .\n";
exit ;
}

open(D2,">$url");
print D2 "$reihe\n";
close (D2) ;

print "<font face=verdana size=2><br><br><br><b>&nbsp;&nbsp;Ihre Tipabgabe wurde registriert .<br>&nbsp;&nbsp;Sie werden zu Ihrem LogIn Bereich weitergeleitet ...\n";
