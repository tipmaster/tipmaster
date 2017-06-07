#!/usr/bin/perl

=head1 NAME
	BTM pokal_show.pl

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
my $session = TMSession::getSession(btm_login => 1);
my $trainer = $session->getUser();
my $leut = $trainer;

use CGI;
$query = new CGI;
$pokal = $query->param('pokal');
$runde = $query->param('runde');

print "Content-Type: text/html \n\n";

require "/tmapp/tmsrc/cgi-bin/btm_ligen.pl" ;
require "/tmapp/tmsrc/cgi-bin/runde.pl" ;

open(D7,"/tmdata/btm/pokal/tip_status.txt");
$tip_status = <D7> ;
chomp $tip_status;
close(D7);

open(D7,"/tmdata/btm/pokal/pokal_datum.txt");
$tip_date = <D7> ;
chomp $tip_date;
close(D7);

$ein = 0;
for ( $x = 1; $x <= 17; $x++ )
{
if ( $x == $pokal ) { $ein = 1 }
}
if ( $ein == 0 ) { $pokal = 17 }



$ein = 0;
for ( $x = 1; $x <= 7; $x++ )
{
if ( $x == $runde ) { $ein = 1 }
}
if ( $ein == 0 ) { $runde = $tip_date }



$bx = "/tmdata/btm/formular$rrunde.txt";
$datei_hier = $bx ;

open(DO,$datei_hier);
while(<DO>) {
@vareine = <DO>;
}
close(DO);

$y = 0;
for ( $x = 0; $x < 25;$x++ )
{
$y++;
chomp $vareine[$y];
@ega = split (/&/, $vareine[$y]);	
$paarung[$y] = $ega[1];
$qu_1[$y] = $ega[2];
$qu_0[$y] = $ega[3];
$qu_2[$y] = $ega[4];
$ergebnis[$y] = $ega[5];
}

open(D7,"/tmdata/btm/pokal/pokal_datum.txt");
$spielrunde_ersatz = <D7> ;

chomp $spielrunde_ersatz;
close(D7);
if ( $spielrunde_ersatz < $runde ) { $runde = $spielrunde_ersatz }

if (( $pokal == 17) and ( $runde == 1 )) { $runde = 2 }

$y = 0;
$rr = 0;
$li=0;
$liga=0;
open(D2,"/tmdata/btm/history.txt");
while(<D2>) {

$li++;
@vereine = split (/&/, $_);	

$y=0;
for ( $x = 1; $x < 19; $x++ )
{

$rr++;
$y++;
chomp $verein[$y];
$team[$rr] = $vereine[$y];

$y++;
chomp $verein[$y];
$verein_trainer[$rr] = $vereine[$y];

if ( $verein_trainer[$rr] eq $trainer ) {
$trainer_verein = $team[$rr];
$trainer_id = ( ($li-1) * 18 ) + $x ;
}


$verein_liga[$rr] = $li;
$verein_nr[$rr] = $x;
$y++;
}

}
close(D2);

$pokal_id = 0;
$pokal_dfb=0;

open(D2,"/tmdata/btm/pokal/pokal.txt");

$rsuche = '&' . $trainer_id . '&' ;
while(<D2>) {
if ($_ =~ /$rsuche/) {
( $pokal_id , $rest ) = split (/&/ , $_ ) ;
}


}
close(D2);

open(D2,"/tmdata/btm/pokal/pokal_id.txt");


$rsuche = '&' . $trainer_id . '&' ;
while(<D2>) {
if ($_ =~ /$rsuche/) {
$pokal_dfb = 1 ;
}


}
close(D2);



if ( $runde == 1 ) {

$suche = '#' . $pokal . '-' . $runde . '&' ;

open(D2,"/tmdata/btm/pokal/pokal.txt");
while(<D2>) {


if ($_ =~ /$suche/) {
@ega = split (/&/ , $_ ) ;
}


$rsuche = '&' . $trainer_id . '&' ;

if ($_ =~ /$rsuche/) {
( $pokal_id , $rest ) = split (/&/ , $_ ) ;
}


}
close(D2);

open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {


if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);

}


open(D2,"/tmdata/btm/heer.txt");
while(<D2>) {
@egx = split (/&/ , $_ ) ;
$plazierung{"$egx[5]"} = $egx[0] ;
$liga{"$egx[5]"} = $egx[1] ;
}
close(D2);





