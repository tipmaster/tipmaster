#!/usr/bin/perl

=head1 NAME
	TMI tips.pl

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

my $coc               = "";
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
my $verein1           = "";
my $verein2           = "";
my $fs                = "";
my $fars              = "";
my $jo                = "";
my @iaa               = ();
my @iab               = ();
my $ros1              = "";
my $ros2              = "";
my @flagge            = ();
my $r                 = "";
my $flag              = "";
my $url               = "";
my $vv                = "";

my @main_flags = (
	"uefa.gif",    "tip_ger.gif", "tip_ger.gif", "tip_eng.gif", "tip_fra.gif", "tip_ita.gif",
	"tip_swi.gif", "tip_aut.gif", "tip_spa.gif", "tip_no.gif",  "tip_swe.gif", "tip_nor.gif",
	"tip_fin.gif", "tip_den.gif", "tip_ned.gif", "tip_sco.gif", "flag_wm.gif", "tip_ger.gif",
	"tip_rus.gif", "tip_por.gif", "tip_irl.gif"
);

$main_flags[34] = "tip_kor.gif";
$main_flags[35] = "tip_wru.gif";

use lib qw{/tmapp/tmsrc/cgi-bin};
use Test;
use CGI qw/:standard/;
use CGI::Cookie;

my $mlib         = new Test;
my $banner_gross = $mlib->banner_gross();
my $banner_bottom = $mlib->banner_bottom();
my $banner_klein = $mlib->banner_klein();

$query      = new CGI;
$spielrunde = $query->param('sp');
$paar       = $query->param('ve');
$liga       = $query->param('li');
$verein1    = $query->param('ve1');
$verein2    = $query->param('ve2');

$fs = "";

$fars = $spielrunde;

if ( $liga < 10 ) { $fs = "0" }

if ( $paar > 0 )  { $jo = $paar }
if ( $paar > 18 ) { $jo = ( $paar - 18 ) }
if ( $paar > 36 ) { $jo = ( $paar - 36 ) }
if ( $paar > 54 ) { $jo = ( $paar - 54 ) }

if ( $paar > 18 ) { $fars = $spielrunde + 0 }
if ( $paar > 36 ) { $fars = $spielrunde + 0 }
if ( $paar > 54 ) { $fars = $spielrunde + 0 }

$ro    = "x";
$suche = $ro . $fs . $liga . '&';

$fgh = int( ( $spielrunde + 3 ) / 4 );
$lok = "";
$lo  = $liga;
if ( $lo < 10 ) { $lok = "0" }

$bv           = "/tmdata/tmi/tipos/QU";
$txt          = ".TXT";
$rtz          = "S";
$datei_quoten = $bv . $lok . $lo . $rtz . $fgh . $txt;

open( DO, "/tmdata/tmi/spieltag.txt" );
while (<DO>) {
	@iaa = <DO>;
}
close(DO);

@iab = split( /&/, $iaa[ $fars - 1 ] );

$ros1 = $iab[ $jo - 1 ];
$ros2 = $iab[$jo];

$bx = "/tmdata/tmi/formular";
$by = int( ( $spielrunde - 1 ) / 4 );
$by++;
$bv         = ".txt";
$datei_hier = $bx . $by . $bv;

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

	if ( $ergebnis[$y] == 4 ) {
		$qu_1[$y] = 10;
		$qu_0[$y] = 10;
		$qu_2[$y] = 10;
	}

}

#open(D2,"/tmdata/tmi/history.txt");
#while(<D2>) {

#if ($_ =~ /$suche/) {
#@fereine = split (/&/, $_);
#}

#}
#close(D2);

#$y = 0;
#for ( $x = 1; $x < 19; $x++ )
#{
#$y++;
#chomp $fereine[$y];
#$data[$x] = $fereine[$y];
#$y++;
#chomp $fereine[$y];
#$datb[$x] = $fereine[$y];
#$y++;
#chomp $fereine[$y];
#$datc[$x] = $fereine[$y];
#}

