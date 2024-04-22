#!/usr/bin/perl

=head1 NAME
	BTM daten.pl

=head1 SYNOPSIS
	TBD
	


=head1 CHANGELOG
	2015-06-09 Thomas: Added Session Management


	Created 2015-06-09

=cut

use lib '/tmapp/tmsrc/cgi-bin/'; 
use TMSession;
my $session = TMSession::getSession(btm_login => 1);
my $trainer = $session->getUser();
my $leut = $trainer;

use CGI;
$query = new CGI;

print "Content-type: text/html\n\n";


#print "<font face=verdana size=1>Feature kurzfristig deaktiv ...";exit;


print <<"(END ERROR HTML)";
<html>
<head>
<title>Bundesliga - TipMaster : LogIn - Daten aendern</title>
</head>
<body bgcolor=#eeeeee text=black>
<font color=#eeeeee face=verdana size=1>.......................<img src=/img/trail.gif>
<br>
<table border=0><tr><td valign=top><img src=/img/url.gif border=0></td>
<td colspan=10></td><td valign=top>

<br><font face=verdana size=1 color=black><br>Guten Tag $trainer , <br>
Sie koennen nun Ihre<br>Log - In Daten aendern .<br><br>
<form action=/cgi-bin/btm/daten/daten_pass.pl  method=post target=_top>
<input type=hidden name=trainer value="$trainer">
<input type=hidden name=password value="$pass">
<font face=verdana size=1><u>Passwort aendern :</u><br><br>
Altes Passwort :<br>
<input type=text length=10 maxlength=15 name=pass1><br><br>
Neues Passwort :<br>
<input type=text length=10 maxlength=15 name=pass2><br><br>
<input type=submit value="Passwort aendern"></form><br><br>

<form action=/cgi-bin/btm/daten/daten_mail.pl  method=post target=_top>
<input type=hidden name=trainer value="$trainer">
<input type=hidden name=password value="$pass">
<font face=verdana size=1><u>E-Mail Adresse aendern :</u><br><br>
Aktuelle Mailadresse :<br>
<input type=text length=20 maxlength=35 name=mail value="$mail"><br><br>
<input type=submit value="Mailadresse aendern"></form><br><br>
</td><td><br>
<br><br><font color=#eeeeee face=verdana size=1>..................
<img src=/img/header.gif valign=top></td></tr></table>



</html>
(END ERROR HTML)

exit;