if ( $runde > 1 ) {

if ($pokal !=17 ) {

$suche = '#' . $pokal . '-1&' ;

open(D2,"/tmdata/btm/pokal/pokal.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@egb = split (/&/ , $_ ) ;
}
}
close(D2);
}


open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote1 = split (/&/ , $_ ) ;
}
}
close(D2);

$c=0;
for ($a=1 ; $a<=128 ; $a = $a+2) {
$b=$a+1;
$c++;

if ( $quote1[$a] ==  $quote1[$b] ) { $egy[$c] = $egb[$b] }
if ( $quote1[$a] >  $quote1[$b] ) { $egy[$c] = $egb[$a] }
if ( $quote1[$a] <  $quote1[$b] ) { $egy[$c] = $egb[$b] }


if ( $egb[$b] == 9999 ) { $egy[$c] = $egb[$a] }

}



if ($pokal == 17 ) {
open(D2,"/tmdata/btm/pokal/pokal_id.txt");
while(<D2>) {
@egy = split (/&/ , $_ ) ;
}
close(D2);
}






if ( $runde == 2 ) {

$suche = '#' . $pokal . '-2&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);
@ega = @egy ;
}





if ( $runde > 2 ) {

$suche = '#' . $pokal . '-2&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote2 = split (/&/ , $_ ) ;
}
}
close(D2);

$c=0;
for ($a=1 ; $a<=64 ; $a = $a+2) {
$b=$a+1;
$c++;

if ( $quote2[$a] ==  $quote2[$b] ) { $egx[$c] = $egy[$b] }
if ( $quote2[$a] >  $quote2[$b] ) { $egx[$c] = $egy[$a] }
if ( $quote2[$a] <  $quote2[$b] ) { $egx[$c] = $egy[$b] }

}


if ( $pokal == 17 ) {
@xex = () ;
@tausch = () ;



open(D2,"/tmdata/btm/pokal/pokal_dfb.txt");
while(<D2>) {
$suche = '1#' ;
if ($_ =~ /$suche/) {
( $rest , $long ) = split (/#/ , $_ ) ;
@tausch = split (/&/ , $long ) ;
for ($a=1 ; $a<=32 ; $a++) {
$xex[$a] = $egx[$tausch[$a-1]] ;
}
}
}
close(D2);

for ($ax=1 ; $ax<=32 ; $ax=$ax+2) {
$bx=$ax+1;


if ( ( $liga{$team[$xex[$bx]]} > 2 ) and ( $liga{$team[$xex[$ax]]} < 3 ) ) {



$xa = $xex[$ax] ;
$xb = $xex[$bx] ;
$xex[$ax] = $xb ;
$xex[$bx] = $xa ;


}
}


@egx = @xex ;
}






if ( $runde == 3 ) {

$suche = '#' . $pokal . '-3&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);
@ega = @egx ;
}

}



if ( $runde > 3 ) {

$suche = '#' . $pokal . '-3&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote3 = split (/&/ , $_ ) ;
}
}
close(D2);

$c=0;
for ($a=1 ; $a<=32 ; $a = $a+2) {
$b=$a+1;
$c++;

if ( $quote3[$a] ==  $quote3[$b] ) { $egw[$c] = $egx[$b] }
if ( $quote3[$a] >  $quote3[$b] ) { $egw[$c] = $egx[$a] }
if ( $quote3[$a] <  $quote3[$b] ) { $egw[$c] = $egx[$b] }
}


if ( $pokal == 17 ) {
@xex = () ;
@tausch = () ;
open(D2,"/tmdata/btm/pokal/pokal_dfb.txt");
while(<D2>) {
$suche = '2#' ;
if ($_ =~ /$suche/) {
( $rest , $long ) = split (/#/ , $_ ) ;
@tausch = split (/&/ , $long ) ;
for ($a=1 ; $a<=16 ; $a++) {
$xex[$a] = $egw[$tausch[$a-1]] ;
}
}
}
close(D2);

for ($ax=1 ; $ax<=16 ; $ax=$ax+2) {
$bx=$ax+1;



if ( ( $liga{$team[$xex[$bx]]} > 2 ) and ( $liga{$team[$xex[$ax]]} < 3 ) ) {



$xa = $xex[$ax] ;
$xb = $xex[$bx] ;
$xex[$ax] = $xb ;
$xex[$bx] = $xa ;


}
}


@egw = @xex ;
}






if ( $runde == 4 ) {

$suche = '#' . $pokal . '-4&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);
@ega = @egw ;
}

}



