#!/usr/bin/perl

=head1 NAME
	BTM verein.pl

=head1 SYNOPSIS
	TBD
	


=head1 CHANGELOG
	2015-06-09 Thomas: Added Session Management


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

my @cookies      = ();
my $mlib         = new Test;
my $banner_gross = $mlib->banner_gross();
my $banner_bottom = $mlib->banner_bottom();
my $banner_klein = $mlib->banner_klein();
my $location     = $mlib->location();
my @liga_namen   = $mlib->btm_liga_namen();
my @main_saison  = $mlib->btm_saison_namen();
my @main_kuerzel = $mlib->btm_saison_kuerzel();
my $main_nr      = $main_saison[0];

my $tor   = "";
my $datei = "";
my $query;
my $liga;
my $verein;
my $ident;
my $ss_saison;
my $saison_aktuell;
my $lo;
my @vereine;
my $y;
my $x;
my @data;
my @datb;
my $ein_a;
my $spieltag;
my $ro;
my $suche;
my $rf;
my $rx;
my @datc;
my @ego;
my $hg;
my $anton;
my $beta;
my $datei_data;
my @quoten_row;
my $leer;
my $xx;
my @sai;
my @sat;
my $c;
my @basis;
my $seit_saison;
my @saison;
my $li     = "";
my @verein = ();
my $url    = "";
my $rre;
my $color;
my $rr;
my $d;
my $karriere;
my @all;
my $wechsel;
my @bongo;
my $saison_start;
my $saison_ende;
my $aa;
my $ab;
my $ac;
my $fa;
my @ega;
my @quoten_zahl;
my $tora;
my $torb;
my $wa;
my $wb;
my $ga;
my $gb;
my $gc;
my @gespielt;
my @gegner;
my @ort;
my @tip;
my $ser_gew;
my $ser_ver;
my $ser_ngew;
my $ser_nver;
my $ser_hgew;
my $ser_hver;
my $ser_hngew;
my $ser_hnver;
my @tor_a;
my @tor_b;
my @qu_a;
my @qu_b;
my $ser_agew;
my $ser_aver;
my $ser_angew;
my $ser_anver;
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
my $yx;
my @plazierung;
my @pl1;
my @pl2;
my @pl3;
my $xc;
my @dat_qu_m;
my @dat_gqu_m;
my @dat_hqu_m;
my @dat_ghqu_m;
my @dat_aqu_m;
my @dat_gaqu_m;
my $sp;
my $l1;
my $l2;
my $l3;
my $l4;
my $l5;
my $rg;
my $farbe;
my $start;
my $ss;
my $page_footer;

use CGI;
$query     = new CGI;
$liga      = $query->param('li');
$verein    = $query->param('ve');
$ident     = $query->param('ident');
$ss_saison = $query->param('saison');

## debug bpf 2022-02-27
my $origve = $verein;
my $origident = $ident;


require "/tmapp/tmsrc/cgi-bin/btm_ligen.pl";
require "/tmapp/tmsrc/cgi-bin/btm/saison.pl";
$saison_aktuell = $main_nr - 1;

if ( $ss_saison < 1 || $ss_saison > $main_nr ) { $ss_saison = $main_nr }
$url = "archiv/" . $main_kuerzel[$ss_saison];
$url =~ s/\ //g;    #Leerzeichen raus

if ( ( $ident ne 'unknown' ) or ( $ident ne "" ) ) {

	$lo = 0;

	my $datei = "/tmdata/btm/" . $url . "/history.txt";
	print "<!-- datei ist $datei ss_saison is $ss_saison main_nr is $main_nr... array size "
	  . scalar(@main_kuerzel)
	  . " //-->\n";
	print "<!-- @main_kuerzel //-->\n";
	open( D2, "$datei" );
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
		chomp $verein[$y];
		$data[$x] = $vereine[$y];
		$y++;
		chomp $verein[$y];
		$datb[$x] = $vereine[$y];

		if ( $data[$x] eq $ident ) {
			$verein = $x;
			$liga   = $li;
		}

		$y++;

	}
}

#bpf debug 2022-02-27
my $ve2_debug = $verein; my $li2_debug = $liga;


my %gl_vereinsid;
my @gl_vereinsname;
open( D1, "</tmdata/btm/db/vereine.txt" );
while (<D1>) {
	my @sal = split( /&/, $_ );
	$gl_vereinsid{ $sal[1] } = $sal[0];
	$gl_vereinsname[ $sal[0] ] = $sal[1];
}
close(D1);

$ein_a = 0;

for ( $spieltag = 1 ; $spieltag <= 384 ; $spieltag++ ) {
	if ( $spieltag == $liga ) { $ein_a = 1 }
}

if ( $ein_a == 0 ) { $liga = 1 }

$ein_a = 0;

for ( $spieltag = 1 ; $spieltag < 19 ; $spieltag++ ) {
	if ( $verein == $spieltag ) { $ein_a = 1 }
}

if ( $ein_a == 0 ) { $verein = 1 }

$ro    = "x";
$suche = $ro . $liga . '&';

$rf = "0";
$rx = "x";
if ( $liga > 9 ) { $rf = "" }

$suche = $rx . $rf . $liga . '&';

$datei = "/tmdata/btm/" . $url . "/history.txt";
open( D2, "$datei" );
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
	$y++;
	chomp $verein[$y];
	$datc[$x] = $vereine[$y];
}

