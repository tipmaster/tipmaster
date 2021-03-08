#!/usr/bin/perl

=head1 NAME
	TMI tab.pl

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

use strict;
use lib '/tmapp/tmsrc/cgi-bin/';
use TMSession;
my $session = TMSession::getSession( tmi_login => 1 );
my $trainer = $session->getUser();
my $leut    = $trainer;

use CGI;

print "Content-Type: text/html \n\n";
use lib qw{/tmapp/tmsrc/cgi-bin};
use Test;
use CGI qw/:standard/;
use CGI::Cookie;

my @cookies      = ();
my $mlib         = new Test;
my $page_footer  = $mlib->page_footer();
my $banner_gross = $mlib->banner_gross();
my $banner_bottom = $mlib->banner_bottom();
my $banner_klein = $mlib->banner_klein();
my $location     = $mlib->location_tmi();
my @liga_namen   = $mlib->tmi_liga_namen();
my @main_saison  = $mlib->tmi_saison_namen();
my $main_nr      = $main_saison[0];

my @uef    = ();
my $status = "";
my $saison = "";
my $spielrunde_ersatz;
my $ein;
my $wert;
my $ein_a;
my $ein_b;
my $spieltag;
my $x;
my $suche;
my $gg;
my $ro;
my $rf;
my $rx;
my @vereine;
my $gp;
my $dd = "";
my $y;
my @verein;
my @data;
my @datb;
my @datc;
my @ego;
my $hg;
my $anton;
my $beta;
my $datei_data;
my @quoten_row;
my $gh;
my $fa;
my $fc;
my @ega;
my @quoten_zahl;
my $tora;
my $torb;
my $wa;
my $wb;
my @dat_sp;
my @dat_hsp;
my @dat_asp;
my @dat_qu;
my @dat_gqu;
my @dat_hqu;
my @dat_ghqu;
my @dat_aqu;
my @dat_gaqu;
my @dat_tp;
my @dat_tm;
my @dat_htp;
my @dat_htm;
my @dat_atp;
my @dat_atm;
my $lr;
my $ls;
my $ll;
my @dat_hi;
my @dat_gs;
my @dat_hs;
my @dat_gpu;
my @dat_gn;
my @dat_an;
my @dat_as;
my @dat_hn;
my @dat_gu;
my @dat_hu;
my @dat_au;
my @plx;
my @tab;
my $xy;
my @dat_td;
my @dat_htd;
my @dat_atd;
my @dat_hpu;
my @dat_apu;
my $v;
my $e;
my @dat_qu_m;
my @dat_gqu_m;
my @dat_hqu_m;
my @dat_ghqu_m;
my @dat_aqu_m;
my @dat_gaqu_m;
my $xx;
my $yx;
my @pl1;
my $farbe;
my $ce_1;
my $ce_2;
my $ce_3;
my $ce_4;
my $ce_5;
my $color;
my $t;
my $r;
my @merk;
my $query;
my $liga;
my $ligi;
my $id;
my $live;
my $spielrunde;
my $methode;
my $sp_ende;
my $sp_start;
my $leer;
my $rr_ligen;
my $kuerzel;
my $ok;
my @liga_art;
my @liga_kuerzel;
my %pokal;
my $kat;
my @liga_kat;
my @line_1;
my @line_2;
my @line_3;
my @line_4;
my $kata;

@liga_art = (
	0, 1, 2, 3, 3, 3, 3, 3, 3, 1, 2, 3, 3, 3, 3, 3, 3, 1, 2, 3, 3, 3, 3, 3, 3, 1, 2, 3, 3, 3, 3, 3, 3, 1,
	2, 4, 4, 2, 2, 1, 2, 4, 4, 2, 2, 1, 2, 4, 4, 2, 2, 1, 2, 4, 4, 2, 2, 1, 2, 4, 4, 2, 2, 1, 2, 4, 4, 2,
	2, 1, 2, 4, 4, 2, 2, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3,
	3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1,
	2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3,
	3, 1, 5, 2, 1, 5, 2, 1, 5, 2, 1, 5, 2, 1, 5, 2, 1, 5, 2, 1, 5, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1
);

@liga_kuerzel = (
	"---",
	"ITA I",
	"ITA II",
	"ITA III/A",
	"ITA III/B",
	"ITA IV/A",
	"ITA IV/B",
	"ITA IV/C",
	"ITA IV/D",
	"ENG I",
	"ENG II",
	"ENG III/A",
	"ENG III/B",
	"ENG IV/A",
	"ENG IV/B",
	"ENG IV/C",
	"ENG IV/D",
	"SPA I",
	"SPA II",
	"SPA III/A",
	"SPA III/B",
	"SPA IV/A",
	"SPA IV/B",
	"SPA IV/C",
	"SPA IV/D",
	"FRA I",
	"FRA II",
	"FRA III/A",
	"FRA III/B",
	"FRA IV/A",
	"FRA IV/B",
	"FRA IV/C",
	"FRA IV/D",
	"NED I",
	"NED II",
	"NED III/A",
	"NED III/B",
	"NED IV/A",
	"NED IV/B",
	"POR I",
	"POR II",
	"POR III/A",
	"POR III/B",
	"POR IV/A",
	"POR IV/B",
	"BEL I",
	"BEL II",
	"BEL III/A",
	"BEL III/B",
	"BEL IV/A",
	"BEL IV/B",
	"SUI I",
	"SUI II",
	"SUI III/A",
	"SUI III/B",
	"SUI IV/A",
	"SUI IV/B",
	"AUT I",
	"AUT II",
	"AUT III/A",
	"AUT III/B",
	"AUT IV/A",
	"AUT IV/B",
	"SCO I",
	"SCO II",
	"SCO III/A",
	"SCO III/B",
	"SCO IV/A",
	"SCO IV/B",
	"TUR I",
	"TUR II",
	"TUR III/A",
	"TUR III/B",
	"TUR IV/A",
	"TUR IV/B",
	"IRL I",
	"IRL II",
	"IRL III/A",
	"IRL III/B",
	"NIR I",
	"NIR II",
	"NIR III/A",
	"NIR III/B",
	"WAL I",
	"WAL II",
	"WAL III/A",
	"WAL III/B",
	"DEN I",
	"DEN II",
	"DEN III/A",
	"DEN III/B",
	"NOR I",
	"NOR II",
	"NOR III/A",
	"NOR III/B",
	"SWE I",
	"SWE II",
	"SWE III/A",
	"SWE III/B",
	"FIN I",
	"FIN II",
	"FIN III/A",
	"FIN III/B",
	"ISL I",
	"ISL II",
	"ISL III/A",
	"ISL III/B",
	"POL I",
	"POL II",
	"POL III/A",
	"POL III/B",
	"TCH I",
	"TCH II",
	"TCH III/A",
	"TCH III/B",
	"UNG I",
	"UNG II",
	"UNG III/A",
	"UNG III/B",
	"RUM I",
	"RUM II",
	"RUM III/A",
	"RUM III/B",
	"SLO I",
	"SLO II",
	"SLO III/A",
	"SLO III/B",
	"KRO I",
	"KRO II",
	"KRO III/A",
	"KRO III/B",
	"JUG I",
	"JUG II",
	"JUG III/A",
	"JUG III/B",
	"BoH I",
	"BoH II",
	"BoH III/A",
	"BoH III/B",
	"BUL I",
	"BUL II",
	"BUL III/A",
	"BUL III/B",
	"GRI I",
	"GRI II",
	"GRI III/A",
	"GRI III/B",
	"RUS I",
	"RUS II",
	"RUS III/A",
	"RUS III/B",
	"EST I",
	"EST II",
	"EST III/A",
	"EST III/B",
	"UKR I",
	"UKR II",
	"UKR III/A",
	"UKR III/B",
	"MOL I",
	"MOL II",
	"MOL III/A",
	"MOL III/B",
	"ISR I",
	"ISR II",
	"ISR III/A",
	"ISR III/B",
	"LUX I",
	"LUX II",
	"LUX III/A",
	"LUX III/B",
	"SLK I",
	"SLK II",
	"SLK III",
	"MAZ I",
	"MAZ II",
	"MAZ III",
	"LIT I",
	"LIT II",
	"LIT III",
	"LET I",
	"LET II",
	"LET III",
	"WRU I",
	"WRU II",
	"WRU III",
	"MAL I",
	"MAL II",
	"MAL III",
	"ZYP I",
	"ZYP II",
	"ZYP III",
	"ALB I",
	"ALB II",
	"GEO I",
	"GEO II",
	"ARM I",
	"ARM II",
	"ASE I",
	"ASE II",
	"AND I",
	"AND II",
	"FAE I",
	"SaM I"
);

