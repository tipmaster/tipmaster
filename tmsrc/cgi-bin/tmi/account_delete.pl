#!/usr/bin/perl

=head1 NAME
	TMI account_delete.pl

=head1 SYNOPSIS
	TBD
	


=head1 CHANGELOG
	2015-06-09 Thomas: Added Session Management


	Created 2015-06-09

=cut

use lib '/tmapp/tmsrc/cgi-bin/'; 
use TMSession;
my $session = TMSession::getSession(tmi_login => 1);
my $trainer = $session->getUser();
my $leut = $trainer;

use CGI;
$query = new CGI;

$pass1 = $query->param('pass1');
$method  = $query->param('method');

require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl";
$referer = "tipmaster.de" ;
if ($ENV{'HTTP_REFERER'} =~ m|https?://([^/]*)$referer|i) {
$check= 1;
}
$check=1;

if ( $check != 1 ) { 
print "Content-type: text/html \n\n";
print "<font face=verdana size=2><b>";
print "<br><br><br>Der Request wurde nicht ueber den tipmaster Server aufgerufen .<br>Die versuchte Manipulation wurde getrackt !";
exit ;

}
#print "Content-type: text/html \n\n";
#print "Diese Feature ist derzeit nicht aktiv . Abmeldung durch Mail an info\@tipmaster.net !";
#exit ;
if ( $method eq "del" ) {
#@todo adjust for new passwords
$pass=$pass1;


($sek, $min, $std, $tag, $mon, $jahr , $wo) =  localtime(time);

$mon++ ;
if ( $sek <10 ) { $xa = "0" }
if ( $min <10 ) { $xb = "0" }
if ( $std <10 ) { $xc = "0" }
if ( $tag <10 ) { $xd = "0" }
if ( $mon <10 ) { $xe = "0" }
if ( $liga <10 ) { $xf = "0" }

$jahr = $jahr + 1900 ;

open (D1,">>/home/tipmaster/account_kill.txt");
print D1 "| TMI | $trainer | $xc$std:$xb$min:$xa$sek | $xd$tag.$xe$mon.$jahr | $ENV{'REMOTE_ADDR'} |\n";
close (D1);

$ersetz = '&' . $trainer . '&&' ;
$l=0;
open (D1,"</tmdata/tmi/history.txt");
while(<D1>) {
$l++;
$zeilen[$l]=$_;
chomp $zeilen[$l];
$zeilen[$l]=~s/$ersetz/&Trainerposten frei&&/;

}
close (D1);


open(A2,">/tmdata/tmi/history.txt");
flock (A2, 2);
for ( $x = 1; $x <= $rr_ligen; $x++ )
{
print A2 "$zeilen[$x]\n";
}
flock (A2, 8);
close(A2);


print "Content-type: text/html\n\n";
print "<center><font face=verdana size=2><b><br><br><br><br>Ihr Traineraccount $trainer wurde<br>erfolgreich gel&ouml;scht !<br><br>Vielen Dank f&uuml;r Ihre Teilnahme<br>am TipMaster international .<br>";
print "<br>Sollten Sie die Absicht haben sich mit Ihrem Trainernamen<br>beim TipMaster neu zu registrieren , muessen Sie<br>bis zur (Wieder)Freischaltung Ihres Trainernamens<br>gedulden . Diese erfolgt t�glich um 4.oo Uhr nachts .<br><br>Mit freundlichen Gr�ssen<br>Die Spielleitung";
require "/tmapp/tmsrc/cronjobs/tmi/neuvergabe.pl";
exit ;

}



print "Content-type: text/html\n\n";
print <<"(END ERROR HTML)";
<html>
<head>
<title>TipMaster international: Trainer - Account l&ouml;schen</title>
</head>
<body bgcolor=#eeeeee text=black>
<font color=#eeeeee face=verdana size=1>.......................<img src=/img/trail.gif>
<br>
<table border=0><tr><td valign=top><img src=/img/url.gif border=0></td>
<td colspan=10></td><td valign=top>

<br>
<font face=verdana size=2><b>Trainer - Account l&ouml;schen</b><br><br>
<font face=verdana size=1 color=black><br>Guten Tag $trainer , <br><br>
wenn Sie kein Interesse mehr an der Teilnahme<br>
am TipMaster international koennen Sie nun mit<br>
untem folgenden Formular Ihren Trainer Account l&ouml;schen .<br><br>
Der w�chentliche Spielbetriebsnewsletter sowie die evtl.<br>
Tip - Remindern werden Ihnen danach nicht mehr zugestellt .<br><br>
Wir bedanken uns f&uuml;r Ihre Teilnahme am Tipmaster international .<br><br>


Bitte geben Sie zur Best�tigung Ihrer L�schabsicht Ihres<br>
Accounts nochmal Ihr Passwort an . Die L�schung Ihres<br>
Accounts kann nicht r�ckg�ngig gemacht werden .
<form action=/cgi-bin/tmi/account_delete.pl  method=post target=_top>
<input type=hidden name=trainer value="$trainer">
<input type=hidden name=method value="del">
<br>
Passwort :<br><br>
#@adjust
<input type=text length=10 maxlength=15 name=pass1><br><br>
<input type=submit value="Trainer Account l&ouml;schen"></form><br><br>
</td><td><br>
<br><br><font color=#eeeeee face=verdana size=1>..................
<img src=/img/header.gif valign=top></td></tr></table>



</html>
(END ERROR HTML)

exit;