open( DO, $datei_quoten );
while (<DO>) {
	@tips = <DO>;

}
close(DO);

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
	if ( ( $pro1[$x] == 1 ) and ( $ergebnis[ $sp1[$x] ] == 1 ) ) { $su_1 = $su_1 + $qu_1[ $sp1[$x] ] }
	if ( ( $pro1[$x] == 2 ) and ( $ergebnis[ $sp1[$x] ] == 2 ) ) { $su_1 = $su_1 + $qu_0[ $sp1[$x] ] }
	if ( ( $pro1[$x] == 3 ) and ( $ergebnis[ $sp1[$x] ] == 3 ) ) { $su_1 = $su_1 + $qu_2[ $sp1[$x] ] }
	if ( ( $pro1[$x] == 1 ) and ( $ergebnis[ $sp1[$x] ] == 4 ) ) { $su_1 = $su_1 + 10 }
	if ( ( $pro1[$x] == 2 ) and ( $ergebnis[ $sp1[$x] ] == 4 ) ) { $su_1 = $su_1 + 10 }
	if ( ( $pro1[$x] == 3 ) and ( $ergebnis[ $sp1[$x] ] == 4 ) ) { $su_1 = $su_1 + 10 }

	if ( ( $pro2[$x] == 1 ) and ( $ergebnis[ $sp2[$x] ] == 1 ) ) { $su_2 = $su_2 + $qu_1[ $sp2[$x] ] }
	if ( ( $pro2[$x] == 2 ) and ( $ergebnis[ $sp2[$x] ] == 2 ) ) { $su_2 = $su_2 + $qu_0[ $sp2[$x] ] }
	if ( ( $pro2[$x] == 3 ) and ( $ergebnis[ $sp2[$x] ] == 3 ) ) { $su_2 = $su_2 + $qu_2[ $sp2[$x] ] }
	if ( ( $pro2[$x] == 1 ) and ( $ergebnis[ $sp2[$x] ] == 4 ) ) { $su_2 = $su_2 + 10 }
	if ( ( $pro2[$x] == 2 ) and ( $ergebnis[ $sp2[$x] ] == 4 ) ) { $su_2 = $su_2 + 10 }
	if ( ( $pro2[$x] == 3 ) and ( $ergebnis[ $sp2[$x] ] == 4 ) ) { $su_2 = $su_2 + 10 }

}

if ( $su_1 > 14 )  { $tora = 1 }
if ( $su_1 > 39 )  { $tora = 2 }
if ( $su_1 > 59 )  { $tora = 3 }
if ( $su_1 > 79 )  { $tora = 4 }
if ( $su_1 > 104 ) { $tora = 5 }
if ( $su_1 > 129 ) { $tora = 6 }
if ( $su_1 > 154 ) { $tora = 7 }

if ( $su_2 > 14 )  { $torb = 1 }
if ( $su_2 > 39 )  { $torb = 2 }
if ( $su_2 > 59 )  { $torb = 3 }
if ( $su_2 > 79 )  { $torb = 4 }
if ( $su_2 > 104 ) { $torb = 5 }
if ( $su_2 > 129 ) { $torb = 6 }
if ( $su_2 > 154 ) { $torb = 7 }

if ( $tora == 0 ) { $tora = 0 }
if ( $torb == 0 ) { $torb = 0 }

print "Content-Type: text/html \n\n";
print
"<html><title>Tipabgabe $verein1 - $verein2</title><body bgcolor=#eeeeee text=black vlink=blue link=blue><font face=verdana size=1><center>\n";

#require "/tmapp/tmsrc/cgi-bin/tag.pl" ;
#require "/tmapp/tmsrc/cgi-bin/tag_small.pl" ;

#print "$banner_gross $banner_klein";

print "<br><br>\n";

if ( $pro1[1] == 0 ) {
	print
"<center><br><font face=verdana size=2><b>Die beiden Tipabgaben fuer dieses Spiel sind noch<br>nicht erfolgt bzw. noch nicht zur Einsicht freigegeben.<br><br><font color=darkred> Die Tipabgaben der aktuellen Spielrunde sind<br>ab Freitags 18.oo Uhr hier einsehbar.</b><br><br>";
	print "<form name=d1 action=/cgi-bin/tmi/form.pl method=post target=new>\n";
	print "</form>\n";
	print
"<br><br><font face=verdana size=1><a href=javascript:document.d1.submit()>Anstosszeiten der Paarungen des aktuellen Tipformulars</a></b>\n";

	exit;
}