if ( $runde > 4 ) {

$suche = '#' . $pokal . '-4&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote4 = split (/&/ , $_ ) ;
}
}
close(D2);

$c=0;
for ($a=1 ; $a<=16 ; $a = $a+2) {
$b=$a+1;
$c++;

if ( $quote4[$a] ==  $quote4[$b] ) { $egv[$c] = $egw[$b] }
if ( $quote4[$a] >  $quote4[$b] ) { $egv[$c] = $egw[$a] }
if ( $quote4[$a] <  $quote4[$b] ) { $egv[$c] = $egw[$b] }
}


if ( $pokal == 17 ) {
@xex = () ;
@tausch = () ;

open(D2,"/tmdata/btm/pokal/pokal_dfb.txt");
while(<D2>) {
$suche = '3#' ;
if ($_ =~ /$suche/) {
( $rest , $long ) = split (/#/ , $_ ) ;
@tausch = split (/&/ , $long ) ;
for ($a=1 ; $a<=8 ; $a++) {
$xex[$a] = $egv[$tausch[$a-1]] ;
}
}
}
close(D2);
for ($ax=1 ; $ax<=8 ; $ax=$ax+2) {
$bx=$ax+1;


if ( ( $liga{$team[$xex[$bx]]} > 2 ) and ( $liga{$team[$xex[$ax]]} < 3 ) ) {



$xa = $xex[$ax] ;
$xb = $xex[$bx] ;
$xex[$ax] = $xb ;
$xex[$bx] = $xa ;


}
}

@egv = @xex ;
}




if ( $runde == 5 ) {

$suche = '#' . $pokal . '-5&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);
@ega = @egv ;
}

}



if ( $runde > 5 ) {

$suche = '#' . $pokal . '-5&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote5 = split (/&/ , $_ ) ;
}
}
close(D2);

$c=0;
for ($a=1 ; $a<=8 ; $a = $a+2) {
$b=$a+1;
$c++;

if ( $quote5[$a] ==  $quote5[$b] ) { $egm[$c] = $egv[$b] }
if ( $quote5[$a] >  $quote5[$b] ) { $egm[$c] = $egv[$a] }
if ( $quote5[$a] <  $quote5[$b] ) { $egm[$c] = $egv[$b] }
}

if ( $pokal == 17 ) {
@xex = () ;
@tausch = () ;

open(D2,"/tmdata/btm/pokal/pokal_dfb.txt");
while(<D2>) {
$suche = '4#' ;
if ($_ =~ /$suche/) {
( $rest , $long ) = split (/#/ , $_ ) ;
@tausch = split (/&/ , $long ) ;
for ($a=1 ; $a<=4 ; $a++) {
$xex[$a] = $egm[$tausch[$a-1]] ;
}
}
}
close(D2);

for ($ax=1 ; $ax<=4 ; $ax=$ax+2) {
$bx=$ax+1;



if ( ( $liga{$team[$xex[$bx]]} > 2 ) and ( $liga{$team[$xex[$ax]]} < 3 ) ) {



$xa = $xex[$ax] ;
$xb = $xex[$bx] ;
$xex[$ax] = $xb ;
$xex[$bx] = $xa ;


}
}


@egm = @xex ;
}




if ( $runde == 6 ) {

$suche = '#' . $pokal . '-6&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);
@ega = @egm ;
}

}



if ( $runde > 6 ) {

$suche = '#' . $pokal . '-6&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote6 = split (/&/ , $_ ) ;
}
}
close(D2);

$c=0;
for ($a=1 ; $a<=4 ; $a = $a+2) {
$b=$a+1;
$c++;

if ( $quote6[$a] ==  $quote6[$b] ) { $egn[$c] = $egm[$b] }
if ( $quote6[$a] >  $quote6[$b] ) { $egn[$c] = $egm[$a] }
if ( $quote6[$a] <  $quote6[$b] ) { $egn[$c] = $egm[$b] }
}


