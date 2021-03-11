#!/usr/bin/perl

=head1 NAME
	BTM scout.pl

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

my @permitted_coaches = (
	"Stefan Imhoff",
	"Bodo Pfannenschwarz",
	"Mick Goeske",
	"Wally Dresel",
	"Thomas Schnaedelbach",
	"Axel Collofong",
	"Holger Spreng",
	"Manfred Kiesel",
	"Markus Reiss",
	"Mirko Doerre",
	"Thomas Lichtner",
	"Bruno Behler",
	"Peter Russ",
	"Ralph Mathes",
	"Martin Ziegler",
	"Michael Pleus",
	"Andreas Hille",
	"Simon Wennige",
	"Martin Grunder",
	"Frederik Jaschinski",
	"Walter Eschbaumer",
	"Gunnar Mueller",
	"Martin Seidl",
	"Reimund Breucker",
	"Nick Zimmermann",
	"Roberto Maisl",
	"Holger Spreng",
	"Thomas Sassmannshausen",
	"Bernd Timmermann",
	"Thomas Hauptmann",
	"Andreas Samjeske",
	"Stefan Pauls"
);

my $flag = 0;
foreach (@permitted_coaches) {
	if ( $_ eq $trainer ) { $flag = 1 }
}

open( D7, "/tmdata/btm/tip_datum.txt" );
$spielrunde_ersatz = <D7>;

chomp $spielrunde_ersatz;
close(D7);

$bx = "formular";
$by = int( ( $spielrunde_ersatz + 3 ) / 4 );

$bv          = ".txt";
$fg          = "/tmdata/btm/";
$datei_hiero = $fg . $bx . $by . $bv;

open( DO, $datei_hiero );
while (<DO>) {
	@ver = <DO>;
}
close(DO);

$y = 0;
for ( $x = 0 ; $x < 25 ; $x++ ) {
	$y++;
	chomp $ver[$y];
	@ega = split( /&/, $ver[$y] );

	#$flagge[$y] = $ega[0] ;
	$paarung_b[$y]  = $ega[1];
	$qu_1_b[$y]     = $ega[2];
	$qu_0_b[$y]     = $ega[3];
	$qu_2_b[$y]     = $ega[4];
	$tendenz_b[$y]  = $ega[5];
	$ergebnis_b[$y] = $ega[6];
	$datum_b[$y]    = $ega[7];
	$zeit[$y]       = $ega[8];

}

print "Content-type: text/html\n\n";
require "/tmapp/tmsrc/cgi-bin/tag.pl";
require "/tmapp/tmsrc/cgi-bin/tag_small.pl";

print
"<br><br><font face=verdana size=2 color=darkred><b>TipMaster Ergebnis - Scoutbereich</b><br><font face=verdana color=black><b>Vielen Dank fuer eure Mithilfe :-) !</b><br><br>\n";

if ( $login != 1 ) {
	print
	  "<font face=verdana size=1>Eingeloggter Trainer : $trainer [ Ihre IP $ENV{REMOTE_ADDR} wird mitgeloggt ]<br><br>";

	if ( $flag == 0 ) {
		print "Im Moment nur eingeschraenkter Zugriff.";
	}

	#temporary, log all requests
	open( A, ">>/tmdata/tmp_scouting.txt" );
	print A localtime . " $trainer\n";
	close(A);
	if ( $flag == 0 ) {
		print "Im Moment nur eingeschraenkter Zugriff.";
		exit;
	}

}
else {

	exit;
}

if ( $ENV{REMOTE_ADDR} =~ /195.179.190/ || $trainer =~ /Wasmer/ ) {
	exit;
}

print
"<font face=verdana size=1 color=darkgreen>Bevor Ihr ein Endergebnis eintragt, prueft dieses Ergebnis<br>bitte durch mindestens zwei unabhaenige Quellen<br>( z.B. <a href=http://www.kicker.de>kicker.de</a> , <a href=https://www.fussball-liveticker.eu>fussball-liveticker.eu</a> etc. )<br><br><font color=black>";

print "<br/>Bitte 10er-Spiele mit <b>\"ausg.\"</b>eintragen!<br/><br/>\n";

open( D7, "/tmdata/btm/scout_btm.txt" );
$show = <D7>;
close(D7);

print "<font face=verdana size=1>Letzte Aktualisierung vorgenommen von $show .<br><br>";
print
"<form action=/cgi-bin/btm/restoreform.pl method=post><input type=\"submit\" value=\"Formular kaputt? Hier zum Backup einspielen\">";
print "</form>\n";

print "<form action=/cgi-bin/btm/modify_btm.pl method=post>\n";

print "<table border=0 cellpadding=0 cellspacing=0>";

