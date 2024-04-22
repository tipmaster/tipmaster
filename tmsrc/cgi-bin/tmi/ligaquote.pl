#!/usr/bin/perl

=head1 NAME
	TMI ligaquote.pl

=head1 SYNOPSIS
	TBD
	


=head1 CHANGELOG
	2015-06-09 Thomas: Added Session Management


	Created 2015-06-09

=cut

use lib '/tmapp/tmsrc/cgi-bin/'; 
use TMSession;
my $session = TMSession::getSession(tmi_login => 1);
my $trainer = $session->getUser();
my $leut = $trainer;

use CGI;
require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl" ;
require "/tmapp/tmsrc/cgi-bin/runde.pl" ;
require "/tmapp/tmsrc/cgi-bin/tmi/saison.pl" ;

$akt_saison = $main_nr -5;


open (D1,"/tmdata/tmi/tip_datum.txt");
$leer=<D1>;
$sp_ende=<D1>;
chomp $sp_ende;
close (D1);

print "Content-Type: text/html \n\n";




use CGI;
$query = new CGI;
$me = $query->param('me');
$loss = $query->param('loss');
$top = $query->param('top');
$sp_start = $query->param('sp_start');
$sp_ende = $query->param('sp_ende');

$into = $query->param('into');
$sai = $query->param('sai');

$saison=$sai;
$liga = 1;

$leut = $trainer ;



$ein=0;
for ( $x = 1; $x <= 6; $x++ ) {
if ( $x == $me ) { $ein = 1 }
}
if ($ein == 0 ) {$me=2}

$ein=0;
for ( $x = 1; $x < 3; $x++ ) {
if ( $x == $loss ) { $ein = 1 }
}
if ($ein == 0 ) {$loss=1}


$ein=0;
for ( $x = 1; $x <= $akt_saison+1; $x++ ) {
if ( $x == $saison ) { $ein = 1 }
}
if ($ein == 0 ) {$saison=$akt_saison+1}

$ein=0;
for ( $x = 1; $x <= 4; $x++ ) {
if ( $x == $top ) { $ein = 1 }
}
if ($ein == 0 ) {$top=2}

$ein=0;
for ( $x = 1; $x <= 5; $x++ ) {
if ( $x == $into ) { $ein = 1 }
}
if ($ein == 0 ) {$into=4}


open(D2,"/tmdata/tmi/history.txt");
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


@sort =  ( undef , 1 , 2 , 5 , 6 , 9 , 10 , 13 , 14 , 17 , 18 , 21 , 22, 25
, 26 , 29 , 30 , 33 , 34 , 37 , 38 , 41 , 42 , 45 , 47 , 49 , 51 , 53 ,55 ,
57 , 59 , 117 , 61 , 63 , 65 , 67 , 69 , 71 , 73 , 75 , 77 , 79 , 81 ,83 ,
85 ,  87 , 89 , 91 , 93 , 95 , 97 , 99 , 101 , 103 , 105 , 107 , 109 ,111 ,113 , 118 , 115 );

for ($x=1;$x<=60;$x++){
$id{$sort[$x]}=$x;
}
if ( $saison < 10 ) {
$liga{$trainer}=$id{$liga{$trainer}};
}

if (( $saison > 9 ) and ($saison<12)) {



}



print "<head>\n";
print "<style type=\"text/css\">";
print "TD.ve { font-family:Verdana; font-size:8pt; color:black; }\n";


print "</style>\n";
print "</head>\n";




print "<html><title>TipMaster Trainer Ligavergleich</title><p align=left><body bgcolor=white text=black>\n";

require "/tmapp/tmsrc/cgi-bin/tag.pl" ;
require "/tmapp/tmsrc/cgi-bin/tag_small.pl" ;

print "<br>\n";
print "<font face=verdana size=1>";
$trainer = $leut ;

require "/tmapp/tmsrc/cgi-bin/loc_tmi.pl" ;
print "<br><font face=verdana size=2>&nbsp;<b>TMI - Ligenvergleich</b> &nbsp; &nbsp; &nbsp; &nbsp; <font size=1 face=verdana>[ QP = Quotenpunkte / UQP = Ueberfluessige Quotenpunkte ]<br><br>";
print "<form method=post action=/cgi-bin/tmi/ligaquote.pl target=_top>\n";
print "<font face=verdana size=1>";

@saison = @main_saison; 