if ( $pokal == 17 ) {
@xex = () ;
@tausch = () ;

open(D2,"/tmdata/btm/pokal/pokal_dfb.txt");
while(<D2>) {
$suche = '5#' ;
if ($_ =~ /$suche/) {
( $rest , $long ) = split (/#/ , $_ ) ;
@tausch = split (/&/ , $long ) ;
for ($a=1 ; $a<=2 ; $a++) {
$xex[$a] = $egn[$tausch[$a-1]] ;
}
}
}
close(D2);

@egn = @xex ;
}





if ( $runde == 7 ) {

$suche = '#' . $pokal . '-7&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);
@ega = @egn ;
}

}






}











if ( $runde == 1 ) { $aa = 128 }
if ( $runde == 2 ) { $aa = 64 }
if ( $runde == 3 ) { $aa = 32 }
if ( $runde == 4 ) { $aa = 16 }
if ( $runde == 5 ) { $aa = 8 }
if ( $runde == 6 ) { $aa = 4 }
if ( $runde == 7 ) { $aa = 2 }





$team[9999] = "<font color=darkred>Freilos";
$verein_liga[9999] = "9999";
$liga_kuerzel[9999] = "----";

print "<html><title>Pokal Paarungen</title><p align=left><body bgcolor=white text=black>\n";
require "/tmapp/tmsrc/cgi-bin/tag.pl" ;
require "/tmapp/tmsrc/cgi-bin/tag_small.pl" ;
require "/tmapp/tmsrc/cgi-bin/loc.pl" ;


print "<script language=JavaScript>\n";
print "<!--\n";
print "function targetLink(URL)\n";
print "  {\n";
print "    if(document.images)\n";
print "      targetWin = open(URL,\"Neufenster\",\"scrollbars=yes,toolbar=no,directories=no,menubar=no,status=no,resizeable=yes,width=850,height=240\");\n";
print " }\n";
print "  //-->\n";
print "  </script>\n";

print "<p align=left>\n";



print "<font face=verdana size=1><form method=post action=/cgi-bin/btm/pokal/pokal_show.pl target=_top>";

print "&nbsp;&nbsp;<select  style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=pokal>";
$gh = "";
if ( $pokal == 17 ) { $gh = "selected" }
print "<option value=17 $gh>DFB - Pokal \n";
for ( $x=1; $x<=16;$x++ ) {
$gh = "";
if ( $pokal == $x ) { $gh = "selected" }
print "<option value=$x $gh>Amateurpokal $x\n";
}
print "</select>&nbsp;&nbsp;\n";



print "<select  style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=runde>";

$gh = "";
if ( $runde ==1 ) { $gh = "selected" }
print "<option value=1 $gh>Qualifikationsrunde \n";
$gh = "";
if ( $runde ==2 ) { $gh = "selected" }
print "<option value=2 $gh>1.Hauptrunde \n";
$gh = "";
if ( $runde ==3 ) { $gh = "selected" }
print "<option value=3 $gh>2.Hauptrunde \n";
$gh = "";
if ( $runde ==4 ) { $gh = "selected" }
print "<option value=4 $gh>Achtelfinale \n";
$gh = "";
if ( $runde ==5 ) { $gh = "selected" }
print "<option value=5 $gh>Viertelfinale \n";
$gh = "";
if ( $runde ==6 ) { $gh = "selected" }
print "<option value=6 $gh>Halbfinale \n";
$gh = "";
if ( $runde ==7 ) { $gh = "selected" }
print "<option value=7 $gh>Finale \n";
print "</select>&nbsp;&nbsp;\n";


print "&nbsp;&nbsp;<input type=hidden name=password value=\"$pass\"><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=ligi value=\"$ligi\"><input type=hidden name=id value=\"$id\"><iNPUT TYPE=SUBMIT  style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" VALUE=\"Resultate laden\"></form>";

$sp01 = $spielrunde + 1;
$sp02 = $spielrunde - 1;

if ($spielrunde ==1) { $sp02 = 1 }
if ($spielrunde ==34) { $sp01 = 34 }



$pokal_aa = $pokal_id ;
$pokal_aa =~s/\#/\ /g ;
$pokal_aa =~s/-1/\ /g ;
$pokal_aa = $pokal_aa * 1;