for ( $x = 1 ; $x <= 25 ; $x++ ) {

	$tf++;

	$farbe = "white";
	if ( $tf == 3 ) { $tf    = 1 }
	if ( $tf == 2 ) { $farbe = "#eeeeee" }
	@selected = ();
	print "<tr>\n";
	print
"<td align=center bgcolor=$farbe><font face=verdana size=1>&nbsp;&nbsp;<input type=text style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=datum$x size=10 maxlength=10 value=\"$datum_b[$x]\">&nbsp;&nbsp;</td>\n";
	print
"<td align=center bgcolor=$farbe><font face=verdana size=1>&nbsp;&nbsp;<input type=text style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=zeit$x size=5 maxlength=5 value=\"$zeit[$x]\">&nbsp;Uhr &nbsp;</td>\n";

	print
"<td align=left bgcolor=$farbe><font face=verdana size=1>&nbsp;&nbsp;&nbsp;$paarung_b[$x]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";
	print
"<td bgcolor=$farbe><font face=verdana size=1> $qu_1[$x] &nbsp;&nbsp; $qu_0[$x] &nbsp;&nbsp; $qu_2[$x] &nbsp;&nbsp;</td>\n";

	print
"<td bgcolor=$farbe><font face=verdana size=1>&nbsp;&nbsp;<select style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=pro$x>\n";
	for ( $c = 0 ; $c <= 4 ; $c++ ) {
		$aa = "";
		if ( $c == $tendenz_b[$x] ) { $aa = " selected" }
		$ab = "";
		if ( $c == 0 ) { $ab = "steht noch aus" }
		if ( $c == 1 ) { $ab = "Heimsieg" }
		if ( $c == 2 ) { $ab = "Unentschieden" }
		if ( $c == 3 ) { $ab = "Auswaertssieg" }
		if ( $c == 4 ) { $ab = "ausgefallen" }

		print "<option value=$c$aa>$ab";
	}
	print "</select>&nbsp;&nbsp;</td>\n";
	print
"<td align=center bgcolor=$farbe><font face=verdana size=1>&nbsp;&nbsp;<input type=text name=erg$x size=5 maxlength=5 value=\"$ergebnis_b[$x]\"  style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\">&nbsp;&nbsp;</td>\n";

	print "</tr>\n";

}

print "</table>\n";

print
"<font face=verdana size=1><br><input  style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" type=submit value=\"BTM - Formular aktualisieren\">\n";
print "</form><hr>";

open( D7, "/tmdata/tmi/tip_datum.txt" );
$spielrunde_ersatz = <D7>;

chomp $spielrunde_ersatz;
close(D7);

$bx = "formular";
$by = int( ( $spielrunde_ersatz + 3 ) / 4 );

$bv          = ".txt";
$fg          = "/tmdata/tmi/";
$datei_hiero = $fg . $bx . $by . $bv;

open( DO, $datei_hiero );
while (<DO>) {
	@ver = <DO>;
}
close(DO);

$y = 0;
for ( $x = 0 ; $x < 25 ; $x++ ) {
	$y++;
	chomp $ver[$y];
	@ega = ();
	@ega = split( /&/, $ver[$y] );

	#$flagge[$y] = $ega[0] ;
	$paarung_b[$y]  = $ega[1];
	$qu_1_b[$y]     = $ega[2];
	$qu_0_b[$y]     = $ega[3];
	$qu_2_b[$y]     = $ega[4];
	$tendenz_b[$y]  = $ega[5];
	$ergebnis_b[$y] = $ega[6];
	$datum_b[$y]    = $ega[7];
	$zeit[$y]       = $ega[8];

}

open( D7, "/tmdata/btm/scout_tmi.txt" );
$show = <D7>;
close(D7);

print "<font face=verdana size=1>Letzte Aktualisierung vorgenommen von $show .<br><br>";

print "<form action=/cgi-bin/btm/modify_tmi.pl method=post>\n";
print "<table border=0 cellpadding=0 cellspacing=0>";

for ( $x = 1 ; $x <= 25 ; $x++ ) {

	$tf++;

	$farbe = "white";
	if ( $tf == 3 ) { $tf    = 1 }
	if ( $tf == 2 ) { $farbe = "#eeeeee" }
	@selected = ();
	print "<tr>\n";
	print
"<td align=center bgcolor=$farbe><font face=verdana size=1>&nbsp;&nbsp;<input type=text style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=datum$x size=10 maxlength=10 value=\"$datum_b[$x]\">&nbsp;&nbsp;</td>\n";
	print
"<td align=center bgcolor=$farbe><font face=verdana size=1>&nbsp;&nbsp;<input type=text style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=zeit$x size=5 maxlength=5 value=\"$zeit[$x]\">&nbsp;Uhr &nbsp;</td>\n";

	print
"<td align=left bgcolor=$farbe><font face=verdana size=1>&nbsp;&nbsp;&nbsp;$paarung_b[$x]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";
	print
"<td bgcolor=$farbe><font face=verdana size=1> $qu_1[$x] &nbsp;&nbsp; $qu_0[$x] &nbsp;&nbsp; $qu_2[$x] &nbsp;&nbsp;</td>\n";

	print
"<td bgcolor=$farbe><font face=verdana size=1>&nbsp;&nbsp;<select style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=pro$x>\n";
	for ( $c = 0 ; $c <= 4 ; $c++ ) {
		$aa = "";
		if ( $c == $tendenz_b[$x] ) { $aa = " selected" }
		$ab = "";
		if ( $c == 0 ) { $ab = "steht noch aus" }
		if ( $c == 1 ) { $ab = "Heimsieg" }
		if ( $c == 2 ) { $ab = "Unentschieden" }
		if ( $c == 3 ) { $ab = "Auswaertssieg" }
		if ( $c == 4 ) { $ab = "ausgefallen" }

		print "<option value=$c$aa>$ab";
	}
	print "</select>&nbsp;&nbsp;</td>\n";
	print
"<td align=center bgcolor=$farbe><font face=verdana size=1>&nbsp;&nbsp;<input type=text name=erg$x size=5 maxlength=5 value=\"$ergebnis_b[$x]\"  style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\">&nbsp;&nbsp;</td>\n";

	print "</tr>\n";

}

