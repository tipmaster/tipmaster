#!/usr/bin/perl

=head1 NAME
	TMI spiel.pl

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

my @uef               = ();
my $live_id           = "";
my $fff               = 0;
my $color1            = "";
my $color2            = "";
my $ausw              = "";
my %ver               = "";
my @cookies           = ();
my $query             = "";
my $liga              = "";
my $ligi              = "";
my $id                = "";
my $live              = "";
my $spielrunde        = "";
my $spielrunde_ersatz = "";
my $spielrunde_live   = "";
my $ein               = "";
my $x                 = "";
my $ro                = "";
my $suche             = "";
my $bv                = "";
my $txt               = "";
my $datei_quoten      = "";
my $lok               = "";
my $fgh               = "";
my $rf                = "";
my $rx                = "";
my $gg                = "";
my @vereine           = ();
my $gp                = "";
my $y                 = "";
my @verein            = ();
my @data              = ();
my @datb              = ();
my @datc              = ();
my @ego               = ();
my $hg                = "";
my $anton             = "";
my $beta              = "";
my $datei_data        = "";
my @quoten_row        = ();
my $va                = "";
my $vab               = "";
my $ex                = "";
my $lo                = "";
my $bx                = "";
my $by                = "";
my $datei_hier        = "";
my @vareine           = ();
my @ega               = ();
my @paarung           = ();
my @qu_1              = ();
my @qu_0              = ();
my @qu_2              = ();
my @ergebnis          = ();
my $rtz               = "";
my $datei_quoten3     = "";
my @tips              = ();
my $la                = "";
my $lb                = "";
my $lc                = "";
my @vx                = ();
my $c                 = "";
my $paar              = "";
my $row1              = "";
my $row2              = "";
my @tip1              = ();
my @tip2              = ();
my @pro1              = ();
my @sp1               = ();
my @liga_art          = ();
my @pro2              = ();
my @sp2               = ();
my $su_1              = "";
my $su_2              = "";
my $end               = "";
my @summe             = ();
my $kk                = "";
my $spieltag          = "";
my @quoten_zahl       = ();
my $tora              = "";
my $torb              = "";
my $wa                = "";
my $wb                = "";
my @dat_sp            = ();
my @dat_hsp           = ();
my @dat_asp           = ();
my @dat_qu            = ();
my @dat_gqu           = ();
my @dat_hqu           = ();
my @dat_ghqu          = ();
my @dat_aqu           = ();
my @dat_gaqu          = ();
my @dat_tp            = ();
my @dat_tm            = ();
my @dat_htp           = ();
my @dat_htm           = ();
my @dat_atp           = ();
my @dat_atm           = ();
my @dat_gs            = ();
my @dat_hs            = ();
my @dat_gpu           = ();
my @dat_gn            = ();
my @dat_an            = ();
my @dat_as            = ();
my @dat_hn            = ();
my @dat_gu            = ();
my @dat_hu            = ();
my @dat_au            = ();
my @pl                = ();
my @tab               = ();
my @dat_td            = ();
my @dat_htd           = ();
my @dat_atd           = ();
my @dat_hpu           = ();
my @dat_apu           = ();
my @plx               = ();
my $nn                = "";
my $ve                = "";
my @liga_namen        = ();
my $gh                = "";
my $sp01              = "";
my $sp02              = "";
my $sp03              = "";
my $fa                = "";
my $rkl               = "";
my $rrr               = "";
my $farbe             = "";
my $xx                = "";
my $start             = "";
my $color             = "";
my $mar               = "";
my $cett              = "";
my $ya                = "";
my $yb                = "";
my $bild              = "";
my @end               = ();
my $ra1               = "";
my $ra2               = "";
my $v                 = "";
my $e                 = "";
my @dat_qu_m          = ();
my @dat_gqu_m         = ();
my @dat_hqu_m         = ();
my @dat_ghqu_m        = ();
my @dat_aqu_m         = ();
my @dat_gaqu_m        = ();
my $kuerzel           = "";
my $ima               = "";
my $rr_liga           = 0;
my $games             = 0;
my @liga_kat          = ();
my $ok                = "";
my $kat               = "";
my @kat1              = ();
my @kat2              = ();
my @kat3              = ();
my @kat4              = ();
my @kat5              = ();
my @line              = ();
my $kata              = "";
my %pokal             = "";
my @liga_kuerzel      = ();
my @max1              = ();
my $torc              = 0;
my $tord              = 0;
my @max               = ();

$rr_liga = 203;

use lib qw{/tmapp/tmsrc/cgi-bin};
use Test;
use CGI qw/:standard/;
use CGI::Cookie;

my $mlib         = new Test;
my $banner_gross = $mlib->banner_gross();
my $banner_bottom = $mlib->banner_bottom();
my $banner_klein = $mlib->banner_klein();
my $page_footer  = $mlib->page_footer();

$query = new CGI;

$liga       = $query->param('li');
$ligi       = $query->param('ligi');
$id         = $query->param('id');
$live       = $query->param('live');
$spielrunde = $query->param('sp');

print "Content-Type: text/html \n\n";

@liga_kat = (
	0, 1, 3, 5, 5, 7, 7, 7, 7, 1, 3, 5, 5, 7, 7, 7, 7, 1, 3, 5, 5, 7, 7, 7, 7, 1, 3, 5, 5, 7, 7, 7, 7, 2,
	4, 6, 6, 8, 8, 2, 4, 6, 6, 8, 8, 2, 4, 6, 6, 8, 8, 2, 4, 6, 6, 8, 8, 2, 4, 6, 6, 8, 8, 2, 4, 6, 6, 8,
	8, 2, 4, 6, 6, 8, 8, 4, 6, 8, 8, 4, 6, 8, 8, 4, 6, 8, 8, 3, 5, 7, 7, 3, 5, 7, 7, 3, 5, 7, 7, 4, 6, 8,
	8, 5, 7, 9, 9, 4, 6, 8, 8, 3, 5, 7, 7, 4, 6, 8, 8, 3, 5, 7, 7, 4, 6, 8, 8, 3, 5, 7, 7, 3, 5, 7, 7, 4,
	6, 8, 8, 4, 6, 8, 8, 3, 5, 7, 7, 3, 5, 7, 7, 4, 6, 8, 8, 3, 5, 7, 7, 5, 7, 9, 9, 4, 6, 8, 8, 5, 7, 9,
	9, 4, 6, 8, 5, 7, 9, 4, 6, 8, 4, 6, 8, 4, 6, 8, 5, 7, 9, 5, 7, 9, 5, 7, 4, 6, 5, 7, 5, 7, 5, 7, 5, 5
);

@liga_art = (
	0, 1, 2, 3, 3, 3, 3, 3, 3, 1, 2, 3, 3, 3, 3, 3, 3, 1, 2, 3, 3, 3, 3, 3, 3, 1, 2, 3, 3, 3, 3, 3, 3, 1,
	2, 4, 4, 2, 2, 1, 2, 4, 4, 2, 2, 1, 2, 4, 4, 2, 2, 1, 2, 4, 4, 2, 2, 1, 2, 4, 4, 2, 2, 1, 2, 4, 4, 2,
	2, 1, 2, 4, 4, 2, 2, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3,
	3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1,
	2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3,
	3, 1, 5, 2, 1, 5, 2, 1, 5, 2, 1, 5, 2, 1, 5, 2, 1, 5, 2, 1, 5, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1
);

