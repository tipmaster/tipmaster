#!/usr/bin/perl

=head1 NAME
	TMSession.pm

=head1 SYNOPSIS
	TipMaster Session Management
	


=head1 CHANGELOG
	2015-06-09 Thomas: Added Session Management


	Created 2015-06-09

=cut

package TMSession;

use lib '/tmapp/tmsrc/cgi-bin/';
use lib '/tmapp/tmsrc/cgi-mod/';
use CGI::Carp qw(fatalsToBrowser);

our $VERSION = 1;

use CGI;
use CGI::Session;
use CGI::Cookie;
use TMLogger;
use TMAuthenticationController;

sub new {

	my ($type) = $_[0];
	my ($self) = {};
	bless( $self, $type );
	$self->setCGISession( $_[1] );
	return ($self);
}

sub getSession {
	my $mode = shift;

	my $sid;
	$sid = getSessionIDCookie();
	my $cgisession = new CGI::Session( undef, $sid, { Directory => '/tmp' } );
	$cgisession->expires("30m");
	my $session  = TMSession->new($cgisession);
	my $query    = new CGI;
	my $user     = $query->param('email');
	my $passwort = $query->param('password');
	my $logout   = $query->param('logout');

	if ( $logout eq "1" ) {
		TMAuthenticationController::doLogout($session);
	}
	if ( $user ne "" || $passwort ne "" ) {
		TMAuthenticationController::executeLoginAttempt( $user, $passwort, $session );
	}

	if ( ( $mode eq "btm_login" || $mode eq "tmi_login" ) && ( !$session->isUserAuthenticated() ) ) {
		TMAuthenticationController::error_needslogin();
	}
	
	
	return $session;
}

sub writeSession {
	my $self = shift;
	return setSessionIDCookie( $self->getCGISession()->id() );

}

sub getSessionIDCookie {
	return CGI->cookie("CGISESSID") || undef;
}

sub setSessionIDCookie {
	eval {
		my $sid           = $_[0];
		my $cgi           = CGI->new;
		my $sessionCookie = CGI::cookie(
			-name    => 'CGISESSID',
			-value   => "$sid",
			-expires => '+2M',
			-domain  => '.tipmaster.de',
			-path    => '/',
			-secure  => 0
		);
		print CGI::header( -cookie => $sessionCookie );
	};
	print "Fehler" if @$;
}

sub setSessionValue {
	my $self  = $_[0];
	my $key   = $_[1];
	my $value = $_[2];

	$self->getCGISession()->param( $key, $value );
	return;

}

sub getSessionValue {
	my $self = $_[0];
	my $key  = $_[1];
	return $self->getCGISession()->param($key);
}

sub getUser {
	my $self = $_[0];
	return $self->getCGISession()->param('trainer');
}

sub getBTMTeam {
	my $self = $_[0];
	return $self->getCGISession()->param('btm_team');
}

sub getTMITeam {
	my $self = $_[0];
	return $self->getCGISession()->param('tmi_team');
}

sub isUserAuthenticated {
	my $self = $_[0];
	return $self->getCGISession()->param('authenticated');
}

sub getCGISession {
	my $self = shift;
	return $self->{'CGISession'};
}

sub setCGISession {
	my $self  = shift;
	my $value = shift;
	$self->{'CGISession'} = $value;
	return;
}

1;