print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=#eeeeee><tr>\n";
print
"<td></td><td bgcolor=white><font face=verdana size=1 color=#390505>&nbsp;&nbsp;$verein1</font></td><td bgcolor=white>&nbsp;</td><td align=right bgcolor=white><font face=verdana size=1>$tora &nbsp;</td><td bgcolor=white>&nbsp</td><td></td><td bgcolor=white><font face=verdana size=1 color=4E2F2F>&nbsp;&nbsp;$verein2</td><td bgcolor=white>&nbsp;</td><td align=right bgcolor=white><font face=verdana size=1>$torb &nbsp;</td><td bgcolor=white>&nbsp;</td></tr>\n";
print "<tr><td align=left valign=top><font face=verdana size=1><img src=/img/tips.JPG><br>";
for ( $x = 1 ; $x < 6 ; $x++ ) {
	my $coc = "red";
	if ( ( $pro1[$x] == 1 ) and ( $ergebnis[ $sp1[$x] ] == 0 ) ) { $r = "k1";  $coc = "black"; }
	if ( ( $pro1[$x] == 2 ) and ( $ergebnis[ $sp1[$x] ] == 0 ) ) { $r = "k0";  $coc = "black"; }
	if ( ( $pro1[$x] == 3 ) and ( $ergebnis[ $sp1[$x] ] == 0 ) ) { $r = "k2";  $coc = "black"; }
	if ( ( $pro1[$x] == 1 ) and ( $ergebnis[ $sp1[$x] ] == 1 ) ) { $r = "k11"; $coc = "green"; }
	if ( ( $pro1[$x] == 2 ) and ( $ergebnis[ $sp1[$x] ] == 2 ) ) { $r = "k00"; $coc = "green"; }
	if ( ( $pro1[$x] == 3 ) and ( $ergebnis[ $sp1[$x] ] == 3 ) ) { $r = "k22"; $coc = "green"; }
	if ( ( $pro1[$x] == 1 ) and ( $ergebnis[ $sp1[$x] ] == 3 ) ) { $r = "k12" }
	if ( ( $pro1[$x] == 2 ) and ( $ergebnis[ $sp1[$x] ] == 3 ) ) { $r = "k02" }
	if ( ( $pro1[$x] == 3 ) and ( $ergebnis[ $sp1[$x] ] == 2 ) ) { $r = "k20" }
	if ( ( $pro1[$x] == 1 ) and ( $ergebnis[ $sp1[$x] ] == 2 ) ) { $r = "k10" }
	if ( ( $pro1[$x] == 2 ) and ( $ergebnis[ $sp1[$x] ] == 1 ) ) { $r = "k01" }
	if ( ( $pro1[$x] == 3 ) and ( $ergebnis[ $sp1[$x] ] == 1 ) ) { $r = "k21" }
	if ( ( $pro1[$x] == 1 ) and ( $ergebnis[ $sp1[$x] ] == 4 ) ) { $r = "k1102" }
	if ( ( $pro1[$x] == 2 ) and ( $ergebnis[ $sp1[$x] ] == 4 ) ) { $r = "k0102" }
	if ( ( $pro1[$x] == 3 ) and ( $ergebnis[ $sp1[$x] ] == 4 ) ) { $r = "k2102" }

	if ( $pro1[$x] == 0 ) { $r = "k102" }

	print "<img src=/img/$r.JPG><br>\n";
}
print "</font></td>\n";
print
"<td align=left valign=middle width=250 nowrap=nowrap><font face=verdana size=1><img src=/img/loch.JPG border=0><br>\n";
for ( $x = 1 ; $x < 6 ; $x++ ) {

	$flag = $main_flags[ $flagge[ $sp1[$x] ] ];

	print
"&nbsp;&nbsp;&nbsp;&nbsp;<img width=14 height=10 src=/img/$flag border=0>&nbsp;&nbsp;&nbsp;&nbsp;$paarung[$sp1[$x]]<br>\n";

}
print "</font>\n";
for ( $x = 1 ; $x < 6 ; $x++ ) {

	( $verein1, $verein2 ) = split( / \- /, $paarung[ $sp1[$x] ] );
	$verein1 =~ s/  //g;
	$verein2 =~ s/  //g;
	if ( $flagge[ $sp1[$x] ] == 1 ) { $vv = "ger1" }
	if ( $flagge[ $sp1[$x] ] == 2 ) { $vv = "ger2" }
	if ( $flagge[ $sp1[$x] ] == 3 ) { $vv = "eng0" }
	if ( $flagge[ $sp1[$x] ] == 4 ) { $vv = "fre0" }
	if ( $flagge[ $sp1[$x] ] == 5 ) { $vv = "ita0" }

	print
"<form target=new_live method=post target=new name=xr$x><input type=hidden name=verein1 value=\"$verein1\"><input type=hidden name=index value=\"$vv\"><input type=hidden name=verein2 value=\"$verein2\"></form>\n";
}