print "</table>\n";

print
"<font face=verdana size=1><br><input  style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" type=submit value=\"TMI - Formular aktualisieren\">\n";
print "</form><hr>";

open( D7, "/tmdata/btm/scout_tt.txt" );
$show = <D7>;
close(D7);

( $sek, $min, $std, $tag, $mon, $jahr ) = localtime( time + 0 );
$mon++;
$tag--;
if ( $sek < 10 )        { $xa = "0" }
if ( $min < 10 )        { $xb = "0" }
if ( $std < 10 )        { $xc = "0" }
if ( $tag < 10 )        { $xd = "0" }
if ( $mon < 10 )        { $xe = "0" }
if ( $liga < 10 )       { $xf = "0" }
if ( $spielrunde < 10 ) { $xg = "0" }
$jahr = $jahr + 1900;

$datum = $xd . $tag . "." . $xe . $mon . "." . $jahr;
$y     = 0;

open( DO, "/tmdata/btm/top_tip.txt" );
while (<DO>) {
	@ega = split( /&/, $_ );

	if ( $datum eq $ega[8] ) {

		$y++;
		chomp $ver[$y];
		$nr[$y]         = $ega[0];
		$paarung_t1[$y] = $ega[1];
		$paarung_t1[$y] .= " - $ega[2]";
		$ee[$y]   = $ega[7];
		$date[$y] = $ega[8];
		$time[$y] = $ega[9];
	}
}
close(DO);

$xa = "";
$xb = "";
$xc = "";
$xd = "";
$xe = "";
$xf = "";
$xg = "";

( $sek, $min, $std, $tag, $mon, $jahr ) = localtime( time + 0 );
$mon++;
if ( $sek < 10 )        { $xa = "0" }
if ( $min < 10 )        { $xb = "0" }
if ( $std < 10 )        { $xc = "0" }
if ( $tag < 10 )        { $xd = "0" }
if ( $mon < 10 )        { $xe = "0" }
if ( $liga < 10 )       { $xf = "0" }
if ( $spielrunde < 10 ) { $xg = "0" }
$jahr = $jahr + 1900;

$datum = $xd . $tag . "." . $xe . $mon . "." . $jahr;

open( DO, "/tmdata/btm/top_tip.txt" );
while (<DO>) {
	@ega = split( /&/, $_ );

	if ( $datum eq $ega[8] ) {

		$y++;
		chomp $ver[$y];
		$nr[$y]         = $ega[0];
		$paarung_t1[$y] = $ega[1];
		$paarung_t1[$y] .= " - $ega[2]";
		$ee[$y]   = $ega[7];
		$date[$y] = $ega[8];
		$time[$y] = $ega[9];
	}
}
close(DO);

$tf = 1;

#print "<font face=verdana size=1>Letzte Aktualisierung vorgenommen von $show .<br><br>";

print "<form action=/cgi-bin/btm/modify_tt.pl method=post>\n";
print "<table border=0 cellpadding=0 cellspacing=0>";

for ( $x = 1 ; $x <= $y ; $x++ ) {
	$tf++;
	$farbe = "white";
	if ( $tf == 3 ) { $tf    = 1 }
	if ( $tf == 2 ) { $farbe = "#eeeeee" }
	@selected = ();
	print "<tr>\n";
	print "<td align=center bgcolor=$farbe><font face=verdana size=1>&nbsp;&nbsp;$date[$x]&nbsp;&nbsp;</td>\n";
	print "<td align=center bgcolor=$farbe><font face=verdana size=1>&nbsp;&nbsp;$time[$x]&nbsp;&nbsp;</td>\n";

	print
"<td align=left bgcolor=$farbe width=400><font face=verdana size=1>&nbsp;&nbsp;&nbsp;$paarung_t1[$x]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";
	print
"<td align=center bgcolor=$farbe><font face=verdana size=1>&nbsp;&nbsp;<input type=text name=$nr[$x] size=5 maxlength=5 value=\"$ee[$x]\"  style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\">&nbsp;&nbsp;</td>\n";

	print "</tr>\n";

}

print "</table>\n";

print
"<font face=verdana size=1><br><input  style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" type=submit value=\"TOP - TIP aktualisieren\">\n";
print "</form>";