@liga_namen = (
	"spacer",
	"Italien Serie A",
	"Italien Serie B",
	"Italien Amateurliga A",
	"Italien Amateurliga B",
	"Italien Amateurklasse A",
	"Italien Amateurklasse B",
	"Italien Amateurklasse C",
	"Italien Amateurklasse D",
	"England Premier League",
	"England 1.Division",
	"England Amateurliga A",
	"England Amateurliga B",
	"England Amateurklasse A",
	"England Amateurklasse B",
	"England Amateurklasse C",
	"England Amateurklasse D",
	"Spanien Primera Division",
	"Spanien Segunda Division",
	"Spanien Amateurliga A",
	"Spanien Amateurliga B",
	"Spanien Amateurklasse A",
	"Spanien Amateurklasse B",
	"Spanien Amateurklasse C",
	"Spanien Amateurklasse D",
	"Frankreich Ligue Une",
	"Frankreich Ligue Deux",
	"Frankreich Amateurliga A",
	"Frankreich Amateurliga B",
	"Frankreich Amateurklasse A",
	"Frankreich Amateurklasse B",
	"Frankreich Amateurklasse C",
	"Frankreich Amateurklasse D",
	"Niederlande Ehrendivision",
	"Niederlande 1.Division",
	"Niederlande Amateurliga A",
	"Niederlande Amateurliga B",
	"Niederlande Amateurklasse A",
	"Niederlande Amateurklasse B",
	"Portugal 1.Divisao",
	"Portugal 2.Divisao",
	"Portugal Amateurliga A",
	"Portugal Amateurliga B",
	"Portugal Amateurklasse A",
	"Portugal Amateurklasse B",
	"Belgien 1.Division",
	"Belgien 2.Division",
	"Belgien Amateurliga A",
	"Belgien Amateurliga B",
	"Belgien Amateurklasse A",
	"Belgien Amateurklasse B",
	"Schweiz Nationalliga A",
	"Schweiz Nationalliga B",
	"Schweiz Amateurliga A",
	"Schweiz Amateurliga B",
	"Schweiz Amateurklasse A",
	"Schweiz Amateurklasse B",
	"Oesterreich Bundesliga",
	"Oesterreich 1.Division",
	"Oesterreich Amateurliga A",
	"Oesterreich Amateurliga B",
	"Oesterreich Amateurklasse A",
	"Oesterreich Amateurklasse B",
	"Schottland 1.Liga",
	"Schottland 2.Liga",
	"Schottland Amateurliga A",
	"Schottland Amateurliga B",
	"Schottland Amateurklasse A",
	"Schottland Amateurklasse B",
	"Tuerkei 1.Liga",
	"Tuerkei 2.Liga",
	"Tuerkei Amateurliga A",
	"Tuerkei Amateurliga B",
	"Tuerkei Amateurklasse A",
	"Tuerkei Amateurklasse B",
	"Irland 1.Liga",
	"Irland 2.Liga",
	"Irland Amateurliga A",
	"Irland Amateurliga B",
	"Nord Irland 1.Liga",
	"Nord Irland 2.Liga",
	"Nord Irland Amateurliga A",
	"Nord Irland Amateurliga B",
	"Wales 1.Liga",
	"Wales 2.Liga",
	"Wales Amateurliga A",
	"Wales Amateurliga B",
	"Daenemark 1.Liga",
	"Daenemark 2.Liga",
	"Daenemark Amateurliga A",
	"Daenemark Amateurliga B",
	"Norwegen 1.Liga",
	"Norwegen 2.Liga",
	"Norwegen Amateurliga A",
	"Norwegen Amateurliga B",
	"Schweden 1.Liga",
	"Schweden 2.Liga",
	"Schweden Amateurliga A",
	"Schweden Amateurliga B",
	"Finnland 1.Liga",
	"Finnland 2.Liga",
	"Finnland Amateurliga A",
	"Finnland Amateurliga B",
	"Island 1.Liga",
	"Island 2.Liga",
	"Island Amateurliga A",
	"Island Amateurliga B",
	"Polen 1.Liga",
	"Polen 2.Liga",
	"Polen Amateurliga A",
	"Polen Amateurliga B",
	"Tschechien 1.Liga",
	"Tschechien 2.Liga",
	"Tschechien Amateurliga A",
	"Tschechien Amateurliga B",
	"Ungarn 1.Liga",
	"Ungarn 2.Liga",
	"Ungarn Amateurliga A",
	"Ungarn Amateurliga B",
	"Rumaenien 1.Liga",
	"Rumaenien 2.Liga",
	"Rumaenien Amateurliga A",
	"Rumaenien Amateurliga B",
	"Slowenien 1.Liga",
	"Slowenien 2.Liga",
	"Slowenien Amateurliga A",
	"Slowenien Amateurliga B",
	"Kroatien 1.Liga",
	"Kroatien 2.Liga",
	"Kroatien Amateurliga A",
	"Kroatien Amateurliga B",
	"Jugoslawien 1.Liga",
	"Jugoslawien 2.Liga",
	"Jugoslawien Amateurliga A",
	"Jugoslawien Amateurliga B",
	"Bosnien-Herz. 1.Liga",
	"Bosnien-Herz. 2.Liga",
	"Bosnien-Herz. Amateurliga A",
	"Bosnien-Herz. Amateurliga B",
	"Bulgarien 1.Liga",
	"Bulgarien 2.Liga",
	"Bulgarien Amateurliga A",
	"Bulgarien Amateurliga B",
	"Griechenland 1.Liga",
	"Griechenland 2.Liga",
	"Griechenland Amateurliga A",
	"Griechenland Amateurliga B",
	"Russland 1.Liga",
	"Russland 2.Liga",
	"Russland Amateurliga A",
	"Russland Amateurliga B",
	"Estland 1.Liga",
	"Estland 2.Liga",
	"Estland Amateurliga A",
	"Estland Amateurliga B",
	"Ukraine 1.Liga",
	"Ukraine 2.Liga",
	"Ukraine Amateurliga A",
	"Ukraine Amateurliga B",
	"Moldawien 1.Liga",
	"Moldawien 2.Liga",
	"Moldawien Amateurliga A",
	"Moldawien Amateurliga B",
	"Israel 1.Liga",
	"Israel 2.Liga",
	"Israel Amateurliga A",
	"Israel Amateurliga B",
	"Luxemburg 1.Liga",
	"Luxemburg 2.Liga",
	"Luxemburg Amateurliga A",
	"Luxemburg Amateurliga B",
	"Slowakei 1.Liga",
	"Slowakei 2.Liga",
	"Slowakei Amateurliga",
	"Mazedonien 1.Liga",
	"Mazedonien 2.Liga",
	"Mazedonien Amateurliga",
	"Litauen 1.Liga",
	"Litauen 2.Liga",
	"Litauen Amateurliga",
	"Lettland 1.Liga",
	"Lettland 2.Liga",
	"Lettland Amateurliga",
	"Weissrussland 1.Liga",
	"Weissrussland 2.Liga",
	"Weissrussland Amateurliga",
	"Malta 1.Liga",
	"Malta 2.Liga",
	"Malta Amateurliga",
	"Zypern 1.Liga",
	"Zypern 2.Liga",
	"Zypern Amateurliga",
	"Albanien 1.Liga",
	"Albanien 2.Liga",
	"Georgien 1.Liga",
	"Georgien 2.Liga",
	"Armenien 1.Liga",
	"Armenien 2.Liga",
	"Aserbaidschan 1.Liga",
	"Aserbaidschan 2.Liga",
	"Andorra 1.Liga",
	"Andorra 2.Liga",
	"Faeroer Inseln 1.Liga",
	"San Marino 1.Liga"
);

my @liga_kuerzel = (
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

open( D7, "/tmdata/tmi/final.txt" );
while (<D7>) {
	( $x, $spielrunde_live ) = split( /&/, $_ );
	$pokal{$spielrunde_live} = 1;
}
close(D7);

open( D7, "/tmdata/tmi/datum.txt" );
$spielrunde_ersatz = <D7>;
$spielrunde_live   = <D7>;
chomp $spielrunde_ersatz;
close(D7);

$ein = 0;
for ( $x = 1 ; $x < 35 ; $x++ ) {
	if ( $x == $spielrunde ) { $ein = 1 }
}
if ( $ein == 0 ) { $spielrunde = $spielrunde_ersatz }

$ro    = "x";
$suche = $ro . $liga;

$bv           = "Qu";
$txt          = ".txt";
$datei_quoten = $bv . $lok . $fgh . $txt;

$fgh = int( $spielrunde + 3 );
$lok = "";
if ( $fgh < 10 ) { $lok = "0" }

$ein = 0;
for ( $x = 1 ; $x <= $rr_liga ; $x++ ) {
	if ( $x == $liga ) { $ein = 1 }
}

$rf = "0";
$rx = "x";
if ( $liga > 9 ) { $rf = "" }

if ( $ein == 0 ) {
	$suche = '&' . $trainer . '&';
}
else {
	$suche = 'x' . $rf . $liga . '&';
}

nis:
$gg = 0;

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
		$liga = $gp;

		$id = $x;
	}
	$y++;
	chomp $verein[$y];
	$datc[$x] = $vereine[$y];
}

