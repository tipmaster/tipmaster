#!/usr/bin/perl

=head1 NAME
	GLOBAL pass_sent.pl

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

#script needs to be redone

use lib '/tmapp/tmsrc/cgi-bin/';
use TMSession;
my $session = TMSession::getSession();
my $trainer = $session->getUser();
my $leut    = $trainer;

use TMDao;
use CGI;
$query = new CGI;
$email = $query->param('email');

$mailprog = '/usr/sbin/sendmail';


my $user = TMDao::getUserForEmail($email);
error() if ( $user eq undef );

my $newPassword = TMDao::createNewPasswordForUser($user);

$mail{Message} .= "*** Neues Passwort TipMaster ***\n\n\n";
$mail{Message} .= "Sehr geehrte(r) $user ,  \n\n";
$mail{Message} .= "Ihre angeforderten neuen Zugangsdaten lauten : \n\n";
$mail{Message} .= "Trainername: $user\n";
$mail{Message} .= "Neues Passwort: $newPassword\n\n\nBitte beachten Sie Gross- und Kleinschreibung beim Login.\n\n\nMit freundlichen Gruessen\nIhr TipMaster - Team\n\n";

$mailprog = '/usr/sbin/sendmail';

open( MAIL, "|$mailprog -t" );
print MAIL "To: $email\n";
print MAIL "From: info\@tipmaster.de ( TipMaster online )\n";
print MAIL "Subject: Neues TipMaster Passwort\n\n";
print MAIL "$mail{Message}";
close(MAIL);

print "Content-type: text/html\n\n";
print <<"(END ERROR HTML)";
<html>
 <head>
  <title>Neues Passwort wurde verschickt</title>
 </head>
<body bgcolor=#eeeeee>
Das Passwort fuer $user wurde an <br>
die Adresse $email gemailt.<br><br>
Falls dies nicht mehr ihre gueltige<br>
E-Mail Adresse oder Sie diese Mail<br>
nicht erreicht ist wenden Sie sich<br> 
bitte an info\@tipmaster.de.

<br/><br/>
<a href="/">Zur&uuml;ck zur Hauptseite</a>
</body>


</html>
(END ERROR HTML)

exit;

sub error {

	print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>Kein Trainer gefunden</title>
 </head>
 <body bgcolor=#eeeeee text=#000000>
<p align=left><body bgcolor=white text=black>
<br><br>
Wir konnten keinen Trainer mit dieser E-Mail Adresse finden.<br/>
Bitte schreiben Sie eine E-Mail an info\@tipmaster.de



 </body>
</html>
(END ERROR HTML)

	exit;
}