use CGI;
$query      = new CGI;
$liga       = $query->param('li');
$ligi       = $query->param('ligi');
$id         = $query->param('id');
$live       = $query->param('live');
$spielrunde = $query->param('sp');
$methode    = $query->param('me');
$sp_ende    = $query->param('ende');
$sp_start   = $query->param('start');

#require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl";

open( D7, "/tmdata/tmi/datum.txt" );
$leer              = <D7>;
$spielrunde_ersatz = <D7>;

chomp $spielrunde_ersatz;
close(D7);

$ein = 0;
if (   ( $methode eq "G" )
	or ( $methode eq "H" )
	or ( $methode eq "A" )
	or ( $methode eq "HR" )
	or ( $methode eq "RR" )
	or ( $methode eq "I" ) )
{
	$ein = 1;
}
if ( $ein == 0 ) { $methode = "G" }

if ( $methode eq "HR" ) { ( $sp_start = 1 )  and ( $sp_ende = 17 ) }
if ( $methode eq "RR" ) { ( $sp_start = 18 ) and ( $sp_ende = 34 ) }

$ein = 0;
if ( ( $wert eq "P" ) or ( $wert eq "OT" ) or ( $wert eq "DT" ) or ( $wert eq "OQ" ) or ( $wert eq "DQ" ) ) { $ein = 1 }
if ( $ein == 0 ) { $wert = "P" }

$ein_a = 0;
$ein_b = 0;

for ( $spieltag = 1 ; $spieltag < 35 ; $spieltag++ ) {
	if ( $sp_start == $spieltag ) { $ein_a = 1 }
	if ( $sp_ende == $spieltag )  { $ein_b = 1 }
}

if ( $ein_a == 0 ) { $sp_start = 1 }
if ( $ein_b == 0 ) { $sp_ende  = $spielrunde_ersatz }

if ( $sp_ende > $spielrunde_ersatz ) { $sp_ende  = $spielrunde_ersatz }
if ( $sp_start > $sp_ende )          { $sp_start = $sp_ende }

$ein_a = 0;

$ein = 0;
for ( $x = 1 ; $x <= 203 ; $x++ ) {
	if ( $x == $liga ) { $ein = 1 }
}

if ( $ein == 0 ) {

	if ( ( $trainer ne "unknown" ) or ( $trainer ne "" ) ) {

		$liga  = 0;
		$suche = '&' . $trainer . '&';
		open( D2, "/tmdata/tmi/history.txt" );
		while (<D2>) {
			$gg++;
			if ( $_ =~ /$suche/ ) {
				$liga = $gg;
			}
		}
		close(D2);
	}

	if ( $liga == 0 ) { $liga = 1 }
}

$ro    = "x";
$suche = $ro . $liga;

$rf = "0";
$rx = "x";
if ( $liga > 9 ) { $rf = "" }

$suche = $rx . $rf . $liga . '&';
$gg    = 0;
open( D2, "/tmdata/tmi/history.txt" );
while (<D2>) {
	$gg++;
	if ( $_ =~ /$suche/ ) {
		@vereine = split( /&/, $_ );
		$gp = $gg;
	}

}
close(D2);

$y = 0;
for ( $x = 1 ; $x < 19 ; $x++ ) {
	$y++;
	chomp $verein[$y];
	$data[$x] = $vereine[$y];
	$y++;
	chomp $verein[$y];
	$datb[$x] = $vereine[$y];

	if ( $datb[$x] eq $trainer ) {
		$ligi = $gp;
		$id   = $x;
	}

	$y++;
	chomp $verein[$y];
	$datc[$x] = $vereine[$y];
}

open( D9, "/tmdata/tmi/spieltag.txt" );
while (<D9>) {
	@ego = <D9>;
}
close(D9);

$hg    = "/tmdata/tmi/DAT";
$anton = "0";
if ( $liga > 9 ) { $anton = "" }
$beta = ".TXT";

$datei_data = $hg . $anton . $liga . $beta;
open( DO, $datei_data );
while (<DO>) {
	@quoten_row = <DO>;
}
close(DO);

print "<script language=JavaScript>\n";
print "<!--\n";
print "function targetLink(URL)\n";
print "  {\n";
print "    if(document.images)\n";
print
"      targetWin = open(URL,\"Neufenster1\",\"scrollbars=yes,toolbar=no,directories=no,menubar=no,status=no,resizeable=yes,width=850,height=240\");\n";
print " }\n";
print "  //-->\n";
print "  </script>\n";

print "<html><title>Tabelle $liga_namen[$liga]</title><p align=left><body bgcolor=white text=black>\n";
print "<head>\n";
print "<style type=\"text/css\">";

