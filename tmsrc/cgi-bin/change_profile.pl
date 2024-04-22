#!/usr/bin/perl

=head1 NAME
	GLOBAL change_profile.pl

=head1 SYNOPSIS
	Script to change password
	


=head1 CHANGELOG
	2015-06-09 Thomas: Added Session Management


	Created 2015-06-09

=cut

use lib '/tmapp/tmsrc/cgi-bin/';
use TMSession;
use TMDao;
use TMAuthenticationController;
my $session = TMSession::getSession( btm_login => 1 );

my $trainer = $session->getUser();
my $leut    = $trainer;
use CGI;
$query = new CGI;
my $method = $query->param('method');
my $pass1  = $query->param('pass1');
my $pass2  = $query->param('pass2');

changepassword( $session, $pass1, $pass2 ) if ($method) eq "changepassword";

print "Content-type: text/html\n\n";

print <<"(END ERROR HTML)";
<html>
<head>
<title>TipMaster : Profil Daten aendern</title>
</head>
<body bgcolor=#eeeeee text=black>

<b>Passwort &auml;ndern f&uuml;r $trainer</b><br/><br/>

<form action=/cgi-bin/change_profile.pl method=post target=_top>
<input type=hidden name=method value="changepassword">

Altes Passwort :<br>
<input type=password length=10 maxlength=15 name=pass1><br><br>
Neues Passwort :<br>
<input type=password length=10 maxlength=15 name=pass2><br><br>
<input type=submit value="Passwort aendern"></form><br><br>


<br/><br/>
Um Ihre E-Mail zu aendern fuer Trainer $trainer<br/> 
mailen sie bitte info\@tipmaster.de .

<!--

<form action=/cgi-bin/change_profile.pl  method=post target=_top>
<input type=hidden name=method value="changeemail">

<b>E-Mail &auml;ndern f&uuml;r $trainer</b><br/><br/>
Aktuelle Mailadresse :<br>
<input type=text length=20 maxlength=35 name=mail><br><br>
<input type=submit value="Mailadresse aendern"></form><br><br>
-->


</html>
(END ERROR HTML)

sub changepassword {
	my $session = shift;
	my $oldpass = shift;
	my $newpass = shift;

	my $oldpassHashed = TMAuthenticationController::hashPassword( $oldpass, $session->getUser() );

	if (TMAuthenticationController::validateNewPassword($newpass) eq "0") {
		errorWrongFormatPassword();
	}


	if ( $oldpassHashed eq TMDao::getHashedPasswordForUser($session->getUser() ) ) {
		TMDao::updatePasswordForUser( $newpass, $session->getUser() );

		print <<"(HTML)";
<html>
<head>
<title>TipMaster : Profil Daten aendern</title>
</head>
<body bgcolor=#eeeeee text=black>
Ihr Passwort wurde geandert.
<br/><br/>
<a href="/">Zur Hauptseite</a>
</html>
(HTML)
	}
	else {
		errorWrongPassword();
	}
	exit;

}

sub errorWrongPassword {
	print <<"(HTML)";
<html>
<head>
<title>TipMaster : Profil Daten aendern</title>
</head>
<body bgcolor=#eeeeee text=black>
Ihr derzeitiges Passwort wurde nicht korrekt angegeben.<br/>Ihr Passwort wuerde nicht aktualisiert.
<br/><br/>
<a href="/cgi-bin/change_profile.pl">Erneut versuchen</a><br/><br/>
<a href="/">Zur Hauptseite</a><br/><br/>

</html>
(HTML)
exit;
}

sub errorWrongFormatPassword {
	print <<"(HTML)";
<html>
<head>
<title>TipMaster : Profil Daten aendern</title>
</head>
<body bgcolor=#eeeeee text=black>
Ihr derzeitiges Passwort kann nicht akzeptiert werden.<br/>
Ein Passwort muss mindestens 4 Zeichen und maximal 16 Zeichen lang sein und<br/>
sollte keine Sonderzeichen beinhalten.<br/><br/>
<a href="/cgi-bin/change_profile.pl">Erneut versuchen</a><br/><br/>
<a href="/">Zur Hauptseite</a><br/><br/>

</html>
(HTML)
exit;
}

