#!/usr/bin/perl

=head1 NAME
	cup_time.pl

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
print "Content-Type: text/html \n\n";
require "/tmapp/tmsrc/cgi-bin/runde.pl";
require "/tmapp/tmsrc/cgi-bin/tag.pl";
require "/tmapp/tmsrc/cgi-bin/tag_small.pl";

print "<br><br><p align=left><font face=verdana size=2><b> &nbsp; TipMaster - Rahmenterminkalender <br><br></b>\n";

print "<TABLE CELLSPACING=0 CELLPADDING=3 BORDER=0>";
for ( $x = 0 ; $x <= 9 ; $x++ ) {
	$fa = $fa + 1;
	if ( $fa == 3 ) { $fa    = 1 }
	if ( $fa == 1 ) { $farbe = "#eeeeee" }
	if ( $fa == 2 ) { $farbe = "white" }

	$color = "black";
	if ( ( $rrunde == $x ) ) { $color = "red" }
	if ( ( $x == 0 ) )       { $color = "darkred" }
	print "<TR BGCOLOR=$farbe>\n";
	if ( $x > 0 ) {
		$ab = $x * 4;
		$aa = $ab - 3;
		if ( $ab > 34 ) { $ab = 34 }

		print
"<TD align=center><font face=verdana size=1 color=$color> &nbsp; - Tiprunde $x - &nbsp; <br> &nbsp; [ Sp. $aa - $ab ] &nbsp; </Td>\n";

	}
	else {
		print "<TD align=center><font face=verdana size=1 color=$color> &nbsp;<br>  &nbsp; </Td>\n";
	}
	print "<TD align=center><font face=verdana size=1 color=$color> &nbsp;  $cup_dfb_name[$x] &nbsp;</Td>\n";
	print "<TD align=center><font face=verdana size=1 color=$color> &nbsp;  $cup_btm_name[$x] &nbsp;</Td>\n";
	print "<TD align=center><font face=verdana size=1 color=$color> &nbsp;  $cup_tmi_name[$x] &nbsp;</Td>\n";
	print "<TD align=center><font face=verdana size=1 color=$color> &nbsp;  $cup_cl_name[$x] &nbsp;</Td>\n";
	print "<TD align=center><font face=verdana size=1 color=$color> &nbsp;  $cup_uefa_name[$x] &nbsp;</Td>\n";

	print "</TR>\n";
}
print "</TABLE>";