print "</td>\n";
print
"<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td nowrap=nowrap align=left valign=top><font face=verdana size=1><img src=/img/loch.JPG><br>\n";

for ( $x = 1 ; $x < 6 ; $x++ ) {

	if ( $pro1[$x] == $ergebnis[ $sp1[$x] ] ) { $r = "black" }
	if ( $pro1[$x] != $ergebnis[ $sp1[$x] ] ) { $r = "silver" }
	if ( $ergebnis[ $sp1[$x] ] == 4 )         { $r = "black" }

	if ( $ergebnis[ $sp1[$x] ] == 0 ) { $r = "gray" }

	if ( $ergebnis[ $sp1[$x] ] == 4 ) { $qu_1[ $sp1[$x] ] = 10 }
	if ( $ergebnis[ $sp1[$x] ] == 4 ) { $qu_0[ $sp1[$x] ] = 10 }
	if ( $ergebnis[ $sp1[$x] ] == 4 ) { $qu_2[ $sp1[$x] ] = 10 }

	print "<font color=$r>\n";

	if ( $pro1[$x] == 1 ) { print "&nbsp;&nbsp; $qu_1[$sp1[$x]] &nbsp;</font><br>\n" }
	if ( $pro1[$x] == 2 ) { print "&nbsp;&nbsp; $qu_0[$sp1[$x]] &nbsp;</font><br>\n" }
	if ( $pro1[$x] == 3 ) { print "&nbsp;&nbsp; $qu_2[$sp1[$x]] &nbsp;</font><br>\n" }
	if ( $pro1[$x] == 0 ) { print "<font face=verdana color=black size=1>&nbsp;&nbsp;&nbsp;**</font><br>\n" }
}
print "</font></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";
print "<td align=left valign=top><font face=verdana size=1><img src=/img/tips.JPG><br>\n";
for ( $x = 1 ; $x < 6 ; $x++ ) {
	if ( ( $pro2[$x] == 1 ) and ( $ergebnis[ $sp2[$x] ] == 0 ) ) { $r = "k1" }
	if ( ( $pro2[$x] == 2 ) and ( $ergebnis[ $sp2[$x] ] == 0 ) ) { $r = "k0" }
	if ( ( $pro2[$x] == 3 ) and ( $ergebnis[ $sp2[$x] ] == 0 ) ) { $r = "k2" }
	if ( ( $pro2[$x] == 1 ) and ( $ergebnis[ $sp2[$x] ] == 1 ) ) { $r = "k11" }
	if ( ( $pro2[$x] == 2 ) and ( $ergebnis[ $sp2[$x] ] == 2 ) ) { $r = "k00" }
	if ( ( $pro2[$x] == 3 ) and ( $ergebnis[ $sp2[$x] ] == 3 ) ) { $r = "k22" }
	if ( ( $pro2[$x] == 1 ) and ( $ergebnis[ $sp2[$x] ] == 3 ) ) { $r = "k12" }
	if ( ( $pro2[$x] == 2 ) and ( $ergebnis[ $sp2[$x] ] == 3 ) ) { $r = "k02" }
	if ( ( $pro2[$x] == 3 ) and ( $ergebnis[ $sp2[$x] ] == 2 ) ) { $r = "k20" }
	if ( ( $pro2[$x] == 1 ) and ( $ergebnis[ $sp2[$x] ] == 2 ) ) { $r = "k10" }
	if ( ( $pro2[$x] == 2 ) and ( $ergebnis[ $sp2[$x] ] == 1 ) ) { $r = "k01" }
	if ( ( $pro2[$x] == 3 ) and ( $ergebnis[ $sp2[$x] ] == 1 ) ) { $r = "k21" }
	if ( ( $pro2[$x] == 1 ) and ( $ergebnis[ $sp2[$x] ] == 4 ) ) { $r = "k1102" }
	if ( ( $pro2[$x] == 2 ) and ( $ergebnis[ $sp2[$x] ] == 4 ) ) { $r = "k0102" }
	if ( ( $pro2[$x] == 3 ) and ( $ergebnis[ $sp2[$x] ] == 4 ) ) { $r = "k2102" }
	if ( $pro2[$x] == 0 ) { $r = "k102" }

	print "<img src=/img/$r.JPG><br>\n";
}
print "</font></td>\n";
print
"<td align=left valign=middle width=250 nowrap=nowrap><font face=verdana size=1><img src=/img/loch.JPG border=0><br><font color=black>\n";
for ( $x = 1 ; $x < 6 ; $x++ ) {

	$flag = $main_flags[ $flagge[ $sp2[$x] ] ];

	if ( $sp2[$x] == 0 ) { ( $flag = "tip_leer.jpg" ) }

	print
"&nbsp;&nbsp;&nbsp;&nbsp;<img width=14 height=10 src=/img/$flag border=0>&nbsp;&nbsp;&nbsp;&nbsp;$paarung[$sp2[$x]]<br>\n";

}