$datei = "/tmdata/btm/" . $url . "/spieltag.txt";
open( D9, "$datei" );
while (<D9>) {
	@ego = <D9>;
}
close(D9);

$hg    = "/tmdata/btm/" . $url . "/DAT";
$anton = "0";
if ( $liga > 9 ) { $anton = "" }
$beta = ".TXT";

$datei_data = $hg . $anton . $liga . $beta;
open( DO, $datei_data );
while (<DO>) {
	@quoten_row = <DO>;
}
close(DO);

$suche = '&' . $data[$verein] . '&';

open( D5, "/tmdata/btm/geschichte.txt" );
while (<D5>) {
	my @split = split( /&/, $_ );

	if ( $split[1] eq $data[$verein] ) {

		my $i = 0;
		my $t;
		foreach $t (@split) {
			if ( ( $i % 2 ) == 0 ) {
				$sai[ int( $i / 2 ) ] = $t;
			}
			if ( ( $i % 2 ) == 1 ) {
				$sat[ int( $i / 2 ) ] = $t;
			}
			$i++;

		}

		#print "Content-type:text/html\n\n";
		#print $_;

		#print "-. $sai[32]";

		if ( $sat[2] == 4 ) { $sat[2] = 5 }

		for ( $c = 1 ; $c <= $saison_aktuell ; $c++ ) {

			if ( $sat[$c] > 0 )   { $basis[$c]++ }
			if ( $sat[$c] > 1 )   { $basis[$c]++ }
			if ( $sat[$c] > 2 )   { $basis[$c]++ }
			if ( $sat[$c] > 4 )   { $basis[$c]++ }
			if ( $sat[$c] > 8 )   { $basis[$c]++ }
			if ( $sat[$c] > 16 )  { $basis[$c]++ }
			if ( $sat[$c] > 32 )  { $basis[$c]++ }
			if ( $sat[$c] > 64 )  { $basis[$c]++ }
			if ( $sat[$c] > 128 ) { $basis[$c]++ }
			if ( $sat[$c] > 256 ) { $basis[$c]++ }

			if ( $sat[2] == 4 ) { $basis[$c]++ }

		}
	}
}
close(D5);

$xx = $main_nr;
$sat[$main_nr] = $liga;
if ( $sat[$main_nr] > 0 )   { $basis[$xx]++ }
if ( $sat[$main_nr] > 1 )   { $basis[$xx]++ }
if ( $sat[$main_nr] > 2 )   { $basis[$xx]++ }
if ( $sat[$main_nr] > 4 )   { $basis[$xx]++ }
if ( $sat[$main_nr] > 8 )   { $basis[$xx]++ }
if ( $sat[$main_nr] > 16 )  { $basis[$xx]++ }
if ( $sat[$main_nr] > 32 )  { $basis[$xx]++ }
if ( $sat[$main_nr] > 64 )  { $basis[$xx]++ }
if ( $sat[$main_nr] > 128 ) { $basis[$xx]++ }
if ( $sat[$main_nr] > 256 ) { $basis[$xx]++ }

for ( $c = $saison_aktuell ; $c > 0 ; $c = $c - 1 ) {
	if ( $sat[$c] != 0 ) { $seit_saison = $c }
}
if ( $seit_saison < 5 ) { $seit_saison = 5 }
@saison = @main_saison;

# bloedmaenner, die geloescht werden wollen
if ( $datb[$verein] =~ /Bellagh/ ) {
	$datb[$verein] = "Entfernter Trainer";
}

print
"<html><title>Vereinsseite $data[$verein]  /  $liga_namen[$liga]</title><p align=left><body bgcolor=white text=black vlink=darkred link=darkred>\n";

#debug bpf 2023-02-27
#print "<div style=\"visibility:hidden\"> Debug: verein is $verein, liga is $liga, ident: $ident origve: $origve origident: |$origident| v2debug $ve2_debug li2debug $li2_debug </div>\n";


print '
<style type="text/css">
TD.r { text-align:right;padding-top:3px;padding-bottom:3px;padding-left:5px;padding-right:8pt;
font-family:Verdana; font-size:8pt; color:black; alignment: right; }
TD.r1 { padding-left:5px;padding-right:0px;font-family:Verdana; font-size:8pt; color:black; text-align:right; }
TD.r2 { padding-left:10px;padding-right:22px;font-family:Verdana; font-size:8pt; color:black; text-align:right; }
TD.c { padding-left:10px;padding-right:10px;font-family:Verdana; font-size:8pt; color:black; text-align:center; }
TD.l { padding-left:10px;padding-right:10px;font-family:Verdana; font-size:8pt; color:black; alignment: left; }
TD.d { text-align:middle;padding-bottom:8px; padding-left:10px;padding-right:10px;font-family:Verdana; font-size:8pt; color:black;  }
</style>
';

print "$banner_gross $banner_klein";
print "$location";
print "\n";

print "<script language=JavaScript>\n";
print "<!--\n";
print "function targetLink(URL)\n";
print "  {\n";
print "    if(document.images)\n";
print
"targetWin =open(URL,\"Neufenster\",\"scrollbars=yes,toolbar=no,directories=no,menubar=no,status=no,resizeable=yes,width=800,height=240\");\n";
print " }\n";
print "  //-->\n";
print "  </script>\n";
print "<p align=left>\n";

print
"<form name=tr method=post action=/cgi-mod/btm/trainer.pl target=_top><input type=hidden name=ident value=\"$datb[$verein]\"></form>\n";