print "<select style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=sai>";
for ($x=1;$x<=$akt_saison+1;$x++){
$gh = "";
if ( $x == $saison ) { $gh = "selected" }
$saison[$akt_saison+6]="Ranking ueber die letzten 8 Saisons";
print "<option value=$x $gh>$saison[$x+5] \n";
}
print "</select> &nbsp; &nbsp; ";
print "<select style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=me>";

$gh = "";
if ( $me == 1 ) { $gh = "selected" }
print "<option value=1 $gh>Die quotenstaerksten Ligen \n";
$gh = "";
if ( $me == 2 ) { $gh = "selected" }
print "<option value=2 $gh>Die torreichsten Ligen \n";

$gh = "";
if ( $me == 3 ) { $gh = "selected" }
print "<option value=3 $gh>Die Top - Optimizer Ligen \n";
print "</select> &nbsp; &nbsp; ";




print "&nbsp;&nbsp<input type=hidden name=id value=\"$id\"><input type=submit style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" value=\"Tabelle laden\"></form>";

#print "<font face=verdana size=1>Die drei bestplazierten Trainer am Ende jeder Saison erhalten einen  offiziellen Traineraward<br>der entspr. Kategorie in Gold , Silber und Bronze welcher auch im Trainerprofil gelistet wird .<br><br>\n";

#if ( $me==1 ) { print "In dieser Tabelle werden alle Ergebnisse eines Trainers seit der Saison 1999'1 addiert .<br>Die Tabelle wird sortiert nach der Anzahl der erreichten Punkte .<br><br>" }
#if ( $me==2 ) { print "In dieser Tabelle werden alle erzielten Tipergebnisse seit der Saison 1999'1 gewertet .<br>Die Tabelle wird sortiert nach der bisherigen durchschnittlichen Tipquote des Trainers.<br><br>" }
#if ( $me==3 ) { print "In dieser Tabelle werden alle ueberfluessigen Tipergebnisse ueber die Torgrenzen hinaus seit der Saison 1999'1 gewertet .<br>Die Tabelle wird sortiert nach den durchschnittlich niedrigsten ueberfluessigen Tipresten des Trainers.<br><br>" }
#if ( $me==4 ) { print "In dieser Tabelle werden alle erzielten Tipergebnisse der Gegner eines Trainers seit der Saison 1999'1 gewertet .<br>Die Tabelle wird sortiert nach der bisherigen niedrigsten durchschnittlichen Tipquote der Gegner des Trainers.<br><br>" }
#if ( $me==5 ) { print "Diese Tabelle ist fuer die Vergabe von Trainerposten ueber die Jobboerse ausschlaggebend .<br>Fuer die Punktezahl eines Trainers sind zum einen die Tipquoten der letzten drei Saisons<br>eines Trainers sowie die aktuelle Vereinsplazierung des Trainers relevant .<br><br>" }








$marker=30;
$grenze = 22 ;

$sai = $saison+5;

$datei = "/tmdata/tmi/ligaquote.txt";