if ( $liga == 0 ) {
	$liga  = 1;
	$suche = "x01";
	goto nis;

}
open( DO, "/tmdata/tmi/spieltag.txt" );
while (<DO>) {
	@ego = <DO>;
}
close(DO);

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

if ( $live == 0 ) {
	if ( $spielrunde_ersatz > $spielrunde_live ) {
		if ( ( $spielrunde <= ( $spielrunde_live + 4 ) ) and ( $spielrunde > $spielrunde_live ) ) {

			$va = int( ( $spielrunde + 3 ) / 4 );
			$vab = ( $va * 4 ) - 3;

			for ( $ex = $vab ; $ex <= $spielrunde - 1 ; $ex++ ) {

				$va = int( ( $spielrunde + 3 ) / 4 );
				$vab = ( $va * 4 ) - 3;

				$fgh = int( ( $spielrunde + 3 ) / 4 );
				$lok = "";
				$lo  = $liga;
				if ( $lo < 10 ) { $lok = "0" }

				$bx = "/tmdata/tmi/formular";
				$by = int( ( $spielrunde - 1 ) / 4 );
				$by++;
				$bv         = ".txt";
				$datei_hier = $bx . $by . $bv;

				open( DO, $datei_hier );
				while (<DO>) {
					@vareine = <DO>;
				}
				close(DO);

				$y = 0;
				for ( $x = 0 ; $x < 25 ; $x++ ) {
					$y++;
					chomp $vareine[$y];
					@ega = split( /&/, $vareine[$y] );
					$paarung[$y]  = $ega[1];
					$qu_1[$y]     = $ega[2];
					$qu_0[$y]     = $ega[3];
					$qu_2[$y]     = $ega[4];
					$ergebnis[$y] = $ega[5];
				}

				$bv            = "/tmdata/tmi/tipos/QU";
				$txt           = ".TXT";
				$rtz           = "S";
				$datei_quoten3 = $bv . $lok . $lo . $rtz . $va . $txt;

				@ega = split( /&/, $ego[ $ex - 1 ] );

				@tips = ();

				open( DO, "$datei_quoten3" );
				while (<DO>) {

					@tips = <DO>;
				}
				close(DO);

				$lo = ($ex) / 4;
				$la = int($lo);
				$lb = $lo - $la;

				if ( $lb == 0.25 ) { $lc = 0 }
				if ( $lb == 0.5 )  { $lc = 18 }
				if ( $lb == 0.75 ) { $lc = 36 }
				if ( $lb == 0 )    { $lc = 54 }

				$quoten_row[ $ex - 1 ] = "";
				@vx = ();

				$c = -2;
				for ( $paar = 1 + $lc ; $paar <= ( $lc + 18 ) ; $paar = $paar + 2 ) {
					$c = $c + 2;

					$row1 = $tips[ $paar - 1 ];
					$row2 = $tips[$paar];

					chomp $row1;
					chomp $row2;

					@tip1 = split( /,/, $row1 );
					@tip2 = split( /,/, $row2 );
					$y    = 0;
					for ( $x = 1 ; $x < 11 ; $x = $x + 2 ) {
						$y        = $y + 1;
						$pro1[$y] = $tip1[ $x - 1 ];
						$sp1[$y]  = $tip1[$x];
						$pro2[$y] = $tip2[ $x - 1 ];
						$sp2[$y]  = $tip2[$x];
					}

					$su_1 = 0;
					$su_2 = 0;
					for ( $x = 1 ; $x < 6 ; $x++ ) {
						if ( ( $pro1[$x] == 1 ) and ( $ergebnis[ $sp1[$x] ] == 1 ) ) {
							$su_1 = $su_1 + $qu_1[ $sp1[$x] ];
						}
						if ( ( $pro1[$x] == 2 ) and ( $ergebnis[ $sp1[$x] ] == 2 ) ) {
							$su_1 = $su_1 + $qu_0[ $sp1[$x] ];
						}
						if ( ( $pro1[$x] == 3 ) and ( $ergebnis[ $sp1[$x] ] == 3 ) ) {
							$su_1 = $su_1 + $qu_2[ $sp1[$x] ];
						}
						if ( ( $pro1[$x] == 1 ) and ( $ergebnis[ $sp1[$x] ] == 4 ) ) { $su_1 = $su_1 + 10 }
						if ( ( $pro1[$x] == 2 ) and ( $ergebnis[ $sp1[$x] ] == 4 ) ) { $su_1 = $su_1 + 10 }
						if ( ( $pro1[$x] == 3 ) and ( $ergebnis[ $sp1[$x] ] == 4 ) ) { $su_1 = $su_1 + 10 }

						if ( ( $pro2[$x] == 1 ) and ( $ergebnis[ $sp2[$x] ] == 1 ) ) {
							$su_2 = $su_2 + $qu_1[ $sp2[$x] ];
						}
						if ( ( $pro2[$x] == 2 ) and ( $ergebnis[ $sp2[$x] ] == 2 ) ) {
							$su_2 = $su_2 + $qu_0[ $sp2[$x] ];
						}
						if ( ( $pro2[$x] == 3 ) and ( $ergebnis[ $sp2[$x] ] == 3 ) ) {
							$su_2 = $su_2 + $qu_2[ $sp2[$x] ];
						}
						if ( ( $pro2[$x] == 1 ) and ( $ergebnis[ $sp2[$x] ] == 4 ) ) { $su_2 = $su_2 + 10 }
						if ( ( $pro2[$x] == 2 ) and ( $ergebnis[ $sp2[$x] ] == 4 ) ) { $su_2 = $su_2 + 10 }
						if ( ( $pro2[$x] == 3 ) and ( $ergebnis[ $sp2[$x] ] == 4 ) ) { $su_2 = $su_2 + 10 }

					}

					$summe[$c] = $su_1;
					$summe[ $c + 1 ] = $su_2;

					$vx[ $ega[$c] ] = $su_1;
					$vx[ $ega[ $c + 1 ] ] = $su_2;

				}

				for ( $kk = 1 ; $kk <= 18 ; $kk++ ) {
					$quoten_row[ $ex - 1 ] = $quoten_row[ $ex - 1 ] . $vx[$kk] . '&';
				}

			}

		}
	}
}