print "
<form action=verein.pl method=post><input type=hidden name=ident value=\"$data[$verein]\">
 &nbsp; &nbsp; <select name=saison style=\"font-family:verdana;font-size=10px;\">
";
for ( $x = $seit_saison ; $x <= $main_nr ; $x++ ) {
	if ( $x == $ss_saison ) { $rre = " selected" }
	print "<option value=$x$rre>$main_saison[$x]\n";
	$rre = "";
}
print "</select>
&nbsp; &nbsp; <input type=submit value=\"Anzeigen\" style=\"font-family:verdana;font-size=10px;\"></form>

&nbsp;\n";

print
"<font face=verdana size=2>&nbsp;<b>Vereinsseite $data[$verein]  &nbsp;&nbsp; </b><font face=verdana size=1> <a href=tab.pl?li=$liga>$liga_namen[$liga]</a> &nbsp;&nbsp; / &nbsp;&nbsp;\n";
print "<font face=verdana size=2>&nbsp;<b>Trainer <a href=javascript:document.tr.submit()>$datb[$verein]</a></b>


<br>&nbsp;\n";

print "<table border=0><tr><td valign=top align=left>\n";

#print "<font face=verdana size=1>&nbsp;<u></u><br><br>";

print '
<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>
<table border=0 cellpadding=2 cellspacing=1>
';
print "
<tr><td align=center bgcolor=#DEDFEC colspan=6><font face=verdana size=1>Vereinshistorie $data[$verein]</td></tr>
";

for ( $c = $saison_aktuell ; $c > 0 ; $c = $c - 1 ) {
	if ( $sat[$c] != 0 ) {
		print "<tr>\n";
		print "<form name=u$c method=post action=/cgi-mod/btm/tab.pl target=_new>\n";
		print "<input type=hidden name=id value=\"$data[$verein]\">\n";
		print "<input type=hidden name=saison value=$c>\n";
		print "<input type=hidden name=li value=$sat[$c]>\n";
		if ( $c > 4 ) {
			print
"<td align=center bgcolor=#E6E8FC><font face=verdana size=1>&nbsp;<a href=javascript:document.u$c.submit()><img src=/img/h1.jpg alt=\"Archivtabelle $saison[$c]\" border=0></a>&nbsp;</td></form>\n";
		}
		else {
			print "<td bgcolor=#E6E8FC><font face=verdana size=1>&nbsp;</td>\n";
		}

		$color = "#eeeeff";
		if ( $ss_saison == $c ) { $color = "#DEDFEC" }
		print "<td align=lef bgcolor=$color><font face=verdana size=1>&nbsp;$saison[$c] &nbsp;</td>";
		print
"<td align=left bgcolor=$color><font face=verdana size=1>&nbsp;$liga_namen[$sat[$c]] &nbsp;&nbsp; &nbsp; </td>";
		$rr = "";
		if ( $sai[$c] < 10 ) { $rr = "0" }
		print "<td align=left bgcolor=#dddeff><font face=verdana size=1>&nbsp;&nbsp;Platz $rr$sai[$c]&nbsp;&nbsp;</td>";

		$d = $c + 1;
		if ( ( $ss_saison != $main_nr && $c == $saison_aktuell ) || ( $liga == 0 ) ) {
			print "<td align=center bgcolor=#cfd0e4><font face=verdana size=1>&nbsp;&nbsp; ? &nbsp; &nbsp; </td>";
		}
		else {
			if ( $basis[$c] > $basis[$d] ) {
				print
"<td align=center bgcolor=#cfd0e4><font face=verdana size=1>&nbsp;&nbsp;<img src=/img/pfeil+.gif border=0>&nbsp;&nbsp;</td>";
			}

			if ( $basis[$c] == $basis[$d] ) {

				if ( $sai[$c] == 1 && $sat[$c] == 1 ) {
					print
"<td align=center bgcolor=#cfd0e4><font face=verdana size=1>&nbsp;&nbsp;<img src=/img/pfeils.gif border=0>&nbsp;&nbsp;</td>";

				}
				else {
					print
"<td align=center bgcolor=#cfd0e4><font face=verdana size=1>&nbsp;&nbsp;<img src=/img/pfeil=.gif border=0>&nbsp;&nbsp;</td>";
				}

			}

			if ( $basis[$c] < $basis[$d] ) {
				print
"<td align=center bgcolor=#cfd0e4><font face=verdana size=1>&nbsp;&nbsp;<img src=/img/pfeil-.gif border=0>&nbsp;&nbsp;</td>";
			}
		}

		print "</tr>";
	}
}
print "</table></td></tr></table><br>";

print '
<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>
<table border=0 cellpadding=2 cellspacing=1>
';
print "
<tr><td align=center bgcolor=#DEDFEC colspan=5><font face=verdana size=1>Bisherige Trainer $data[$verein] seit 1999'1</td></tr>
";

open( D1, "</tmdata/btm/db/karriere.txt" );
while (<D1>) {
	if ( $_ =~ /$data[$verein]\!/ ) {
		$karriere = $_;
		chomp $karriere;
	}
}
close(D1);