open(D2,"<$datei");
while(<D2>) {
@boh =  split (/#/,$_);
#print "$_<br>";

$d[1][$boh[1]][$boh[0]]=$boh[3];
$d[2][$boh[1]][$boh[0]]=$boh[4];
$d[3][$boh[1]][$boh[0]]=$boh[5];
$d[4][$boh[1]][$boh[0]]=$boh[6];
$d[5][$boh[1]][$boh[0]]=$boh[4];
$d[6][$boh[1]][$boh[0]]=$boh[8];


if ( $boh[0] == $sai-1 ) {
$rr++;
($leer,$trainer[$rr],$sp,$q_g[$rr],$t_g[$rr],$o_g[$rr],$qp_g[$rr],$tp_g[$rr],$op_g[$rr]) = split (/#/,$_);
}

}
close (D2) ;

if ( $sai == ($akt_saison+6)){$rr=213}

if ( $me == 1 ) {
for ($ti=1;$ti<=$rr;$ti++) {

if ( $sai == ($akt_saison+6)){
$q_g[$ti]=0;
for ($ss=$sai-9;$ss<=$sai-1;$ss++){
$q_g[$ti]+=$d[1][$ti][$ss];
}}

if ( $q_g[$ti]<10 ) {$q_g[$ti]='0' . $q_g[$ti] }
if ( $q_g[$ti]<100 ) {$q_g[$ti]='0' . $q_g[$ti] }
if ( $q_g[$ti]<1000 ) {$q_g[$ti]='0' . $q_g[$ti] }
if ( $q_g[$ti]<10000 ) {$q_g[$ti]='0' . $q_g[$ti] }



$quoten[$ti] = $q_g[$ti] ;
$quoten[$ti] = $quoten[$ti] . '#' ;
$quoten[$ti] = $quoten[$ti] . $ti ;
}
}


if ( $me == 2 ) {
for ($ti=1;$ti<=$rr;$ti++) {

if ( $sai == ($akt_saison+6)){
$t_g[$ti]=0;
for ($ss=$sai-9;$ss<=$sai-1;$ss++){
$t_g[$ti]+=$d[2][$ti][$ss];
}}


if ( $t_g[$ti]<10 ) {$t_g[$ti]='0' . $t_g[$ti] }
if ( $t_g[$ti]<100 ) {$t_g[$ti]='0' . $t_g[$ti] }
if ( $t_g[$ti]<1000 ) {$t_g[$ti]='0' . $t_g[$ti] }
if ( $t_g[$ti]<10000 ) {$t_g[$ti]='0' . $t_g[$ti] }
if ( $t_g[$ti]<100000 ) {$t_g[$ti]='0' . $t_g[$ti] }

$quoten[$ti] = $t_g[$ti] ;
$quoten[$ti] = $quoten[$ti] . '#' ;
$quoten[$ti] = $quoten[$ti] . $ti ;
}
}


if ( $me == 3 ) {
for ($ti=1;$ti<=$rr;$ti++) {

if ( $sai == ($akt_saison+6)){
$o_g[$ti]=0;
for ($ss=$sai-9;$ss<=$sai-1;$ss++){
$o_g[$ti]+=$d[3][$ti][$ss];
}}


$x=1000000-$o_g[$ti];
if ( $x<10 ) {$x='0' . $x }
if ( $x<100 ) {$x='0' . $x }
if ( $x<1000 ) {$x='0' . $x }
if ( $x<10000 ) {$x='0' . $x }
if ( $x<100000 ) {$x='0' . $x }

$quoten[$ti] = $x ;
$quoten[$ti] = $quoten[$ti] . '#' ;
$quoten[$ti] = $quoten[$ti] . $ti ;
}
}


@ranks = () ;
@king = () ;
@ident = () ;


@ranks = sort @quoten ;


@quoten = () ;

$r=0;
for ($t=1;$t<=$rr;$t++){
$r--;
($leer ,$ident[$t])= split (/#/, $ranks[$r]);	
}






if ( $sai!=($akt_saison+6)){

print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>\n";
print "<table border=0 cellpadding=1 cellspacing=1>\n";


print "<tr>\n";
print "<td class=ve bgcolor=#f5f5ff align=left>&nbsp;</td>\n";

print "<td class=ve bgcolor=#f5f5ff align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Liga</td>\n";
#print "<td class=ve bgcolor=#f5f5ff align=left colspan=2><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;aktueller Verein / Liga</td>\n";
#print "<td class=ve bgcolor=#f5f5ff align=left>&nbsp;Sp.</td>\n";
#print "<td class=ve bgcolor=#f5f5ff align=center colspan=3><font face=verdana size=1>&nbsp;Bilanz&nbsp;</td>\n";
#print "<td class=ve bgcolor=#f5f5ff align=center>&nbsp;Tore&nbsp;</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=center colspan=2>&nbsp;Quote&nbsp;</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=center colspan=2>&nbsp;Tore&nbsp;</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=center colspan=2>&nbsp;Optimizer&nbsp;</td>\n";
print "</tr>\n";

$marker=50;
for ($t=1;$t<=$rr;$t++){
$ein = 0;

$color="black" ;
if ($trainer[$ident[$t]] eq $liga{$trainer} ) { $color="red" }
if ( ( $t<=$marker ) or  ($liga{$trainer} == $trainer[$ident[$t]] ) ) { $ein = 1 }
if ( $loss== 2 ) {$ein=0}
if ( ( $liga{$trainer[$ident[$t]]} == $liga{$trainer} ) and  ($loss == 2 ) ) { $ein = 1 }


if ( $ein == 1 ) {


$col = "#f5f5ff" ;



$img="";


print "<tr>\n";
print "<td bgcolor=$col align=right><font face=verdana size=1 color=$color> &nbsp; $t .&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;$liga_namen[$ident[$t]] &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </td>\n";

$q_g[$ident[$t]] = $q_g[$ident[$t]] *1;
$t_g[$ident[$t]] = $t_g[$ident[$t]] *1;
$o_g[$ident[$t]] = $o_g[$ident[$t]] *1;

if (( $me == 1)){ $color="#dddeff" } else { $color="#eeeeff"}
print "<td class=ve bgcolor=$color align=right>&nbsp; &nbsp; $q_g[$ident[$t]] QP &nbsp;</td>\n";
print "<td class=ve bgcolor=$color align=right>&nbsp; &nbsp; $qp_g[$ident[$t]] &nbsp;</td>\n";
if (( $me == 2)){ $color="#dddeff" } else { $color="#eeeeff"}
print "<td class=ve bgcolor=$color align=right>&nbsp; &nbsp; $t_g[$ident[$t]] Tore &nbsp;</td>\n";
print "<td class=ve bgcolor=$color align=right>&nbsp; &nbsp; $tp_g[$ident[$t]] &nbsp;</td>\n";

if (( $me == 3)){ $color="#dddeff" } else { $color="#eeeeff"}
print "<td class=ve bgcolor=$color align=right>&nbsp; &nbsp; $o_g[$ident[$t]] UQP &nbsp;</td>\n";
print "<td class=ve bgcolor=$color align=right>&nbsp; &nbsp; $op_g[$ident[$t]] &nbsp;</td>\n";

print "</tr>";
}
}


print "</table>\n";
print "</td></tr></table>\n";




}else {
print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>\n";
print "<table border=0 cellpadding=1 cellspacing=1>\n";


print "<tr>\n";
print "<td class=ve bgcolor=#f5f5ff align=left>&nbsp;</td>\n";

print "<td class=ve colspan=2 bgcolor=#f5f5ff align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;Liga</td>\n";
for($x=$sai-1;$x>=$sai-8;$x--){
print "<td class=ve bgcolor=#f5f5ff align=center> &nbsp; $main_kuerzel[$x] &nbsp;</td>";
}
print "</tr>";

$marker=50;
for ($t=1;$t<=$rr;$t++){
$ein = 0;
if ($trainer[$ident[$t]] eq $liga{$trainer} ) { $color="red" }
$color="black" ;
if ($ident[$t] eq $liga{$trainer} ) { $color="red" }
if ( ( $t<=$marker ) or  ($liga{$trainer} == $ident[$t] ) ) { $ein = 1
 }
if ( $loss== 2 ) {$ein=0}
if ( ( $liga{$ident[$t]} == $liga{$trainer} ) and  ($loss == 2 ) ) { $ein = 1 }

if ( $ein == 1 ) {
$col = "#f5f5ff" ;
$img="";


print "<tr>\n";
print "<td bgcolor=$col align=right><font face=verdana size=1 color=$color> &nbsp;
 $t .&nbsp;</td>\n";
print "<td bgcolor=#eeeeff align=left><font face=verdana size=1 color=$color>
&nbsp;$liga_namen[$ident[$t]]  &nbsp; &nbsp; 
 &nbsp; &nbsp; &nbsp; </td>\n";

$q_g[$ident[$t]] = $q_g[$ident[$t]] *1;
$t_g[$ident[$t]] = $t_g[$ident[$t]] *1;
$o_g[$ident[$t]] = $o_g[$ident[$t]] *1;

if ( $me == 2 ) { $ok = $t_g[$ident[$t]] ;
print "<td class=ve bgcolor=#eeeddf align=right> &nbsp; $ok Tore &nbsp; </td>";
}

if ( $me == 1 ) { $ok = $q_g[$ident[$t]] ;

print "<td class=ve bgcolor=#eeeddf align=right> &nbsp; $ok Quote &nbsp; </td>";
}

if ( $me == 3 ) { $ok = $o_g[$ident[$t]] ;
print "<td class=ve bgcolor=#eeeddf align=right> &nbsp; $ok Opt. &nbsp; </td>";
}


for($x=$sai-1;$x>=$sai-8;$x--){


print "<td class=ve bgcolor=#dddeff align=right> &nbsp; $d[$me+3][$ident[$t]][$x-1] &nbsp; </td>";
}



print "</tr>";
}
}

print "</table>\n";
print "</td></tr></table>\n";
}





exit ;