print
"TD.r { text-align:right;padding-top:3px;padding-bottom:3px;padding-left:5px;padding-right:10px;font-family:Verdana; font-size:8pt; color:black; alignment: right; }\n";
print
  "TD.r1 { padding-left:5px;padding-right:0px;font-family:Verdana; font-size:8pt; color:black; text-align:right; }\n";
print
  "TD.r2 { padding-left:10px;padding-right:22px;font-family:Verdana; font-size:8pt; color:black; text-align:right; }\n";
print
  "TD.c { padding-left:10px;padding-right:10px;font-family:Verdana; font-size:8pt; color:black; text-align:center; }\n";
print
  "TD.l { padding-left:10px;padding-right:10px;font-family:Verdana; font-size:8pt; color:black; alignment: left; }\n";
print
"TD.d { text-align:middle;padding-bottom:8px; padding-left:10px;padding-right:10px;font-family:Verdana; font-size:8pt; color:black;  }\n";
print "</style>\n";
print "</head>\n";

print "$banner_gross $banner_klein";
print "$location";

# if ( ($methode eq "G" ) or ($methode eq "HR" ) or ($methode eq "RR" )) { print "<font face=verdana size=2>Gesamttabelle von Spieltag $sp_start bis $sp_ende</b></font>" }
# if ( ($methode eq "H" )) { print "<font face=verdana size=2>Heimtabelle von Spieltag $sp_start bis $sp_ende</b></font>" }
# if ( ($methode eq "A" )) { print "<font face=verdana size=2>Auswartstabelle von Spieltag $sp_start bis $sp_ende</b></font>" }

print "<font face=verdana size=1><form method=post action=tab.pl target=_top>";

print "<select style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=li>";

for ( $x = 1 ; $x <= 203 ; $x++ ) {
	$gh = "";
	if ( $x == $liga ) { $gh = "selected" }
	print "<option value=$x $gh>$liga_namen[$x] \n";
}
print "</select>&nbsp;&nbsp;\n";

print "<select style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=me>";
if ( $methode eq "G" ) {
	print "<option value=G selected>Gesamt";
	print "<option value=H>Heim";
	print "<option value=A>Auswaerts";
	print "<option value=HR>Hinrunde";
	print "<option value=RR>Rueckrunde";
}
if ( $methode eq "H" ) {
	print "<option value=G>Gesamt";
	print "<option value=H selected>Heim";
	print "<option value=A>Auswaerts";
	print "<option value=HR>Hinrunde";
	print "<option value=RR>Rueckrunde";
}
if ( $methode eq "A" ) {
	print "<option value=G>Gesamt";
	print "<option value=H>Heim";
	print "<option value=A selected>Auswaerts";
	print "<option value=HR>Hinrunde";
	print "<option value=RR>Rueckrunde";
}

if ( $methode eq "HR" ) {
	print "<option value=G>Gesamt";
	print "<option value=H>Heim";
	print "<option value=A>Auswaerts";
	print "<option value=HR selected>Hinrunde";
	print "<option value=RR>Rueckrunde";
}

if ( $methode eq "RR" ) {
	print "<option value=G>Gesamt";
	print "<option value=H>Heim";
	print "<option value=A>Auswaerts";
	print "<option value=HR>Hinrunde";
	print "<option value=RR selected>Rueckrunde";
}

print "</select>&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=1>";
print
"Sp.&nbsp;<input type=text  style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000; background-color: #FFFFFF;\" size=2 maxlenght=2 value=$sp_start name=start>&nbsp;bis&nbsp;<input type=text  style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000; background-color: #FFFFFF;\" size=2 maxlenght=2 value=$sp_ende name=ende>&nbsp;&nbsp;";
print
"&nbsp;&nbsp;&nbsp;<input type=hidden name=trainer value=\"$leut\"><input type=hidden name=id value=\"$id\" ><input type=hidden name=ligi value=\"$ligi\" ><input  style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" type=submit value=\"Tabelle laden\"></form>";