@all = split( /#/, $karriere );
( $leer, $wechsel ) = split( /\!/, $all[0] );

for ( $x = 1 ; $x <= $wechsel ; $x++ ) {
	@bongo = split( /&/, $all[$x] );

	$saison_start = int( $bongo[0] / 34 ) + 1 + 5;
	$saison_ende  = int( $bongo[1] / 34 ) + 1 + 5;
	$aa           = $bongo[0] - ( int( $bongo[0] / 34 ) * 34 );
	$ab           = $bongo[1] - ( int( $bongo[1] / 34 ) * 34 );
	if ( $ab == 0 ) { $saison_ende-- }
	if ( $ab == 0 ) { $ab = 34 }
	if ( $bongo[2] ne "" ) {
		print "<tr>\n";

		$saison[$saison_start] =~ s/Saison//;
		$saison[$saison_ende] =~ s/Saison//;
		$ac = $bongo[2];
		$ac =~ s/ /%20/g;
		print
"<td align=lef bgcolor=#E6E8FC><font face=verdana size=1>&nbsp;Von $saison[$saison_start] | Sp. $aa &nbsp;</td>";
		print
"<td align=lef bgcolor=#E6E8FC><font face=verdana size=1>&nbsp;Bis $saison[$saison_ende] | Sp. $ab &nbsp;</td>";

		print
"<td align=lef bgcolor=#eeedff><font face=verdana size=1>&nbsp;<a href=/cgi-mod/btm/trainer.pl?ident=$ac><img src=/img/h1.jpg alt=\"Trainerprofil $bongo[2]\" border=0></a>&nbsp;&nbsp;$bongo[2] &nbsp;</td>";

		print "</tr>\n";
	}
}

print "</table></td></tr></table>";

print "</td><td>&nbsp;&nbsp;&nbsp;</td>";

print
"<td align=left valign=top><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;<u>Saisonverlauf $saison[$ss_saison]</u><br>";

$fa = 0;

for ( $spieltag = 0 ; $spieltag < 34 ; $spieltag++ ) {

	@ega = split( /&/, $ego[$spieltag] );

	chop $quoten_row[$spieltag];
	@quoten_zahl = split( /&/, $quoten_row[$spieltag] );

	for ( $x = 0 ; $x < 18 ; $x = $x + 2 ) {

		$tora = 0;
		$torb = 0;
		$y    = $x + 1;
		$wa   = $x - 1;
		$wb   = $y - 1;

		$ga = ($spieltag) / 4;
		$gb = $ga - int($ga);
		if ( $gb == 0.25 ) { $gc = 18 }
		if ( $gb == 0.5 )  { $gc = 36 }
		if ( $gb == 0.75 ) { $gc = 54 }
		if ( $gb == 0 )    { $gc = 0 }

		$gespielt[$spieltag] = 0;

		if ( $verein == $ega[$x] ) {
			$gegner[$spieltag] = $ega[$y];
			$ort[$spieltag]    = "H";
			$tip[$spieltag]    = $gc + $x + 1;
		}

		if ( $verein == $ega[$y] ) {
			$gegner[$spieltag] = $ega[$x];
			$ort[$spieltag]    = "A";
			$tip[$spieltag]    = $gc + $x + 1;
		}

		if ( $quoten_zahl[ $ega[$x] - 1 ] != "1" ) {

			$gespielt[$spieltag] = 1;

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

			if ( $verein == $ega[$x] ) {

				if ( $tora > $torb ) {

					$ser_gew++;
					$ser_ver  = 0;
					$ser_ngew = 0;
					$ser_nver++;

					$ser_hgew++;
					$ser_hver  = 0;
					$ser_hngew = 0;
					$ser_hnver++;

				}

				if ( $tora < $torb ) {

					$ser_gew = 0;
					$ser_ver++;
					$ser_ngew++;
					$ser_nver = 0;

					$ser_hgew = 0;
					$ser_hver++;
					$ser_hngew++;
					$ser_hnver = 0;

				}

				if ( $tora == $torb ) {

					$ser_gew = 0;
					$ser_ver = 0;
					$ser_ngew++;
					$ser_nver++;

					$ser_hgew = 0;
					$ser_hver = 0;
					$ser_hngew++;
					$ser_hnver++;

				}

				$tor_a[$spieltag] = $tora;
				$tor_b[$spieltag] = $torb;
				$qu_a[$spieltag]  = $quoten_zahl[ $ega[$x] - 1 ];
				$qu_b[$spieltag]  = $quoten_zahl[ $ega[$y] - 1 ];
			}

			if ( $verein == $ega[$y] ) {

				if ( $torb > $tora ) {

					$ser_gew++;
					$ser_ver  = 0;
					$ser_ngew = 0;
					$ser_nver++;

					$ser_agew++;
					$ser_aver  = 0;
					$ser_angew = 0;
					$ser_anver++;

				}

				if ( $torb < $tora ) {

					$ser_gew = 0;
					$ser_ver++;
					$ser_ngew++;
					$ser_nver = 0;

					$ser_agew = 0;
					$ser_aver++;
					$ser_angew++;
					$ser_anver = 0;

				}

				if ( $tora == $torb ) {

					$ser_gew = 0;
					$ser_ver = 0;
					$ser_ngew++;
					$ser_nver++;

					$ser_agew = 0;
					$ser_aver = 0;
					$ser_angew++;
					$ser_anver++;

				}

				$tor_a[$spieltag] = $torb;
				$tor_b[$spieltag] = $tora;
				$qu_a[$spieltag]  = $quoten_zahl[ $ega[$y] - 1 ];
				$qu_b[$spieltag]  = $quoten_zahl[ $ega[$x] - 1 ];

			}

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

	@plx = ();
	@tab = ();

	for ( $xy = 1 ; $xy < 19 ; $xy++ ) {
		$dat_td[$xy]  = $dat_tp[$xy] - $dat_tm[$xy];
		$dat_htd[$xy] = $dat_htp[$xy] - $dat_htm[$xy];
		$dat_atd[$xy] = $dat_atp[$xy] - $dat_atm[$xy];
		$dat_hpu[$xy] = ( $dat_hs[$xy] * 3 ) + ( $dat_hu[$xy] * 1 );
		$dat_apu[$xy] = ( $dat_as[$xy] * 3 ) + ( $dat_au[$xy] * 1 );

	}

	for ( $xx = 1 ; $xx < 19 ; $xx++ ) {

		for ( $yx = 1 ; $yx < 19 ; $yx++ ) {

			if ( $dat_gpu[$xx] < $dat_gpu[$yx] ) { $plx[$xx]++ }

			if ( $dat_gpu[$xx] == $dat_gpu[$yx] ) {

				if ( $dat_td[$xx] < $dat_td[$yx] ) { $plx[$xx]++ }
				if ( $dat_td[$xx] == $dat_td[$yx] ) {

					if ( $dat_tp[$xx] < $dat_tp[$yx] ) { $plx[$xx]++ }
					if ( $dat_tp[$xx] == $dat_tp[$yx] ) {

						if ( $xx > $yx )  { $plx[$xx]++ }
						if ( $xx == $yx ) { $plx[$xx]++ }
					}

				}
			}
		}

	}

	$plazierung[$spieltag] = $plx[$verein];

}

for ( $xx = $verein ; $xx < $verein + 1 ; $xx++ ) {
	for ( $yx = 1 ; $yx < 19 ; $yx++ )

	{

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
}

for ( $xx = $verein ; $xx < $verein + 1 ; $xx++ ) {
	for ( $yx = 1 ; $yx < 19 ; $yx++ )

	{

		if ( $dat_hpu[$xx] < $dat_hpu[$yx] ) { $pl2[$xx]++ }

		if ( $dat_hpu[$xx] == $dat_hpu[$yx] ) {

			if ( $dat_htd[$xx] < $dat_htd[$yx] ) { $pl2[$xx]++ }
			if ( $dat_htd[$xx] == $dat_htd[$yx] ) {

				if ( $dat_htp[$xx] < $dat_htp[$yx] ) { $pl2[$xx]++ }
				if ( $dat_htp[$xx] == $dat_htp[$yx] ) {

					if ( $xx > $yx )  { $pl2[$xx]++ }
					if ( $xx == $yx ) { $pl2[$xx]++ }
				}
			}
		}
	}
}

for ( $xx = $verein ; $xx < $verein + 1 ; $xx++ ) {
	for ( $yx = 1 ; $yx < 19 ; $yx++ )

	{

		if ( $dat_apu[$xx] < $dat_apu[$yx] ) { $pl3[$xx]++ }

		if ( $dat_apu[$xx] == $dat_apu[$yx] ) {

			if ( $dat_atd[$xx] < $dat_atd[$yx] ) { $pl3[$xx]++ }
			if ( $dat_atd[$xx] == $dat_atd[$yx] ) {

				if ( $dat_atp[$xx] < $dat_atp[$yx] ) { $pl3[$xx]++ }
				if ( $dat_atp[$xx] == $dat_atp[$yx] ) {

					if ( $xx > $yx )  { $pl3[$xx]++ }
					if ( $xx == $yx ) { $pl3[$xx]++ }
				}
			}
		}
	}
}

$xy = $verein;

if ( $dat_sp[$xy] > 0 ) {
	$xc = $dat_qu[$xy];
	$dat_qu[$xy] = ( int( ( $dat_qu[$xy] / $dat_sp[$xy] ) * 10 ) ) / 10;
	if ( int( $dat_qu[$xy] ) == ( $xc / $dat_sp[$xy] ) ) { $dat_qu_m[$xy] = ".0" }
}

if ( $dat_sp[$xy] > 0 ) {
	$xc = $dat_gqu[$xy];

	$dat_gqu[$xy] = ( int( ( $dat_gqu[$xy] / $dat_sp[$xy] ) * 10 ) ) / 10;
	if ( int( $dat_gqu[$xy] ) == ( $xc / $dat_sp[$xy] ) ) { $dat_gqu_m[$xy] = ".0" }
}

if ( $dat_hsp[$xy] > 0 ) {
	$xc = $dat_hqu[$xy];

	$dat_hqu[$xy] = ( int( ( $dat_hqu[$xy] / $dat_hsp[$xy] ) * 10 ) ) / 10;
	if ( int( $dat_hqu[$xy] ) == ( $xc / $dat_hsp[$xy] ) ) { $dat_hqu_m[$xy] = ".0" }
}

if ( $dat_hsp[$xy] > 0 ) {
	$xc = $dat_ghqu[$xy];

	$dat_ghqu[$xy] = ( int( ( $dat_ghqu[$xy] / $dat_hsp[$xy] ) * 10 ) ) / 10;
	if ( int( $dat_ghqu[$xy] ) == ( $xc / $dat_hsp[$xy] ) ) { $dat_ghqu_m[$xy] = ".0" }
}

if ( $dat_asp[$xy] > 0 ) {
	$xc = $dat_aqu[$xy];

	$dat_aqu[$xy] = ( int( ( $dat_aqu[$xy] / $dat_asp[$xy] ) * 10 ) ) / 10;
	if ( int( $dat_aqu[$xy] ) == ( $xc / $dat_asp[$xy] ) ) { $dat_aqu_m[$xy] = ".0" }
}

if ( $dat_asp[$xy] > 0 ) {
	$xc = $dat_gaqu[$xy];

	$dat_gaqu[$xy] = ( int( ( $dat_gaqu[$xy] / $dat_asp[$xy] ) * 10 ) ) / 10;
	if ( int( $dat_gaqu[$xy] ) == ( $xc / $dat_asp[$xy] ) ) { $dat_gaqu_m[$xy] = ".0" }
}

print "<br><TABLE cellpadding=0 cellspacing=0 border=0 bgcolor=white><tr>";
print "<tr><td></td><td colspan=34 align=right><img src=/img/tab88.gif border=0></td></tr><tr>\n";
print "<td><img src=/img/tab99.gif border=0></td>\n";
for ( $x = 0 ; $x <= 33 ; $x++ ) {

	$xx = "";
	if ( $plazierung[$x] < 10 ) { $xx = '0' }
	if ( $qu_a[$x] eq "" ) {
		$xx = '00';
		$plazierung[$x] = "";
	}
	$sp = $x + 1;
	print
"<td><img src=/img/tab$xx$plazierung[$x].gif width=10 heigth=180 alt=\"$sp. Spieltag / $plazierung[$x].Platz\" border=0></td>\n";
}
print "</tr></table></td></tr></table><br>\n";

print '
<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>
<table border=0 cellpadding=2 cellspacing=1>
';
print "
<tr><td align=center bgcolor=#DEDFEC colspan=7><font face=verdana size=1>Saisonbilanz $saison[$ss_saison] $data[$verein]</td></tr>
";

$l1 = "";
$l2 = "";
$l3 = "";
$l4 = "";
$l5 = "";

$dat_gs[$verein] = $dat_gs[$verein] * 1;
$dat_gu[$verein] = $dat_gu[$verein] * 1;
$dat_gn[$verein] = $dat_gn[$verein] * 1;
$dat_tp[$verein] = $dat_tp[$verein] * 1;
$dat_tm[$verein] = $dat_tm[$verein] * 1;

if ( $dat_gs[$verein] < 10 ) { $l1 = "0" }
if ( $dat_gu[$verein] < 10 ) { $l2 = "0" }
if ( $dat_gn[$verein] < 10 ) { $l3 = "0" }
if ( $dat_tp[$verein] < 10 ) { $l4 = "0" }
if ( $dat_tm[$verein] < 10 ) { $l5 = "0" }

print
"<TR><Td  bgcolor=#eeeeff align=left><font face=verdana size=1>&nbsp;&nbsp;Gesamtbilanz&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";
print
"<Td bgcolor=#eeeeff bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp; &nbsp;$dat_sp[$verein] Sp.&nbsp;&nbsp;</td>\n";
print
"<Td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;&nbsp;&nbsp;$l1$dat_gs[$verein] - $l2$dat_gu[$verein] - $l3$dat_gn[$verein]&nbsp;&nbsp; </td>\n";
print
"<Td bgcolor=#eeeeff align=right bgcolor=#eeeeee><font face=verdana size=1>&nbsp;&nbsp;&nbsp;$l4$dat_tp[$verein] : $l5$dat_tm[$verein] Tore &nbsp; &nbsp;</td>\n";
print
"<Td bgcolor=#eeeeff  align=right><font face=verdana size=1>&nbsp;&nbsp;&nbsp;$dat_gpu[$verein]&nbsp;&nbsp; Pkt. &nbsp; </TD>";

#print "<Td bgcolor=#eeeeff align=center><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$dat_qu[$verein]$dat_qu_m[$verein] - $dat_gqu[$verein]$dat_gqu_m[$verein] &nbsp; &nbsp; &nbsp; </td>\n";
print
"<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;&nbsp;&nbsp;$pl1[$verein]&nbsp;.&nbsp;Platz&nbsp;&nbsp;</td>";
print "</tr>";

$l1 = "";
$l2 = "";
$l3 = "";
$l4 = "";
$l5 = "";

$dat_hs[$verein]  = $dat_hs[$verein] * 1;
$dat_hu[$verein]  = $dat_hu[$verein] * 1;
$dat_hn[$verein]  = $dat_hn[$verein] * 1;
$dat_htp[$verein] = $dat_htp[$verein] * 1;
$dat_htm[$verein] = $dat_htm[$verein] * 1;

if ( $dat_hs[$verein] < 10 ) { $l1 = "0" }
if ( $dat_hu[$verein] < 10 ) { $l2 = "0" }
if ( $dat_hn[$verein] < 10 ) { $l3 = "0" }
if ( $dat_tp[$verein] < 10 ) { $l4 = "0" }
if ( $dat_tm[$verein] < 10 ) { $l5 = "0" }

print
  "<TR><Td  bgcolor=#eeeeff align=left><font face=verdana size=1>&nbsp;&nbsp;Heimbilanz&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";
print
"<Td bgcolor=#eeeeff bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp; &nbsp;$dat_hsp[$verein] Sp.&nbsp;&nbsp;</td>\n";
print
"<Td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;&nbsp;&nbsp;$l1$dat_hs[$verein] - $l2$dat_hu[$verein] - $l3$dat_hn[$verein]&nbsp;&nbsp; </td>\n";
print
"<Td bgcolor=#eeeeff align=right bgcolor=#eeeeee><font face=verdana size=1>&nbsp;&nbsp;&nbsp;$l4$dat_htp[$verein] : $l5$dat_htm[$verein] Tore &nbsp; &nbsp;</td>\n";
print
"<Td bgcolor=#eeeeff  align=right><font face=verdana size=1>&nbsp;&nbsp;&nbsp;$dat_hpu[$verein]&nbsp;&nbsp; Pkt. &nbsp; </TD>";

#print "<Td bgcolor=#eeeeff align=center><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$dat_hqu[$verein]$dat_hqu_m[$verein] - $dat_hqu[$verein]$dat_hqu_m[$verein] &nbsp; &nbsp; &nbsp; </td>\n";
print
"<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;&nbsp;&nbsp;$pl2[$verein]&nbsp;.&nbsp;Platz&nbsp;&nbsp;</td>";
print "</tr>";

$l1 = "";
$l2 = "";
$l3 = "";
$l4 = "";
$l5 = "";

$dat_as[$verein]  = $dat_as[$verein] * 1;
$dat_au[$verein]  = $dat_au[$verein] * 1;
$dat_an[$verein]  = $dat_an[$verein] * 1;
$dat_atp[$verein] = $dat_atp[$verein] * 1;
$dat_atm[$verein] = $dat_atm[$verein] * 1;

if ( $dat_as[$verein] < 10 )  { $l1 = "0" }
if ( $dat_au[$verein] < 10 )  { $l2 = "0" }
if ( $dat_an[$verein] < 10 )  { $l3 = "0" }
if ( $dat_atp[$verein] < 10 ) { $l4 = "0" }
if ( $dat_atm[$verein] < 10 ) { $l5 = "0" }

print
"<TR><Td  bgcolor=#eeeeff align=left><font face=verdana size=1>&nbsp;&nbsp;Auswaertsbilanz&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";
print
"<Td bgcolor=#eeeeff bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp; &nbsp;$dat_asp[$verein] Sp.&nbsp;&nbsp;</td>\n";
print
"<Td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;&nbsp;&nbsp;$l1$dat_as[$verein] - $l2$dat_au[$verein] - $l3$dat_an[$verein]&nbsp;&nbsp; </td>\n";
print
"<Td bgcolor=#eeeeff align=right bgcolor=#eeeeee><font face=verdana size=1>&nbsp;&nbsp;&nbsp;$l4$dat_atp[$verein] : $l5$dat_atm[$verein] Tore &nbsp; &nbsp;</td>\n";
print
"<Td bgcolor=#eeeeff  align=right><font face=verdana size=1>&nbsp;&nbsp;&nbsp;$dat_apu[$verein]&nbsp;&nbsp; Pkt. &nbsp; </TD>";

#print "<Td bgcolor=#eeeeff align=center><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$dat_aqu[$verein]$dat_aqu_m[$verein] - $dat_aqu[$verein]$dat_aqu_m[$verein] &nbsp; &nbsp; &nbsp; </td>\n";
print
"<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;&nbsp;&nbsp;$pl3[$verein]&nbsp;.&nbsp;Platz&nbsp;&nbsp;</td>";
print "</tr>";

print "</table></td></tr></table><br>";

my $vor = 0;
print '
<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>
<table border=0 cellpadding=2 cellspacing=1>
';
print "
<tr><td align=center bgcolor=#DEDFEC colspan=7><font face=verdana size=1> &nbsp; &nbsp; Aktuelle Serien $data[$verein] &nbsp; &nbsp; </td></tr>
";

if ( $ser_gew > 3 ) {
	$vor = 1;
	print
"<tr><td  bgcolor=#eeeeff align=left><font face=verdana size=1>&nbsp;&nbsp;$ser_gew Spiele in Folge gewonnen&nbsp;&nbsp;</td></tr>\n";
}
if ( $ser_ngew > 3 ) {
	$vor = 1;
	print
"<tr><td  bgcolor=#eeeeff align=left><font face=verdana size=1>&nbsp;&nbsp;$ser_ngew Spiele in Folge ohne Sieg&nbsp;&nbsp;</td></tr>\n";
}
if ( $ser_ver > 3 ) {
	$vor = 1;
	print
"<tr><td  bgcolor=#eeeeff align=left><font face=verdana size=1>&nbsp;&nbsp;$ser_ver Spiele in Folge verloren&nbsp;&nbsp;</td></tr>\n";
}
if ( $ser_nver > 3 ) {
	$vor = 1;
	print
"<tr><td  bgcolor=#eeeeff align=left><font face=verdana size=1>&nbsp;&nbsp;$ser_nver Spiele in Folge ungeschlagen&nbsp;&nbsp;</td></tr>\n";
}

if ( $ser_hgew > 3 ) {
	$vor = 1;
	print
"<tr><td  bgcolor=#eeeeff align=left><font face=verdana size=1>&nbsp;&nbsp;$ser_hgew Spiele zu Hause in Folge gewonnen&nbsp;&nbsp;</td></tr>\n";
}
if ( $ser_hngew > 3 ) {
	$vor = 1;
	print
"<tr><td  bgcolor=#eeeeff align=left><font face=verdana size=1>&nbsp;&nbsp;$ser_hngew Spiele zu Hause in Folge ohne Sieg&nbsp;&nbsp;</td></tr>\n";
}
if ( $ser_hver > 3 ) {
	$vor = 1;
	print
"<tr><td  bgcolor=#eeeeff align=left><font face=verdana size=1>&nbsp;&nbsp;$ser_hver Spiele zu Hause in Folge verloren&nbsp;&nbsp;</td></tr>\n";
}
if ( $ser_hnver > 3 ) {
	$vor = 1;
	print
"<tr><td bgcolor=#eeeeff  align=left><font face=verdana size=1>&nbsp;&nbsp;$ser_hnver Spiele zu Hause in Folge ungeschlagen&nbsp;&nbsp;</td></tr>\n";
}

if ( $ser_agew > 3 ) {
	$vor = 1;
	print
"<tr><td bgcolor=#eeeeff  align=left><font face=verdana size=1>&nbsp;&nbsp;$ser_agew Spiele auswaerts in Folge gewonnen&nbsp;&nbsp;</td></tr>\n";
}
if ( $ser_angew > 3 ) {
	$vor = 1;
	print
"<tr><td bgcolor=#eeeeff  align=left><font face=verdana size=1>&nbsp;&nbsp;$ser_angew Spiele auswaerts in Folge ohne Sieg&nbsp;&nbsp;</td></tr>\n";
}
if ( $ser_aver > 3 ) {
	$vor = 1;
	print
"<tr><td bgcolor=#eeeeff  align=left><font face=verdana size=1>&nbsp;&nbsp;$ser_aver Spiele auswaerts in Folge verloren&nbsp;&nbsp;</td></tr>\n";
}
if ( $ser_anver > 3 ) {
	$vor = 1;
	print
"<tr><td bgcolor=#eeeeff  align=left><font face=verdana size=1>&nbsp;&nbsp;$ser_anver Spiele auswaerts in Folge ungeschlagen&nbsp;&nbsp;</td></tr>\n";
}

if ( $vor == 0 ) {
	print
"<tr><td bgcolor=#eeeeff align=center><font face=verdana size=1>&nbsp;&nbsp;Keine Serien vorhanden&nbsp;&nbsp;</td></tr>";
}
print "</table></td></tr></table><br>";

print "<br><font face=verdana size=2>&nbsp; &nbsp; <b>Spielplan $saison[$ss_saison] $data[$verein]</b><br><br>";

$fa = 0;
print "<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0>";
print "<tr>\n";
print "<td colspan=10 bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
$rg = 0;
for ( $spieltag = 0 ; $spieltag < 34 ; $spieltag++ ) {

	$rg++;
	if ( $rg == 5 ) { $rg = 1 }

	$fa = $fa + 1;
	if ( $fa == 3 ) { $fa    = 1 }
	if ( $fa == 1 ) { $farbe = "white" }
	if ( $fa == 2 ) { $farbe = "#eeeeee" }

	$xx = $start + 1;

	my $tmp = "";
	open( D1, "</tmdata/btm/db/head2head/$gl_vereinsid{$data[$verein]}.txt" );
	while (<D1>) {
		my @sal = split( /\!/, $_ );
		if ( $sal[0] == $gl_vereinsid{ $data[ $gegner[$spieltag] ] } ) {
			$tmp = $_;
		}
	}
	close(D1);

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

	print "<TR BGCOLOR=$farbe>";
	$rr = $spieltag + 1;
	$rf = "0";
	if ( $rr > 9 ) { $rf = "" }
	print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
	print "<TD class=c>Sp. $rf$rr &nbsp; &nbsp; $ort[$spieltag]</td> \n";
	print
"<TD class=l><a href=/cgi-mod/btm/verein.pl?li=$liga&ve=$gegner[$spieltag]><img src=/img/h1.jpg border=0></a>&nbsp; $data[$gegner[$spieltag]]</td> \n";
	$rf = "0";
	if ( $plx[ $gegner[$spieltag] ] > 9 ) { $rf = "" }
	print "<TD class=r>( $rf$plx[$gegner[$spieltag]].)</td> \n";
	print "<TD class=c>$tor_a[$spieltag] : $tor_b[$spieltag]</td> \n";
	print "<TD class=c>[ $qu_a[$spieltag] - $qu_b[$spieltag] ]</td> \n";
	$ss = $spieltag + 1;

	if ( $main_nr == $ss_saison ) {
		print
"<TD class=c><a href=/cgi-mod/btm/tips.pl?li=$liga&sp=$ss&ve=$tip[$spieltag] target\"_blank\" onClick=\"targetLink('/cgi-mod/btm/tips.pl?li=$liga&sp=$ss&ve=$tip[$spieltag]');return false\"><IMG SRC=/img/ti.jpg BORDER=0></A></td> \n";
	}
	else {

		print "<TD class=c>&nbsp;</td>";
	}

	print "<TD class=r>$plazierung[$spieltag]. Rang</td> \n";
	print "<td class=r> &nbsp; Bilanz:</td>";
	print
"<td class=r >  <a href=/cgi-bin/head2head.pl?loc=btm&id1=$gl_vereinsid{$data[$verein]}&id2=$gl_vereinsid{$data[$gegner[$spieltag]]} target=bilanz>$return[0] - $return[1] - $return[2]</a> &nbsp; &nbsp; ";
	print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
	print "</tr>";

	if ( $rg == 4 ) {
		print "<tr>\n";
		print "<td bgcolor=black colspan=10><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
		print "</TR>\n";
	}

}

print "<tr>\n";
print "<td bgcolor=black colspan=10><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
print "</table>$banner_bottom
$page_footer
</html>";

exit;

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

