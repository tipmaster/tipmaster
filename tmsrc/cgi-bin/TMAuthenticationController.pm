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
	$session->setSessionValue( "authenticated", 0 );
	$session->setSessionValue( "trainer",       "" );
	$session->setSessionValue( "btm_team",      "" );
	$session->setSessionValue( "tmi_team",      "" );
	return;

}

sub error_needslogin {

	my $status = shift;
	select STDOUT;
	print "Content-type:text/html\n\n";
	print '
	
	<html>
	<body>
	<p align=left>
	<div style="text-align:left;width:400px;border:1px solid black; font-family:tahoma; font-size:14px; padding:20px;margin:30px">
	';

	if ( $status eq "no team" ) {
		print '
	Ihnen ist aktuell kein Verein zugewiesen. Bitte schreiben<br/> 
	Sie eine E-Mail an info@tipmaster.de wenn Sie denken das <br/>dass ein Fehler ist.
	';

	}
	else {
		print '
	
	<b>Du bist nicht eingeloggt oder Ihre Login Daten waren inkorrekt.</b>
	Bitte von der <a href="/">Startseite</a> aus einloggen.<br/><br/><br><br/>
	Im Fall von Login Problemen:<br/><br/>
	<li> Bitte gehen Sie sicher dass Ihr Trainername und Passwort mit der richtigen Gross- und Kleinschreibung angegeben werden.</li>
	<li> Fordern Sie ein neues Passwort <a href="/url.shtml">hier an</a></li>
	<li> Falls es weiterhin Probleme gibt, dann bitte <a href="http://community.tipmaster.de/showthread.php?p=253375">hier in der Community melden</a> und eine E-Mail an info@tipmaster.de mit der Problembeschreibung senden.</li>
	
	<br/><br/><b>
	Augrund eines weitreichenden Datenverlusts mussten wir den Spielbetrieb und Datenstand leider auf die Saison 2018\'2 Spieltag 20 zuruecksetzen.<br/>
	Dieser "Daten Reset" betrifft auch Accounts, Passwoerter, Pokal und Eurocup etc. Wenn Sie Ihren Account nach dem Mai 2018 erstellt haben<br/>
	muessen sie sich leider <a href="http://www.tipmaster.de/cgi-bin/btm/anmeldung.pl">erneut anmelden</a>.
	';
	}

	print '
	</div>
	</p>
	</body>
	</html>
	
	';

	exit;
}

sub validateNewPassword {
	my $pass = shift;

	return 0
	  if ( length($pass) < 4 || length($pass) > 16 || $pass =~ / / || $pass =~ /\&/ || $pass =~ /\!/ || $pass =~ /\#/ );
	return 1;

}
1;