$fa = 0;
$fc = -1;
for ( $spieltag = ( $sp_start - 1 ) ; $spieltag < ($sp_ende) ; $spieltag++ ) {

	if ( ( $methode ne "A" ) and ( $methode ne "H" ) ) {
		if ( ( $spieltag + 7 ) >= ( $sp_ende - 1 ) ) { $fc++ }
	}

	if ( ( $methode eq "A" ) or ( $methode eq "H" ) ) {
		if ( ( $spieltag + 18 ) >= ( $sp_ende - 1 ) ) { $fc++ }
	}

	@ega = split( /&/, $ego[$spieltag] );

	chop $quoten_row[$spieltag];
	@quoten_zahl = split( /&/, $quoten_row[$spieltag] );
	for ( $x = 0 ; $x < 18 ; $x = $x + 2 ) {

		$tora = 0;
		$torb = 0;
		$y    = $x + 1;
		$wa   = $x - 1;
		$wb   = $y - 1;

		if ( $quoten_zahl[ $ega[$x] - 1 ] != "1" ) {

			if ( $quoten_zahl[ $ega[$x] - 1 ] > 14 )  { $tora = 1 }
			if ( $quoten_zahl[ $ega[$x] - 1 ] > 39 )  { $tora = 2 }
			if ( $quoten_zahl[ $ega[$x] - 1 ] > 59 )  { $tora = 3 }
			if ( $quoten_zahl[ $ega[$x] - 1 ] > 79 )  { $tora = 4 }
			if ( $quoten_zahl[ $ega[$x] - 1 ] > 104 ) { $tora = 5 }
			if ( $quoten_zahl[ $ega[$x] - 1 ] > 129 ) { $tora = 6 }
			if ( $quoten_zahl[ $ega[$x] - 1 ] > 154 ) { $tora = 7 }

			if ( $quoten_zahl[ $ega[$y] - 1 ] > 14 )  { $torb = 1 }
			if ( $quoten_zahl[ $ega[$y] - 1 ] > 39 )  { $torb = 2 }
			if ( $quoten_zahl[ $ega[$y] - 1 ] > 59 )  { $torb = 3 }
			if ( $quoten_zahl[ $ega[$y] - 1 ] > 79 )  { $torb = 4 }
			if ( $quoten_zahl[ $ega[$y] - 1 ] > 104 ) { $torb = 5 }
			if ( $quoten_zahl[ $ega[$y] - 1 ] > 129 ) { $torb = 6 }
			if ( $quoten_zahl[ $ega[$y] - 1 ] > 154 ) { $torb = 7 }

			$y = $x + 1;

			$dat_sp[ $ega[$x] ]++;
			$dat_sp[ $ega[$y] ]++;
			$dat_hsp[ $ega[$x] ]++;
			$dat_asp[ $ega[$y] ]++;

			$dat_qu[ $ega[$x] ]   = $quoten_zahl[ $ega[$x] - 1 ] + $dat_qu[ $ega[$x] ];
			$dat_qu[ $ega[$y] ]   = $quoten_zahl[ $ega[$y] - 1 ] + $dat_qu[ $ega[$y] ];
			$dat_gqu[ $ega[$x] ]  = $quoten_zahl[ $ega[$y] - 1 ] + $dat_gqu[ $ega[$x] ];
			$dat_gqu[ $ega[$y] ]  = $quoten_zahl[ $ega[$x] - 1 ] + $dat_gqu[ $ega[$y] ];
			$dat_hqu[ $ega[$x] ]  = $quoten_zahl[ $ega[$x] - 1 ] + $dat_hqu[ $ega[$x] ];
			$dat_ghqu[ $ega[$x] ] = $quoten_zahl[ $ega[$y] - 1 ] + $dat_ghqu[ $ega[$x] ];
			$dat_aqu[ $ega[$y] ]  = $quoten_zahl[ $ega[$y] - 1 ] + $dat_aqu[ $ega[$y] ];
			$dat_gaqu[ $ega[$y] ] = $quoten_zahl[ $ega[$x] - 1 ] + $dat_gaqu[ $ega[$y] ];

			$dat_tp[ $ega[$x] ]  = $dat_tp[ $ega[$x] ] + $tora;
			$dat_tm[ $ega[$x] ]  = $dat_tm[ $ega[$x] ] + $torb;
			$dat_tp[ $ega[$y] ]  = $dat_tp[ $ega[$y] ] + $torb;
			$dat_tm[ $ega[$y] ]  = $dat_tm[ $ega[$y] ] + $tora;
			$dat_htp[ $ega[$x] ] = $dat_htp[ $ega[$x] ] + $tora;
			$dat_htm[ $ega[$x] ] = $dat_htm[ $ega[$x] ] + $torb;
			$dat_atp[ $ega[$y] ] = $dat_atp[ $ega[$y] ] + $torb;
			$dat_atm[ $ega[$y] ] = $dat_atm[ $ega[$y] ] + $tora;

			$lr = 0;
			$ls = 0;

			if ( $fc > -1 ) {
				$ll = ($fc) * 18;
				$lr = $ll + $ega[$x];
				$ls = $ll + $ega[$y];
			}

			if ( $tora > $torb ) {
				if ( $methode ne "A" ) { $dat_hi[$lr] = "S" }
				if ( $methode ne "H" ) { $dat_hi[$ls] = "n" }

				$dat_gs[ $ega[$x] ]++;
				$dat_hs[ $ega[$x] ]++;
				$dat_gpu[ $ega[$x] ] = $dat_gpu[ $ega[$x] ] + 3;
				$dat_gn[ $ega[$y] ]++;
				$dat_an[ $ega[$y] ]++;
			}

			if ( $tora < $torb ) {
				if ( $methode ne "A" ) { $dat_hi[$lr] = "N" }
				if ( $methode ne "H" ) { $dat_hi[$ls] = "s" }

				$dat_gs[ $ega[$y] ]++;
				$dat_as[ $ega[$y] ]++;
				$dat_gpu[ $ega[$y] ] = $dat_gpu[ $ega[$y] ] + 3;
				$dat_gn[ $ega[$x] ]++;
				$dat_hn[ $ega[$x] ]++;
			}

			if ( $tora == $torb ) {

				if ( $methode ne "A" ) { $dat_hi[$lr] = "U" }
				if ( $methode ne "H" ) { $dat_hi[$ls] = "u" }

				$dat_gu[ $ega[$x] ]++;
				$dat_hu[ $ega[$x] ]++;
				$dat_gpu[ $ega[$x] ] = $dat_gpu[ $ega[$x] ] + 1;
				$dat_gu[ $ega[$y] ]++;
				$dat_au[ $ega[$y] ]++;
				$dat_gpu[ $ega[$y] ] = $dat_gpu[ $ega[$y] ] + 1;
			}

		}
	}

}

@plx = ();
@tab = ();

for ( $xy = 1 ; $xy < 19 ; $xy++ ) {
	$dat_td[$xy]  = $dat_tp[$xy] - $dat_tm[$xy];
	$dat_htd[$xy] = $dat_htp[$xy] - $dat_htm[$xy];
	$dat_atd[$xy] = $dat_atp[$xy] - $dat_atm[$xy];
	$dat_hpu[$xy] = ( $dat_hs[$xy] * 3 ) + ( $dat_hu[$xy] * 1 );
	$dat_apu[$xy] = ( $dat_as[$xy] * 3 ) + ( $dat_au[$xy] * 1 );

	$dat_sp[$xy]  = $dat_sp[$xy] * 1;
	$dat_hsp[$xy] = $dat_hsp[$xy] * 1;
	$dat_asp[$xy] = $dat_asp[$xy] * 1;

	$dat_gpu[$xy] = $dat_gpu[$xy] * 1;
	$dat_hpu[$xy] = $dat_hpu[$xy] * 1;
	$dat_apu[$xy] = $dat_apu[$xy] * 1;

	$dat_gs[$xy] = $dat_gs[$xy] * 1;
	$dat_gu[$xy] = $dat_gu[$xy] * 1;
	$dat_gn[$xy] = $dat_gn[$xy] * 1;
	$dat_hs[$xy] = $dat_hs[$xy] * 1;
	$dat_hu[$xy] = $dat_hu[$xy] * 1;
	$dat_hn[$xy] = $dat_hn[$xy] * 1;
	$dat_as[$xy] = $dat_as[$xy] * 1;
	$dat_au[$xy] = $dat_au[$xy] * 1;
	$dat_an[$xy] = $dat_an[$xy] * 1;

	$dat_htp[$xy] = $dat_htp[$xy] * 1;
	$dat_htm[$xy] = $dat_htm[$xy] * 1;
	$dat_atp[$xy] = $dat_atp[$xy] * 1;
	$dat_atm[$xy] = $dat_atm[$xy] * 1;

	$dat_hqu[$xy]  = $dat_hqu[$xy] * 1;
	$dat_aqu[$xy]  = $dat_aqu[$xy] * 1;
	$dat_ghqu[$xy] = $dat_ghqu[$xy] * 1;
	$dat_gaqu[$xy] = $dat_gaqu[$xy] * 1;

	$v = $dat_sp[$xy];
	if ( $v == 0 ) { $v = 1 }
	$e = int( $dat_qu[$xy] / $v );
	$dat_qu[$xy] = int( ( $dat_qu[$xy] / $v ) * 10 ) / 10;
	if ( $e == $dat_qu[$xy] ) { $dat_qu_m[$xy] = ".0" }

	$v = $dat_sp[$xy];
	if ( $v == 0 ) { $v = 1 }
	$e = int( $dat_gqu[$xy] / $v );
	$dat_gqu[$xy] = int( ( $dat_gqu[$xy] / $v ) * 10 ) / 10;
	if ( $e == $dat_gqu[$xy] ) { $dat_gqu_m[$xy] = ".0" }

	$v = $dat_hsp[$xy];
	if ( $v == 0 ) { $v = 1 }
	$e = int( $dat_hqu[$xy] / $v );
	$dat_hqu[$xy] = int( ( $dat_hqu[$xy] / $v ) * 10 ) / 10;
	if ( $e == $dat_hqu[$xy] ) { $dat_hqu_m[$xy] = ".0" }

	$v = $dat_hsp[$xy];
	if ( $v == 0 ) { $v = 1 }
	$e = int( $dat_ghqu[$xy] / $v );
	$dat_ghqu[$xy] = int( ( $dat_ghqu[$xy] / $v ) * 10 ) / 10;
	if ( $e == $dat_ghqu[$xy] ) { $dat_ghqu_m[$xy] = ".0" }

	$v = $dat_asp[$xy];
	if ( $v == 0 ) { $v = 1 }
	$e = int( $dat_aqu[$xy] / $v );
	$dat_aqu[$xy] = int( ( $dat_aqu[$xy] / $v ) * 10 ) / 10;
	if ( $e == $dat_aqu[$xy] ) { $dat_aqu_m[$xy] = ".0" }

	$v = $dat_asp[$xy];
	if ( $v == 0 ) { $v = 1 }
	$e = int( $dat_gaqu[$xy] / $v );
	$dat_gaqu[$xy] = int( ( $dat_gaqu[$xy] / $v ) * 10 ) / 10;
	if ( $e == $dat_gaqu[$xy] ) { $dat_gaqu_m[$xy] = ".0" }

}

