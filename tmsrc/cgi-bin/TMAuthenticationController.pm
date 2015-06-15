#!/usr/bin/perl

=head1 NAME
	TMAuthenticationController.pm

=head1 SYNOPSIS
	Authentication Controller
	
=head1 Author
	Thomas Prommer (thomas@socapro.com)

=head1 COPYRIGHT
	Copyright SocaPro Inc
	Created Jun 7, 2015

=cut

package TMAuthenticationController;

use lib '/tmapp/tmsrc/cgi-bin';
use lib '/tmapp/tmsrc/cgi-mod';
use TMLogger;
use Crypt::PBKDF2;

sub hashPassword {
	my $clearPassword = shift;
	my $user          = shift;

	my $pbkdf2 = Crypt::PBKDF2->new(
		hash_class => 'HMACSHA1',
		iterations => 100,          # so is this
		output_len => 20,           # and this
		salt_len   => 4,            # and this.
	);

	my $hashedPassword = $pbkdf2->generate( $clearPassword, $user );
	return $hashedPassword;
}

sub executeLoginAttempt {
	my $user          = $_[0];
	my $clearPassword = $_[1];
	my $session       = $_[2];

	my $hashedPassword = hashPassword( $clearPassword, $user );

	my $loginSuccess = 0;
	open( D2, "/tmdata/hashedPasswords.txt" );
	while (<D2>) {
		( undef, $line_user, $line_pass, undef ) = split( /&/, $_ );

		if ( ( $line_user eq $user ) && ( $line_pass eq $hashedPassword ) ) {
			$loginSuccess = 1;
			last;
		}

	}
	close(D2);

	my $btm_verein;
	open( D2, "/tmdata/btm/history.txt" );
	while (<D2>) {
		if ( $_ =~ /&$user&&/i ) {
			$_ =~ m/([^&]*)&$user&&/;
			$btm_verein = $1;
			last;
		}
	}
	close(D2);

	my $tmi_verein;
	open( D2, "/tmdata/tmi/history.txt" );
	while (<D2>) {
		if ( $_ =~ /&$user&&/i ) {
			$_ =~ m/([^&]*)&$user&&/;
			$tmi_verein = $1;
			last;
		}
	}
	close(D2);

	if ($loginSuccess) {
		$session->setSessionValue( "authenticated", 1 );
		$session->setSessionValue( "trainer",       $user );
		$session->setSessionValue( "btm_team",      $btm_verein );
		$session->setSessionValue( "tmi_team",      $tmi_verein );
	}
	else {
		error_needslogin();
	}
	return;

}

sub doLogout {

	my $session = $_[0];
	TMLogger::log("TMAuthenticationController.pm >>> logout");
	$session->setSessionValue( "authenticated", 0 );
	$session->setSessionValue( "trainer",       "" );
	$session->setSessionValue( "btm_team",      "" );
	$session->setSessionValue( "tmi_team",      "" );
	return;

}

sub error_needslogin {

	TMLogger::log("TMAuthenticationController.pm >>> show werrror");
	my $competition = shift;
	select STDOUT;
	print "Content-type:text/html\n\n";
	print '
	
	<html>
	<body>
	<p align=center>
	<div style="text-align:center;width:400px;border:1px solid black; font-family:tahoma; font-size:14px; padding:20px;margin:30px">
	<b>Du bist nicht beim ' . $competition . ' eingeloggt oder Ihre Login Daten waren inkorrekt.</b><br/>
	Bitte von der <a href="/">Startseite</a> aus einloggen.<br/><br/><br><br/>
	Im Fall von Login Problemen:<br>
	1/ Bitte gehen Sie sicher dass Ihr Trainername und Passwort mit der richtigen Gross- und Kleinschreibung angegeben werden.<br/>
	2/ Fordern Sie ein neues Passwort an. (Im Moment in Arbeit)<br/>
	3/ Senden Sie eine E-Mail an info@tipmaster.de mit der Problembeschreibung.<br/>
	
	</div>
	</p>
	</body>
	</html>
	
	';

	exit;
}

1;