if ( $pokal_dfb != 0 ) {
print "<form name=tipdfb method=post action=/cgi-bin/btm/pokal/pokal_tip.pl target=_top><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=pokal value=17><input type=hidden name=password value=\"$pass\"></form>\n";
print "<font face=verdana size=1>&nbsp;&nbsp;Ihr Verein $trainer_verein startet im DFB - Pokal ... ";
if ( $cup_dfb_name[$rrunde] ne "" ) {

print "<a href=javascript:document.tipdfb.submit()>Zur Tipabgabe [ $cup_dfb_name[$rrunde] ]</a><br><br>\n";
} else {
print "[ Diese Woche keine Tiprunde in diesem Wettbewerb ]<br><br>\n";
}

}
if ( $pokal_id ne "0" ) {
print "<form name=tip method=post action=/cgi-bin/btm/pokal/pokal_tip.pl target=_top><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=pokal value=\"$pokal_aa\"><input type=hidden name=password value=\"$pass\"></form>\n";
print "<font face=verdana size=1>&nbsp;&nbsp;Ihr Verein $trainer_verein startet im Amateurpokal $pokal_aa ... ";

if ( $cup_btm_name[$rrunde] ne "" ) {

print "<a href=javascript:document.tip.submit()>Zur Tipabgabe [ $cup_btm_name[$rrunde] ]</a><br><br>\n";
} else {
print "[ Diese Woche keine Tiprunde in diesem Wettbewerb ]<br><br>\n";
}

}


if (( $pokal_dfb == 0 ) and  ( $pokal_id eq "0" )){
print "<br><font face=verdana size=1>&nbsp;&nbsp;Ihr Verein $trainer_verein hat sich fuer keinen der Pokalwettbewerbe qualifiziert ... <br><br>\n";
}


print "<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0>";


