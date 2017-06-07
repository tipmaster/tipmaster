#!/usr/bin/perl

=head1 NAME
	BTM werben.pl

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

print "Content-type: text/html\n\n";


print <<"(END ERROR HTML)";
<html>
<head>
<title>Bundesliga - TipMaster : Mitspieler werben </title>
</head>
<body bgcolor=#eeeeee text=black>
<font color=#eeeeee face=verdana size=1>.......................<img src=/img/trail.gif>
<br>
<table border=0><tr><td valign=top><img src=/img/url.gif border=0></td>
<td colspan=10></td><td valign=top>
<br>
<font face=verdana size=2 color=darkred><b>Freunde zum TM einladen</b><br><br>
<font face=verdana color=black size=1>
Haben Sie fussballinteressierte Bekannte die Sie gerne<br>
fuer eine Teilnahme am TipMaster gewinnen wuerden und<br>
mit denen Sie sich gerne beim TipMaster messen wuerden ?<br><br>
Tragen Sie einfach den Namen und die E-Mail Adresse<br>
im unten folgenden Formular ein und Ihr Bekannter <br>
erhaelt kurze unverbindliche Informationsmail von<br>
uns mit einer freundlichen Einladung zur Teilnahme !<br><br><br>

<form action=/cgi-bin/btm/daten/werben_mail.pl  method=post target=_top>
<input type=hidden name=trainer value="$trainer">
<input type=hidden name=password value="$pass">
<font face=verdana size=1>
Name des Bekannten:<br>
<input type=text length=25 maxlength=20 name=name><br><br>
<font face=verdana size=1>
E-Mail Adresse des Bekannten:<br>
<input type=text length=35 maxlength=50 name=mail value=\@><br><br>
<input type=submit value="Informatios E-Mail senden"></form>
</td></tr></table>

</html>
(END ERROR HTML)

exit;






