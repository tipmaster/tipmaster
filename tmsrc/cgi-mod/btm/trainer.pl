#!/usr/bin/perl

=head1 NAME
	BTM trainer.pl

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
my $session = TMSession::getSession( btm_login => 1 );
my $trainer = $session->getUser();
my $leut    = $trainer;

use CGI;
print "Content-Type: text/html \n\n";
use lib qw{/tmapp/tmsrc/cgi-bin};
use Test;
use CGI qw/:standard/;
use CGI::Cookie;

my @cookies        = ();
my $mlib           = new Test;
my $banner_gross   = $mlib->banner_gross();
my $banner_klein   = $mlib->banner_klein();
my $location       = $mlib->location();
my @liga_namen     = $mlib->btm_liga_namen();
my @tmi_liga_namen = $mlib->tmi_liga_namen();
my @main_saison    = $mlib->btm_saison_namen();
my @main_kuerzel   = $mlib->btm_saison_kuerzel();

my $main_nr = $main_saison[0];

my $xa = "";
my $i  = 0;
my $x  = "";
my $query;
my $liga;
my $verein;
my $ident;
my $kid1;
my $kid2;
my $lo;
my $li;
my @vereine;
my $y;
my @verein;
my @verein;
my @datb;
my $li;
my $li;
my $ro;
my $suche;
my $rf;
my $rx;
my @verein;
my @verein;
my @data;
my @verein;
my @verein;
my $coach;
my $verein_coach;
my @verein;
my @verein;
my @datc;
my $aa;
my $ae;
my $r;
my $db;
my $host;
my $user;
my $dbh;
my $aktiv;
my $foto;
my $foto1;
my $foto2;
my $foto3;
my $foto4;
my $foto5;
my $foto6;
my $bild;
my $bild_path;
my $datei;
my $leer;
my $wohnort;
my $land;
my $geburtstag;
my $bundesland;
my $beruf;
my $liebling;
my $hobby;
my $motto;
my $zeile;
my $richtig;
my $mail_adresse;
my $sp1;
my $sp2;
my $sp3;
my $sp4;
my $sp5;
my $sp6;
my $qu1;
my $qu2;
my $qu3;
my $qu4;
my $qu5;
my $qu6;
my $t;
my $nummer;
my $ve;
my @li1;
my @li2;
my @li3;
my @li4;
my @li5;
my @li6;
my @li7;
my @li8;
my @li9;
my @li10;
my @team;
my $station;
my @comp;
my $egal;
my $saison;
my @spiel;
my @station_verein;
my @station_start;
my @station_ende;
my @station_saison;
my $tora;
my $torb;
my $grenze_a;
my $grenze_b;
my @st_s;
my @st_u;
my @st_n;
my $sp_s_g;
my $sp_u_g;
my $sp_n_g;
my @st_p;
my @st_tp;
my @st_tm;
my @st_uu;
my $sp_tp_g;
my $sp_tm_g;
my @st_qp;
my @st_qm;
my $sp_qp_g;
my $sp_qm_g;
my $sp_uu_g;
my @st_sp;
my $sp_g;
my $tip_g;
my $sp_h;
my $sp_s_h;
my $sp_u_h;
my $sp_n_h;
my $sp_tp_h;
my $sp_tm_h;
my $sp_qp_h;
my $sp_qm_h;
my $sp_uu_h;
my $tip_h;
my $sp_a;
my $sp_s_a;
my $sp_u_a;
my $sp_n_a;
my $sp_tp_a;
my $sp_tm_a;
my $sp_qp_a;
my $sp_qm_a;
my $sp_uu_a;
my $tip_a;
my @sai;
my @name_sai;
my @gop;
my $award;
my @a_line;
my @seson;
my $statusi;
my $status;
my $pu;
my $sp_qpd_g;
my $sp_qmd_g;
my $xm;
my $xn;
my $ka;
my $kb;
my $oo;
my $op;
my $xx;
my $yy;
my $sp_qpd_h;
my $sp_qmd_h;
my $sp_qpd_a;
my $sp_qmd_a;
my $line;
my @ok;
my @linedb;
my @lineup;
my $ff;
my @all;
my @db;
my @db;
my $ss;
my @db;
my @db;
my @s;
my $pl;
my $ima;
my @db;
my @db;
my @db;
my @db;
my @db;
my @db;
my @sat;
my @no;
my $liga_akt;
my $xb;
my $xd;
my $xe;
my $xf;
my $xg;
my $xh;
my $xc;
my $xj;
my @st_qpd;
my @st_qmd;
my $xy;
my $ident = "unknown";
my $ein_trainer;
my $ein_pass;
my $mail;
my $ac;

#use DBI;
use CGI;
$query  = new CGI;
$liga   = $query->param('li');
$verein = $query->param('ve');
$ident  = $query->param('ident');

$kid1 = $verein;
$kid2 = $liga;

if ( $ident ne 'unknown' ) {

	$lo = 0;

	open( D2, "/tmdata/btm/history.txt" );
	while (<D2>) {
		$lo++;
		if ( $_ =~ /&$ident&/ ) {
			$li = $lo;
			@vereine = split( /&/, $_ );
		}

	}
	close(D2);

	$y = 0;
	for ( $x = 1 ; $x < 19 ; $x++ ) {
		$y++;

		$y++;
		chomp $verein[$y];
		$datb[$x] = $vereine[$y];

		if ( $datb[$x] eq $ident ) {
			$kid1 = $x;
			$kid2 = $li;
		}

		$y++;

	}
}

if ( $kid1 == 0 ) {

	print
"<font face=verdana size=2><b>Der Trainer des angeforderten Trainerprofils ist<br>leider nicht mehr beim TipMaster aktiv !";
	exit;
}

$ro    = "x";
$suche = $ro . $kid2 . '&';

$rf = "0";
$rx = "x";
if ( $kid2 > 9 ) { $rf = "" }

$suche = $rx . $rf . $kid2 . '&';