for ($x=1 ; $x <= $aa ; $x = $x + 2 ) {
$y = $x +1 ;

	$fa = $fa + 1;
	if ( $fa == 3 ) { $fa = 1 }
	if ( $fa == 1 ) { $farbe = "#eeeeee" }
	if ( $fa == 2 ) { $farbe = "white" }

$color = "black";

	
print  "<TR BGCOLOR=$farbe>\n";

$color=black ;
if ( $team[$ega[$x]] eq $trainer_verein ) { $color="red" }

print  "<TD align=left><FONT FACE=verdana SIZE=1 color=$color>&nbsp;&nbsp;<a href=/cgi-mod/btm/verein.pl?li=$verein_liga[$ega[$x]]&ve=$verein_nr[$ega[$x]]><img src=/img/h1.jpg heigth=10 width=10  alt=\"Vereinsseite $team[$ega[$x]]\" border=0></a>&nbsp;&nbsp;$team[$ega[$x]]&nbsp;&nbsp;&nbsp;&nbsp;</td></form>\n";

$mar = "" ;
if ( $plazierung{$team[$ega[$x]]} < 10 ) { $mar = 0 }
print  "<td align=right><FONT FACE=verdana SIZE=1> $liga_kuerzel[$verein_liga[$ega[$x]]]&nbsp;&nbsp;( $mar$plazierung{$team[$ega[$x]]}.)&nbsp;&nbsp;</FONT></TD>\n";

$color = "black";
if ( ($id == $ega[$y]) and ($ligi == $liga) ) { $color="red" }

$color=black ;
if ( $team[$ega[$y]] eq $trainer_verein ) { $color="#000099" }


print  "<TD align=left><FONT FACE=verdana SIZE=1 color=$color>-&nbsp;&nbsp;<a href=/cgi-mod/btm/verein.pl?li=$verein_liga[$ega[$y]]&ve=$verein_nr[$ega[$y]]><img src=/img/h1.jpg heigth=10 width=10  alt=\"Vereinsseite $team[$ega[$y]]\" border=0></a>&nbsp;&nbsp;$team[$ega[$y]]&nbsp;&nbsp;&nbsp;&nbsp;</td></form>\n";
$mar = "" ;
if ($plazierung{$team[$ega[$y]]}< 10 ) { $mar = 0 }

if ( $ega[$y] != 9999 ) {
print  "<td align=right><FONT FACE=verdana SIZE=1> $liga_kuerzel[$verein_liga[$ega[$y]]]&nbsp;&nbsp;( $mar$plazierung{$team[$ega[$y]]}.)&nbsp;</FONT></TD>\n";
} else {
print  "<td align=right><FONT FACE=verdana SIZE=1> &nbsp;</TD>\n";

}

print  "<td colspan=10><font face=verdana size=3>&nbsp;</td>\n";
$kuerzel = "" ;

if ( $cup_btm_round[$rrunde] == $runde && $tip_status ==2 && $runde == $spielrunde_ersatz && $cup_btm_aktiv_f[$rrunde] == 1 && $quote[$x] == 1 ) { $live = 1 }


################################################
if ( $live == 1 ) {
# LIVE _ BERECHNUNG !

$xx=$ega[$x];
if ( $xx < 10 ) { $xx='0'.$xx }
if ( $xx < 100 ) { $xx='0'.$xx }
if ( $xx < 1000 ) { $xx='0'.$xx }

$datei1 ="/tmdata/btm/pokal/tips/$xx-$pokal-$runde.txt";

$xx=$ega[$y];
if ( $xx < 10 ) { $xx='0'.$xx }
if ( $xx < 100 ) { $xx='0'.$xx }
if ( $xx < 1000 ) { $xx='0'.$xx }

$datei2 ="/tmdata/btm/pokal/tips/$xx-$pokal-$runde.txt";

open(A1,"<$datei1");
$row1 =<A1>;chomp $row1;
close (A1);
open(A1,"<$datei2");
$row2 =<A1>;chomp $row2;
close (A1);

@tips=();
@tips = split (/\./ , $row1 ) ;
$quote=0;
for ($r=0;$r<=9;$r++) {
#print "<td>$ergebnis[$r+1] $tips[$r] -</td>";
if ( ($tips[$r] eq "1&1") and ($ergebnis[$r+1] == 1)) { $quote = $quote + $qu_1[$r+1] }
if ( ($tips[$r] eq "1&2") and ($ergebnis[$r+1] == 2)) { $quote = $quote + $qu_0[$r+1] }
if ( ($tips[$r] eq "1&3") and ($ergebnis[$r+1] == 3)) { $quote = $quote + $qu_2[$r+1] }
if ( ($ergebnis[$r+1] == 4) and ($tips[$r] > 0 )) { $quote = $quote + 10 }
}
if ( $quote < 10 ) { $quote = '0' . $quote }
$quote[$x] = $quote;

@tips=();
@tips = split (/\./ , $row2 ) ;
$quote=0;
for ($r=0;$r<=9;$r++) {

if ( ($tips[$r] eq "1&1") and ($ergebnis[$r+1] == 1)) { $quote = $quote + $qu_1[$r+1] }
if ( ($tips[$r] eq "1&2") and ($ergebnis[$r+1] == 2)) { $quote = $quote + $qu_0[$r+1] }
if ( ($tips[$r] eq "1&3") and ($ergebnis[$r+1] == 3)) { $quote = $quote + $qu_2[$r+1] }
if ( ($ergebnis[$r+1] == 4) and ($tips[$r] > 0)) { $quote = $quote + 10 }
}
if ( $quote < 10 ) { $quote = '0' . $quote }
$quote[$y] = $quote;
}
####################################################





$cett = "black" ;
if ( ($ega[$y] == 9999) or ($quote[$y] == 1 ) ) {
print  "<td align=center><FONT FACE=verdana SIZE=1> &nbsp;&nbsp; - : - &nbsp;&nbsp; </FONT></TD>\n";
print  "<td align=left><FONT FACE=verdana SIZE=1>&nbsp;$kuerzel&nbsp;</TD>\n";
} 

if ( ($ega[$y] != 9999) and ($quote[$y] != 1 ) ) {

$tora=0;
$torb=0;

if ( $quote[$x] > 14 ) { $tora = 1 }
if ( $quote[$x]> 39 ) { $tora = 2 }
if ( $quote[$x]> 59 ) { $tora = 3 }
if ( $quote[$x]> 79 ) { $tora = 4 }
if ( $quote[$x]> 104 ) { $tora = 5 }
if ( $quote[$x]> 129 ) { $tora = 6 }
if ( $quote[$x]> 154 ) { $tora = 7 }

if ( $quote[$y] >  14 ) { $torb = 1 }
if ( $quote[$y]> 39 ) { $torb = 2 }
if ( $quote[$y]> 59 ) { $torb = 3 }
if ( $quote[$y]> 79 ) { $torb = 4 }
if ( $quote[$y]> 104 ) { $torb = 5 }
if ( $quote[$y]> 129 ) { $torb = 6 }
if ( $quote[$y]> 154 ) { $torb = 7 }


if ( $tora == $torb ) { 
if ( $live != 1 ) {
$d = $quote[$x] - $quote[$y] ;
if ( $d > 5 ) { $kuerzel = "n.V." }
if ( $d > 5 ) { $tora++ }
if ( $d > 15 ) { $tora++ }
if ( $d < -5 ) { $kuerzel = "n.V." }
if ( $d < -5 ) { $torb++ }
if ( $d < -15 ) { $torb++ }

if ( $d == 0 ) { $kuerzel = "n.E." }
if ( $d == 0 ) { $tora=$tora+4 }
if ( $d == 0 ) { $torb=$torb+5 }

if ( $d == -1 ) { $kuerzel = "n.E." }
if ( $d == -1 ) { $tora=$tora+4 }
if ( $d == -1 ) { $torb=$torb+5 }

if ( $d == 1 ) { $kuerzel = "n.E." }
if ( $d == 1 ) { $tora=$tora+5 }
if ( $d == 1 ) { $torb=$torb+4 }

if ( ($d > 1) and ($d < 4) ) { $kuerzel = "n.E." }
if  ( ($d > 1) and ($d < 4) ) { $tora=$tora+5 }
if  ( ($d > 1) and ($d < 4) ) { $torb=$torb+3 }

if ( ($d > 3) and ($d < 6) ) { $kuerzel = "n.E." }
if  ( ($d > 3) and ($d < 6) ) { $tora=$tora+4 }
if  ( ($d > 3) and ($d < 6) ) { $torb=$torb+2 }


if ( ($d > -4) and ($d < -1) ) { $kuerzel = "n.E." }
if  ( ($d > -4) and ($d < -1) ) { $tora=$tora+3 }
if  ( ($d > -4) and ($d < -1) ) { $torb=$torb+5 }

if ( ($d > -6) and ($d < -3) ) { $kuerzel = "n.E." }
if  ( ($d > -6) and ($d < -3) ) { $tora=$tora+2 }
if  ( ($d > -6) and ($d < -3) ) { $torb=$torb+4 }


}
}




$color=black;

if ( $live ==1 ) { $color = "red" }


print  "<td align=right><FONT FACE=verdana SIZE=1 color=$color>&nbsp; $tora : $torb &nbsp;</TD>\n";
print  "<td align=left><FONT FACE=verdana SIZE=1 color=$color>&nbsp;$kuerzel&nbsp;</TD>\n";
}

if ( ($ega[$y] == 9999 || $quote[$y] == 1) && $live==0) {
print  "<td align=center><FONT FACE=verdana SIZE=1>&nbsp;&nbsp; [ __ - __ ] &nbsp;&nbsp;</FONT></TD>\n";
} else {

print  "<td align=right><FONT FACE=verdana SIZE=1 color=black>&nbsp;&nbsp; [ <font color=$color>$quote[$x] - $quote[$y] <font color=black>] &nbsp;&nbsp;</TD>\n";

}

$ra1=$team[$ega[$x]];
$ra2=$team[$ega[$y]];

# special for bodo
if ($runde eq 7 && $pokal eq 17) {
  my $nr1 = $verein_liga[$ega[$x]]*18+$plazierung{$team[$ega[$x]]}-18;
  my $nr2 = $verein_liga[$ega[$y]]*18+$plazierung{$team[$ega[$y]]}-18;
  
  open(K,">/tmdata/cl/swechsel/dfb_pokal.txt");
  print K $ra1,"#",$nr1,"#",$ra2,"#",$nr2,"#",$quote[$x],"#",$quote[$y],"\n";
  close(K);
}

$ra1=~s/ /%20/g;
$ra2=~s/ /%20/g;

if ( $ega[$y] != 9999 ) {
print  "<TD ALIGN=RIGHT colspan=30><a href=tips_cup.pl?po=$pokal&ru=$runde&row1=$ega[$x]&row2=$ega[$y]&ve1=$ra1&ve2=$ra2 target\"_blank\" onClick=\"targetLink('tips_cup.pl?po=$pokal&ru=$runde&row1=$ega[$x]&row2=$ega[$y]&ve1=$ra1&ve2=$ra2');return false\"><IMG SRC=/img/ti.jpg BORDER=0 alt=\"Detail - Tipansicht\"></A>&nbsp;&nbsp;</TD>\n";
}
print "</TR>\n";

}

print "</table>\n";

exit ;