if ( ( $methode eq "G" ) or ( $methode eq "HR" ) or ( $methode eq "RR" ) ) {

	for ( $xx = 1 ; $xx < 19 ; $xx++ ) {
		for ( $yx = 1 ; $yx < 19 ; $yx++ ) {

			if ( $dat_gpu[$xx] < $dat_gpu[$yx] ) { $pl1[$xx]++ }

			if ( $dat_gpu[$xx] == $dat_gpu[$yx] ) {

				if ( $dat_td[$xx] < $dat_td[$yx] ) { $pl1[$xx]++ }
				if ( $dat_td[$xx] == $dat_td[$yx] ) {

					if ( $dat_tp[$xx] < $dat_tp[$yx] ) { $pl1[$xx]++ }
					if ( $dat_tp[$xx] == $dat_tp[$yx] ) {

						if ( $xx > $yx )  { $pl1[$xx]++ }
						if ( $xx == $yx ) { $pl1[$xx]++ }
					}
				}
			}
		}

		$tab[ $pl1[$xx] ] = $xx;
	}

	print "<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0>\n";

	print
"<TR bgcolor=white><TD colspan=2></TD><TD class=d> &nbsp;&nbsp; Serie</TD><TD class=d>Sp.</TD><TD colspan=3 class=d> &nbsp; &nbsp; Bilanz</TD><TD></TD><TD class=d>Tore</TD>
<TD></TD><TD class=d>Pu.</TD><TD class=d>Qu.</TD><TD class=d> &nbsp; &nbsp; &nbsp;$status Trainer</TD></TR>";

	$fa = 0;
	for ( $yx = 1 ; $yx < 19 ; $yx++ ) {
		$fa++;
		if ( $fa == 3 ) { $fa    = 1 }
		if ( $fa == 1 ) { $farbe = "#eeeeee" }
		if ( $fa == 2 ) { $farbe = "white" }

		$x       = $yx;
		$kuerzel = "";
		$ok      = 0;
		$ein     = 0;

		my @off = ( "GER I", "FRA I", "SUI I", "ITA I", "SPA I", "ENG I", "POR I", "BEL I", "AND I", "CRO I", "SCO I" );
		my @uefa =
		  ( "SPA I", "GER I", "MAL I", "NIR I", "SLO I", "NOR I", "ISR I", "LUX I", "ALB I", "FRA I", "SLK I" );

		my $cl   = 0;
		my $qcl  = 2;
		my $uefa = 3;
		my $xxx  = 0;
		if ( $liga_art[$liga] == 1 ) {

			for ( $xxx = 1 ; $xxx <= 2 ; $xxx++ ) {
				if ( $off[$xxx] eq $liga_kuerzel[$liga] ) { $cl++; $qcl++; $uefa++ }
				if ( $uef[$xxx] eq $liga_kuerzel[$liga] ) { $cl++; $qcl++; $uefa++ }
			}

			for ( $xxx = 3 ; $xxx <= 8 ; $xxx++ ) {
				if ( $off[$xxx] eq $liga_kuerzel[$liga] ) { $qcl++; $uefa++ }
				if ( $uef[$xxx] eq $liga_kuerzel[$liga] ) { $qcl++; $uefa++ }
			}

			for ( $xxx = 9 ; $xxx <= 11 ; $xxx++ ) {
				if ( $off[$xxx] eq $liga_kuerzel[$liga] ) { $uefa++ }
				if ( $uef[$xxx] eq $liga_kuerzel[$liga] ) { $uefa++ }
			}

			if ( ( $x == $cl ) )   { $ein = 1 }
			if ( ( $x == $qcl ) )  { $ein = 1 }
			if ( ( $x == $uefa ) ) { $ein = 1 }

			if ( ( $x == 15 ) ) { $ein = 1 }

			if ( ( $x == 15 ) ) { $ein = 1 }

			if ( ( $tab[$x] == 1 ) ) { $kuerzel = "[M]" }

			if ( ( $tab[$x] > 15 ) ) { $kuerzel = "[N]" }
		}

		if ( $liga_art[$liga] == 2 ) {
			if ( ( $x == 3 ) )       { $ein     = 1 }
			if ( ( $x == 14 ) )      { $ein     = 1 }
			if ( ( $tab[$x] < 4 ) )  { $kuerzel = "[A]" }
			if ( ( $tab[$x] > 14 ) ) { $kuerzel = "[N]" }
		}

		if ( $liga_art[$liga] == 3 ) {
			if ( ( $x == 2 ) )       { $ein     = 1 }
			if ( ( $x == 14 ) )      { $ein     = 1 }
			if ( ( $tab[$x] < 3 ) )  { $kuerzel = "[A]" }
			if ( ( $tab[$x] > 14 ) ) { $kuerzel = "[N]" }
		}

		if ( $liga_art[$liga] == 4 ) {
			if ( ( $x == 2 ) )       { $ein     = 1 }
			if ( ( $x == 15 ) )      { $ein     = 1 }
			if ( ( $tab[$x] < 3 ) )  { $kuerzel = "[A]" }
			if ( ( $tab[$x] > 15 ) ) { $kuerzel = "[N]" }
		}

		if ( $liga_art[$liga] == 5 ) {
			if ( ( $x == 3 ) )       { $ein     = 1 }
			if ( ( $x == 15 ) )      { $ein     = 1 }
			if ( ( $tab[$x] < 4 ) )  { $kuerzel = "[A]" }
			if ( ( $tab[$x] > 15 ) ) { $kuerzel = "[N]" }
		}

		if ( ( $liga > 201 )                      and ( $kuerzel eq "[N]" ) ) { $kuerzel = "" }
		if ( ( $pokal{ $data[ $tab[$x] ] } == 1 ) and ( $kuerzel eq "" ) )    { $kuerzel = "[P]" }
		if ( ( $pokal{ $data[ $tab[$x] ] } == 1 ) and ( $kuerzel eq "[M]" ) ) { $kuerzel = "[M+P]" }

		if ( ( $pokal{ $data[ $tab[$x] ] } == 1 ) and ( $kuerzel eq "[N]" ) ) { $kuerzel = "[N+P]" }
		if ( ( $pokal{ $data[ $tab[$x] ] } == 1 ) and ( $kuerzel eq "[A]" ) ) { $kuerzel = "[A+P]" }

		#-------------------------KUERZEL + LINES------------------------------------------------

		$ce_1 = "";
		$ce_2 = "";

		$ce_3 = "";
		$ce_4 = "";
		$ce_5 = "";

		if ( $dat_tp[ $tab[$yx] ] < 10 ) { $ce_1 = "0" }
		if ( $dat_tm[ $tab[$yx] ] < 10 ) { $ce_2 = "0" }
		if ( $dat_gs[ $tab[$yx] ] < 10 ) { $ce_3 = "0" }
		if ( $dat_gu[ $tab[$yx] ] < 10 ) { $ce_4 = "0" }
		if ( $dat_gn[ $tab[$yx] ] < 10 ) { $ce_5 = "0" }

		print "<TR BGCOLOR=$farbe>\n";

		print "<TD class=r1>$yx.</TD>\n";
		$color = "black";
		if ( ( $datb[ $tab[$yx] ] eq $leut ) ) { $color = "red" }
		my $tmp = $data[ $tab[$yx] ];
		$tmp =~ s/ /%20/g;
		print
"<TD class=l><a href=/cgi-mod/tmi/verein.pl?saison=$saison&ident=$tmp><img src=/img/h1.jpg heigth=10 width=10 alt=\"Vereinsseite $data[$tab[$yx]]\" border=0></a> &nbsp; <font color=$color>$data[$tab[$yx]]</TD>\n";

		print "<td class=r>";

		for ( $xx = 0 ; $xx < 10 ; $xx++ )

		{
			$t = $xx * 18;
			print "$dat_hi[$tab[$yx]+$t]";
		}
		print "</td>\n";

		print "<TD class=r2>$dat_sp[$tab[$yx]]</TD>\n";
		print "<TD class=r>$ce_3$dat_gs[$tab[$yx]]</TD>\n";
		print "<TD class=r>$ce_4$dat_gu[$tab[$yx]]</TD>\n";
		print "<TD class=r>$ce_5$dat_gn[$tab[$yx]]</TD><td width=8></td>\n";
		print "<TD class=r>$ce_1$dat_tp[$tab[$yx]] : $ce_2$dat_tm[$tab[$yx]]</TD>\n";
		print "<TD class=r>$dat_td[$tab[$yx]]</TD>\n";
		print "<TD class=r2>$dat_gpu[$tab[$yx]]</TD>\n";

		#print "<TD class=c>$dat_qu[$tab[$yx]]$dat_qu_m[$tab[$yx]] - $dat_gqu[$tab[$yx]]$dat_gqu_m[$tab[$yx]]</TD>\n";
		print "<TD class=r>$dat_qu[$tab[$yx]]$dat_qu_m[$tab[$yx]]</TD>\n";

		if ( $datb[ $tab[$yx] ] ne 'Trainerposten frei' ) {
			my $tmp = $datb[ $tab[$yx] ];
			$tmp =~ s/ /%20/g;
			print
"<TD class=l><a href=trainer.pl?ident=$tmp><img src=/img/h1.jpg heigth=10 width=10  alt=\"Trainerprofil $datb[$tab[$yx]]\" border=0></a> &nbsp; $datb[$tab[$yx]]</TD>\n";
		}
		else {
			print "<TD class=l><img src=/img/h1.jpg heigth=10 width=10 border=0> &nbsp; $datb[$tab[$yx]]</TD>\n";
		}

		print "</TR>\n";

		if ( $ein == 1 ) {
			print "<tr>";

			#print "<td colspan=19 bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
			print "<td bgcolor=black colspan=20><div style=\"height:1px; line-height:1px\"></div></td>\n";

			print "</tr>";
		}

	}

	print "</table>\n";

}