for ( $spieltag = 0 ; $spieltag < ( $spielrunde - 1 ) ; $spieltag++ ) {
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

			if ( $tora > $torb ) {
				$dat_gs[ $ega[$x] ]++;
				$dat_hs[ $ega[$x] ]++;
				$dat_gpu[ $ega[$x] ] = $dat_gpu[ $ega[$x] ] + 3;
				$dat_gn[ $ega[$y] ]++;
				$dat_an[ $ega[$y] ]++;
			}

			if ( $tora < $torb ) {
				$dat_gs[ $ega[$y] ]++;
				$dat_as[ $ega[$y] ]++;
				$dat_gpu[ $ega[$y] ] = $dat_gpu[ $ega[$y] ] + 3;
				$dat_gn[ $ega[$x] ]++;
				$dat_hn[ $ega[$x] ]++;
			}

			if ( $tora == $torb ) {
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

@pl  = ();
@tab = ();

for ( $x = 1 ; $x < 19 ; $x++ ) {

	$dat_td[$x]  = $dat_tp[$x] - $dat_tm[$x];
	$dat_htd[$x] = $dat_htp[$x] - $dat_htm[$x];
	$dat_atd[$x] = $dat_atp[$x] - $dat_atm[$x];
	$dat_hpu[$x] = ( $dat_hs[$x] * 3 ) + ( $dat_hu[$x] * 1 );
	$dat_apu[$x] = ( $dat_as[$x] * 3 ) + ( $dat_au[$x] * 1 );

	@plx = ();
	@tab = ();

	for ( $x = 1 ; $x < 19 ; $x++ ) {

		$dat_td[$x]  = $dat_tp[$x] - $dat_tm[$x];
		$dat_htd[$x] = $dat_htp[$x] - $dat_htm[$x];
		$dat_atd[$x] = $dat_atp[$x] - $dat_atm[$x];
		$dat_hpu[$x] = ( $dat_hs[$x] * 3 ) + ( $dat_hu[$x] * 1 );
		$dat_apu[$x] = ( $dat_as[$x] * 3 ) + ( $dat_au[$x] * 1 );

		for ( $x = 1 ; $x < 19 ; $x++ ) {

			$dat_td[$x]  = $dat_tp[$x] - $dat_tm[$x];
			$dat_htd[$x] = $dat_htp[$x] - $dat_htm[$x];
			$dat_atd[$x] = $dat_atp[$x] - $dat_atm[$x];
			$dat_hpu[$x] = ( $dat_hs[$x] * 3 ) + ( $dat_hu[$x] * 1 );
			$dat_apu[$x] = ( $dat_as[$x] * 3 ) + ( $dat_au[$x] * 1 );
			$dat_tp[$x]  = ( $dat_tp[$x] * 1 );
			$dat_tm[$x]  = ( $dat_tm[$x] * 1 );
			$dat_htp[$x] = ( $dat_htp[$x] * 1 );
			$dat_htm[$x] = ( $dat_htm[$x] * 1 );
			$dat_atp[$x] = ( $dat_atp[$x] * 1 );
			$dat_atm[$x] = ( $dat_atm[$x] * 1 );

		}

		for ( $x = 1 ; $x < 19 ; $x++ ) {

			for ( $y = 1 ; $y < 19 ; $y++ ) {

				if ( $dat_gpu[$x] < $dat_gpu[$y] ) { $plx[$x]++ }

				if ( $dat_gpu[$x] == $dat_gpu[$y] ) {

					if ( $dat_td[$x] < $dat_td[$y] ) { $plx[$x]++ }
					if ( $dat_td[$x] == $dat_td[$y] ) {

						if ( $dat_tp[$x] < $dat_tp[$y] ) { $plx[$x]++ }
						if ( $dat_tp[$x] == $dat_tp[$y] ) {

							if ( $x > $y )  { $plx[$x]++ }
							if ( $x == $y ) { $plx[$x]++ }
						}

					}
				}
			}
		}

	}

}

srand();
$nn = int( rand(1500) );
$nn = $nn + $ve + $liga;

print "<html><title>Resultate $liga_namen[$liga] ( Kat $liga_kat[$liga] ) $spielrunde. Spieltag</title>\n";

print "<head>\n";
print "<style type=\"text/css\">";
print "TD.trai { font-family:Verdana; font-size:8pt; color:black; }\n";
print "TD.act { font-family:Verdana; font-size:8pt; color:red; }\n";
print
  "TD.ri { padding-left:5px;padding-right:10px;font-family:Verdana; font-size:8pt; color:black; alignment: right; }\n";
print
  "TD.ce { padding-left:8px;padding-right:8px;font-family:Verdana; font-size:8pt; color:black; font-align: center;}\n";
print
"TD.ce2 { padding-left:28px;padding-right:28px;font-family:Verdana; font-size:8pt; color:black; font-align: center;}\n";
print "TD.bl { font-family:Verdana; font-size:8pt;}\n";
print
  "TD.le { padding-left:5px;padding-right:10px;font-family:Verdana; font-size:8pt; color:black; alignment: left;}\n";
print "TD.ler { font-family:Verdana; font-size:8pt; color:red; alignment: left;}\n";
print "TD.gr { padding-left:10px;padding-right:2px;font-family:Verdana; font-size:12pt; color:red; alignment: left;}\n";
print
  "TD.ri2 { padding-left:10px;padding-right:1px;font-family:Verdana; font-size:8pt; color:black; alignment: right; }\n";

print "</style>\n";
print "<meta name=\"robots\" content=\"noindex\"/>\n";

print "</head>\n";

print "<p align=left><body bgcolor=white text=black vlink=red link=red>\n";

print "$banner_gross";

print "<table border=0 cellspacing=0><tr>\n";
print "<td><a href=/cgi-mod/tmi/login.pl><img src=/img/b01.JPG border=0></a></td>\n";
print "<td><a href=/cgi-mod/tmi/spiel.pl><img src=/img/b03.JPG border=0></a></td>\n";
print "<td><a href=/cgi-mod/tmi/tab.pl><img src=/img/b02.JPG border=0></a></td>\n";
print "<td><a href=/cgi-bin/tmi/boerse.pl><img src=/img/b05.JPG border=0></a></td>\n";
print "<td><a href=http://community.tipmaster.de><img src=/img/b13.jpeg border=0></a></td>\n";
print "<td><a href=/cgi-bin/tmi/mail/mail_inbox.pl><img src=/img/b08.JPG border=0></a></td>\n";
print "<td><a href=http://community.tipmaster.de><img src=/img/b06.JPG border=0></a></td>\n";
print "<td><a href=/tmi/><img src=/img/b07.JPG border=0></a></td>\n";
print "</tr></table>\n";

#require "/tmapp/tmsrc/cgi-bin/tag.pl" ;
#require "/tmapp/tmsrc/cgi-bin/tag_small.pl" ;

print "\n";

#require "/tmapp/tmsrc/cgi-bin/loc_tmi.pl" ;

print "<script language=JavaScript>\n";
print "<!--\n";
print "function targetLink(URL)\n";
print "  {\n";
print "    if(document.images)\n";
print
"      targetWin = open(URL,\"Neufenster\",\"scrollbars=yes,toolbar=no,directories=no,menubar=no,status=no,resizeable=yes,width=850,height=580\");\n";
print " }\n";
print "  //-->\n";
print "  </script>\n";

print "<p align=left>\n";

( my $a1, my $a2 ) = split( / /, $liga_kuerzel[$liga] );
$a1 = lc($a1);
$a1 = "/img/flags/" . $a1 . ".jpg";
print "<font face=verdana size=1><form method=post action=/cgi-mod/tmi/spiel.pl target=_top>";

print
  "&nbsp;&nbsp;<select style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=li>";

for ( $x = 1 ; $x <= $rr_liga ; $x++ ) {
	$gh = "";
	if ( $x == $liga ) { $gh = "selected" }
	print "<option value=$x $gh>$liga_namen[$x] ( Kat $liga_kat[$x] ) \n";
}
print "</select>&nbsp;&nbsp;\n";
print "<select style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=sp>";
for ( $x = 1 ; $x < 35 ; $x++ ) {
	$gh = "";
	if ( $x == $spielrunde ) { $gh = "selected" }
	print "<option value=$x $gh>$x .Spieltag \n";
}
print "</select>&nbsp;&nbsp;\n";
print
"&nbsp;&nbsp;<input type=hidden name=live value=$live><input type=hidden name=ligi value=\"$ligi\"><input type=hidden name=id value=\"$id\"><iNPUT TYPE=SUBMIT   style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" VALUE=\"Resultate laden\"></form>\n";

$sp01 = $spielrunde + 1;
$sp02 = $spielrunde - 1;

if ( $spielrunde == 1 )  { $sp02 = 1 }
if ( $spielrunde == 34 ) { $sp01 = 34 }

$sp03 = $spielrunde;

print
"<form name=vor method=post action=/cgi-mod/tmi/spiel.pl target=_top><input type=hidden name=id value=\"$id\"><input type=hidden name=ligi value=\"$ligi\"><input type=hidden name=sp value=\"$sp01\"><input type=hidden name=li value=\"$liga\"><input type=hidden name=live value=$live></form>\n";
print
"<form name=hinter method=post action=/cgi-mod/tmi/spiel.pl target=_top><input type=hidden name=id value=\"$id\"><input type=hidden name=ligi value=\"$ligi\"><input type=hidden name=sp value=\"$sp02\"><input type=hidden name=li value=\"$liga\"><input type=hidden name=live value=$live></form>\n";
print
"<form name=live method=post action=/cgi-mod/tmi/spiel.pl target=_top><input type=hidden name=id value=\"$id\"><input type=hidden name=ligi value=\"$ligi\"><input type=hidden name=sp value=\"$sp03\"><input type=hidden name=li value=\"$liga\"><input type=hidden name=live value=0></form>\n";
print
"<form name=nolive method=post action=/cgi-mod/tmi/spiel.pl target=_top><input type=hidden name=id value=\"$id\"><input type=hidden name=ligi value=\"$ligi\"><input type=hidden name=sp value=\"$sp03\"><input type=hidden name=li value=\"$liga\"><input type=hidden name=live value=1></form>\n";

if ( $spielrunde_ersatz > $spielrunde_live ) {
	if ( ( $spielrunde <= ( $spielrunde_live + 4 ) ) and ( $spielrunde > $spielrunde_live ) ) {

#print "<script Language=\"JavaScript\">\n";
#print "window.open(\'http://www.live-resultate.net\',\'popup\',\'scrollbars=auto,width=1000,height=600,resizable=yes\');\n";
#print "// -->\n";
#print "</script>\n";
	}
}

print "<font size=1><br>";
print
"</b><font face=verdana size=2>&nbsp;<img src=$a1 border=0>&nbsp; <b>Resultate $liga_namen[$liga] ( Kat $liga_kat[$liga] )</b>&nbsp;&nbsp;/&nbsp;&nbsp;<a href=javascript:document.hinter.submit()><img src=/img/h2.jpg alt=\"$sp02. Spieltag\" border=0></a>&nbsp;&nbsp;$spielrunde. Spieltag&nbsp;&nbsp;<a href=javascript:document.vor.submit()><img src=/img/h1.jpg  alt=\"$sp01. Spieltag\" border=0></a>\n";

if ( $spielrunde_ersatz > $spielrunde_live ) {
	if ( ( $spielrunde <= ( $spielrunde_live + 4 ) ) and ( $spielrunde > $spielrunde_live ) ) {

		if ( $live == 1 ) {
			print
"&nbsp;&nbsp;&nbsp;&nbsp;<b><a href=javascript:document.live.submit()>Livetabelle anzeigen</a></b><font size=1>";
		}
		if ( $live == 0 ) {
			print
"&nbsp;&nbsp;&nbsp;&nbsp;<b><a href=javascript:document.nolive.submit()>Reale Tabelle anzeigen</a></b><font size=1>";
		}

	}
}

if ( $spielrunde_ersatz > $spielrunde_live ) {
	if ( ( $spielrunde <= ( $spielrunde_live + 4 ) ) and ( $spielrunde > $spielrunde_live ) ) {
		print "<br>\n";
		open( D, "</tmdata/tmi_ausw.txt" );
		$ausw = <D>;
		chomp $ausw;
		close(D);
		$ausw = $ausw * 1;
		$ausw *= 1;

		#print "<br><font face=verdana size=1>&nbsp;&nbsp;Verfolgen Sie die realen Zwischenergebnisse
		#der europaieschen Top - Ligen mit unserem
		#<a href=http://www.live-resultate.net target=new1>-> Live - Ergebnisdienst !</a><br>\n";
		print "<br><font face=verdana size=1>&nbsp;
[ <img src=/img/ani.gif> &nbsp;<a href=https://www.fussball-liveticker.eu target=new1>Live Ticker Heute</a> aller realen europaeischen Ligen &nbsp;<img src=/img/ani.gif> ]
&nbsp; &nbsp;
[ Ausgewertete Tipformular Spiele bis jetzt : $ausw von 25 &nbsp;<a href=/cgi-bin/tmi/form.pl target=new>Uebersicht</a> ]";
	}
}

print "<br><p align=left>\n";

print "<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0>";

$fa = 0;

if ( $spielrunde_ersatz > $spielrunde_live ) {
	if ( ( $spielrunde <= ( $spielrunde_live + 4 ) ) and ( $spielrunde > $spielrunde_live ) ) {

		$fgh = int( ( $spielrunde + 3 ) / 4 );
		$lok = "";
		$lo  = $liga;
		if ( $lo < 10 ) { $lok = "0" }

		$bx = "/tmdata/tmi/formular";
		$by = int( ( $spielrunde - 1 ) / 4 );
		$by++;
		$bv         = ".txt";
		$datei_hier = $bx . $by . $bv;

		open( DO, $datei_hier );
		while (<DO>) {
			print <D0>;
			@vareine = <DO>;
		}
		close(DO);

		$y = 0;
		for ( $x = 0 ; $x < 25 ; $x++ ) {
			$y++;
			chomp $vareine[$y];
			@ega = split( /&/, $vareine[$y] );
			$paarung[$y]  = $ega[1];
			$qu_1[$y]     = $ega[2];
			$qu_0[$y]     = $ega[3];
			$qu_2[$y]     = $ega[4];
			$ergebnis[$y] = $ega[5];
		}

		$bv            = "/tmdata/tmi/tipos/QU";
		$txt           = ".TXT";
		$rtz           = "S";
		$datei_quoten3 = $bv . $lok . $lo . $rtz . $fgh . $txt;

		open( DO, "<$datei_quoten3" );
		while (<DO>) {
			print "$_\n";
			@tips = <DO>;
		}
		close(DO);

		$lo = $spielrunde / 4;
		$la = int($lo);
		$lb = $lo - $la;

		if ( $lb == 0.25 ) { $lc = 0 }
		if ( $lb == 0.5 )  { $lc = 18 }
		if ( $lb == 0.75 ) { $lc = 36 }
		if ( $lb == 0 )    { $lc = 54 }

		$c = -2;
		for ( $paar = 1 + $lc ; $paar <= ( $lc + 18 ) ; $paar = $paar + 2 ) {
			$c = $c + 2;

			$row1 = $tips[ $paar - 1 ];
			$row2 = $tips[$paar];

			chomp $row1;
			chomp $row2;

			@tip1 = split( /,/, $row1 );
			@tip2 = split( /,/, $row2 );
			$y    = 0;
			for ( $x = 1 ; $x < 11 ; $x = $x + 2 ) {
				$y        = $y + 1;
				$pro1[$y] = $tip1[ $x - 1 ];
				$sp1[$y]  = $tip1[$x];
				$pro2[$y] = $tip2[ $x - 1 ];
				$sp2[$y]  = $tip2[$x];
			}

			$games   = 0;
			$su_1    = 0;
			$su_2    = 0;
			$end[$c] = 0;
			for ( $x = 1 ; $x < 6 ; $x++ ) {
				if ( ( $pro1[$x] == 1 ) and ( $ergebnis[ $sp1[$x] ] == 1 ) ) { $su_1    = $su_1 + $qu_1[ $sp1[$x] ] }
				if ( ( $pro1[$x] == 2 ) and ( $ergebnis[ $sp1[$x] ] == 2 ) ) { $su_1    = $su_1 + $qu_0[ $sp1[$x] ] }
				if ( ( $pro1[$x] == 3 ) and ( $ergebnis[ $sp1[$x] ] == 3 ) ) { $su_1    = $su_1 + $qu_2[ $sp1[$x] ] }
				if ( ( $pro1[$x] == 1 ) and ( $ergebnis[ $sp1[$x] ] == 4 ) ) { $su_1    = $su_1 + 10 }
				if ( ( $pro1[$x] == 2 ) and ( $ergebnis[ $sp1[$x] ] == 4 ) ) { $su_1    = $su_1 + 10 }
				if ( ( $pro1[$x] == 3 ) and ( $ergebnis[ $sp1[$x] ] == 4 ) ) { $su_1    = $su_1 + 10 }
				if ( ( $pro1[$x] == 1 ) and ( $ergebnis[ $sp1[$x] ] == 0 ) ) { $max[$c] = $max[$c] + $qu_1[ $sp1[$x] ] }
				if ( ( $pro1[$x] == 2 ) and ( $ergebnis[ $sp1[$x] ] == 0 ) ) { $max[$c] = $max[$c] + $qu_0[ $sp1[$x] ] }
				if ( ( $pro1[$x] == 3 ) and ( $ergebnis[ $sp1[$x] ] == 0 ) ) { $max[$c] = $max[$c] + $qu_2[ $sp1[$x] ] }

				if ( $ergebnis[ $sp1[$x] ] > 0 ) { $end[$c]++ }

				if ( ( $pro2[$x] == 1 ) and ( $ergebnis[ $sp2[$x] ] == 1 ) ) { $su_2 = $su_2 + $qu_1[ $sp2[$x] ] }
				if ( ( $pro2[$x] == 2 ) and ( $ergebnis[ $sp2[$x] ] == 2 ) ) { $su_2 = $su_2 + $qu_0[ $sp2[$x] ] }
				if ( ( $pro2[$x] == 3 ) and ( $ergebnis[ $sp2[$x] ] == 3 ) ) { $su_2 = $su_2 + $qu_2[ $sp2[$x] ] }
				if ( ( $pro2[$x] == 1 ) and ( $ergebnis[ $sp2[$x] ] == 4 ) ) { $su_2 = $su_2 + 10 }
				if ( ( $pro2[$x] == 2 ) and ( $ergebnis[ $sp2[$x] ] == 4 ) ) { $su_2 = $su_2 + 10 }
				if ( ( $pro2[$x] == 3 ) and ( $ergebnis[ $sp2[$x] ] == 4 ) ) { $su_2 = $su_2 + 10 }
				if ( ( $pro2[$x] == 1 ) and ( $ergebnis[ $sp2[$x] ] == 0 ) ) {
					$max[ $c + 1 ] = $max[ $c + 1 ] + $qu_1[ $sp2[$x] ];
				}
				if ( ( $pro2[$x] == 2 ) and ( $ergebnis[ $sp2[$x] ] == 0 ) ) {
					$max[ $c + 1 ] = $max[ $c + 1 ] + $qu_0[ $sp2[$x] ];
				}
				if ( ( $pro2[$x] == 3 ) and ( $ergebnis[ $sp2[$x] ] == 0 ) ) {
					$max[ $c + 1 ] = $max[ $c + 1 ] + $qu_2[ $sp2[$x] ];
				}

				if ( $ergebnis[ $sp2[$x] ] > 0 ) { $end[$c]++ }

			}

			$summe[$c]       = $su_1;
			$summe[ $c + 1 ] = $su_2;
			$max[$c]         = $max[$c] + $su_1;
			$max[ $c + 1 ]   = $max[ $c + 1 ] + $su_2;

		}

	}
}

if ( $spielrunde_ersatz > $spielrunde_live ) {
	if ( ( $spielrunde <= ( $spielrunde_live + 4 ) ) and ( $spielrunde > $spielrunde_live ) ) {
		$rkl = 1;
	}
}

for ( $spieltag = ( $spielrunde - 1 ) ; $spieltag < ($spielrunde) ; $spieltag++ ) {
	@ega = split( /&/, $ego[$spieltag] );

	chop $quoten_row[$spieltag];
	@quoten_zahl = split( /&/, $quoten_row[$spieltag] );

	if ( $spielrunde_ersatz > $spielrunde_live ) {
		if ( ( $spielrunde <= ( $spielrunde_live + 4 ) ) and ( $spielrunde > $spielrunde_live ) ) {

			for ( $x = 0 ; $x < 18 ; $x = $x + 1 ) {
				$quoten_zahl[ $ega[$x] - 1 ] = $summe[$x];
				$max1[ $ega[$x] - 1 ]        = $max[$x];
			}

		}
	}

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

			if ( $max1[ $ega[$x] - 1 ] < 15 )  { $torc = 0 }
			if ( $max1[ $ega[$x] - 1 ] > 14 )  { $torc = 1 }
			if ( $max1[ $ega[$x] - 1 ] > 39 )  { $torc = 2 }
			if ( $max1[ $ega[$x] - 1 ] > 59 )  { $torc = 3 }
			if ( $max1[ $ega[$x] - 1 ] > 79 )  { $torc = 4 }
			if ( $max1[ $ega[$x] - 1 ] > 104 ) { $torc = 5 }
			if ( $max1[ $ega[$x] - 1 ] > 129 ) { $torc = 6 }
			if ( $max1[ $ega[$x] - 1 ] > 154 ) { $torc = 7 }

			if ( $max1[ $ega[$y] - 1 ] < 15 )  { $tord = 0 }
			if ( $max1[ $ega[$y] - 1 ] > 14 )  { $tord = 1 }
			if ( $max1[ $ega[$y] - 1 ] > 39 )  { $tord = 2 }
			if ( $max1[ $ega[$y] - 1 ] > 59 )  { $tord = 3 }
			if ( $max1[ $ega[$y] - 1 ] > 79 )  { $tord = 4 }
			if ( $max1[ $ega[$y] - 1 ] > 104 ) { $tord = 5 }
			if ( $max1[ $ega[$y] - 1 ] > 129 ) { $tord = 6 }
			if ( $max1[ $ega[$y] - 1 ] > 154 ) { $tord = 7 }

			$y = $x + 1;

			$rrr = $rkl;
			if ( $live == 0 ) { $rrr = 0 }

			if ( $rrr != 1 ) {

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

				if ( $tora > $torb ) {
					$dat_gs[ $ega[$x] ]++;
					$dat_hs[ $ega[$x] ]++;
					$dat_gpu[ $ega[$x] ] = $dat_gpu[ $ega[$x] ] + 3;
					$dat_gn[ $ega[$y] ]++;
					$dat_an[ $ega[$y] ]++;
				}

				if ( $tora < $torb ) {
					$dat_gs[ $ega[$y] ]++;
					$dat_as[ $ega[$y] ]++;
					$dat_gpu[ $ega[$y] ] = $dat_gpu[ $ega[$y] ] + 3;
					$dat_gn[ $ega[$x] ]++;
					$dat_hn[ $ega[$x] ]++;
				}

				if ( $tora == $torb ) {
					$dat_gu[ $ega[$x] ]++;
					$dat_hu[ $ega[$x] ]++;
					$dat_gpu[ $ega[$x] ] = $dat_gpu[ $ega[$x] ] + 1;
					$dat_gu[ $ega[$y] ]++;
					$dat_au[ $ega[$y] ]++;
					$dat_gpu[ $ega[$y] ] = $dat_gpu[ $ega[$y] ] + 1;
				}

			}

		}
		$fa = $fa + 1;
		if ( $fa == 3 ) { $fa    = 1 }
		if ( $fa == 1 ) { $farbe = "#eeeeee" }
		if ( $fa == 2 ) { $farbe = "white" }

		$xx = $start + 1;

		$color = "black";
		if ( ( $datb[ $ega[$x] ] eq $trainer ) )            { $color = "red" }
		if ( ( $datb[ $ega[$x] ] eq $session->getUser() ) ) { $color = "red" }


		print "<TR BGCOLOR=$farbe>\n";
		my $spacer = " &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ";
		if ( $x != 0 ) { $spacer = "" }

		print
"<TD class=le><font color=$color><a href=verein.pl?ve=$ega[$x]&li=$liga><img src=/img/h1.jpg  alt=\"Vereinsseite $data[$ega[$x]]\" border=0></a> &nbsp; $data[$ega[$x]]</td>\n";

		#print  "<TD class=le><font color=$color>$data[$ega[$x]]</td>\n";

		$mar = "";
		if ( $plx[ $ega[$x] ] < 10 ) { $mar = 0 }
		print "<td class=ce>( $mar$plx[$ega[$x]].) &nbsp; - &nbsp;</TD>\n";

		$color = "black";
		if ( ( $datb[ $ega[$y] ] eq $trainer ) )            { $color = "red" }
		if ( ( $datb[ $ega[$y] ] eq $session->getUser() ) ) { $color = "red" }

		print
"<TD class=le><font color=$color><a href=verein.pl?ve=$ega[$y]&li=$liga><img src=/img/h1.jpg alt=\"Vereinsseite $data[$ega[$y]]\" border=0></a> &nbsp; $data[$ega[$y]] </td></form>\n";

		#print  "<TD class=le><font color=$color>  &nbsp; $data[$ega[$y]] </td></form>\n";

		$mar = "";
		if ( $plx[ $ega[$y] ] < 10 ) { $mar = 0 }
		print "<td class=ce>( $mar$plx[$ega[$y]].)</TD>\n";

		$cett = "black";

		if ( $spielrunde_ersatz > $spielrunde_live ) {
			if ( ( $spielrunde <= ( $spielrunde_live + 4 ) ) and ( $spielrunde > $spielrunde_live ) ) {
				$cett = "red";
				$fff  = 1;
				if ( $end[$x] == 9 ) { $cett = "black" }

			}
		}

		if ( $quoten_zahl[ $ega[$x] - 1 ] != "1" ) {

			$color1 = "red";
			$color2 = "red";
			if ( $tora == $torc ) { $color1 = "black" }
			if ( $torb == $tord ) { $color2 = "black" }
			if ( $fff != 1 ) {
				$color1 = "black";
				$color2 = "black";
			}

			print
"<TD class=ce2><font color=$cett><font color=$color1>$tora <font color=black>:<FONT color=$color2> $torb </TD>\n";

		}

		if ( $quoten_zahl[ $ega[$x] - 1 ] == "1" ) {
			print "<TD class=ce> - : - </TD>\n";
		}

		if ( $quoten_zahl[ $ega[$x] - 1 ] != "1" ) {
			$ya = "0";
			$yb = "0";
			if ( $quoten_zahl[ $ega[$x] - 1 ] != 0 ) { $ya = "" }
			if ( $quoten_zahl[ $ega[$y] - 1 ] != 0 ) { $yb = "" }

			print "<TD class=ce>[ $ya$quoten_zahl[$ega[$x]-1]  - $yb$quoten_zahl[$ega[$y]-1] ]</TD>\n";
		}

		if ( $quoten_zahl[ $ega[$x] - 1 ] == "1" ) {
			print "<TD class=ce>[ &nbsp;  - &nbsp; ]</TD>\n";
		}

		print "<td align=center width=10></td>\n";

		$lo = $spielrunde / 4;
		$la = int($lo);
		$lb = $lo - $la;

		if ( $lb == 0.25 ) { $lc = 0 }
		if ( $lb == 0.5 )  { $lc = 18 }
		if ( $lb == 0.75 ) { $lc = 36 }
		if ( $lb == 0 )    { $lc = 54 }

		$lc = $lc + $x + 1;

		$bild = "ti";
		if ( $spielrunde_ersatz > $spielrunde_live ) {
			if ( ( $spielrunde <= ( $spielrunde_live + 4 ) ) and ( $spielrunde > $spielrunde_live ) ) {
				$bild = "live";
				if ( $end[$x] == 9 ) { $bild = "ti" }

			}

		}

		$ra1 = $data[ $ega[$x] ];
		$ra2 = $data[ $ega[$y] ];

		$ra1 =~ s/ /%20/g;
		$ra2 =~ s/ /%20/g;

		print
"<TD ALIGN=RIGHT colspan=30> <a href=/cgi-mod/tmi/tips.pl?li=$liga&sp=$spielrunde&ve=$lc&ve1=$ra1&ve2=$ra2 target\"_blank\" onClick=\"targetLink('/cgi-mod/tmi/tips.pl?li=$liga&sp=$spielrunde&ve=$lc&ve1=$ra1&ve2=$ra2');return false\"><IMG SRC=/img/$bild.jpg BORDER=0 alt=\"Detail - Tipansicht | Maximales Ergebnis $torc : $tord [ $max1[$ega[$x]-1] - $max1[$ega[$y]-1] ] \"
title=\"Detail - Tipansicht | Maximales Ergebnis $torc : $tord [ $max1[$ega[$x]-1] - $max1[$ega[$y]-1] ] \"></A>&nbsp;&nbsp;</TD>\n";

		print "</TR>\n";

	}
}

@pl  = ();
@tab = ();

for ( $x = 1 ; $x < 19 ; $x++ ) {

	$dat_td[$x]  = $dat_tp[$x] - $dat_tm[$x];
	$dat_htd[$x] = $dat_htp[$x] - $dat_htm[$x];
	$dat_atd[$x] = $dat_atp[$x] - $dat_atm[$x];
	$dat_hpu[$x] = ( $dat_hs[$x] * 3 ) + ( $dat_hu[$x] * 1 );
	$dat_apu[$x] = ( $dat_as[$x] * 3 ) + ( $dat_au[$x] * 1 );

	@pl  = ();
	@tab = ();

	for ( $x = 1 ; $x < 19 ; $x++ ) {

		$dat_td[$x]  = $dat_tp[$x] - $dat_tm[$x];
		$dat_htd[$x] = $dat_htp[$x] - $dat_htm[$x];
		$dat_atd[$x] = $dat_atp[$x] - $dat_atm[$x];
		$dat_hpu[$x] = ( $dat_hs[$x] * 3 ) + ( $dat_hu[$x] * 1 );
		$dat_apu[$x] = ( $dat_as[$x] * 3 ) + ( $dat_au[$x] * 1 );

		for ( $x = 1 ; $x < 19 ; $x++ ) {

			$dat_td[$x]  = $dat_tp[$x] - $dat_tm[$x];
			$dat_htd[$x] = $dat_htp[$x] - $dat_htm[$x];
			$dat_atd[$x] = $dat_atp[$x] - $dat_atm[$x];
			$dat_hpu[$x] = ( $dat_hs[$x] * 3 ) + ( $dat_hu[$x] * 1 );
			$dat_apu[$x] = ( $dat_as[$x] * 3 ) + ( $dat_au[$x] * 1 );

			$v = $dat_sp[$x];
			if ( $v == 0 ) { $v = 1 }
			$e = int( $dat_qu[$x] / $v );
			$dat_qu[$x] = int( ( $dat_qu[$x] / $v ) * 10 ) / 10;
			if ( $e == $dat_qu[$x] ) { $dat_qu_m[$x] = ".0" }

			$e = int( $dat_gqu[$x] / $v );
			$dat_gqu[$x] = int( ( $dat_gqu[$x] / $v ) * 10 ) / 10;
			if ( $e == $dat_gqu[$x] ) { $dat_gqu_m[$x] = ".0" }

			$v = $dat_hsp[$x];
			if ( $v == 0 ) { $v = 1 }
			$e = int( $dat_hqu[$x] / $v );
			$dat_hqu[$x] = int( ( $dat_hqu[$x] / $v ) * 10 ) / 10;
			if ( $e == $dat_hqu[$x] ) { $dat_hqu_m[$x] = ".0" }

			$e = int( $dat_ghqu[$x] / $v );
			$dat_ghqu[$x] = int( ( $dat_ghqu[$x] / $v ) * 10 ) / 10;
			if ( $e == $dat_ghqu[$x] ) { $dat_ghqu_m[$x] = ".0" }

			$v = $dat_asp[$x];
			if ( $v == 0 ) { $v = 1 }
			$e = int( $dat_aqu[$x] / $v );
			$dat_aqu[$x] = int( ( $dat_aqu[$x] / $v ) * 10 ) / 10;
			if ( $e == $dat_aqu[$x] ) { $dat_aqu_m[$x] = ".0" }

			$e = int( $dat_gaqu[$x] / $v );
			$dat_gaqu[$x] = int( ( $dat_gaqu[$x] / $v ) * 10 ) / 10;
			if ( $e == $dat_gaqu[$x] ) { $dat_gaqu_m[$x] = ".0" }

		}

		for ( $x = 1 ; $x < 19 ; $x++ ) {

			for ( $y = 1 ; $y < 19 ; $y++ ) {

				if ( $dat_gpu[$x] < $dat_gpu[$y] ) { $pl[$x]++ }

				if ( $dat_gpu[$x] == $dat_gpu[$y] ) {

					if ( $dat_td[$x] < $dat_td[$y] ) { $pl[$x]++ }
					if ( $dat_td[$x] == $dat_td[$y] ) {

						if ( $dat_tp[$x] < $dat_tp[$y] ) { $pl[$x]++ }
						if ( $dat_tp[$x] == $dat_tp[$y] ) {

							if ( $x > $y )  { $pl[$x]++ }
							if ( $x == $y ) { $pl[$x]++ }
						}

					}
				}
			}
			$tab[ $pl[$x] ] = $x;

		}
	}

}

print "</table><font size=1><br>\n";
print "<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0>\n";

$fa = 0;

for ( $x = 1 ; $x < 19 ; $x++ ) {
	$fa = $fa + 1;
	if ( $fa == 3 ) { $fa    = 1 }
	if ( $fa == 1 ) { $farbe = "#eeeeee" }
	if ( $fa == 2 ) { $farbe = "white" }

	$color = "black";
	if ( ( $id == $tab[$x] ) and ( $ligi == $liga ) ) { $color = "red" }

	#-------------------------KUERZEL + LINES------------------------------------------------
	$kuerzel = "";
	$ok      = 0;
	$ein     = 0;

	#chnge for 7/01
	#we should automatically read the contents of /mt/cl/bonusplaces.cfg and translate into leagues.

	my @off = ( "", "FRA I", "BEL I", "ITA I", "POR I", "SPA I", "SUI I", "SWE I", "ENG I", "TUR I", "SCO I", "LUX I" );
	my @uefa =
	  ( "", "AND I", "SPA I", "GER I", "MAZ I", "FRA I", "MAL I", "POR I", "CRO I", "ITA I", "BIL I", "ALB I" );

	my $cl   = 0;
	my $qcl  = 2;
	my $uefa = 3;
	my $xxx  = 0;
	if ( $liga_art[$liga] == 1 ) {

		for ( $xxx = 1 ; $xxx <= 2 ; $xxx++ ) {
			if ( $off[$xxx] eq $liga_kuerzel[$liga] )  { $cl++; $qcl++; $uefa++ }
			if ( $uefa[$xxx] eq $liga_kuerzel[$liga] ) { $cl++; $qcl++; $uefa++ }
		}

		for ( $xxx = 3 ; $xxx <= 8 ; $xxx++ ) {
			if ( $off[$xxx] eq $liga_kuerzel[$liga] )  { $qcl++; $uefa++ }
			if ( $uefa[$xxx] eq $liga_kuerzel[$liga] ) { $qcl++; $uefa++ }
		}

		for ( $xxx = 9 ; $xxx <= 11 ; $xxx++ ) {
			if ( $off[$xxx] eq $liga_kuerzel[$liga] )  { $uefa++ }
			if ( $uefa[$xxx] eq $liga_kuerzel[$liga] ) { $uefa++ }
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

	# EUROCUP LINES

	#if ( $ok == 0 ) {
	#$kat = $liga_kat[$liga] ;
	#@kat1=(0,2,4,6);
	#@kat2=(0,1,2,3,4);
	#@kat3=(0,1,3);
	#@kat4=(0,1,2,3);
	#@kat5=(0,1,2);
	#if ( $kat == 1 ) { @line = @kat1}
	#if ( $kat == 2 ) { @line = @kat2}
	#if ( $kat == 3 ) { @line = @kat3}
	#if ( $kat == 4 ) { @line = @kat4}
	#if ( $kat == 5 ) { @line = @kat5}
	#if ($line[1] == $x) { $ein = 1 }
	#if ($line[2] == $x) { $ein = 1 }
	#if ($line[3] == $x) { $ein = 1 }
	#if ($line[4] == $x) { $ein = 1 }
	#}

	#-------------------------KUERZEL + LINES------------------------------------------------

	print "<TR BGCOLOR=$farbe>\n";
	print "<TD class=ri2>$x.</TD>\n";
	print "<TD class=ri2>( $plx[$tab[$x]].)</TD>\n";

	if ( $x == $plx[ $tab[$x] ] ) { $ima = "/img/pfeil=.gif" }
	if ( $x < $plx[ $tab[$x] ] )  { $ima = "/img/pfeil++.gif" }
	if ( $x > $plx[ $tab[$x] ] )  { $ima = "/img/pfeil--.gif" }
	if ( $x < ( $plx[ $tab[$x] ] - 2 ) ) { $ima = "/img/pfeil+.gif" }
	if ( $x > ( $plx[ $tab[$x] ] + 2 ) ) { $ima = "/img/pfeil-.gif" }

	print "<TD class=gr><img src=$ima>&nbsp;</TD>\n";
	print
"<TD class=le><a href=verein.pl?ve=$tab[$x]&li=$liga><img src=/img/h1.jpg alt=\"Vereinsseite $data[$tab[$x]]\" border=0></a> &nbsp; <FONT color=$color>$data[$tab[$x]]</TD>\n";
	print "<TD class=ri>$kuerzel</TD>\n";
	print "<TD class=ce> $dat_sp[$tab[$x]]</TD>\n";

	$dat_gs[ $tab[$x] ]  = $dat_gs[ $tab[$x] ] * 1;
	$dat_gu[ $tab[$x] ]  = $dat_gu[ $tab[$x] ] * 1;
	$dat_gn[ $tab[$x] ]  = $dat_gn[ $tab[$x] ] * 1;
	$dat_gpu[ $tab[$x] ] = $dat_gpu[ $tab[$x] ] * 1;

	print "<TD class=ri>$dat_gs[$tab[$x]]</TD>\n";
	print "<TD class=ri>$dat_gu[$tab[$x]]</TD>\n";
	print "<TD class=ri>$dat_gn[$tab[$x]]</TD>\n";
	print "<TD class=ce>$dat_tp[$tab[$x]] : $dat_tm[$tab[$x]]</TD>\n";
	print "<TD class=ri>$dat_td[$tab[$x]]</TD>\n";
	print "<TD class=ce>$dat_gpu[$tab[$x]]</TD>\n";
	print "<TD class=ce>$dat_qu[$tab[$x]]$dat_qu_m[$tab[$x]]</TD>\n";

	if ( $datb[ $tab[$x] ] ne 'Trainerposten frei' ) {
		print
"<TD class=le> &nbsp; <a href=trainer.pl?ve=$tab[$x]&li=$liga><img src=/img/h1.jpg alt=\"Trainerprofil $datb[$tab[$x]]\" border=0></a> &nbsp; $datb[$tab[$x]]</TD>\n";
	}
	else {
		print
"<TD class=le> &nbsp; <img src=/img/h1.jpg alt=\"Trainerposten nicht besetzt\" border=0> &nbsp; $datb[$tab[$x]]</TD>\n";

	}

	print "</TR>\n";

	$kata = $liga;

#if ( ( $tab[$x] ==1 )) { $kuerzel = " [M]" }
#if (( ($liga==2) or ($liga==4) or ($liga==6) or ($liga==8) or ($liga==10) or ($liga==12) or ($liga==14) or ($liga==16) or ($liga==18) or ($liga==20) or ($liga==22)  ) and $tab[$x]<4) { $kuerzel = " [A]" }
#if (( ($liga==1) or ($liga==3) or ($liga==5) or ($liga==7) or ($liga==9) or ($liga==11 )or ($liga==13)or ($liga==15)or ($liga==17) or ($liga==19) or ($liga==21)   ) and $tab[$x]>15) { $kuerzel = " [N]" }

	if ( $ein == 1 ) {
		print "<tr>\n";

		#print "<td bgcolor=black colspan=14><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
		print "<td bgcolor=black colspan=14><div style=\"height:1px; line-height:1px\"></div></td>\n";

		print "</TR>\n";
	}

}

print "</table>\n";
print "</tr></table></html>\n";
print $page_footer;
print $banner_bottom;
exit;
