#!/usr/bin/perl

=head1 NAME
	BTM form.pl

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
my $session = TMSession::getSession();
my $trainer = $session->getUser();
my $leut    = $trainer;

use CGI;
print "Content-Type: text/html \n\n";

$query      = new CGI;
$spielrunde = $query->param('spielrunde');

# kleine Statistik-Sonderanzeige
$perc = $query->param('perc');

require "/tmapp/tmsrc/cgi-bin/runde.pl";

$bx = "/tmdata/btm/formular";
$by = $rrunde - 1;
$by++;
if ( $spielrunde == 0 ) { $by = $rrunde }
$bv                = ".txt";
$datei_hier        = $bx . $by . $bv;
$spielrunde_ersatz = ( ( $by - 1 ) * 4 ) + 1;

$datei = '/tmdata/btm/tips/' . $spielrunde_ersatz . '/bisher.txt';
open( D2, "$datei" );
$p = 0;
while (<D2>) {
	$p++;

	@set = split( /&/, $_ );
	$toto_1[$p] = $set[1];
	$toto_2[$p] = $set[2];
	$toto_3[$p] = $set[3];

}

close(D2);
open( DO, $datei_hier );
while (<DO>) {
	@vereine = <DO>;
}
close(DO);

$y = 0;
for ( $x = 0 ; $x < 25 ; $x++ ) {
	$y++;
	chomp $vereine[$y];
	@ega = split( /&/, $vereine[$y] );
	$flagge[$y]   = $ega[0];
	$paarung[$y]  = $ega[1];
	$qu_1[$y]     = $ega[2];
	$qu_0[$y]     = $ega[3];
	$qu_2[$y]     = $ega[4];
	$ergebnis[$y] = $ega[5];
	$resultat[$y] = $ega[6];
	$datum[$y]    = $ega[7];
	$zeit[$y]     = $ega[8];
}

$xa = ( $by * 4 ) - 3;
$xb = $xa + 3;
if ( $xb > 34 ) { $xb = 34 }
print
"<html><title>Tipformular Ergebnisse</title><p align=left><body bgcolor=white text=black link=darkred link=darkred>\n";
require "/tmapp/tmsrc/cgi-bin/tag.pl";
require "/tmapp/tmsrc/cgi-bin/tag_small.pl";

print "<br><br>&nbsp;&nbsp;<font face=verdana size=2 color=black><b>Aktuelles Tipformular Uebersicht</b><br><br>\n";

print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>\n";
print "<table cellspacing=0 cellpadding=2 border=0>\n";

$xx = 0;
for ( $x = 1 ; $x <= 25 ; $x++ ) {
	$xx++;
	if ( $xx == 3 ) { $xx    = 1 }
	if ( $xx == 1 ) { $color = "#eeeeee" }
	if ( $xx == 2 ) { $color = "white" }

	$flag = $main_flags[ $flagge[$x] ];

	print "<tr>\n";
	print "<td align=right bgcolor=$color><font face=verdana size=1>&nbsp;&nbsp;$datum[$x]&nbsp;&nbsp;</td>\n";
	print "<td align=center bgcolor=$color><font face=verdana size=1>&nbsp;&nbsp;$zeit[$x]&nbsp;&nbsp;</td>\n";
	print
"<td align=left bgcolor=$color nowrap=nowrap><font face=verdana size=1>&nbsp;&nbsp;<img src=/img/$flag border=0 width=14 height=10>&nbsp;&nbsp;&nbsp;&nbsp;$paarung[$x]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";
	print "<td align=center bgcolor=$color><font face=verdana size=1>&nbsp;&nbsp;$resultat[$x]&nbsp;&nbsp;</td>\n";
	print
"<td align=center bgcolor=$color><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";

	$color1 = "black";
	$color2 = "black";
	$color3 = "black";

	if ( $ergebnis[$x] == 1 ) { $color1 = "red" }
	if ( $ergebnis[$x] == 2 ) { $color2 = "red" }
	if ( $ergebnis[$x] == 3 ) { $color3 = "red" }
	if ( $ergebnis[$x] == 4 ) { $color1 = $color2 = $color3 = "red"; $qu_1[$x] = $qu_0[$x] = $qu_2[$x] = 10 }

	print
"<td align=center bgcolor=$color><font face=verdana size=1 color=$color1>&nbsp;&nbsp;$qu_1[$x]&nbsp;&nbsp;</td>\n";
	print
"<td align=center bgcolor=$color><font face=verdana size=1 color=$color2>&nbsp;&nbsp;$qu_0[$x]&nbsp;&nbsp;</td>\n";
	print
"<td align=center bgcolor=$color><font face=verdana size=1 color=$color3>&nbsp;&nbsp;$qu_2[$x]&nbsp;&nbsp;</td>\n";

	print "<td align=center bgcolor=$color><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;
</td>\n";

	print "<td align=center bgcolor=$color>
<font face=verdana size=1 color=$color1>&nbsp;&nbsp;$toto_1[$x]&nbsp;
</td>\n";
	print "<td align=center bgcolor=$color>
<font face=verdana size=1 color=$color2>&nbsp;&nbsp;$toto_2[$x]&nbsp;
</td>\n";
	print "<td align=center bgcolor=$color>
<font face=verdana size=1 color=$color3>&nbsp;&nbsp;$toto_3[$x]&nbsp;
</td>\n";
	if ($perc) {
		my $sum = $toto_1[$x] + $toto_2[$x] + $toto_3[$x];
		my @perc =
		  ( int( $toto_1[$x] * 100 / $sum ), int( $toto_2[$x] * 100 / $sum ), int( $toto_3[$x] * 100 / $sum ) );
		print "<td align=center bgcolor=$color><font face=verdana size=1 color=black>(", $perc[0], "-", $perc[1], "-",
		  $perc[2], ")</font></td>";
	}

	print "</tr>\n";
}
print "</table>\n";
print "</td></tr></table>\n";