if ( $methode eq "H" ) {

	for ( $xx = 1 ; $xx < 19 ; $xx++ ) {
		for ( $yx = 1 ; $yx < 19 ; $yx++ ) {

			if ( $dat_hpu[$xx] < $dat_hpu[$yx] ) { $pl1[$xx]++ }

			if ( $dat_hpu[$xx] == $dat_hpu[$yx] ) {

				if ( $dat_htd[$xx] < $dat_htd[$yx] ) { $pl1[$xx]++ }
				if ( $dat_htd[$xx] == $dat_htd[$yx] ) {

					if ( $dat_htp[$xx] < $dat_htp[$yx] ) { $pl1[$xx]++ }
					if ( $dat_htp[$xx] == $dat_htp[$yx] ) {

						if ( $xx > $yx )  { $pl1[$xx]++ }
						if ( $xx == $yx ) { $pl1[$xx]++ }
					}
				}
			}
		}

		$tab[ $pl1[$xx] ] = $xx;
	}

	print "<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0>\n";
	print
"<TR bgcolor=white><TD colspan=2></TD><TD class=d> &nbsp;&nbsp; Serie</TD><TD class=d>Sp.</TD><TD colspan=3 class=d> &nbsp; &nbsp; Bilanz</TD><TD></TD><TD class=d>Tore</TD>
<TD></TD><TD class=d>Pu.</TD><TD class=d>Qu.</TD><TD class=d> &nbsp; &nbsp; &nbsp;$status Trainer</TD></TR>";

	$fa = 0;
	for ( $yx = 1 ; $yx < 19 ; $yx++ ) {
		$fa++;
		if ( $fa == 3 ) { $fa    = 1 }
		if ( $fa == 1 ) { $farbe = "#eeeeee" }
		if ( $fa == 2 ) { $farbe = "white" }

		$r = 0;
		for ( $x = 0 ; $x < 19 ; $x++ ) {
			$y = $x * 18;
			if (   ( $dat_hi[ $tab[$yx] + $y ] eq "S" )
				or ( $dat_hi[ $tab[$yx] + $y ] eq "U" )
				or ( $dat_hi[ $tab[$yx] + $y ] eq "N" ) )
			{
				$r++;
				$merk[$r] = $tab[$yx] + $y;
			}
		}

		if ( $r == 9 ) { $dat_hi[ $merk[1] ] = "" }
		if ( $r == 10 ) {
			$dat_hi[ $merk[1] ] = "";
			$dat_hi[ $merk[2] ] = "";
		}
		if ( $r == 11 ) {
			$dat_hi[ $merk[1] ] = "";
			$dat_hi[ $merk[2] ] = "";
			$dat_hi[ $merk[3] ] = "";
		}

		$ce_1 = "";
		$ce_2 = "";

		$ce_3 = "";
		$ce_4 = "";
		$ce_5 = "";

		if ( $dat_htp[ $tab[$yx] ] < 10 ) { $ce_1 = "0" }
		if ( $dat_htm[ $tab[$yx] ] < 10 ) { $ce_2 = "0" }
		if ( $dat_hs[ $tab[$yx] ] < 10 )  { $ce_3 = "0" }
		if ( $dat_hu[ $tab[$yx] ] < 10 )  { $ce_4 = "0" }
		if ( $dat_hn[ $tab[$yx] ] < 10 )  { $ce_5 = "0" }

		print "<TR BGCOLOR=$farbe>\n";

		print "<TD class=r1>$yx.</TD>\n";
		$color = "black";
		if ( ( $tab[$yx] == $id ) and ( $liga == $ligi ) ) { $color = "red" }
		my $tmp = $data[ $tab[$yx] ];
		$tmp =~ s/ /%20/g;
		print
"<TD class=l><a href=/cgi-mod/tmi/verein.pl?saison=$saison&ident=$tmp><img src=/img/h1.jpg heigth=10 width=10 alt=\"Vereinsseite $data[$tab[$yx]]\" border=0></a> &nbsp; <font color=$color>$data[$tab[$yx]]</TD>\n";

		print "<td class=r>";

		for ( $xx = 0 ; $xx < 19 ; $xx++ )

		{
			$t = $xx * 18;
			print "$dat_hi[$tab[$yx]+$t]";
		}
		print "</td>\n";

		print "<TD class=r2>$dat_hsp[$tab[$yx]]</TD>\n";
		print "<TD class=r>$ce_3$dat_hs[$tab[$yx]]</TD>\n";
		print "<TD class=r>$ce_4$dat_hu[$tab[$yx]]</TD>\n";
		print "<TD class=r>$ce_5$dat_hn[$tab[$yx]]</TD><td width=8></td>\n";
		print "<TD class=r>$ce_1$dat_htp[$tab[$yx]] : $ce_2$dat_htm[$tab[$yx]]</TD>\n";
		print "<TD class=r>$dat_htd[$tab[$yx]]</TD>\n";
		print "<TD class=r2>$dat_hpu[$tab[$yx]]</TD>\n";
		print "<TD class=r>$dat_hqu[$tab[$yx]]$dat_hqu_m[$tab[$yx]]</TD>\n";

		if ( $datb[ $tab[$yx] ] ne 'Trainerposten frei' ) {
			my $tmp = $datb[ $tab[$yx] ];
			$tmp =~ s/ /%20/g;
			print
"<TD class=l><a href=trainer.pl?ident=$tmp><img src=/img/h1.jpg heigth=10 width=10  alt=\"Trainerprofil $datb[$tab[$yx]]\" border=0></a> &nbsp; $datb[$tab[$yx]]</TD>\n";
		}
		else {
			print "<TD class=l><img src=/img/h1.jpg heigth=10 width=10 border=0> &nbsp; $datb[$tab[$yx]]</TD>\n";
		}

		print "</TR>\n";

		$ein = 0;

		if ( $ein == 1 ) {
			print "<tr>";
			for ( $a = 1 ; $a < 19 ; $a++ ) {
				print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
			}
			print "</tr>";
		}

	}

	print "</table>\n";

}

