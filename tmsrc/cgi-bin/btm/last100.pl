#!/usr/bin/perl

=head1 NAME
	BTM last100.pl

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
my $session = TMSession::getSession(undef);
TMLogger::log("last100.pl >>> completed");
my $trainer = $session->getUser();
my $leut = $trainer;

use CGI;
require "/tmapp/tmsrc/cgi-bin/btm_ligen.pl" ;
require "/tmapp/tmsrc/cgi-bin/btm/saison.pl";
require "/tmapp/tmsrc/cgi-bin/runde.pl";


print "Content-Type: text/html \n\n";


$query = new CGI;
$me = $query->param('me');
$loss = $query->param('loss');
$top = $query->param('top');
$sp_start = $query->param('sp_start');
$sp_ende = $query->param('sp_ende');
$into = $query->param('into');
$fileid = $query->param('fileid');
$sai = $query->param('sai');
$runde = $query->param('runde');


&header;
&readin_data;
&display;
exit;

sub header{

$ein=0;
for ( $x = 1; $x <= 4; $x++ ) {
if ( $x == $me ) { $ein = 1 }
}
if ($ein == 0 ) {$me=2}



($saison_sel,$runde_sel)=split(/&/,$runde);

$ein=0;
for ( $x = 1; $x < 3; $x++ ) {
if ( $x == $loss ) { $ein = 1 }
}
if ($ein == 0 ) {$loss=1}

$ein=0;
for ( $x = 1; $x <= 4; $x++ ) {
if ( $x == $top ) { $ein = 1 }
}
if ($ein == 0 ) {$top=2}

$ein=0;
for ( $x = 1; $x <= 7; $x++ ) {
if ( $x == $into ) { $ein = 1 }
}
if ($ein == 0 ) {$into=4}

print "<head>\n";
print "<style type=\"text/css\">";
print "TD.ve { font-family:Verdana; font-size:8pt; color:black; }\n";
print "</style>\n";
print "</head>\n";

if ( $saison_sel eq "" ) { $saison_sel = $main_nr }
if ( $runde_sel == 0 ) { $runde_sel = $rrunde -1 }

print " <html><title>TipMaster Trainer - Last-100-Ranking </title><p align=left><body bgcolor=white text=black>\n";

require "/tmapp/tmsrc/cgi-bin/tag.pl" ;
require "/tmapp/tmsrc/cgi-bin/tag_small.pl" ;
print "<br>\n";
print "<font face=verdana size=1>";
$trainer = $leut ;

require "/tmapp/tmsrc/cgi-bin/loc.pl" ;

print "<font face=verdana size=1>";

$tmp1 = $runde_sel - 1;
$tmp2 = $runde_sel + 1;

$ru_zurueck = $saison_sel.'&'.$tmp1;
$ru_vor = $saison_sel.'&'.$tmp2;
$ss1= $saison_sel -1;
$ss2= $saison_sel+1;
if ($tmp1 == 0){$ru_zurueck = $ss1.'&9'}
if ($tmp2 == 10){$ru_vor = $ss2.'&1'}


$last=(($saison_sel-6)*34)+(($tmpr-1)*4);

print "<table>";
print "<form name=vor method=post action=last100.pl target=_top>
<input type=hidden name=me value=\"$me\">
<input type=hidden name=runde value=\"$ru_vor\">

</form>\n";

print "<form name=zurueck method=post action=last100.pl target=_top>
<input type=hidden name=me value=\"$me\">
<input type=hidden name=runde value=\"$ru_zurueck\">

</form>\n";
print "<tr></tr></table>";
print "<form method=post action=/cgi-bin/btm/last100.pl target=_top>\n";

print "<a href=javascript:document.zurueck.submit()><img src=/img/h2.jpg heigth=10 width=10 border=0></a> &nbsp; "; 

print "<select style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=runde>";

for($y=10;$y<=$main_nr;$y++){
for($x=1;$x<=9;$x++){
$gh = "";
if ( $runde_sel == $x && $saison_sel == $y) { $gh = "selected" }
print "<option value=$y&$x $gh>$main_saison[$y] Runde #$x\n";
}}
print "</select>";
print " &nbsp; <a href=javascript:document.vor.submit()><img src=/img/h1.jpg heigth=10 width=10 border=0></a> &nbsp; "; 



print "<select style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=me>";

$gh = "";
if ( $me == 1 ) { $gh = "selected" }
print "<option value=1 $gh>Die erfolgreichsten Trainer ( Spiele-Bilanz )\n";
$gh = "";
if ( $me == 2 ) { $gh = "selected" }
print "<option value=2 $gh>Die offensivstaerksten Trainer ( Tore pro Spiel ) \n";
$gh = "";
if ( $me == 3 ) { $gh = "selected" }
print "<option value=3 $gh>Die effektivsten Trainer ( Optimizer Wert ) \n";
$gh = "";
if ( $me == 4 ) { $gh = "selected" }
print "<option value=4 $gh>Die defensivschwaechsten Trainer ( Gegentore pro Spiel ) \n";
print "</select>&nbsp;&nbsp;";

if ( $trainer ne "unknown" ) {
print "<select style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=loss>";
$gh = "";
if ( $loss == 1 ) { $gh = "selected" }
print "<option value=1 $gh>Alle Trainer \n";
$gh = "";
if ( $loss == 2 ) { $gh = "selected" }
print "<option value=2 $gh>Nur Ligakonkurenten \n";
print "</select>&nbsp;&nbsp;\n";
}



print "&nbsp;&nbsp<input type=hidden name=id value=\"$id\"><input style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\"  type=submit value=\"Tabelle laden\"></form><br>";


if ( $me==1 ) { print "In dieser Tabelle werden alle Ergebnisse der letzten 100 Spieltage addiert .<br>Die Tabelle wird sortiert nach der Anzahl der erreichten Punkte .<br><br>" }
if ( $me==2 ) { print "In dieser Tabelle werden alle Tipergebnisse der letzten 100 Spieltage addiert .<br>Die Tabelle wird sortiert nach der bisherigen durchschnittlichen Tipquote des Trainers.<br><br>" }
if ( $me==3 ) { print "In dieser Tabelle werden alle ueberfluessigen Tipergebnisse ueber die Torgrenzen hinaus der letzten 100 Spieltage gewertet .<br>Die Tabelle wird sortiert nach den durchschnittlich niedrigsten ueberfluessigen Tipresten des Trainers.<br><br>" }
if ( $me==4 ) { print "In dieser Tabelle werden alle erzielten Tipergebnisse der Gegner eines Trainers der letzten 100 Spieltage gewertet .<br>Die Tabelle wird sortiert nach der bisherigen niedrigsten durchschnittlichen Tipquote der Gegner des Trainers.<br><br>" }
if ( $me==5 ) { print "Diese Tabelle ist fuer die Vergabe von Trainerposten ueber die Jobboerse ausschlaggebend .<br>Fuer die Punktezahl eines Trainers sind zum einen die Tipquoten der letzten drei Saisons<br>eines Trainers sowie die aktuelle Vereinsplazierung des Trainers relevant .<br><br>" }
print "[ Zur Erklaerung: die \"zu Vert.\" Spalte gibt Auskunft der erzielten Leistungen des Trainers in der entsprechenden Kategorie in den 4 aeltesten Spieltage<br> der letzten 100 Spieltage. Diese \"Punkte\" muessen also quasi in  der kommenden Runde verteidigt werden da sie aus der Wertung herausfallen. ]<br><br> >> zu den <a href=ranking.pl>All Time Trainer Rankings</a><br><br>";
}





$r=0;







