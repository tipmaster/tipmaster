#!/usr/bin/perl

=head1 NAME
	lib.pl

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
my $session = TMSession::getSession( btm_login => 1 );
my $trainer = $session->getUser();
my $leut    = $trainer;

use CGI;

$gl_{style} = " style=\"font-family:verdana; font-size:11px;\"";

sub readin_vereinsid {
	my $local = shift;
	open( D1, "</tmdata/$local/db/vereine.txt" );
	while (<D1>) {
		my @sal = split( /&/, $_ );
		$gl_vereinsid{ $sal[1] } = $sal[0];
		$gl_vereinsname[ $sal[0] ] = $sal[1];

	}
	close(D1);
}

sub get_head2head {
	my $local = shift;
	my $id1   = shift;
	my $id2   = shift;
	my $tmp   = "";
	open( D1, "</tmdata/$local/db/head2head/$id1.txt" );
	while (<D1>) {

		#print "$_<br>";
		my @sal = split( /\!/, $_ );

		#print "$sal[0]<br>";
		if ( $sal[0] == $id2 ) {
			$tmp = $_;
		}
	}
	close(D1);
	return $tmp;

}

sub get_balance {
	my $tmp = shift;
	my $b1  = 0;
	my $b2  = 0;
	my $b3  = 0;
	my @sal = split( /\!/, $tmp );
	foreach (@sal) {
		my @salb = split( /#/, $_ );
		my $tor1 = &tore( $salb[3] );
		my $tor2 = &tore( $salb[4] );
		if ( $salb[3] ne "" ) {
			if ( $tor1 == $tor2 ) { $b2++ }
			if ( $tor1 > $tor2 )  { $b1++ }
			if ( $tor1 < $tor2 )  { $b3++ }
		}
	}
	my @return = ();
	push( @return, $b1 );
	push( @return, $b2 );
	push( @return, $b3 );
	return @return;
}

sub head2head_games {
	my $tmp   = shift;
	my $b1    = 0;
	my $b2    = 0;
	my $b3    = 0;
	my @games = ();
	my @sal   = split( /\!/, $tmp );
	foreach (@sal) {
		my @salb = split( /#/, $_ );
		my $tor1 = &tore( $salb[3] );
		my $tor2 = &tore( $salb[4] );
		if ( $salb[3] ne "" ) {
			my $tmp = $_ . '#' . $tor1 . '#' . $tor2;
			push( @games, $tmp );
		}
	}
	return @games;
}

sub button {
	$text = shift;
	return "<input $gl_{style} type=submit value=\"$text\">";
}

sub hidden {
	my $name  = shift;
	my $value = shift;
	return "<input type=hidden name=\"$name\" value=\"$value\">";
}

sub datum {
	( my $sek, my $min, my $std, my $tag, my $mon, my $jahr ) = localtime( time + 0 );
	$mon++;
	if ( $sek < 10 )  { my $xa = "0" }
	if ( $min < 10 )  { my $xb = "0" }
	if ( $std < 10 )  { my $xc = "0" }
	if ( $tag < 10 )  { my $xd = "0" }
	if ( $mon < 10 )  { my $xe = "0" }
	if ( $liga < 10 ) { my $xf = "0" }
	$jahr = $jahr + 1900;
	return "$xd$tag.$xe$mon.$jahr";
}

sub replace {
	my $file    = shift;
	my $string1 = shift;
	my $string2 = shift;
	my $content = "";
	open( Z1, $file );
	while (<Z1>) {
		$content = $content . $_;
	}
	close(Z1);
	$content =~ s/$string1/$string2/;

	open( Z2, ">$file" );
	flock( Z2, 2 );
	print Z2 $content;
	flock( Z2, 8 );
	close(Z2);

}

sub tore {
	$xx  = shift;
	$tor = 0;
	if ( $xx > 14 )  { $tor = 1 }
	if ( $xx > 39 )  { $tor = 2 }
	if ( $xx > 59 )  { $tor = 3 }
	if ( $xx > 79 )  { $tor = 4 }
	if ( $xx > 104 ) { $tor = 5 }
	if ( $xx > 129 ) { $tor = 6 }
	if ( $xx > 154 ) { $tor = 7 }
	return $tor;
}

sub getAllTrainer {
	$xx = shift;
	if ( $xx ne "btm" && $xx ne "tmi" ) { $xx = "btm" }
	$nr = 0;
	open( D2, "/tmdata/" . $xx . "/history.txt" );
	while (<D2>) {
		$li++;
		@v = split( /&/, $_ );
		$y = 0;
		for ( $x = 1 ; $x < 19 ; $x++ ) {
			$y++;
			$y++;
			chomp $v[$y];
			$tmp[$nr] = $v[$y];
			$nr++;
			$y++;
		}
	}
	close(D2);
	return @tmp;

}