open( D2, "/tmdata/btm/history.txt" );
while (<D2>) {

	if ( $_ =~ /$suche/ ) {
		@vereine = split( /&/, $_ );
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

	if ( $x == $kid1 ) {
		$coach        = $datb[$x];
		$verein_coach = $data[$x];
	}

	$y++;
	chomp $verein[$y];
	$datc[$x] = $vereine[$y];
}

$aa    = "&";
$ae    = "!";
$suche = $ae . $aa . $coach . $aa;
$r     = 0;

$suche = '&' . $coach . '&';
my $tmi_verein = "no";
my $tmi_liga   = 0;
$li = 0;
open( D2, "/tmdata/tmi/history.txt" );
while (<D2>) {
	$li++;
	if ( $_ =~ /$suche/ ) {
		@vereine = split( /&/, $_ );
		$tmi_liga = $li;
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

	if ( $datb[$x] eq $coach ) {
		$tmi_verein = $data[$x];

	}

	$y++;
	chomp $verein[$y];
	$datc[$x] = $vereine[$y];
}

$foto = $coach;
$foto =~ s/ /_/g;
$foto1 = "/home/tm/www/fotos/" . $foto . ".gif";
$foto2 = "/home/tm/www/fotos/" . $foto . ".jpg";
$foto3 = "/home/tm/www/fotos/" . $foto . ".GIF";
$foto4 = "/home/tm/www/fotos/" . $foto . ".JPG";
$foto5 = "/home/tm/www/fotos/" . $foto . ".jpeg";
$foto6 = "/home/tm/www/fotos/" . $foto . ".JPEG";

$bild = "";
if ( -e $foto1 ) { $bild = $foto1 }
if ( -e $foto2 ) { $bild = $foto2 }
if ( -e $foto3 ) { $bild = $foto3 }
if ( -e $foto4 ) { $bild = $foto4 }
if ( -e $foto5 ) { $bild = $foto5 }
if ( -e $foto6 ) { $bild = $foto6 }
$bild_path = $bild;
$bild =~ s/\/www/http:\/\/www.tipmaster.de/;

if ( $bild eq "" ) { $bild = "/fotos/nofoto.gif" }

$datei = "/tmdata/btm/db/profile/" . $coach . ".txt";

open( D2, "$datei" );
while (<D2>) {
	$r++;

	( $leer, $coach, $wohnort, $land, $geburtstag, $bundesland, $beruf, $liebling, $hobby, $motto ) = split( /&/, $_ );
	$zeile = $r;

}
close(D2);

$sp1 = "----";
$sp2 = "----";
$sp3 = "----";
$sp4 = "----";
$sp5 = "----";
$sp6 = "----";

$suche = $coach . $aa;
$r     = 0;
open( D2, "/tmdata/btm/allquotes.txt" );
while (<D2>) {
	$r++;
	if ( $_ =~ /$suche/i ) {

		( $coach, $sp1, $qu1, $sp2, $qu2, $sp3, $qu3, $sp4, $qu4, $sp5, $qu5, $sp6, $qu6 ) = split( /&/, $_ );

	}
}
close(D2);

if ( $qu1 < 17 ) { $sp1 = "----" }
if ( $qu2 < 17 ) { $sp2 = "----" }
if ( $qu3 < 17 ) { $sp3 = "----" }
if ( $qu4 < 17 ) { $sp4 = "----" }
if ( $qu5 < 17 ) { $sp5 = "----" }
if ( $qu6 < 17 ) { $sp6 = "----" }

open( DO, "</tmdata/btm/db/vereine.txt" );
while (<DO>) {
	$t++;
	( $nummer, $ve ) = split( /&/, $_ );
	(
		$nummer,       $ve,           $li1[$nummer], $li2[$nummer], $li3[$nummer], $li4[$nummer],
		$li5[$nummer], $li6[$nummer], $li7[$nummer], $li8[$nummer], $li9[$nummer], $li10[$nummer]
	) = split( /&/, $_ );
	chomp $li9[$nummer];
	chomp $ve;
	$team[$nummer] = $ve;
}
close(DO);

$station = 0;

$ro    = $$ % 10;
$datei = "/tmdata/btm/db/trainer/temp_" . $ro . '.txt';

$datei = "/tmdata/btm/db/trainer/" . $coach . '.txt';

open( DO, "<$datei" );
while (<DO>) {
	$t++;

	#print "$_\n";
	@comp = split( /&/, $_ );
	( $egal, $saison ) = split( /#/, $comp[0] );

	for ( $y = 1 ; $y <= 34 ; $y++ ) {
		@spiel = split( /#/, $comp[$y] );
		$ve = $spiel[0];

		if ( ( $y == 1 ) ) {
			$station++;
			$station_verein[$station] = $ve;
			$station_start[$station]  = $y;
			if ( $station_ende[ $station - 1 ] eq "" ) { $station_ende[ $station - 1 ] = 34 }
			$station_saison[$station] = $saison;

		}

		if ( ( $station == 0 ) and ( $ve ne "-" ) ) {
			$station                  = 1;
			$station_verein[$station] = $ve;
			$station_start[$station]  = $y;
			$station_saison[$station] = $saison;
		}

		if ( $ve != $station_verein[$station] ) {
			$station++;
			$station_verein[$station]     = $ve;
			$station_start[$station]      = $y;
			$station_ende[ $station - 1 ] = $y - 1;
			$station_saison[$station]     = $saison;
		}

		if ( $team[ $station_verein[$station] ] ne "" ) {

			$qu1 = $spiel[1];
			$qu2 = $spiel[2];

			$tora = 0;
			$torb = 0;

			if ( $qu1 > 14 )  { $tora = 1 }
			if ( $qu1 > 39 )  { $tora = 2 }
			if ( $qu1 > 59 )  { $tora = 3 }
			if ( $qu1 > 79 )  { $tora = 4 }
			if ( $qu1 > 104 ) { $tora = 5 }
			if ( $qu1 > 129 ) { $tora = 6 }
			if ( $qu1 > 154 ) { $tora = 7 }

			if ( $qu2 > 14 )  { $torb = 1 }
			if ( $qu2 > 39 )  { $torb = 2 }
			if ( $qu2 > 59 )  { $torb = 3 }
			if ( $qu2 > 79 )  { $torb = 4 }
			if ( $qu2 > 104 ) { $torb = 5 }
			if ( $qu2 > 129 ) { $torb = 6 }
			if ( $qu2 > 154 ) { $torb = 7 }

			if ( $tora == 0 ) { $grenze_a = 0 }
			if ( $tora == 1 ) { $grenze_a = 15 }
			if ( $tora == 2 ) { $grenze_a = 40 }
			if ( $tora == 3 ) { $grenze_a = 60 }
			if ( $tora == 4 ) { $grenze_a = 80 }
			if ( $tora == 5 ) { $grenze_a = 105 }
			if ( $tora == 6 ) { $grenze_a = 130 }
			if ( $tora == 7 ) { $grenze_a = 155 }

			if ( $torb == 0 ) { $grenze_b = 0 }
			if ( $torb == 1 ) { $grenze_b = 15 }
			if ( $torb == 2 ) { $grenze_b = 40 }
			if ( $torb == 3 ) { $grenze_b = 60 }
			if ( $torb == 4 ) { $grenze_b = 80 }
			if ( $torb == 5 ) { $grenze_b = 105 }
			if ( $torb == 6 ) { $grenze_b = 130 }
			if ( $torb == 7 ) { $grenze_b = 155 }

			if ( $tora > $torb )  { $st_s[$station]++ }
			if ( $tora == $torb ) { $st_u[$station]++ }
			if ( $tora < $torb )  { $st_n[$station]++ }

			if ( $tora > $torb )  { $sp_s_g++ }
			if ( $tora == $torb ) { $sp_u_g++ }
			if ( $tora < $torb )  { $sp_n_g++ }

			if ( $tora > $torb ) { $st_p[$station] = $st_p[$station] + 3 }
			if ( $tora == $torb ) { $st_p[$station]++ }

			$st_tp[$station] = $st_tp[$station] + $tora;
			$st_tm[$station] = $st_tm[$station] + $torb;
			$st_uu[$station] = $st_uu[$station] + $qu1 - $grenze_a;

			$sp_tp_g = $sp_tp_g + $tora;
			$sp_tm_g = $sp_tm_g + $torb;

			$st_qp[$station] = $st_qp[$station] + $qu1;
			$st_qm[$station] = $st_qm[$station] + $qu2;

			$sp_qp_g = $sp_qp_g + $qu1;
			$sp_qm_g = $sp_qm_g + $qu2;

			$sp_uu_g = $sp_uu_g + $qu1 - $grenze_a;

			$st_sp[$station]++;
			$sp_g++;

			if ( $qu1 > $tip_g ) { $tip_g = $qu1 }

			chomp $spiel[3];

			if ( $spiel[3] eq "H" ) {
				$sp_h++;

				if ( $tora > $torb )  { $sp_s_h++ }
				if ( $tora == $torb ) { $sp_u_h++ }
				if ( $tora < $torb )  { $sp_n_h++ }

				$sp_tp_h = $sp_tp_h + $tora;
				$sp_tm_h = $sp_tm_h + $torb;

				$sp_qp_h = $sp_qp_h + $qu1;
				$sp_qm_h = $sp_qm_h + $qu2;

				$sp_uu_h = $sp_uu_h + $qu1 - $grenze_a;

				if ( $qu1 > $tip_h ) { $tip_h = $qu1 }

			}

			if ( $spiel[3] eq "A" ) {
				$sp_a++;

				if ( $tora > $torb )  { $sp_s_a++ }
				if ( $tora == $torb ) { $sp_u_a++ }
				if ( $tora < $torb )  { $sp_n_a++ }

				$sp_tp_a = $sp_tp_a + $tora;
				$sp_tm_a = $sp_tm_a + $torb;

				$sp_qp_a = $sp_qp_a + $qu1;
				$sp_qm_a = $sp_qm_a + $qu2;

				$sp_uu_a = $sp_uu_a + $qu1 - $grenze_a;

				if ( $qu1 > $tip_a ) { $tip_a = $qu1 }
			}
		}

	}
	$sai[$t] = $saison;

}
close(DO);

if ( $station_ende[$station] eq "" ) { $station_ende[$station] = 34 }

@name_sai = @main_saison;

$liga = $kid2;
print "<html><head><title>Trainer - Profile $coach ($ident)</title></head>\n";
print "<meta name=\"GOOGLEBOT\" content=\"NOINDEX, NOFOLLOW\">\n";
print "<body bgcolor=#eeeeee text=black>\n";

print "<head>\n";
print "<style type=\"text/css\">";
print
"TD.l {padding-left:10px;padding-right:10px;font-family:Verdana; font-size:7pt; color:black; background-color:white;}\n";
print
"TD.e {padding-left:15px;padding-right:15px;font-family:Verdana;font-size:7pt; color:black; background-color:#eeeeff;}\n";
print
"TD.f {padding-left:15px;padding-right:15px;font-family:Verdana;font-size:7pt; color:black; background-color:#dddeff;}\n";
print
"TD.r {text-align:right;padding-left:15px;padding-right:15px;font-family:Verdana;font-size:7pt; color:black; background-color:#eeeeff;}\n";
print
"TD.c {text-align:center;padding-left:15px;padding-right:15px;font-family:Verdana;font-size:7pt; color:black; background-color:#eeedff;}\n";
print
"TD.a {text-align:right;padding-left:8px;padding-right:8px;font-family:Verdana;font-size:7pt; color:black; background-color:white;}\n";
print
"TD.t {text-align:center;padding-left:15px;padding-right:15px;font-family:Verdana;font-size:7pt; color:black; background-color:#dddeff;}\n";
print
"TD.b {text-align:right;padding-left:8px;padding-right:8px;font-family:Verdana;font-size:7pt; color:black; background-color:#f5f5ff;}\n";

print "</style>\n";
print "</head>\n";
print "<p align=left>\n";

print "$banner_gross $banner_klein";
print "$location\n";
print "<br>\n";

print "<table border=0><tr><td valign=top align=left>";
print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black>\n";
print "<tr><td valign=top>\n";

print "<table border=0 cellpadding=2 cellspacing=1>\n";

print
"<tr><td bgcolor=#eeeeff >&nbsp;</td><td align=left bgcolor=#dddeff><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;<font size=2><b>$coach</b></font>&nbsp;&nbsp;\n";
if ( $land eq "Deutschland" ) { print "<img src=/img/tip_ger.JPG border=0>&nbsp;&nbsp;&nbsp;" }
if ( $land eq "Oesterreich" ) { print "<img src=/img/tip_aut.JPG border=0>&nbsp;&nbsp;&nbsp;" }
if ( $land eq "Schweiz" )     { print "<img src=/img/tip_swi.JPG border=0>&nbsp;&nbsp;&nbsp;" }
if ( $land eq "England" )     { print "<img src=/img/tip_eng.JPG border=0>&nbsp;&nbsp;&nbsp;" }
if ( $land eq "Niederlande" ) { print "<img src=/img/tip_ned.JPG border=0>&nbsp;&nbsp;&nbsp;" }

print
"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>";

print "<tr><td class=r>BTM Verein </td>\n";
print "<td class=l>$verein_coach</td></tr>\n";
print "<tr><td class=r>Liga  </td>\n";
print "<td class=l>$liga_namen[$kid2]</td></tr>\n";

if ( $tmi_liga != 0 ) {
	print "<tr><td class=r>TMI Verein </td>\n";
	print "<td class=l>$tmi_verein</td></tr>\n";
	print "<tr><td class=r>Liga  </td>\n";
	print "<td class=l>$tmi_liga_namen[$tmi_liga]</td></tr>\n";
}

#print "<tr><td class=r>E-Mail </td>\n";
#print "<td class=l>$mail_adresse </td></tr>\n";
if ( ( $wohnort ne "keine Angabe" ) and ( $wohnort ne "" ) ) {
	print "<tr><td class=r>Wohnort</td>\n";
	print "<td class=l>$wohnort</td></tr>\n";
}
if ( ( $bundesland ne "keine Angabe" ) and ( $bundesland ne "" ) and ( $bundesland ne "01.01.1900" ) ) {
	print "<tr><td class=r>Bundesland </td>\n";
	print "<td class=l>$bundesland</td></tr>\n";
}
if ( ( $land ne "keine Angabe" ) and ( $land ne "" ) ) {
	print "<tr><td class=r>Land </td>\n";
	print "<td class=l>$land</td></tr>\n";
}
if ( ( $geburtstag ne "01.01.1900" ) and ( $geburtstag ne "" ) and ( $geburtstag ne "keine Angabe" ) ) {
	print "<tr><td class=r>Geburtstag </td>\n";
	print "<td class=l>$geburtstag</td></tr>\n";
}
if ( ( $beruf ne "keine Angabe" ) and ( $beruf ne "" ) and ( $beruf ne "kein Angabe" ) ) {
	print "<tr><td class=r>Beruf </td>\n";
	print "<td class=l>$beruf</td></tr>\n";
}
if ( ( $liebling ne "keine Angabe" ) and ( $liebling ne "" ) ) {
	print "<tr><td class=r>Lieblingsverein </td>\n";
	print "<td class=l>$liebling</td></tr>\n";
}
if ( ( $hobby ne "keine Angabe" ) and ( $hobby ne "" ) ) {
	print "<tr><td class=r>Hobbys</td>\n";
	print "<td class=l>$hobby</td></tr>\n";
}
if ( ( $motto ne "keine Angabe" ) and ( $motto ne "" ) ) {
	print "<tr><td class=r>Statement zum BTM</td>\n";
	print "<td class=l>$motto</td></tr>";
}

#print "<tr><td class=r>TM Aktivitaet </td>\n";
#print "<td class=l>Rang $aktiv diese Woche</td></tr>";

open( D1, "/tmdata/btm/awards.txt" );
while (<D1>) {
	@gop = split( /#/, $_ );
	if ( $gop[4] eq $coach ) {
		$award++;
		$a_line[$award] = $_;
		chomp $a_line[$award];
	}
}
close(D1);

@seson = @main_saison;

if ( $award > 0 ) {
	print
"<tr><td align=right bgcolor=#eeeeff valign=top><br><font face=verdana size=1>&nbsp;&nbsp;&nbsp;Trainer Awards &nbsp; </td>\n";
	print "<td align=left bgcolor=white><font face=verdana size=1>\n";

	print "<br>";
	for ( $x = 1 ; $x <= $award ; $x++ ) {
		@gop = split( /#/, $a_line[$x] );
		if ( $gop[3] == 1 ) { $statusi = "Gold Award ( 1. Platz )" }
		if ( $gop[3] == 2 ) { $statusi = "Silber Award ( 2. Platz )" }
		if ( $gop[3] == 3 ) { $statusi = "Bronze Award ( 3. Platz )" }

		if ( $gop[2] == 1 ) { $status = "Top - League Players" }
		if ( $gop[2] == 2 ) { $status = "Quotenk�nige" }
		if ( $gop[2] == 3 ) { $status = "Torsch�tzenk�nige" }
		if ( $gop[2] == 4 ) { $status = "Top - Optimizer" }
		if ( $gop[2] == 5 ) { $status = "Schiessbuden" }

		print " &nbsp;&nbsp;&nbsp;&nbsp;$seson[$gop[1]+5] : Kategorie \'$status\' $statusi&nbsp; &nbsp; &nbsp; <br>";
	}
	print
"<br> &nbsp;&nbsp;&nbsp;&nbsp;-> zu den <a href=/cgi-bin/btm/award.pl target=new>Trainer - Award Rankings</a><br><br>";

	print "</td></tr>";

}
$award = 0;
open( D1, "/tmapp/appdata/fuxx.txt" );
while (<D1>) {
	@gop = split( /#/, $_ );
	if ( $gop[2] eq $coach ) {
		$award++;
		$a_line[$award] = $_;
		chomp $a_line[$award];
	}
}
close(D1);

if ( $award > 0 ) {
	print
"<tr><td align=right bgcolor=#eeeeff valign=top><font face=verdana size=1>&nbsp;&nbsp;&nbsp;Auszeichnungen &nbsp; </td>\n";
	print "<td align=left bgcolor=white><font face=verdana size=1>\n";

	for ( $x = 1 ; $x <= $award ; $x++ ) {
		@gop = split( /#/, $a_line[$x] );

		print
		  " &nbsp;&nbsp;&nbsp;&nbsp;$seson[$gop[1]+5] : Wahl zum Trainer - Fuxx der Saison&nbsp; &nbsp; &nbsp; <br>";
	}

	print "</td></tr>";
}

if ( $trainer eq $coach ) {
	print
"<form name=pr action=/cgi-bin/btm/daten/profile.pl method=post><input type=hidden name=address value=\"$coach\">\n";
	print
"<tr><td bgcolor=#eeeeff>&nbsp;</td><td bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;<a href=javascript:document.pr.submit()>Eigenes Trainerprofil eintragen / aendern</a>&nbsp;&nbsp;&nbsp;</td></tr></form>\n";

}

print "</tr></table></td></tr></table>\n";
print "</td><td width=200 align=center valign=top>";
if ( $bild ne "" ) {

	print "<a href=$bild target=nnew><img src=$bild width=\"110\" height=\"130\" border=0></a>";

	if ( $bild =~ /nofoto/ ) {
		print "<font face=verdana size=1><br><br>Click auf Foto<br>-> Orginalgr�sse <-";
		print "<font face=verdana size=1><br><br><a href=/cgi-bin/btm/upload.pl>Eigenes Foto uploaden</a>";

	}
	else {
		print "<font face=verdana size=1><br><br><a href=/cgi-bin/btm/upload.pl>Eigenes Foto uploaden</a>";
	}
}
print "</td></tr></table>";
print "<tr><td></td></tr>";

if ( $sp_g > 0 ) {

	print
"<tr><td colspan=2 align=left valign=top><font face=verdana size=2><br><br>&nbsp;<b>Gesamtbilanz $coach</b>&nbsp;&nbsp;&nbsp;<br><br>\n";

	print "<table border=0 bgcolor=black  cellpadding=0 cellspacing=0>\n";
	print "<tr><td>\n";
	print "<table border=0 cellpadding=3 cellspacing=1>\n";

	print "<tr>\n";

	print "<td align=right bgcolor=#dddeff><font face=verdana size=1>&nbsp;Saison&nbsp;&nbsp;&nbsp;</td>\n";
	print "<td align=center bgcolor=#dddeff><font face=verdana size=1>&nbsp;&nbsp;Spiele&nbsp;&nbsp;</td>\n";
	print "<td align=center bgcolor=#dddeff><font face=verdana size=1>&nbsp;&nbsp;Bilanz&nbsp;&nbsp;</td>\n";
	print "<td align=center bgcolor=#dddeff><font face=verdana size=1>&nbsp;&nbsp;Tore&nbsp;&nbsp;</td>\n";
	print "<td align=center bgcolor=#dddeff><font face=verdana size=1>&nbsp;&nbsp;Punkte&nbsp;&nbsp;</td>\n";
	print "<td align=center bgcolor=#dddeff><font face=verdana size=1>&nbsp;&nbsp;Quote&nbsp;&nbsp;</td>\n";
	print "<td align=center bgcolor=#dddeff><font face=verdana size=1>&nbsp;&nbsp;Optimizer&nbsp;&nbsp;</td>\n";

	print "<td align=center bgcolor=#dddeff><font face=verdana size=1>&nbsp;&nbsp;Bester Tip&nbsp;&nbsp;</td>\n";
	print "</tr>\n";

	$pu = ( $sp_s_g * 3 ) + $sp_u_g;

	print "<tr>\n";
	print "<td align=right bgcolor=#eeeeff><font face=verdana size=1>&nbsp;&nbsp;Gesamt&nbsp;&nbsp;&nbsp;</td>\n";
	print "<td align=center bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;$sp_g&nbsp;&nbsp;</td>\n";
	print
"<td align=center bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;$sp_s_g - $sp_u_g - $sp_n_g&nbsp;&nbsp;</td>\n";
	print
	  "<td align=center bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;$sp_tp_g : $sp_tm_g &nbsp;&nbsp;</td>\n";

	print "<td align=right bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;$pu Pu.&nbsp;&nbsp;</td>\n";

	$sp_qpd_g = int( ( $sp_qp_g / $sp_g ) * 10 ) / 10;
	$sp_qmd_g = int( ( $sp_qm_g / $sp_g ) * 10 ) / 10;

	$xm = "";
	$xn = "";
	$ka = int($sp_qpd_g);
	$kb = int($sp_qmd_g);
	if ( $ka == $sp_qpd_g ) { $xm = ".0" }
	if ( $kb == $sp_qmd_g ) { $xn = ".0" }

	print
"<td align=center bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;$sp_qpd_g$xm  &nbsp;-&nbsp; $sp_qmd_g$xn&nbsp;&nbsp;</td>\n";
	$oo = 0;
	$op = int( ( $sp_uu_g / $sp_g ) * 1000 ) / 1000;
	$xx = "111";
	( $yy, $xx ) = split( /\./, $op );
	$oo = length($xx);
	if ( $oo == 2 ) { $op = $op . '0' }
	if ( $oo == 1 ) { $op = $op . '00' }
	if ( $oo == 0 ) { $op = $op . '.000' }

	print "<td align=center bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;$op &nbsp;&nbsp;</td>\n";

	print "<td align=center bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;$tip_g&nbsp;&nbsp;</td>\n";
	print "</tr>\n";

	$pu = ( $sp_s_h * 3 ) + $sp_u_h;

	print "<tr>\n";
	print "<td align=right bgcolor=#eeeeff><font face=verdana size=1>&nbsp;&nbsp;Heim&nbsp;&nbsp;&nbsp;</td>\n";
	print "<td align=center bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;$sp_h&nbsp;&nbsp;</td>\n";
	print
"<td align=center bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;$sp_s_h - $sp_u_h - $sp_n_h&nbsp;&nbsp;</td>\n";
	print
	  "<td align=center bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;$sp_tp_h : $sp_tm_h &nbsp;&nbsp;</td>\n";
	print "<td align=right bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;$pu Pu.&nbsp;&nbsp;</td>\n";

	$sp_qpd_h = int( ( $sp_qp_h / $sp_h ) * 10 ) / 10;
	$sp_qmd_h = int( ( $sp_qm_h / $sp_h ) * 10 ) / 10;

	$xm = "";
	$xn = "";
	$ka = int($sp_qpd_h);
	$kb = int($sp_qmd_h);
	if ( $ka == $sp_qpd_h ) { $xm = ".0" }
	if ( $kb == $sp_qmd_h ) { $xn = ".0" }

	print
"<td align=center bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;$sp_qpd_h$xm  &nbsp;-&nbsp; $sp_qmd_h$xn&nbsp;&nbsp;</td>\n";
	$oo = 0;
	$op = int( ( $sp_uu_h / $sp_h ) * 1000 ) / 1000;
	$xx = "111";
	( $yy, $xx ) = split( /\./, $op );
	$oo = length($xx);
	if ( $oo == 2 ) { $op = $op . '0' }
	if ( $oo == 1 ) { $op = $op . '00' }
	if ( $oo == 0 ) { $op = $op . '.000' }

	print "<td align=center bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;$op &nbsp;&nbsp;</td>\n";

	print "<td align=center bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;$tip_h&nbsp;&nbsp;</td>\n";
	print "</tr>\n";

	$pu = ( $sp_s_a * 3 ) + $sp_u_a;

	print "<tr>\n";
	print "<td align=right bgcolor=#eeeeff><font face=verdana size=1>&nbsp;&nbsp;Auswaerts&nbsp;&nbsp;&nbsp;</td>\n";
	print "<td align=center bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;$sp_a&nbsp;&nbsp;</td>\n";
	print
"<td align=center bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;$sp_s_a - $sp_u_a - $sp_n_a&nbsp;&nbsp;</td>\n";
	print
	  "<td align=center bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;$sp_tp_a : $sp_tm_a &nbsp;&nbsp;</td>\n";
	print "<td align=right bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;$pu Pu.&nbsp;&nbsp;</td>\n";

	$sp_qpd_a = int( ( $sp_qp_a / $sp_a ) * 10 ) / 10;
	$sp_qmd_a = int( ( $sp_qm_a / $sp_a ) * 10 ) / 10;

	$xm = "";
	$xn = "";
	$ka = int($sp_qpd_a);
	$kb = int($sp_qmd_a);
	if ( $ka == $sp_qpd_a ) { $xm = ".0" }
	if ( $kb == $sp_qmd_a ) { $xn = ".0" }

	print
"<td align=center bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;$sp_qpd_a$xm  &nbsp;-&nbsp; $sp_qmd_a$xn&nbsp;&nbsp;</td>\n";
	$oo = 0;
	$op = int( ( $sp_uu_a / $sp_a ) * 1000 ) / 1000;
	$xx = "111";
	( $yy, $xx ) = split( /\./, $op );
	$oo = length($xx);
	if ( $oo == 2 ) { $op = $op . '0' }
	if ( $oo == 1 ) { $op = $op . '00' }
	if ( $oo == 0 ) { $op = $op . '.000' }

	print "<td align=center bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;$op &nbsp;&nbsp;</td>\n";

	print "<td align=center bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;$tip_a&nbsp;&nbsp;</td>\n";
	print "</tr>\n";

	print "</table>\n";
	print "</td></tr></table>\n";

	print
"<br><font size=1>&nbsp; Anmerkung: Der Optimizer Wert berechnet sich indem alle Quotenpunkte oberhalb einer Torgrenze,<br>
&nbsp; die zu
keinem weiteren Tor f�hrten, addiert und durch die Anzahl der absolvierten Spiele geteilt werden. <br>
&nbsp; Ein niedriger Optimizer Wert entspricht also einer effektiven und verlustarmen Umsetzung der erzielten<br>
&nbsp; eigenen Quotenpunkte in Tore durch den Trainer.<br>
";
##########################################################################################

	$line = 0;
	open( D, "</tmdata/btm/trainer_db/ligawerte.txt" );
	while (<D>) {
		$line++;
		@ok = split( /&/, $_ );
		$linedb[ $ok[0] ] = $_;
	}
	close(D);

	$line = 0;
	open( D, "</tmdata/btm/trainer_db/$coach" );
	while (<D>) {
		$line++;
		$lineup[$line] = $_;
	}
	close(D);
	if ( $line > 0 ) {
		print "<br><br><font size=2> &nbsp; <b>Saisondaten $coach
</b><br><br>";

		$ff = $coach;
		$ff =~ s/ /_/g;

		my $g = $main_kuerzel[$main_nr];
		$g =~ s/\ //g;
		print "<!-- Coach is $ff, Kuerzel is $g //-->\n";

		if ( -e "/home/tm/www/img/chart/$ff-lp-$g.gif" ) {
			print "<table border=0><tr>";
			print "<td> <img src=/img/chart/$ff-lp-$g.gif> </td><td width=50></td>";
			print "<td> <img src=/img/chart/$ff-to-$g.gif> </td>";
			print "</tr><tr>";
			print "<td> <img src=/img/chart/$ff-qu-$g.gif> </td><td width=50></td>";
			print "<td> <img src=/img/chart/$ff-op-$g.gif> </td>";
			print "</table>";
		}

		print "<br><br>";
		print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black>\n";
		print "<tr><td>\n";

		print "<table border=0 cellpadding=2 cellspacing=1>\n";

		print "<tr>\n";
		print "<td class=t><br>Saison</td>";
		print "<td class=t colspan=4>Kategorie<br>Ligapunkte</td>";
		print "<td class=t colspan=4>Kategorie<br>Geschossene Tore</td>";
		print "<td class=t colspan=4>Kategorie<br>Erzielte Quote</td>";
		print "<td class=t colspan=4>Kategorie<br>Optimizer Wert</td>";

		#print "<td class=c colspan=4>Kategorie<br>Erhaltene Gegentore</td>";
		print "</tr>";

		for ( $x = 1 ; $x <= $line ; $x++ ) {
			print "<tr>\n";
			@all = split( /&/, $lineup[$x] );
			@db  = split( /&/, $linedb[ $all[0] ] );

			$r = "a";
			if ( $x % 2 == 0 ) { $r = "b" }

			$ss = $main_saison[ $all[0] + 5 ];
			$ss =~ s/Saison //;
			print "<td class=r> $ss </td>";

			#print "<td class=r> $all[7]</td>";

			print "<td class=$r> $all[8] Pu. </td>";
			print "<td class=$r> &#216; $db[1] </td>";
			@s = split( /\//, $all[1] );
			$pl = $s[0] / $s[1];
			my $aa3 = $coach;
			$aa3 =~ s/ /%20/g;
			print "<td class=$r> <a href=/cgi-bin/btm/award.pl?sai=", $all[0], "&me=1&trainer=$aa3>$s[0].</a></td>";

			$ima = "/img/pfeil+.gif";
			$pl  = int( $pl * 100 );

			if ( $pl > 15 ) { $ima = "/img/pfeil++.gif" }
			if ( $pl > 35 ) { $ima = "/img/pfeil=.gif" }
			if ( $pl > 65 ) { $ima = "/img/pfeil--.gif" }
			if ( $pl > 85 ) { $ima = "/img/pfeil-.gif" }
			print "<td class=$r> <img src=$ima> </td>";

			print "<td class=$r> $all[12] To. </td>";
			print "<td class=$r> &#216; $db[2] </td>";
			@s = split( /\//, $all[3] );
			$pl = $s[0] / $s[1];
			print "<td class=$r> <a href=/cgi-bin/btm/award.pl?sai=", $all[0], "&me=3&trainer=$aa3>$s[0].</a></td>";

			$ima = "/img/pfeil+.gif";
			$pl  = int( $pl * 100 );

			if ( $pl > 15 ) { $ima = "/img/pfeil++.gif" }
			if ( $pl > 35 ) { $ima = "/img/pfeil=.gif" }
			if ( $pl > 65 ) { $ima = "/img/pfeil--.gif" }
			if ( $pl > 85 ) { $ima = "/img/pfeil-.gif" }
			print "<td class=$r> <img src=$ima alt=\"Platz $s[0] von $s[1] gelisteten Trainern\"> </td>";

			print "<td class=$r> $all[14] Qu. </td>";
			print "<td class=$r> &#216; $db[3] </td>";
			@s = split( /\//, $all[2] );
			$pl = $s[0] / $s[1];
			print "<td class=$r> <a href=/cgi-bin/btm/award.pl?sai=", $all[0], "&me=2&trainer=$aa3>$s[0].</a></td>";

			$ima = "/img/pfeil+.gif";
			$pl  = int( $pl * 100 );
			if ( $pl > 15 ) { $ima = "/img/pfeil++.gif" }
			if ( $pl > 35 ) { $ima = "/img/pfeil=.gif" }
			if ( $pl > 65 ) { $ima = "/img/pfeil--.gif" }
			if ( $pl > 85 ) { $ima = "/img/pfeil-.gif" }
			print "<td class=$r> <img src=$ima alt=\"Platz $s[0] von $s[1] gelisteten Trainern\"> </td>";

			#$all[16]*= 1;
			print "<td class=$r> $all[16] Op. </td>";
			print "<td class=$r> &#216; $db[4] </td>";
			@s = split( /\//, $all[4] );
			$pl = $s[0] / $s[1];
			print "<td class=$r> <a href=/cgi-bin/btm/award.pl?sai=", $all[0], "&me=4&trainer=$aa3>$s[0].</a></td>";

			$ima = "/img/pfeil+.gif";
			$pl  = int( $pl * 100 );
			if ( $pl > 15 ) { $ima = "/img/pfeil++.gif" }
			if ( $pl > 35 ) { $ima = "/img/pfeil=.gif" }
			if ( $pl > 65 ) { $ima = "/img/pfeil--.gif" }
			if ( $pl > 85 ) { $ima = "/img/pfeil-.gif" }
			print "<td class=$r> <img src=$ima alt=\"Platz $s[0] von $s[1] gelisteten Trainern\"> </td>";

			print "</tr>";
		}

		print "</table>\n";
		print "</td></tr></table>\n";
		print "<br>
<font size=1> 
 &nbsp; &nbsp; -> Der erste aufgef�hrte Wert gibt den vom Trainer erzielten Wert in der jew. Kategorie und Saison an <br>
 &nbsp; &nbsp; -> Der zweite aufgef�hrte Wert gibt den durchschnittlich erreichten Wert dieser Kategorie aller Trainer mit 34 absolvierten Spielen der Saison an<br>
 &nbsp; &nbsp; -> Der dritte augef�hrte Wert gibt die Plazierung des Trainers im Saison - Award Ranking der jew. Kategorie an 
<br><br> 
 &nbsp; &nbsp; <img src=/img/pfeil+.gif> Plazierung an der Tabellenspitze unter den besten 15%<br> 
 &nbsp; &nbsp; <img src=/img/pfeil++.gif> Plazierung im oberen Mittelfeld unter den besten 16% bis 35% <br>
 &nbsp; &nbsp; <img src=/img/pfeil=.gif> Plazierung im Mittelfeld ( die besten 36% bis 65% ) <br>
 &nbsp; &nbsp; <img src=/img/pfeil--.gif> Plazierung im unteren Mittelfeld ( die besten 66% bis 85% ) <br>
 &nbsp; &nbsp; <img src=/img/pfeil-.gif> Plazierung am Tabellenende ( die besten 86% bis 100% ) <br><br>
"
		  ;

		close(D);
	}
	goto tab;

	print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=#eeeeee>\n";
	print "<tr>\n";

	for ( $x = 1 ; $x <= $line ; $x++ ) {
		@all = split( /&/, $lineup[$x] );
		$all[8] *= 1.5;
		print "<td valign=bottom>";
		print "<table border=0>\n";
		print "<tr>";
		print "<td class=b height=$all[8] bgcolor=green valign=bottom></td>\n";
		print "</tr></table>";
		print "</td>";
	}

	print "<td width=50></td>";

	for ( $x = 1 ; $x <= $line ; $x++ ) {
		@all = split( /&/, $lineup[$x] );
		$all[12] *= 1.5;
		print "<td valign=bottom>";
		print "<table border=0>\n";
		print "<tr>";
		print "<td class=b height=$all[12] bgcolor=green valign=bottom></td>\n";
		print "</tr></table>";
		print "</td>";
	}

	print "</tr></table>";

  tab:

############################################################################################

	print
"<tr><td align=left valign=top colspan=2><br><br>&nbsp;<font face=verdana size=2><b>Bisherige Trainerstationen $coach</b><br><br>\n";

	print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black>\n";
	print "<tr><td>\n";

	print "<table border=0 cellpadding=2 cellspacing=1>\n";
	print "<tr>\n";

	print "<td class=e align=center bgcolor=#dddeff> Saison </td>\n";
	print "<td class=e align=center colspan=5 bgcolor=#dddeff> Verein </td>\n";
	print "<td class=e align=center bgcolor=#dddeff> Liga </td>\n";

	print "</tr>\n";

	for ( $x = 1 ; $x <= $station ; $x++ ) {

		if ( $team[ $station_verein[$x] ] ne "" ) {

			open( D5, "/tmdata/btm/geschichte.txt" );
			while (<D5>) {

				if ( $_ =~ /&$team[$station_verein[$x]]&/ ) {

					my @tmparray = split( /&/, $_ );
					my $id       = 0;
					my $index    = 0;
					foreach (@tmparray) {
						$index = int( $id / 2 );
						$id++;
						if ( $id % 2 == 0 ) { $sat[$index] = $_ }
						if ( $id % 2 == 1 ) { $sai[$index] = $_ }

					}

				}
			}
			close(D5);

			if ( $station_saison[$x] == ( $main_nr - 5 ) ) {

				open( D5, "/tmdata/btm/heer.txt" );

				while (<D5>) {

					if ( $_ =~ /&$team[$station_verein[$x]]&/ ) {
						@no = split( /&/, $_ );
						$sai[$main_nr] = $no[0];
						$liga_akt = $no[1];

					}
				}
				close(D5);

			}

			print "<tr>\n";
			print "<td class=e> $name_sai[$station_saison[$x]+5] </td>\n";
			$aa = $team[ $station_verein[$x] ];
			$aa =~ s/ /%20/g;
			print
"<td class=f colspan=5> <a href=/cgi-mod/btm/verein.pl?ident=$aa><img src=/img/h1.jpg border=0 alt=\"Vereinsseite $team[$station_verein[$x]]\"></a> &nbsp; $team[$station_verein[$x]] </td>\n";

			for ( $yy = 1 ; $yy <= ( $main_nr - 6 ) ; $yy++ ) {
				if ( $station_saison[$x] == $yy ) { $i = $sat[ $yy + 5 ] }
			}

			if ( $station_saison[$x] == ( $main_nr - 5 ) ) { $i = $no[1] }

			print "<td class=r>$liga_namen[$i]</td>\n";
			$xa = "";
			$xb = "";
			if ( $station_start[$x] < 10 ) { $xa = "0" }
			if ( $station_ende[$x] < 10 )  { $xb = "0" }
			print "</tr><tr>\n";

			print "<td class=e> Sp. &nbsp; $xa$station_start[$x] -  $xb$station_ende[$x] </td>\n";

			$st_s[$x] = $st_s[$x] * 1;
			$st_u[$x] = $st_u[$x] * 1;
			$st_n[$x] = $st_n[$x] * 1;

			#$st_sp[$x]= $st_s[$x]+ $st_u[$x]+ $st_n[$x];

			$xd = "";
			$xe = "";
			$xf = "";
			if ( $st_s[$x] < 10 ) { $xd = "0" }
			if ( $st_u[$x] < 10 ) { $xe = "0" }
			if ( $st_n[$x] < 10 ) { $xf = "0" }

			$st_tp[$x] = $st_tp[$x] * 1;
			$st_tm[$x] = $st_tm[$x] * 1;

			$xg = "";
			$xh = "";
			$xc = "";
			$xj = "";
			if ( $st_tp[$x] < 10 ) { $xg = "0" }
			if ( $st_tm[$x] < 10 ) { $xh = "0" }
			if ( $st_n[$x] < 10 )  { $xb = "0" }
			if ( $st_p[$x] < 10 )  { $xj = "0" }

			$st_qpd[$x] = int( ( $st_qp[$x] / $st_sp[$x] ) * 10 ) / 10;
			$st_qmd[$x] = int( ( $st_qm[$x] / $st_sp[$x] ) * 10 ) / 10;

			$xx = "";
			$xy = "";

			$ka = int( $st_qpd[$x] );
			$kb = int( $st_qmd[$x] );

			if ( $ka == $st_qpd[$x] ) { $xx = ".0" }
			if ( $kb == $st_qmd[$x] ) { $xy = ".0" }

			print "<td class=l> Bilanz $xd$st_s[$x] - $xe$st_u[$x] - $xf$st_n[$x] </td>\n";
			print "<td class=l> $xg$st_tp[$x] : $xh$st_tm[$x] &nbsp; Tore </td>\n";
			print "<td class=l> $xj$st_p[$x] Punkte </td>\n";
			print "<td class=l> Qu. $st_qpd[$x]$xx - $st_qmd[$x]$xy </td>\n";

			$oo = 0;
			$op = int( ( $st_uu[$x] / $st_sp[$x] ) * 1000 ) / 1000;
			$xx = "111";
			( $yy, $xx ) = split( /\./, $op );
			$oo = length($xx);
			if ( $oo == 2 ) { $op = $op . '0' }
			if ( $oo == 1 ) { $op = $op . '00' }
			if ( $oo == 0 ) { $op = $op . '.000' }

			print "<td class=l> Opt. $op </td>\n";

			for ( $yy = 1 ; $yy <= ( $main_nr - 6 ) ; $yy++ ) {
				if ( $station_saison[$x] == $yy ) { $i = $sai[ $yy + 5 ] }
			}

			if ( $station_saison[$x] == ( $main_nr - 5 ) ) { $i = $no[0] }
			print "<td class=r>$i. Platz</td>\n";
			print "</tr>\n";

		}
	}
	print "</table>\n";
	print "</td></tr></table>\n";
	print
"<font face=verdana size=1 color=darkred><br>&nbsp;Die Vereinsplazierung geben die Saisonendplazierung wieder und<br>&nbsp;nicht die Vereinsplazierung zum Zeitpunkt des Wechsels .<font color=black>\n";

	print "</td></tr>\n";

	print "</td></tr>\n";

}

print
"<tr><td></td><td align=left><font face=verdana size=1><br><br><br>&nbsp;&nbsp;<font size=2><b>Nachricht an die Message - Box verfassen</b></font>&nbsp;&nbsp;\n";

print "<tr><td><br></td></tr>";
if ( $trainer eq "unknown" ) {
}
if ( $trainer ne "unknown" ) {
	print "<form method=post action=/cgi-bin/btm/mail/mail_sent.pl>\n";

	print "<table border=0 bgcolor=black  cellpadding=0 cellspacing=0>\n";
	print "<tr><td>\n";
	print "<table border=0 cellpadding=3 cellspacing=1>\n";

	print "<tr>\n";
	print "<td align=right bgcolor=#dddeff><font face=verdana size=1>&nbsp;Absender&nbsp;:&nbsp;&nbsp;</td>\n";
	print "<td align=left bgcolor=#eeeeff><font face=verdana size=1>&nbsp;&nbsp;$trainer&nbsp;&nbsp;</td>\n";
	print "</tr>\n";
	print "<tr>\n";
	print "<td align=right bgcolor=#dddeff><font face=verdana size=1>&nbsp;Empfaenger&nbsp;:&nbsp;&nbsp;</td>\n";
	print "<td align=left bgcolor=#eeeeff><font face=verdana size=1>&nbsp;&nbsp;$coach&nbsp;&nbsp;</td>\n";
	print "</tr>\n";
	print "<tr>\n";
	print "<td align=right bgcolor=#dddeff><font face=verdana size=1>&nbsp;Betreff&nbsp;:&nbsp;&nbsp;</td>\n";
	print
"<td align=left bgcolor=#eeeeff><font face=verdana size=1>&nbsp;&nbsp;<input type=text name=subject length=35 maxlength=35>&nbsp;&nbsp;</td>\n";
	print "</tr>\n";
	print "<tr>\n";
	print
	  "<td align=right valign=top bgcolor=#dddeff><font face=verdana size=1>&nbsp;Nachricht&nbsp;:&nbsp;&nbsp;</td>\n";
	print
"<td align=left bgcolor=#eeeeff><font face=verdana size=1>&nbsp;&nbsp;<textarea name=text rows=6 cols=25 maxrows=8 maxcols=40></textarea>&nbsp;&nbsp;</td>\n";
	print "</tr>\n";
	print "\n";
	print "<input type=hidden name=message value=konkurrenz><input type=hidden name=auswahl_liga value=\"$coach\">\n";
	print "<tr>\n";
	print "<td align=right bgcolor=#dddeff><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";
	print
"<td align=left bgcolor=#eeeeff><font face=verdana size=1>&nbsp;&nbsp;<input type=submit value=\"Nachricht senden\">&nbsp;&nbsp;</td>\n";
	print "</tr>\n";
	print "</form>\n";

	print
"<form name=ad action=/cgi-bin/btm/mail/mailbox.pl method=post><input type=hidden name=method value=\"add_adress\">\n";
	print "<input type=hidden name=add value=\"$coach\"></form>";

	print "<tr>\n";
	print "<td align=right bgcolor=#dddeff><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";
	print
"<td align=left bgcolor=#eeeeff><font face=verdana size=1>&nbsp;&nbsp;<a href=javascript:document.ad.submit()>$coach ins Adressbuch aufnehmen</a>&nbsp;&nbsp;</td>\n";
	print "</tr>\n";
	print "</form>\n";
	print "</table></td></tr></table>\n";

}

exit;