if ( $me == 1 ) {

open(D2,"/tmdata/btm/stat1.txt");
while(<D2>) {
$rr++;
($trainer[$rr],$spiele[$rr],$s_g[$rr],$u_g[$rr],$n_g[$rr],$tp_g[$rr],$tm_g[$rr],$qp_g[$rr],$qm_g[$rr],$pu[$rr],$pu_old[$rr]) = split (/&/,$_);
}
close (D2) ;


for ($ti=1;$ti<=$rr;$ti++) {

$quoten[$ti] = $pu_old[$ti] ;
$quoten[$ti] = $quoten[$ti] . '#' ;
$quoten[$ti] = $quoten[$ti] . $ti ;

}

@ranks = sort @quoten ;

@quoten = () ;


for ($t=1;$t<=$rr;$t++){
$r--;
($king[$t] , $ident[$t])= split (/#/, $ranks[$r]);	

$place_old[$ident[$t]] = $t ;
}

@ranks = () ;
@king = () ;
@ident = () ;



for ($ti=1;$ti<=$rr;$ti++) {

$quoten[$ti] = $pu[$ti] ;
$quoten[$ti] = $quoten[$ti] . '#' ;
$quoten[$ti] = $quoten[$ti] . $ti ;
}
@ranks = sort @quoten ;



$r=0;
for ($t=1;$t<=$rr;$t++){
$r--;
($king[$t] , $ident[$t])= split (/#/, $ranks[$r]);	
}






print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>\n";
print "<table border=0 cellpadding=1 cellspacing=1>\n";


print "<tr>\n";
print "<td class=ve bgcolor=#f5f5ff align=left>&nbsp;</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=left>&nbsp;</td>\n";

print "<td class=ve bgcolor=#f5f5ff align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Trainer</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=left colspan=2><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;aktueller Verein / Liga</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=left>&nbsp;Sp.</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=center colspan=3><font face=verdana size=1>&nbsp;Bilanz&nbsp;</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=center>&nbsp;Tore&nbsp;</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=center>&nbsp;Pu.&nbsp;</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=center>&nbsp;Quote&nbsp;</td>\n";
print "</tr>\n";


for ($t=1;$t<=$rr;$t++){
$ein = 0;

$color="black" ;
if ($trainer[$ident[$t]] eq $trainer ) { $color="red" }
if ( ( $t<=$marker ) or  ($trainer[$ident[$t]] eq $trainer ) ) { $ein = 1 }
if ( $loss== 2 ) {$ein=0}
if ( ( $liga{$trainer[$ident[$t]]} == $liga{$trainer} ) and  ($loss == 2 ) ) { $ein = 1 }


if ( $ein == 1 ) {



if ( $t == $place_old[$ident[$t]] ) { $ima = "pfeil=.gif" }
if ( $t < $place_old[$ident[$t]] ) { $ima = "pfeil++.gif" }
if ( $t > $place_old[$ident[$t]] ) { $ima = "pfeil--.gif" }
if ( $t < ( $place_old[$ident[$t]] - 10 ) ) { $ima = "pfeil+.gif" }
if ( $t > ( $place_old[$ident[$t]] + 10 ) ) { $ima = "pfeil-.gif" }


print "<tr>\n";
print "<td bgcolor=#f5f5ff align=right><font face=verdana size=1 color=$color>&nbsp;&nbsp;$t .&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=right><font face=verdana size=1>&nbsp;( $place_old[$ident[$t]] .)&nbsp;</td>\n";
$aa=$trainer[$ident[$t]];
$aa=~s/ /%20/g ;
print "<td bgcolor=#eeeeff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;<img src=/img/$ima>&nbsp;&nbsp;&nbsp;<a href=/cgi-mod/btm/trainer.pl?ident=$aa><img src=/img/h1.jpg border=0 alt=\"Trainerstatistik $trainer[$ident[$t]]\"></a>&nbsp;&nbsp;$trainer[$ident[$t]]&nbsp;&nbsp;</td>\n";
$color="black" ;
$aa=$verein{$trainer[$ident[$t]]};
$aa=~s/ /%20/g ;

print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;<a href=/cgi-mod/btm/verein.pl?ident=$aa><img src=/img/h1.jpg border=0 alt=\"Vereinsstatistik $verein{$trainer[$ident[$t]]}\"></a>&nbsp;&nbsp;$verein{$trainer[$ident[$t]]}&nbsp;&nbsp;</td>\n";



print "<td class=ve bgcolor=#f5f5ff align=left><font color=$color>&nbsp;&nbsp;$liga_kuerzel[$liga{$trainer[$ident[$t]]}]&nbsp;&nbsp;</td><!--ligaid=$liga{$trainer[$ident[$t]]}-->\n";
print "<td class=ve bgcolor=#eeeeff align=right>&nbsp;$spiele[$ident[$t]]&nbsp;</td>\n";
print "<td class=ve bgcolor=#eeeeff align=right>&nbsp;$s_g[$ident[$t]]&nbsp;</td>\n";
print "<td class=ve bgcolor=#eeeeff align=right>&nbsp;$u_g[$ident[$t]]&nbsp;</td>\n";
print "<td class=ve bgcolor=#eeeeff align=right>&nbsp;$n_g[$ident[$t]]&nbsp;</td>\n";
print "<td class=ve bgcolor=#eeeeff align=center>&nbsp;$tp_g[$ident[$t]] : $tm_g[$ident[$t]]&nbsp;</td>\n";

$pu[$ident[$t]] = $pu[$ident[$t]] * 1;
print "<td class=ve bgcolor=#CACBF6 align=right>&nbsp;&nbsp;$pu[$ident[$t]]&nbsp;&nbsp;</td>\n";



print "<td class=ve bgcolor=#eeeeff align=center>&nbsp;&nbsp;$qp_g[$ident[$t]] - $qm_g[$ident[$t]]&nbsp;&nbsp;</td>\n";

print "</tr>";
}
}


print "</table>\n";
print "</td></tr></table>\n";
$dd=$rr;

}








if ( $me == 2 ) {

open(D2,"/tmdata/btm/stat2.txt");
while(<D2>) {
$rr++;
($trainer[$rr],$rest) = split (/&/,$_);
($rest,$spiele[$rr],$spiele_mi[$rr],$qp_g[$rr],  $qm_g[$rr] , $qp_mi[$ti] ,$sp , $qu4{$trainer[$rr]}, $qu5{$trainer[$rr]}, $qu6{$trainer[$rr]}, $qu7{$trainer[$rr]}, $qu8{$trainer[$rr]} ) = split (/&/,$_);
}
close (D2) ;


$dd=0;
for ($ti=1;$ti<=$rr;$ti++) {
if ( ($spiele[$ti] - $spiele_mi[$ti]) > $grenze-1 ) {
$dd++;
$qpd_old[$dd] = int ( ( ($qp_g[$ti]-$qp_mi[$ti]) / ($spiele[$ti]-$spiele_mi[$ti]) ) * 100 ) / 100 ;
$xx="11";
( $yy , $xx ) = split (/\./ , $qpd_old[$dd] ) ;
$oo = length($xx) ;
if ($oo==1 ) { $qpd_old[$dd] = $qpd_old[$dd] . '0' }
if ($oo==0 ) { $qpd_old[$dd] = $qpd_old[$dd] . '.00' }
$coach[$dd] = $trainer[$ti] ;
}
}


for ($ti=1;$ti<=$dd;$ti++) {
$quoten[$ti] = $qpd_old[$ti] ;
$quoten[$ti] = $quoten[$ti] . '#' ;
$quoten[$ti] = $quoten[$ti] . $ti ;
}
@ranks = sort @quoten ;
$r = 0;
for ($t=1;$t<=$dd;$t++){
$r--;
($king[$t] , $ident[$t])= split (/#/, $ranks[$r]);	
$place_old{$coach[$ident[$t]]} = $t ;

}

@quoten = () ;
@king = () ;
@ident = () ;
@ranks = () ;
@coach = () ;





$dd=0;
for ($ti=1;$ti<=$rr;$ti++) {
if ( $spiele[$ti] > $grenze-1 ) {
$dd++;
$qpd[$dd] = int ( ($qp_g[$ti] / $spiele[$ti] ) * 100 ) / 100 ;
$xx="11";
( $yy , $xx ) = split (/\./ , $qpd[$dd] ) ;
$oo = length($xx) ;
if ($oo==1 ) { $qpd[$dd] = $qpd[$dd] . '0' }
if ($oo==0 ) { $qpd[$dd] = $qpd[$dd] . '.00' }
$quote[$dd] = $qp_g[$ti] ;
$coach[$dd] = $trainer[$ti] ;
$sp[$dd] = $spiele[$ti] ;
}
}



for ($ti=1;$ti<=$dd;$ti++) {
$quoten[$ti] = $qpd[$ti] ;
$quoten[$ti] = $quoten[$ti] . '#' ;
$quoten[$ti] = $quoten[$ti] . $ti ;
}
@ranks = sort @quoten ;
$r = 0;
for ($t=1;$t<=$dd;$t++){
$r--;
($king[$t] , $ident[$t])= split (/#/, $ranks[$r]);	
}






print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>\n";
print "<table border=0 cellpadding=1 cellspacing=1>\n";


print "<tr>\n";
print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1>&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1>&nbsp;</td>\n";

print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Trainer</td>\n";
print "<td bgcolor=#f5f5ff align=left colspan=2><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;aktueller Verein / Liga</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;Sp.&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;$l_s[5]&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;$l_s[4]&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;$l_s[3]&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;$l_s[2]&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;$l_s[1]&nbsp;</td>\n";

print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;Gesamt&nbsp;</td>\n";
print "</tr>\n";


for ($t=1;$t<=$dd;$t++){

$ein = 0;
$color="black" ;
if ($coach[$ident[$t]] eq $trainer ) { $color="red" }
if ( ( $t<=$marker ) or  ($coach[$ident[$t]] eq $trainer ) ) { $ein = 1 }
if ( $loss== 2 ) {$ein=0}
if ( ( $liga{$coach[$ident[$t]]} == $liga{$trainer} ) and  ($loss == 2 ) ) { $ein = 1 }

if ( $ein == 1 ) {

if ( $t == $place_old{$coach[$ident[$t]]} ) { $ima = "pfeil=.gif" }
if ( $t < $place_old{$coach[$ident[$t]]} ) { $ima = "pfeil++.gif" }
if ( $t > $place_old{$coach[$ident[$t]]} ) { $ima = "pfeil--.gif" }
if ( $t < ( $place_old{$coach[$ident[$t]]} - 10 ) ) { $ima = "pfeil+.gif" }
if ( $t > ( $place_old{$coach[$ident[$t]]} + 10 ) ) { $ima = "pfeil-.gif" }

if ( $place_old{$coach[$ident[$t]]} eq "" ) { $ima = "pfeil+.gif" }
if ( $place_old{$coach[$ident[$t]]} eq "" ) { $place_old{$coach[$ident[$t]]} = "--" }

print "<tr>\n";
print "<td bgcolor=#f5f5ff align=right><font face=verdana size=1 color=$color>&nbsp;&nbsp;$t .&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=right><font face=verdana size=1>&nbsp;( $place_old{$coach[$ident[$t]]} .)&nbsp;</td>\n";

$aa=$coach[$ident[$t]];
$aa=~s/ /%20/g ;

print "<td bgcolor=#eeeeff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;<img src=/img/$ima>&nbsp;&nbsp;&nbsp;<a href=/cgi-mod/btm/trainer.pl?ident=$aa><img src=/img/h1.jpg border=0 alt=\"Trainerstatistik $coach[$ident[$t]]\"></a>&nbsp;&nbsp;$coach[$ident[$t]]&nbsp;&nbsp;</td>\n";
$color="black" ;

$aa=$verein{$coach[$ident[$t]]};
$aa=~s/ /%20/g ;
print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;<a href=/cgi-mod/btm/verein.pl?ident=$aa><img src=/img/h1.jpg border=0 alt=\"Vereinsstatistik $verein{$coach[$ident[$t]]}\"></a>&nbsp;&nbsp;$verein{$coach[$ident[$t]]}&nbsp;&nbsp;</td>\n";



print "<td class=ve bgcolor=#f5f5ff align=left><font color=$color>&nbsp;&nbsp;$liga_kuerzel[$liga{$coach[$ident[$t]]}]&nbsp;&nbsp;</td><!--ligaid=$liga{$coach[$ident[$t]]}-->\n";
print "<td class=ve bgcolor=#eeeeff align=right>&nbsp;&nbsp;$sp[$ident[$t]]&nbsp;&nbsp;</td>\n";
print "<td class=ve bgcolor=#eeeeff align=right>&nbsp;$qu4{$coach[$ident[$t]]}&nbsp;</td>\n";
print "<td class=ve bgcolor=#eeeeff align=right>&nbsp;$qu5{$coach[$ident[$t]]}&nbsp;</td>\n";
print "<td class=ve bgcolor=#eeeeff align=right>&nbsp;$qu6{$coach[$ident[$t]]}&nbsp;</td>\n";
print "<td class=ve bgcolor=#eeeeff align=right>&nbsp;$qu7{$coach[$ident[$t]]}&nbsp;</td>\n";
print "<td class=ve bgcolor=#eeeeff align=right>&nbsp;$qu8{$coach[$ident[$t]]}&nbsp;</td>\n";

print "<td bgcolor=#CACBF6 align=center><font face=verdana size=1>&nbsp;$king[$t]&nbsp;</td>\n";
print "</tr>";


}
}

print "</table>\n";
print "</td></tr></table>\n";


}







if ( $me == 3 || $me == 7) {

$rr=0;

if ( $me ==7 ) { $me = 5 }

open(D2,"/tmdata/btm/stat$me.txt");
while(<D2>) {
$rr++;
($trainer[$rr],$rest) = split (/&/,$_);
($rest,$spiele[$rr],$sp_mi[$rr],$qr_g[$rr],  $qr_mi[$ti] ,$sp, $qx4{$trainer[$rr]}, $qx5{$trainer[$rr]}, $qx6{$trainer[$rr]}, $qx7{$trainer[$rr]},$qx8{$trainer[$rr]}) = split (/&/,$_);
}
close (D2) ;





$dd=0;

for ($ti=1;$ti<=$rr;$ti++) {
if ( ($spiele[$ti] - $sp_mi[$ti]) > $grenze-1 ) {
$dd++;
$qpd_o[$dd] = int ( ( ($qr_g[$ti] - $qr_mi[$ti] ) / ( $spiele[$ti] - $sp_mi[$ti] )) * 1000 ) / 1000 ;

$xx="111";

if ($qpd_o[$dd]<10 ) { $qpd_o[$dd] = '0' . $qpd_o[$dd] }
( $yy , $xx ) = split (/\./ , $qpd_o[$dd] ) ;
$oo = length($xx) ;
if ($oo==1 ) { $qpd_o[$dd] = $qpd_o[$dd] . '00' }
if ($oo==0 ) { $qpd_o[$dd] = $qpd_o[$dd] . '.000' }
if ($oo==2 ) { $qpd_o[$dd] = $qpd_o[$dd] . '0' }
$coach[$dd] = $trainer[$ti] ;
}
}

for ($ti=1;$ti<=$dd;$ti++) {
$quoten[$ti] = $qpd_o[$ti] ;
$quoten[$ti] = $quoten[$ti] . '#' ;
$quoten[$ti] = $quoten[$ti] . $ti ;
}

@rank = sort @quoten ;
@ranks = reverse @rank;
if ( $me == 3 ) { $tmp=1} else { $tmp=0}

if ( $me == 3 ) { $r=0} else { $r=-2}
for ($t=1;$t<=$dd+1;$t++){
if ( $me == 3 ) { $r--} else { $r++}
($king[$t] , $ident[$t])= split (/#/, $ranks[$r]);	
$place_old{$coach[$ident[$t]]} = $t-1 ;}



@quoten = () ;
@king = () ;
@ident = () ;
@ranks = () ;
@coach = () ;



$dd=0;

for ($ti=1;$ti<=$rr;$ti++) {
if ( $spiele[$ti] > $grenze-1 ) {
$dd++;
$qpd[$dd] = int ( ($qr_g[$ti] / $spiele[$ti] ) * 1000 ) / 1000 ;

$xx="111";

if ($qpd[$dd]<10 ) { $qpd[$dd] = '0' . $qpd[$dd] }
( $yy , $xx ) = split (/\./ , $qpd[$dd] ) ;
$oo = length($xx) ;
if ($oo==1 ) { $qpd[$dd] = $qpd[$dd] . '00' }
if ($oo==0 ) { $qpd[$dd] = $qpd[$dd] . '.000' }
if ($oo==2 ) { $qpd[$dd] = $qpd[$dd] . '0' }
$quote[$dd] = $qp_g[$ti] ;
$coach[$dd] = $trainer[$ti] ;
$sp[$dd] = $spiele[$ti] ;
}
}

for ($ti=1;$ti<=$dd;$ti++) {
$quoten[$ti] = $qpd[$ti] ;
$quoten[$ti] = $quoten[$ti] . '#' ;
$quoten[$ti] = $quoten[$ti] . $ti ;
}

@rank = sort @quoten ;
@ranks = reverse @rank;


if ( $me == 3 ) { $r=0} else { $r=-2}

for ($t=1;$t<=$dd+1;$t++){
if ( $me == 3 ) { $r--} else { $r++}
($king[$t] , $ident[$t])= split (/#/, $ranks[$r]);	
}




print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>\n";
print "<table border=0 cellpadding=1 cellspacing=1>\n";


print "<tr>\n";
print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1>&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1>&nbsp;</td>\n";

print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Trainer</td>\n";
print "<td bgcolor=#f5f5ff align=left colspan=2><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;aktueller Verein / Liga</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;Sp.&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;$l_s[5]&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;$l_s[4]&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;$l_s[3]&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;$l_s[2]&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;$l_s[1]&nbsp;</td>\n";


print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;Gesamt&nbsp;</td>\n";
print "</tr>\n";


for ($t=1;$t<=$dd;$t++){

$ein=0;
$tt=$t+1;
$color="black" ;
if ($coach[$ident[$tt]] eq $trainer ) { $color="red" }
if ( ( $t<=$marker ) or  ($coach[$ident[$tt]] eq $trainer ) ) { $ein = 1 }
if ( $loss== 2 ) {$ein=0}
if ( ( $liga{$coach[$ident[$tt]]} == $liga{$trainer} ) and  ($loss == 2 ) ) { $ein = 1 }

if ( $ein == 1 ) {

if ( $t == $place_old{$coach[$ident[$tt]]} ) { $ima = "pfeil=.gif" }
if ( $t < $place_old{$coach[$ident[$tt]]} ) { $ima = "pfeil++.gif" }
if ( $t > $place_old{$coach[$ident[$tt]]} ) { $ima = "pfeil--.gif" }
if ( $t < ( $place_old{$coach[$ident[$tt]]} - 10 ) ) { $ima = "pfeil+.gif" }
if ( $t > ( $place_old{$coach[$ident[$tt]]} + 10 ) ) { $ima = "pfeil-.gif" }

if ( $place_old{$coach[$ident[$tt]]} eq "" ) { $ima = "pfeil+.gif" }
if ( $place_old{$coach[$ident[$tt]]} eq "" ) { $place_old{$coach[$ident[$tt]]} = "--" }

print "<tr>\n";
print "<td bgcolor=#f5f5ff align=right><font face=verdana size=1 color=$color>&nbsp;&nbsp;$t .&nbsp;</td>\n";

print "<td bgcolor=#f5f5ff align=right><font face=verdana size=1>&nbsp;( $place_old{$coach[$ident[$tt]]} .)&nbsp;</td>\n";



print "<form name=x$tt action=/cgi-mod/btm/trainer.pl method=post><input type=hidden name=ident value=\"$coach[$ident[$tt]]\"></form><td bgcolor=#eeeeff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;<img src=/img/$ima>&nbsp;&nbsp;<a href=javascript:document.x$tt.submit()><img src=/img/h1.jpg border=0 alt=\"Trainerstatistik $coach[$ident[$tt]]\"></a>&nbsp;&nbsp;$coach[$ident[$tt]]&nbsp;&nbsp;</td>\n";
$color="black" ;
print "<form name=y$tt action=/cgi-mod/btm/verein.pl method=post><input type=hidden name=ident value=\"$verein{$coach[$ident[$tt]]}\"></form><td bgcolor=#f5f5ff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;<a href=javascript:document.y$tt.submit()><img src=/img/h1.jpg border=0 alt=\"Vereinsstatistik $verein{$coach[$ident[$tt]]}\"></a>&nbsp;&nbsp;$verein{$coach[$ident[$tt]]}&nbsp;&nbsp;</td>\n";


print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;$liga_kuerzel[$liga{$coach[$ident[$tt]]}]&nbsp;&nbsp;</td><!--ligaid=$liga{$coach[$ident[$t]]}-->\n";
print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;&nbsp;$sp[$ident[$tt]]&nbsp;&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;$qx4{$coach[$ident[$tt]]}&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;$qx5{$coach[$ident[$tt]]}&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;$qx6{$coach[$ident[$tt]]}&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;$qx7{$coach[$ident[$tt]]}&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;$qx8{$coach[$ident[$tt]]}&nbsp;</td>\n";

print "<td bgcolor=#CACBF6 align=center><font face=verdana size=1>&nbsp;$king[$tt]&nbsp;</td>\n";
print "</tr>";

}
}


print "</table>\n";
print "</td></tr></table>\n";
print "<font face=verdana size=1><br> [ In diesem Ranking sind insgesamt $dd aktive Trainer gelistet ]";

exit;
}





if ( $me == 4 ) {

open(D2,"/tmdata/btm/stat4.txt");
while(<D2>) {
$rr++;
($trainer[$rr],$rest) = split (/&/,$_);
($rest,$spiele[$rr],$sp_mi[$rr],$qm_g[$rr],  $qp_g[$rr] , $qm_mi[$ti], $sp, $qo4{$trainer[$rr]}, $qo5{$trainer[$rr]}, $qo6{$trainer[$rr]}, $qo7{$trainer[$rr]},$qo8{$trainer[$rr]}) = split (/&/,$_);
}
close (D2) ;




$dd=0;
for ($ti=1;$ti<=$rr;$ti++) {
if ( ( $spiele[$ti] - $sp_mi[$ti]) > $grenze-1 ) {
$dd++;
$qmd_old[$dd] = int ( ( ($qm_g[$ti]-$qm_mi[$ti]) / ($spiele[$ti] - $sp_mi[$ti]) ) * 100 ) / 100 ;
$xx="11";
( $yy , $xx ) = split (/\./ , $qmd_old[$dd] ) ;
$oo = length($xx) ;
if ($oo==1 ) { $qmd_old[$dd] = $qmd_old[$dd] . '0' }
if ($oo==0 ) { $qmd_old[$dd] = $qmd_old[$dd] . '.00' }
$coach[$dd] = $trainer[$ti] ;
}
}



for ($ti=1;$ti<=$dd;$ti++) {
$quoten[$ti] = $qmd_old[$ti] ;
$quoten[$ti] = $quoten[$ti] . '#' ;
$quoten[$ti] = $quoten[$ti] . $ti ;
}

@rank = sort @quoten ;
@ranks = reverse @rank ;

$r = 0;
for ($t=1;$t<=$dd+1;$t++){
$r--;
($king[$t] , $ident[$t])= split (/#/, $ranks[$r]);	
$place_old{$coach[$ident[$t]]} = $t-1 ;

}




@quoten = () ;
@king = () ;
@ident = () ;
@ranks = () ;
@coach = () ;




$dd=0;
for ($ti=1;$ti<=$rr;$ti++) {
if ( $spiele[$ti] > $grenze-1 ) {
$dd++;
$qmd[$dd] = int ( ($qm_g[$ti] / $spiele[$ti] ) * 100 ) / 100 ;
$xx="11";
( $yy , $xx ) = split (/\./ , $qmd[$dd] ) ;
$oo = length($xx) ;
if ($oo==1 ) { $qmd[$dd] = $qmd[$dd] . '0' }
if ($oo==0 ) { $qmd[$dd] = $qmd[$dd] . '.00' }
$quote[$dd] = $qm_g[$ti] ;
$coach[$dd] = $trainer[$ti] ;
$sp[$dd] = $spiele[$ti] ;
}
}



for ($ti=1;$ti<=$dd;$ti++) {
$quoten[$ti] = $qmd[$ti] ;
$quoten[$ti] = $quoten[$ti] . '#' ;
$quoten[$ti] = $quoten[$ti] . $ti ;
}

@rank = sort @quoten ;
@ranks = reverse @rank ;

$r = 0;
for ($t=1;$t<=$dd+1;$t++){
$r--;
($king[$t] , $ident[$t])= split (/#/, $ranks[$r]);	
}






print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>\n";
print "<table border=0 cellpadding=1 cellspacing=1>\n";


print "<tr>\n";
print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1>&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1>&nbsp;</td>\n";

print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Trainer</td>\n";
print "<td bgcolor=#f5f5ff align=left colspan=2><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;aktueller Verein / Liga</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;Sp.&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;$l_s[5]&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;$l_s[4]&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;$l_s[3]&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;$l_s[2]&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;$l_s[1]&nbsp;</td>\n";


print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;Gesamt&nbsp;</td>\n";
print "</tr>\n";


for ($t=1;$t<=$dd;$t++){

$tt=$t+1;

$ein=0;
$color="black" ;
if ($coach[$ident[$tt]] eq $trainer ) { $color="red" }
if ( ( $t<=$marker ) or  ($coach[$ident[$tt]] eq $trainer ) ) { $ein = 1 }
if ( $loss== 2 ) {$ein=0}
if ( ( $liga{$coach[$ident[$tt]]} == $liga{$trainer} ) and  ($loss == 2 ) ) { $ein = 1 }

if ( $ein == 1 ) {





if ( $t == $place_old{$coach[$ident[$tt]]} ) { $ima = "pfeil=.gif" }
if ( $t < $place_old{$coach[$ident[$tt]]} ) { $ima = "pfeil++.gif" }
if ( $t > $place_old{$coach[$ident[$tt]]} ) { $ima = "pfeil--.gif" }
if ( $t < ( $place_old{$coach[$ident[$tt]]} - 10 ) ) { $ima = "pfeil+.gif" }
if ( $t > ( $place_old{$coach[$ident[$tt]]} + 10 ) ) { $ima = "pfeil-.gif" }

if ( $place_old{$coach[$ident[$tt]]} eq "" ) { $ima = "pfeil+.gif" }
if ( $place_old{$coach[$ident[$tt]]} eq "" ) { $place_old{$coach[$ident[$tt]]} = "--" }

print "<tr>\n";
print "<td bgcolor=#f5f5ff align=right><font face=verdana size=1 color=$color>&nbsp;&nbsp;$t .&nbsp;</td>\n";

print "<td bgcolor=#f5f5ff align=right><font face=verdana size=1>&nbsp;( $place_old{$coach[$ident[$tt]]} .)&nbsp;</td>\n";



print "<form name=x$tt action=/cgi-mod/btm/trainer.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=ident value=\"$coach[$ident[$tt]]\"></form><td bgcolor=#eeeeff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;<img src=/img/$ima>&nbsp;&nbsp;<a href=javascript:document.x$tt.submit()><img src=/img/h1.jpg border=0 alt=\"Trainerstatistik $coach[$ident[$tt]]\"></a>&nbsp;&nbsp;$coach[$ident[$tt]]&nbsp;&nbsp;</td>\n";
$color="black" ;
print "<form name=y$tt action=/cgi-mod/btm/verein.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=ident value=\"$verein{$coach[$ident[$tt]]}\"></form><td bgcolor=#f5f5ff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;<a href=javascript:document.y$tt.submit()><img src=/img/h1.jpg border=0 alt=\"Vereinsstatistik $verein{$coach[$ident[$tt]]}\"></a>&nbsp;&nbsp;$verein{$coach[$ident[$tt]]}&nbsp;&nbsp;</td>\n";


print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;$liga_kuerzel[$liga{$coach[$ident[$tt]]}]&nbsp;&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;&nbsp;$sp[$ident[$tt]]&nbsp;&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;$qo4{$coach[$ident[$tt]]}&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;$qo5{$coach[$ident[$tt]]}&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;$qo6{$coach[$ident[$tt]]}&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;$qo7{$coach[$ident[$tt]]}&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;$qo8{$coach[$ident[$tt]]}&nbsp;</td>\n";

print "<td bgcolor=#CACBF6 align=center><font face=verdana size=1>&nbsp;$king[$tt]&nbsp;</td>\n";
print "</tr>";

}
}


print "</table>\n";
print "</td></tr></table>\n";


}




if ( $me == 5 ) {

$dd=0;

open(D2,"/tmdata/btm/stat5.txt");
while(<D2>) {
$rr++;
($trainer[$rr],$rest) = split (/&/,$_);
($rest,$spiele[$rr],$spiele_mi[$rr],$qp_g[$rr],  $qm_g[$rr] , $qp_mi[$ti] ,$qu4{$trainer[$rr]}, $qu5{$trainer[$rr]}, $qu8{$trainer[$rr]}, $qu9{$trainer[$rr]}, $qu10{$trainer[$rr]}) = split (/&/,$_)
}
close (D2) ;



open(D2,"/tmdata/btm/heer.txt");
while(<D2>) {
@go = ();
@go = split (/&/ , $_);
$bewerber_verein_platz{"$go[5]"} = $go[0] ;
$bewerber_verein_liga{"$go[5]"}= $go[1];
$bewerber_verein_basis{"$go[5]"}= $go[2];




}
close (D2);

for ($ti=1;$ti<=$rr;$ti++) {



$dd++;
$qpd[$dd] = 0;

if ( $bewerber_verein_basis{$verein{$trainer[$ti]}} == 1 ) {  $qpd[$dd]= 300 - (($bewerber_verein_platz{$verein{$trainer[$ti]}}-1)*3)}
if ( $bewerber_verein_basis{$verein{$trainer[$ti]}} == 2 ) {  $qpd[$dd]= 258 - (($bewerber_verein_platz{$verein{$trainer[$ti]}}-1)*3)}
if ( $bewerber_verein_basis{$verein{$trainer[$ti]}} == 3 ) {  $qpd[$dd]= 216 - (($bewerber_verein_platz{$verein{$trainer[$ti]}}-1)*3)}
if ( $bewerber_verein_basis{$verein{$trainer[$ti]}} == 4 ) {  $qpd[$dd]= 180 - (($bewerber_verein_platz{$verein{$trainer[$ti]}}-1)*3)}
if ( $bewerber_verein_basis{$verein{$trainer[$ti]}} == 5 ) {  $qpd[$dd]= 150 - (($bewerber_verein_platz{$verein{$trainer[$ti]}}-1)*3)}
if ( $bewerber_verein_basis{$verein{$trainer[$ti]}} == 6 ) {  $qpd[$dd]= 123 - (($bewerber_verein_platz{$verein{$trainer[$ti]}}-1)*3)}
if ( $bewerber_verein_basis{$verein{$trainer[$ti]}} == 7 ) {  $qpd[$dd]= 99 - (($bewerber_verein_platz{$verein{$trainer[$ti]}}-1)*3)}
if ( $bewerber_verein_basis{$verein{$trainer[$ti]}} == 8 ) {  $qpd[$dd]= 78 - (($bewerber_verein_platz{$verein{$trainer[$ti]}}-1)*3)}
if ( $bewerber_verein_basis{$verein{$trainer[$ti]}} == 9 ) {  $qpd[$dd]= 60 - (($bewerber_verein_platz{$verein{$trainer[$ti]}}-1)*3)}

$fa = $qpd[$dd] ;




if ( $qu8{$trainer[$ti]} ne "----" ) {
if  ( $qu8{$trainer[$ti]} > 0)  { $qpd[$dd] = int ( $qpd[$dd] + ($qu8{$trainer[$ti]}-0)) }
}
if ( $qu9{$trainer[$ti]} ne "----" ) {
if  ( $qu9{$trainer[$ti]} > 0)  { $qpd[$dd] = int ( $qpd[$dd] + ($qu9{$trainer[$ti]}-0)) }
}
if ( $qu10{$trainer[$ti]} ne "----" ) {
if  ( $qu10{$trainer[$ti]} > 0)  { $qpd[$dd] = int ( $qpd[$dd] + ($qu10{$trainer[$ti]}-0)) }
}


$fb = $qpd[$dd] - $fa ;

if ($qpd[$dd]<100 ) { $qpd[$dd] = '0' . $qpd[$dd] }
if ($qpd[$dd]<10 ) { $qpd[$dd] = '0' . $qpd[$dd] }
$quote[$dd] = $qpd[$ti] ;
$coach[$dd] = $trainer[$ti] ;

$sp[$dd] = $spiele[$ti] ;
$pu_a[$dd] = $fa ;
$pu_b[$dd] = $fb ;
}



for ($ti=1;$ti<=$dd;$ti++) {

$quoten[$ti] = $qpd[$ti] ;



$quoten[$ti] = $quoten[$ti] . '#' ;

$quoten[$ti] = $quoten[$ti] . $ti ;

}

@ranks = sort @quoten ;




for ($t=1;$t<=$dd;$t++){
$r--;
($king[$t] , $ident[$t])= split (/#/, $ranks[$r]);	
}






print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>\n";
print "<table border=0 cellpadding=1 cellspacing=1>\n";


print "<tr>\n";
print "<td bgcolor=#f5f5ff valign=bottom  align=left><font face=verdana size=1>&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff valign=bottom align=left><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Trainer</td>\n";
print "<td bgcolor=#f5f5ff valign=bottom align=left colspan=3><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;aktueller Verein / Liga / Plazierung</td>\n";
print "<td bgcolor=#f5f5ff valign=bottom align=center><font face=verdana size=1>&nbsp;Pu. A&nbsp;</td>\n";

print "<td bgcolor=#f5f5ff valign=bottom align=center><font face=verdana size=1>&nbsp;$l_s[3]&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff valign=bottom align=center><font face=verdana size=1>&nbsp;$l_s[2]&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff valign=bottom align=center><font face=verdana size=1>&nbsp;$l_s[1]&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff valign=bottom align=center><font face=verdana size=1>&nbsp;Pu. B&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;Punkte&nbsp;<br>&nbsp;A + B&nbsp;</td>\n";
print "</tr>\n";


for ($t=1;$t<=$dd;$t++){

$ein = 0;
$color="black" ;
if ($coach[$ident[$t]] eq $trainer ) { $color="red" }
if ( ( $t<=$marker ) or  ($coach[$ident[$t]] eq $trainer ) ) { $ein = 1 }
if ( $loss== 2 ) {$ein=0}
if ( ( $liga{$coach[$ident[$t]]} == $liga{$trainer} ) and  ($loss == 2 ) ) { $ein = 1 }

if ( $ein == 1 ) {

print "<tr>\n";
print "<td bgcolor=#f5f5ff align=right><font face=verdana size=1 color=$color>&nbsp;&nbsp;$t .&nbsp;</td>\n";
print "<form name=x$t action=/cgi-mod/btm/trainer.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=ident value=\"$coach[$ident[$t]]\"></form><td bgcolor=#eeeeff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;<a href=javascript:document.x$t.submit()><img src=/img/h1.jpg border=0 alt=\"Trainerstatistik $coach[$ident[$t]]\"></a>&nbsp;&nbsp;$coach[$ident[$t]]&nbsp;&nbsp;</td>\n";
$color="black" ;
print "<form name=y$t action=/cgi-mod/btm/verein.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=ident value=\"$verein{$coach[$ident[$t]]}\"></form><td bgcolor=#f5f5ff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;<a href=javascript:document.y$t.submit()><img src=/img/h1.jpg border=0 alt=\"Vereinsstatistik $verein{$coach[$ident[$t]]}\"></a>&nbsp;&nbsp;$verein{$coach[$ident[$t]]}&nbsp;&nbsp;</td>\n";


print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;$liga_kuerzel[$liga{$coach[$ident[$t]]}]&nbsp;&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=right><font face=verdana size=1>&nbsp;&nbsp;$bewerber_verein_platz{$verein{$coach[$ident[$t]]}}. Platz &nbsp;</td>\n";
print "<td bgcolor=#cfd0e4 align=right><font face=verdana size=1>&nbsp;$pu_a[$ident[$t]]&nbsp;</td>\n";

print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;$qu8{$coach[$ident[$t]]}&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;$qu9{$coach[$ident[$t]]}&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;$qu10{$coach[$ident[$t]]}&nbsp;</td>\n";
print "<td bgcolor=#cfd0e4 align=right><font face=verdana size=1>&nbsp;$pu_b[$ident[$t]]&nbsp;</td>\n";

print "<td bgcolor=#CACBF6 align=center><font face=verdana size=1>&nbsp;$king[$t]&nbsp;</td>\n";
print "</tr>";


}
}

print "</table>\n";
print "</td></tr></table>\n";


}




if ( $me == 6 ) {


open(D2,"/tmdata/btm/stat6.txt");
while(<D2>) {
$rr++;
($trainer[$rr],$spiele[$rr],$sp_mi[$rr],$s_g[$rr],$si_mi[$rr],$u_g[$rr],$u_mi[$rr],$n_g[$rr],$tp_g[$rr],$tm_g[$rr],$qp_g[$rr],$qm_g[$rr],$pu[$rr],$pu_old[$rr]) = split (/&/,$_);
}
close (D2) ;


$dd=0;

for ($ti=1;$ti<=$rr;$ti++) {
if ( ($spiele[$ti] - $sp_mi[$ti]) > $grenze-1 ) {
$dd++;
$qpd_o[$ti] = ( $s_g[$ti] * 3 ) + $u_g[$ti] ;
$qpd_o[$ti] = $qpd_o[$ti] - (  ( $s_mi[$ti] * 3 ) + $u_mi[$ti] )  ;
$qpd_ox[$dd] = int ( ( $qpd_o[$ti] / ( $spiele[$ti] - $sp_mi[$ti] )) * 1000 ) / 1000 ;

$xx="111";

( $yy , $xx ) = split (/\./ , $qpd_ox[$dd] ) ;
$oo = length($xx) ;
if ($oo==1 ) { $qpd_ox[$dd] = $qpd_ox[$dd] . '00' }
if ($oo==0 ) { $qpd_ox[$dd] = $qpd_ox[$dd] . '.000' }
if ($oo==2 ) { $qpd_ox[$dd] = $qpd_ox[$dd] . '0' }
$coach[$dd] = $trainer[$ti] ;
}
}

for ($ti=1;$ti<=$dd;$ti++) {
$quoten[$ti] = $qpd_ox[$ti] ;
$quoten[$ti] = $quoten[$ti] . '#' ;
$quoten[$ti] = $quoten[$ti] . $ti ;
}

@ranks = sort @quoten ;

$r=0;
for ($t=1;$t<=$dd+1;$t++){
$r--;
($king[$t] , $ident[$t])= split (/#/, $ranks[$r]);	
$place_old{$coach[$ident[$t]]} = $t ;

}



@quoten = () ;
@king = () ;
@ident = () ;
@ranks = () ;
@coach = () ;



$dd=0;

for ($ti=1;$ti<=$rr;$ti++) {
if ( $spiele[$ti] > $grenze-1 ) {
$dd++;
$qpd_x[$ti] = ( $s_g[$ti] * 3 ) + $u_g[$ti] ;
$qpd[$dd] = int ( ( $qpd_x[$ti] / $spiele[$ti] ) * 1000 ) / 1000 ;

$xx="111";

( $yy , $xx ) = split (/\./ , $qpd[$dd] ) ;
$oo = length($xx) ;
if ($oo==1 ) { $qpd[$dd] = $qpd[$dd] . '00' }
if ($oo==0 ) { $qpd[$dd] = $qpd[$dd] . '.000' }
if ($oo==2 ) { $qpd[$dd] = $qpd[$dd] . '0' }
$quote[$dd] = $qp_g[$ti] ;
$coach[$dd] = $trainer[$ti] ;
$sp[$dd] = $spiele[$ti] ;
$sp_s[$dd] = $s_g[$ti] ;
$sp_u[$dd] = $u_g[$ti] ;
$sp_n[$dd] = $n_g[$ti] ;
$sp_tp[$dd] = $tp_g[$ti] ;
$sp_tm[$dd] = $tm_g[$ti] ;





}
}

for ($ti=1;$ti<=$dd;$ti++) {
$quoten[$ti] = $qpd[$ti] ;
$quoten[$ti] = $quoten[$ti] . '#' ;
$quoten[$ti] = $quoten[$ti] . $ti ;

}

@ranks = sort @quoten ;

$r=0;
for ($t=1;$t<=$dd+1;$t++){
$r--;
($king[$t] , $ident[$t])= split (/#/, $ranks[$r]);	
}






print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>\n";
print "<table border=0 cellpadding=1 cellspacing=1>\n";


print "<tr>\n";
print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1>&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1>&nbsp;</td>\n";

print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Trainer</td>\n";
print "<td bgcolor=#f5f5ff align=left colspan=2><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;aktueller Verein / Liga</td>\n";
print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1>&nbsp;Sp.</td>\n";
print "<td bgcolor=#f5f5ff align=center colspan=3><font face=verdana size=1>&nbsp;Bilanz&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;Tore&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;Pu.&nbsp;</td>\n";
print "</tr>\n";


for ($t=1;$t<=$dd;$t++){

$ein=0;
$tt=$t;

$color="black" ;
if ($coach[$ident[$tt]] eq $trainer ) { $color="red" }
if ( ( $t<=$marker ) or  ($coach[$ident[$tt]] eq $trainer ) ) { $ein = 1 }
if ( $loss== 2 ) {$ein=0}
if ( ( $liga{$coach[$ident[$tt]]} == $liga{$trainer} ) and  ($loss == 2 ) ) { $ein = 1 }

if ( $ein == 1 ) {

if ( $t == $place_old{$coach[$ident[$t]]} ) { $ima = "pfeil=.gif" }
if ( $t < $place_old{$coach[$ident[$t]]} ) { $ima = "pfeil++.gif" }
if ( $t > $place_old{$coach[$ident[$t]]} ) { $ima = "pfeil--.gif" }
if ( $t < ( $place_old{$coach[$ident[$t]]} - 10 ) ) { $ima = "pfeil+.gif" }
if ( $t > ( $place_old{$coach[$ident[$t]]} + 10 ) ) { $ima = "pfeil-.gif" }

if ( $place_old{$coach[$ident[$t]]} eq "" ) { $ima = "pfeil+.gif" }
if ( $place_old{$coach[$ident[$t]]} eq "" ) { $place_old{$coach[$ident[$t]]} = "--" }

print "<tr>\n";
print "<td bgcolor=#f5f5ff align=right><font face=verdana size=1 color=$color>&nbsp;&nbsp;$t .&nbsp;</td>\n";

print "<td bgcolor=#f5f5ff align=right><font face=verdana size=1>&nbsp;( $place_old{$coach[$ident[$t]]} .)&nbsp;</td>\n";



print "<form name=x$tt action=/cgi-mod/btm/trainer.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=ident value=\"$coach[$ident[$t]]\"></form><td bgcolor=#eeeeff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;<img src=/img/$ima>&nbsp;&nbsp;<a href=javascript:document.x$t.submit()><img src=/img/h1.jpg border=0 alt=\"Trainerstatistik $coach[$ident[$t]]\"></a>&nbsp;&nbsp;$coach[$ident[$t]]&nbsp;&nbsp;</td>\n";
$color="black" ;
print "<form name=y$tt action=/cgi-mod/btm/verein.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=ident value=\"$verein{$coach[$ident[$t]]}\"></form><td bgcolor=#f5f5ff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;<a href=javascript:document.y$tt.submit()><img src=/img/h1.jpg border=0 alt=\"Vereinsstatistik $verein{$coach[$ident[$t]]}\"></a>&nbsp;&nbsp;$verein{$coach[$ident[$t]]}&nbsp;&nbsp;</td>\n";


print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;$liga_kuerzel[$liga{$coach[$ident[$t]]}]&nbsp;&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;$sp[$ident[$t]]&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;$sp_s[$ident[$t]]&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;$sp_u[$ident[$t]]&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;$sp_n[$ident[$t]]&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=center><font face=verdana size=1>&nbsp;$sp_tp[$ident[$t]] : $sp_tm[$ident[$t]]&nbsp;</td>\n";


print "<td bgcolor=#CACBF6 align=center><font face=verdana size=1>&nbsp;$king[$tt]&nbsp;</td>\n";
print "</tr>";

}
}


print "</table>\n";
print "</td></tr></table>\n";


}

print "<font face=verdana size=1><br> [ In diesem Ranking sind insgesamt $dd aktive Trainer gelistet ]";
exit;




sub readin_data {

open(D2,"/tmdata/btm/history.txt");
while(<D2>) {
$li++;
@vereine = split (/&/, $_);
$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
$y++;
chomp $verein[$y];
$data[$x] = $vereine[$y];
$y++;
chomp $verein[$y];
$datb[$x] = $vereine[$y];
$verein{"$datb[$x]"} = $data[$x] ;
$liga{"$datb[$x]"} = $li ;
$y++;
chomp $verein[$y];
$datc[$x] = $vereine[$y];
}
}
close(D2);

open(D2,"/tmdata/btm/heer.txt");
while(<D2>) {
@go = ();
@go = split (/&/ , $_);
$vplatz{"$go[5]"} = $go[0] ;
}
close (D2);
$border=(($saison_sel-6)*34)+(($runde_sel)*4);


$file = "/tmdata/btm/db/wranking/stat_".$border;
if (!-e $file) {$border=$border+2;$file = "/tmdata/btm/db/wranking/stat_".$border;}
open(A,$file);
while(<A>){
$tr++;@data = split(/&/,$_);$tmp=$_;chomp $tmp;
$tab1[$data[14]]=$tmp;
$tab2[$data[15]]=$tmp;
$tab3[$data[16]]=$tmp;
$tab4[$data[17]]=$tmp;
}
close(A);

$tmpr = $runde_sel ;
if ($tmpr == 0){$tmpr=9;$saison_sel=$saison_sel-1;}
$last=(($saison_sel-6)*34)+(($tmpr-1)*4);
$file = "/tmdata/btm/db/wranking/stat_".$last;

if (!-e $file) {$last=$last+2;$file = "/tmdata/btm/db/wranking/stat_".$last;}
open(A,$file);
while(<A>){
@data = split(/&/,$_);$tmp=$_;chomp $tmp;
$pl1{$data[0]}=$data[14];
$pl2{$data[0]}=$data[15];
$pl3{$data[0]}=$data[16];
$pl4{$data[0]}=$data[17];
}
close(A);

}






sub display {

print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>\n";
print "<table border=0 cellpadding=1 cellspacing=1>\n";


print "<tr>\n";
print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1>&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1>&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Trainer</td>\n";
print "<td bgcolor=#f5f5ff align=left><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;aktueller Verein </td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;Liga&nbsp;</td>\n";

print "<td bgcolor=#f5f5ff align=center colspan=3><font face=verdana size=1>Bilanz</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;Tore&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;Pu.&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;Optimizer&nbsp;</td>\n";
print "<td bgcolor=#f5f5ff align=center><font face=verdana size=1>&nbsp;zu Vert. &nbsp;</td>\n";

print "</tr>\n";
if ($me == 1){@tab = @tab1;%p=%pl1}
if ($me == 2){@tab = @tab2;%p=%pl2}
if ($me == 3){@tab = @tab3;%p=%pl3}
if ($me == 4){@tab = @tab4;%p=%pl4}



for ($t=1;$t<=$tr;$t++){

$ein=0;





@data = split(/&/,$tab[$t]);
if (($data[0] eq $trainer )){$color="red"}
if ( ( $t<=30 ) or  ($data[0] eq $trainer ) ) { $ein = 1 }
if ( $loss== 2 ) {$ein=0}
if ( ( $liga{$data[0]} == $liga{$trainer} ) and  ($loss == 2 ) ) { $ein = 1 }


if ( $ein == 1 ) {

if ( $t == $p{$data[0]} ) { $ima = "pfeil=.gif" }
if ( $t < $p{$data[0]} ) { $ima = "pfeil++.gif" }
if ( $t > $p{$data[0]} ) { $ima = "pfeil--.gif" }
if ( $t < ( $p{$data[0]} - 10 ) ) { $ima = "pfeil+.gif" }
if ( $t > ( $p{$data[0]} + 10 ) ) { $ima = "pfeil-.gif" }

if ( $p{$data[0]} eq "" ) { $ima = "pfeil+.gif" }
if ( $p{$data[0]} eq "") { $p{$data[0]} = "--" }

print "<tr>\n";

print "<td bgcolor=#f5f5ff align=right NOWRAP><font face=verdana size=1 color=$color>&nbsp;&nbsp;$t.&nbsp;</td>\n";

print "<td bgcolor=#f5f5ff align=right NOWRAP><font face=verdana size=1>&nbsp;( $p{$data[0]}.)&nbsp;</td>\n";
$tmp=$data[0];$tmp=~s/ /%20/g;
print "<td bgcolor=#eeeeff align=left NOWRAP><font face=verdana size=1 color=$color>&nbsp;&nbsp;<img src=/img/$ima>&nbsp;&nbsp;<a href=/cgi-mod/btm/trainer.pl?ident=$tmp target=new><img src=/img/h1.jpg border=0 alt=\"Trainerstatistik $data[0]\"></a>&nbsp;&nbsp;$data[0]&nbsp;&nbsp;</td>\n";
$color="black" ;
$tmp=$verein{$data[0]};$tmp=~s/ /%20/g;
if ($tmp){
print "<td bgcolor=#f5f5ff align=left NOWRAP><font face=verdana size=1 color=$color>&nbsp;&nbsp;<a href=/cgi-mod/btm/verein.pl?ident=$tmp target=new><img src=/img/h1.jpg border=0 alt=\"Vereinsstatistik $verein{$data[0]}\"></a>&nbsp;&nbsp;$verein{$data[0]}&nbsp;&nbsp;</td>\n";

$tmp="";if ($vplatz{$verein{$data[0]}} < 10){$tmp="0"}
print "<td bgcolor=#f5f5ff align=right NOWRAP><font face=verdana size=1 color=$color>&nbsp;&nbsp;$liga_kuerzel[$liga{$data[0]}] [$tmp$vplatz{$verein{$data[0]}}.]&nbsp;&nbsp;</td>\n";
} else {
print "<td bgcolor=#f5f5ff colspan=2></td>";
}

print "<td bgcolor=#eeeeff align=right NOWRAP><font face=verdana size=1>&nbsp;$data[2]&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=right NOWRAP><font face=verdana size=1>&nbsp;$data[3]&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=right NOWRAP><font face=verdana size=1>&nbsp;$data[4]&nbsp;</td>\n";


$co="#eeeeff";if ($me==2 || $me==4){$co="#CACBF6"}
print "<td bgcolor=$co align=center NOWRAP><font face=verdana size=1>&nbsp;$data[5] : $data[6]&nbsp;</td>\n";
$co="#eeeeff";if ($me==1){$co="#CACBF6"}
print "<td bgcolor=$co align=center NOWRAP><font face=verdana size=1>&nbsp;$data[1] Pu.&nbsp;</td>\n";
$co="#eeeeff";if ($me==3){$co="#CACBF6"}
print "<td bgcolor=$co align=center NOWRAP><font face=verdana size=1>&nbsp;&#216; $data[9]&nbsp;</td>\n";

$kuerzel1="";$kuerzel2="";

if ($me == 1){$kuerzel1="Pu.";$wert=$data[12]}
if ($me == 2){$kuerzel1="To.";$wert=$data[10]}
if ($me == 3){$kuerzel2="&#216;";$wert=$data[13]}
if ($me == 4){$kuerzel1="To.";$wert=$data[11]}


print "<td bgcolor=#eeeeee align=right NOWRAP><font face=verdana size=1>&nbsp;$kuerzel2 $wert $kuerzel1&nbsp;</td>\n";



print "</tr>";

}
}


print "</table>\n";
print "</td></tr></table>\n";

print "<br> &nbsp; $t Trainer in diesem Ranking gelistet ...";

}
