#!/usr/bin/perl

=head1 NAME
	BTM modify_btm.pl

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
$query = new CGI;

for ( $x = 1 ; $x <= 25 ; $x++ ) {
	$erg[$x]       = $query->param("erg$x");
	$pro[$x]       = $query->param("pro$x");
	$datum_new[$x] = $query->param("datum$x");
	$zeit_new[$x]  = $query->param("zeit$x");

}

print "Content-type: text/html \n\n";
print "<body bgcolor=#eeeeee text=black><font face=verdana size=1>";

print "<form name=Testform action=/cgi-bin/btm/scout.pl method=post></form>";
print "<script language=JavaScript>\n";
print "   function AbGehts()\n";
print "   {\n";
print "    document.Testform.submit();\n";
print "    }\n";
print "   window.setTimeout(\"AbGehts()\",0);\n";
print "  </script>\n";

if ( !$trainer ) {
	print
"<b1>Ung&uuml;ltiger Aufruf!</b1> Bitte vom <a href=\"/cgi-bin/btm/scout.pl\">Scout-Formular</a> aus aufrufen!<br>\n";
	print "</body></html>\n";
	exit 0;
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
	$flagge[$y]     = $ega[0];
	$paarung_b[$y]  = $ega[1];
	$qu_1_b[$y]     = $ega[2];
	$qu_0_b[$y]     = $ega[3];
	$qu_2_b[$y]     = $ega[4];
	$tendenz_b[$y]  = $ega[5];
	$ergebnis_b[$y] = $ega[6];
	$datum_b[$y]    = $ega[7];
	$zeit[$y]       = $ega[8];
}

print $datei_hiero;
open( DO, ">$datei_hiero" );

print DO "\n\n";
for ( $y = 1 ; $y <= 25 ; $y++ ) {

	print DO
"$flagge[$y]&$paarung_b[$y]&$qu_1_b[$y]&$qu_0_b[$y]&$qu_2_b[$y]&$pro[$y]&$erg[$y]&$datum_new[$y]&$zeit_new[$y]&\n";

	if ( $pro[$y] > 0 ) { $ausw++ }
}

close(DO);

open( D, ">/tmdata/btm_ausw.txt" );
print D "$ausw";
close(D);
print "Ausgewertet $ausw von 25 ...";
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
open( DO, ">/tmdata/btm/scout_btm.txt" );

print DO "$trainer ( $xd$tag.$xe$mon.$jahr / $xc$std:$xb$min:$xa$sek Uhr )";

close(DO);