if ( $methode eq "A" ) {

	for ( $xx = 1 ; $xx < 19 ; $xx++ ) {
		for ( $yx = 1 ; $yx < 19 ; $yx++ ) {

			if ( $dat_apu[$xx] < $dat_apu[$yx] ) { $pl1[$xx]++ }

			if ( $dat_apu[$xx] == $dat_apu[$yx] ) {

				if ( $dat_atd[$xx] < $dat_atd[$yx] ) { $pl1[$xx]++ }
				if ( $dat_atd[$xx] == $dat_atd[$yx] ) {

					if ( $dat_atp[$xx] < $dat_atp[$yx] ) { $pl1[$xx]++ }
					if ( $dat_atp[$xx] == $dat_atp[$yx] ) {

						if ( $xx > $yx )  { $pl1[$xx]++ }
						if ( $xx == $yx ) { $pl1[$xx]++ }
					}
				}
			}
		}

		$tab[ $pl1[$xx] ] = $xx;
	}

	print "<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0>\n";
	print
"<TR bgcolor=white><TD colspan=2></TD><TD class=d> &nbsp;&nbsp; Serie</TD><TD class=d>Sp.</TD><TD colspan=3 class=d> &nbsp; &nbsp; Bilanz</TD><TD></TD><TD class=d>Tore</TD>
<TD></TD><TD class=d>Pu.</TD><TD class=d>Qu.</TD><TD class=d> &nbsp; &nbsp; &nbsp;$status Trainer</TD></TR>";

	$fa = 0;
	for ( $yx = 1 ; $yx < 19 ; $yx++ ) {
		$fa++;
		if ( $fa == 3 ) { $fa    = 1 }
		if ( $fa == 1 ) { $farbe = "#eeeeee" }
		if ( $fa == 2 ) { $farbe = "white" }

		$r = 0;
		for ( $x = 0 ; $x < 19 ; $x++ ) {
			$y = $x * 18;
			if (   ( $dat_hi[ $tab[$yx] + $y ] eq "s" )
				or ( $dat_hi[ $tab[$yx] + $y ] eq "u" )
				or ( $dat_hi[ $tab[$yx] + $y ] eq "n" ) )
			{
				$r++;
				$merk[$r] = $tab[$yx] + $y;
			}
		}

		if ( $r == 9 ) { $dat_hi[ $merk[1] ] = "" }
		if ( $r == 10 ) {
			$dat_hi[ $merk[1] ] = "";
			$dat_hi[ $merk[2] ] = "";
		}
		if ( $r == 11 ) {
			$dat_hi[ $merk[1] ] = "";
			$dat_hi[ $merk[2] ] = "";
			$dat_hi[ $merk[3] ] = "";
		}

		$ce_1 = "";
		$ce_2 = "";

		$ce_3 = "";
		$ce_4 = "";
		$ce_5 = "";

		if ( $dat_atp[ $tab[$yx] ] < 10 ) { $ce_1 = "0" }
		if ( $dat_atm[ $tab[$yx] ] < 10 ) { $ce_2 = "0" }
		if ( $dat_as[ $tab[$yx] ] < 10 )  { $ce_3 = "0" }
		if ( $dat_au[ $tab[$yx] ] < 10 )  { $ce_4 = "0" }
		if ( $dat_an[ $tab[$yx] ] < 10 )  { $ce_5 = "0" }

		print "<TR BGCOLOR=$farbe>\n";

		print "<TD class=r1>$yx.</TD>\n";
		$color = "black";
		if ( ( $tab[$yx] == $id ) and ( $liga == $ligi ) ) { $color = "red" }
		my $tmp = $data[ $tab[$yx] ];
		$tmp =~ s/ /%20/g;
		print
"<TD class=l><a href=/cgi-mod/tmi/verein.pl?saison=$saison&ident=$tmp><img src=/img/h1.jpg heigth=10 width=10 alt=\"Vereinsseite $data[$tab[$yx]]\" border=0></a> &nbsp; <font color=$color>$data[$tab[$yx]]</TD>\n";

		print "<td class=r>";

		for ( $xx = 0 ; $xx < 19 ; $xx++ )

		{
			$t = $xx * 18;
			print "$dat_hi[$tab[$yx]+$t]";
		}
		print "</td>\n";

		print "<TD class=r2>$dat_asp[$tab[$yx]]</TD>\n";
		print "<TD class=r>$ce_3$dat_as[$tab[$yx]]</TD>\n";
		print "<TD class=r>$ce_4$dat_au[$tab[$yx]]</TD>\n";
		print "<TD class=r>$ce_5$dat_an[$tab[$yx]]</TD><td width=8></td>\n";
		print "<TD class=r>$ce_1$dat_atp[$tab[$yx]] : $ce_2$dat_atm[$tab[$yx]]</TD>\n";
		print "<TD class=r>$dat_atd[$tab[$yx]]</TD>\n";
		print "<TD class=r2>$dat_apu[$tab[$yx]]</TD>\n";
		print "<TD class=r>$dat_aqu[$tab[$yx]]$dat_aqu_m[$tab[$yx]]</TD>\n";

		if ( $datb[ $tab[$yx] ] ne 'Trainerposten frei' ) {
			my $tmp = $datb[ $tab[$yx] ];
			$tmp =~ s/ /%20/g;
			print
"<TD class=l><a href=trainer.pl?ident=$tmp><img src=/img/h1.jpg heigth=10 width=10  alt=\"Trainerprofil $datb[$tab[$yx]]\" border=0></a> &nbsp; $datb[$tab[$yx]]</TD>\n";
		}
		else {
			print "<TD class=l><img src=/img/h1.jpg heigth=10 width=10 border=0> &nbsp; $datb[$tab[$yx]]</TD>\n";
		}

		print "</TR>\n";

		$ein = 0;
		$kat = $liga_kat[$liga];

		$line_1[1] = 2;
		$line_1[2] = 1;
		$line_1[3] = 1;
		$line_1[4] = 1;
		$line_1[5] = 1;

		$line_2[1] = 4;
		$line_2[2] = 2;
		$line_2[3] = 3;
		$line_2[4] = 2;
		$line_2[5] = 2;

		$line_3[1] = 6;
		$line_3[2] = 3;
		$line_3[3] = 99;
		$line_3[4] = 3;
		$line_3[5] = 99;

		$line_4[1] = 99;
		$line_4[2] = 4;
		$line_4[3] = 99;
		$line_4[4] = 99;
		$line_4[5] = 99;

		if ( $liga == 43 ) { ( $line_1[5]++ ) and ( $line_2[5]++ ) }
		if ( $liga == 26 ) { ( $line_1[3]++ ) and ( $line_2[3]++ ) and ( $line_4[3] = 4 ) }
		if ( $liga == 21 ) { ( $line_2[2]++ ) and ( $line_3[2]++ ) and ( $line_4[2]++ ) }
		if ( $liga == 34 ) { ( $line_1[4]++ ) and ( $line_2[4]++ ) and ( $line_3[4]++ ) }

		if ( $liga == 7 )  { ( $line_4[1] = 7 ) }
		if ( $liga == 5 )  { ( $line_4[1] = 7 ) }
		if ( $liga == 45 ) { ( $line_3[3] = 4 ) }
		if ( $liga == 56 ) { ( $line_2[5]++ ) }
		if ( $liga == 24 ) { ( $line_3[4]++ ) }
		if ( $liga == 37 ) { ( $line_3[4] = 4 ) }
		if ( $liga == 13 ) { ( $line_4[2]++ ) }
		$x   = $yx;
		$ein = 0;
		if ( $line_1[$kat] == $x ) { $ein = 1 }
		if ( $line_2[$kat] == $x ) { $ein = 1 }
		if ( $line_3[$kat] == $x ) { $ein = 1 }
		if ( $line_4[$kat] == $x ) { $ein = 1 }

		$kata = $liga;
		if (   ( $kata == 2 )
			or ( $kata == 4 )
			or ( $kata == 6 )
			or ( $kata == 8 )
			or ( $kata == 10 )
			or ( $kata == 12 )
			or ( $kata == 14 )
			or ( $kata == 16 )
			or ( $kata == 18 )
			or ( $kata == 20 )
			or ( $kata == 22 ) )
		{
			$ein = 0;
			if ( $x == 3 ) { $ein = 1 }
		}

		if ( $x == 15 ) { $ein = 1 }

		$ein = 0;
		if ( $ein == 1 ) {
			print "<tr>";
			for ( $a = 1 ; $a < 19 ; $a++ ) {
				print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
			}
			print "</tr>";
		}

	}

	print "</table>\n";

}
print $banner_bottom;
print $page_footer;
exit;