print "</font>\n";
for ( $x = 1 ; $x < 6 ; $x++ ) {

	( $verein1, $verein2 ) = split( / \- /, $paarung[ $sp2[$x] ] );
	$verein1 =~ s/  //g;
	$verein2 =~ s/  //g;
	if ( $flagge[ $sp2[$x] ] == 1 ) { $vv = "ger1" }
	if ( $flagge[ $sp2[$x] ] == 2 ) { $vv = "ger2" }
	if ( $flagge[ $sp2[$x] ] == 3 ) { $vv = "eng0" }
	if ( $flagge[ $sp2[$x] ] == 4 ) { $vv = "fre0" }
	if ( $flagge[ $sp2[$x] ] == 5 ) { $vv = "ita0" }

	print
"<form target=new_live  method=post target=new name=xs$x><input type=hidden name=verein1 value=\"$verein1\"><input type=hidden name=index value=\"$vv\"><input type=hidden name=verein2 value=\"$verein2\"></form>\n";
}

print "</td>\n";
print
"<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td align=left valign=top nowrap=nowrap><font face=verdana size=1><img src=/img/loch.JPG><br>\n";

for ( $x = 1 ; $x < 6 ; $x++ ) {

	if ( $pro2[$x] == $ergebnis[ $sp2[$x] ] ) { $r = "black" }
	if ( $pro2[$x] != $ergebnis[ $sp2[$x] ] ) { $r = "silver" }
	if ( $ergebnis[ $sp2[$x] ] == 4 )         { $r = "black" }

	if ( $ergebnis[ $sp2[$x] ] == 0 ) { $r = "gray" }

	print "<font color=$r>\n";

	if ( $ergebnis[ $sp2[$x] ] == 4 ) { $qu_1[ $sp2[$x] ] = 10 }
	if ( $ergebnis[ $sp2[$x] ] == 4 ) { $qu_0[ $sp2[$x] ] = 10 }
	if ( $ergebnis[ $sp2[$x] ] == 4 ) { $qu_2[ $sp2[$x] ] = 10 }

	if ( $pro2[$x] == 1 ) { print "&nbsp;&nbsp; $qu_1[$sp2[$x]] &nbsp;</font><br>\n" }
	if ( $pro2[$x] == 2 ) { print "&nbsp;&nbsp; $qu_0[$sp2[$x]] &nbsp;</font><br>\n" }
	if ( $pro2[$x] == 3 ) { print "&nbsp;&nbsp; $qu_2[$sp2[$x]] &nbsp;</font><br>\n" }
	if ( $pro2[$x] == 0 ) { print "<font face=verdana color=black size=1>&nbsp;&nbsp;&nbsp;**</font><br>\n" }
}

print "</font></td></tr><tr><td></td><td></td><td></td><td bgcolor=#000000><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
print "<td></td><td></td><td></td><td></td><td bgcolor=#000000><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr>\n";
print
"<tr><td></td><td></td><td></td><td align=right><font face=verdana size=1>$su_1&nbsp;&nbsp;</td><td></td><td></td><td></td><td></td>\n";
print "<td align=right><font face=verdana size=1>$su_2&nbsp;&nbsp;</td></tr></table>\n";
print "<form name=d1 action=/cgi-bin/tmi/form.pl method=post target=new>\n";
print "<input type=hidden name=spielrunde value=$spielrunde></form>\n";
print
"<font face=verdana size=2><b><a href=javascript:document.d1.submit()>Ergebnisse und Anstosszeiten der Tipformular Paarungen</a></b>\n";
print $banner_bottom;
print '<!-- Google Tag Manager -->
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-KX6R92"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':
new Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=
\'//www.googletagmanager.com/gtm.js?id=\'+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,\'script\',\'dataLayer\',\'GTM-KX6R92\');</script>
<!-- End Google Tag Manager -->
';
exit;

