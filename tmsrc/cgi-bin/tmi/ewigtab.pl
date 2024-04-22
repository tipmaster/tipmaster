#!/usr/bin/perl

=head1 NAME
	TMI ewigtab.pl

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
$akt_saison = 12;

open (D1,"/tmdata/tmi/tip_datum.txt");
$leer=<D1>;
$sp_ende=<D1>;
chomp $sp_ende;
close (D1);

print "Content-Type: text/html \n\n";





$query = new CGI;
$me = $query->param('me');
$loss = $query->param('loss');
$top = $query->param('top');
$sp_start = $query->param('sp_start');
$sp_ende = $query->param('sp_ende');
$into = $query->param('into');
$sai = $query->param('sai');

$liga = 1;

$leut = $trainer ;



$ein=0;
for ( $x = 1; $x <= 6; $x++ ) {
if ( $x == $me ) { $ein = 1 }
}
if ($ein == 0 ) {$me=1}

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
$vereina{"$datb[$x]"} = $data[$x] ;
$vereinb{"$data[$x]"} = $datb[$x] ;
$liga{"$datb[$x]"} = $li ;
$ligav{"$data[$x]"} = $li ;
$y++;
chomp $verein[$y];
$datc[$x] = $vereine[$y];
}
}
close(D2);

if ( $sai == 0 ) { $sai = $liga{$trainer} }
$ein=0;
for ( $x = 1; $x <=$rr_ligen ; $x++ ) {
if ( $x == $sai ) { $ein = 1 }
}
if ($ein == 0 ) {$sai=1}


print "<head>\n";
print "<style type=\"text/css\">";
print "TD.ve { font-family:Verdana; font-size:8pt; color:black; }\n";


print "</style>\n";
print "</head>\n";




print "<html><title>TipMaster Ewige Tabellen</title><p align=left><body bgcolor=white text=black>\n";

require "/tmapp/tmsrc/cgi-bin/tag.pl" ;
require "/tmapp/tmsrc/cgi-bin/tag_small.pl" ;

print "<br><br>\n";
print "<font face=verdana size=1>";
$trainer = $leut ;

require "/tmapp/tmsrc/cgi-bin/loc_tmi.pl" ;
print "<br>";
print "<form method=post action=/cgi-bin/tmi/ewigtab.pl target=_top>\n";
print "<font face=verdana size=1>";


print "<select style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=sai>";

for ($x=1;$x<=$rr_ligen;$x++){
$gh = "";
if ( $x == $sai ) { $gh = "selected" }
print "<option value=$x $gh>$liga_namen[$x] \n";
}


print "</select> &nbsp; ";

print "<select style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=me>";

$gh = "";
if ( $me == 1 ) { $gh = "selected" }
print "<option value=1 $gh>Ewige Tabelle Gesamt \n";
$gh = "";
if ( $me == 2 ) { $gh = "selected" }
print "<option value=2 $gh>Ewige Tabelle Relativ \n";

print "</select> &nbsp; &nbsp; ";




print "&nbsp;&nbsp<input type=hidden name=id value=\"$id\"><input type=submit style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" value=\"Tabelle laden\"> &nbsp; &nbsp; &nbsp;</form>";

if ($me ==2 ) {
print "<font face=verdana size=1>[ Beim Relativ - Ranking werden nur Vereine mit mind. 34 Spielen in der entsprechenden Liga gewertet ]<br><br>";
}

#print "<font face=verdana size=1>Die drei bestplazierten Trainer am Ende jeder Saison erhalten einen  offiziellen Traineraward<br>der entspr. Kategorie in Gold , Silber und Bronze welcher auch im Trainerprofil gelistet wird .<br><br>\n";

#if ( $me==1 ) { print "In dieser Tabelle werden alle Ergebnisse eines Trainers seit der Saison 1999'1 addiert .<br>Die Tabelle wird sortiert nach der Anzahl der erreichten Punkte .<br><br>" }
#if ( $me==2 ) { print "In dieser Tabelle werden alle erzielten Tipergebnisse seit der Saison 1999'1 gewertet .<br>Die Tabelle wird sortiert nach der bisherigen durchschnittlichen Tipquote des Trainers.<br><br>" }
#if ( $me==3 ) { print "In dieser Tabelle werden alle ueberfluessigen Tipergebnisse ueber die Torgrenzen hinaus seit der Saison 1999'1 gewertet .<br>Die Tabelle wird sortiert nach den durchschnittlich niedrigsten ueberfluessigen Tipresten des Trainers.<br><br>" }
#if ( $me==4 ) { print "In dieser Tabelle werden alle erzielten Tipergebnisse der Gegner eines Trainers seit der Saison 1999'1 gewertet .<br>Die Tabelle wird sortiert nach der bisherigen niedrigsten durchschnittlichen Tipquote der Gegner des Trainers.<br><br>" }
#if ( $me==5 ) { print "Diese Tabelle ist fuer die Vergabe von Trainerposten ueber die Jobboerse ausschlaggebend .<br>Fuer die Punktezahl eines Trainers sind zum einen die Tipquoten der letzten drei Saisons<br>eines Trainers sowie die aktuelle Vereinsplazierung des Trainers relevant .<br><br>" }










$datei = "/tmdata/tmi/ewig/" . $sai . ".txt";

$grenze = 0;
if ( $me==2){$grenze=33}

open(D2,"<$datei");
while(<D2>) {

@boh =  split (/#/,$_);
if ($boh[1] > $grenze) {
$rr++;
($verein[$rr],$spiele[$rr],$pu_g[$rr],$pu_schnitt[$rr],$qu_schnitt[$rr],$s_g[$rr],$u_g[$rr],$n_g[$rr],$tp_g[$rr],$tm_g[$rr]) = split (/#/,$_);
$s_g[$rr]=$s_g[$rr]*1;
$u_g[$rr]=$u_g[$rr]*1;
$n_g[$rr]=$n_g[$rr]*1;
$tp_g[$rr]=$tp_g[$rr]*1;
$tm_g[$rr]=$tm_g[$rr]*1;

}
}
close (D2) ;

if ( $me == 1 ) {
for ($ti=1;$ti<=$rr;$ti++) {
$quoten[$ti] = $pu_g[$ti]+100000 ;
$quoten[$ti] = $quoten[$ti] . '#' ;
$xx=150000+$tp_g[$ti]-$tm_g[$ti];
$quoten[$ti] = $quoten[$ti]. $xx . '#' ;
$quoten[$ti] = $quoten[$ti].  $tp_g[$ti] . '#' ;
$quoten[$ti] = $quoten[$ti] . $ti ;
}
}

if ( $me == 2 ) {
for ($ti=1;$ti<=$rr;$ti++) {
$quoten[$ti] = $pu_schnitt[$ti] ;
$quoten[$ti] = $quoten[$ti] . '#' ;
$quoten[$ti] = $quoten[$ti]. $pu_g[$ti] . '#' ;
$quoten[$ti] = $quoten[$ti].  $tp_g[$ti] . '#' ;
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
($leer ,$leer,$leer, $ident[$t])= split (/#/, $ranks[$r]);	
}







print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>\n";
print "<table border=0 cellpadding=1 cellspacing=1>\n";


print "<tr>\n";
print "<td class=ve bgcolor=#f5f5ff align=left>&nbsp;</td>\n";

print "<td class=ve bgcolor=#f5f5ff align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Verein</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=center colspan=1><font face=verdana size=1>akt. Liga</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=left>&nbsp;Sp.</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=center colspan=3><font face=verdana size=1>&nbsp;Bilanz&nbsp;</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=center>&nbsp;Tore&nbsp;</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=center>&nbsp;Pu.&nbsp;</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=center>&nbsp;Quote&nbsp;</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=left colspan=1><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;aktueller Trainer</td>\n";

print "</tr>\n";


for ($t=1;$t<=$rr;$t++){
$ein = 0;

$color="black" ;
if ($verein[$ident[$t]] eq $vereina{$trainer} ) { $color="red" }

$ein = 1;

if ( $ein == 1 ) {


$col = "#f5f5ff" ;


$img="";


print "<tr>\n";
print "<td bgcolor=$col align=right><font face=verdana size=1 color=$color>&nbsp;$img&nbsp;$t .&nbsp;</td>\n";
$aa=$verein[$ident[$t]];
$aa=~s/ /%20/g ;
print "<td bgcolor=#eeeeff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;<a href=/cgi-mod/tmi/verein.pl?ident=$aa><img src=/img/h1.jpg border=0 alt=\"Vereinsstatistik $verein[$ident[$t]]\"></a>&nbsp;&nbsp;$verein[$ident[$t]] &nbsp; &nbsp; &nbsp; </td>\n";

$colore="#eeeeff";
if ( $sai == $ligav{$verein[$ident[$t]]} ) { $colore="#e3e4ff" }
print "<td bgcolor=$colore align=center><font face=verdana size=1 color=$color>&nbsp;&nbsp;$liga_kuerzel[$ligav{$verein[$ident[$t]]}]&nbsp;&nbsp;</td>\n";


print "<td class=ve bgcolor=#eeeeff align=right>&nbsp; $spiele[$ident[$t]]&nbsp;</td>\n";

print "<td class=ve bgcolor=#e3e4ff align=right>&nbsp;$s_g[$ident[$t]]&nbsp;</td>\n";
print "<td class=ve bgcolor=#e3e4ff align=right>&nbsp;$u_g[$ident[$t]]&nbsp;</td>\n";
print "<td class=ve bgcolor=#e3e4ff align=right>&nbsp;$n_g[$ident[$t]]&nbsp;</td>\n";
if (( $me == 5 ) or  ( $me == 3 )){ $color="#CACBF6" } else { $color="#eeeeff"}
print "<td class=ve bgcolor=$color align=center>&nbsp; $tp_g[$ident[$t]] : $tm_g[$ident[$t]] &nbsp;</td>\n";

$pu_g[$ident[$t]] = $pu_g[$ident[$t]] * 1;

if ( $me < 3 ) { $color="#CACBF6" } else { $color="#eeeeff"}
if ( $me == 1 ) {
print "<td class=ve bgcolor=$color align=right>&nbsp;&nbsp; $pu_g[$ident[$t]]&nbsp;&nbsp;</td>\n";
} else {
print "<td class=ve bgcolor=$color align=right>&nbsp;&nbsp; $pu_schnitt[$ident[$t]]&nbsp;&nbsp;</td>\n";

}

#$qp_g[$ident[$t]]=$qp_g[$ident[$t]]*1;
#$qm_g[$ident[$t]]=$qm_g[$ident[$t]]*1;
#$op_g[$ident[$t]]=$op_g[$ident[$t]]*1;
if ( $me == 10 ) { $color="#CACBF6" } else { $color="#eeeeff"}
print "<td class=ve bgcolor=$color align=right>&nbsp;&nbsp;&nbsp;$qu_schnitt[$ident[$t]]&nbsp;&nbsp;</td>\n";
$color="black" ;
$aa=$vereinb{$verein[$ident[$t]]};
$aa=~s/ /%20/g ;

print "<td bgcolor=#e3e4ff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;<a href=/cgi-mod/tmi/trainer.pl?ident=$aa><img src=/img/h1.jpg border=0 alt=\"Trainerstatistik $vereinb{$verein[$ident[$t]]}\"></a>&nbsp;&nbsp;$vereinb{$verein[$ident[$t]]} &nbsp; &nbsp; </td>\n";


print "</tr>";
}
}


print "</table>\n";
print "</td></tr></table>\n";
print "<br>&nbsp;<font face=verdana size=1>[ Es wurden alle Spiele seit der Saison 2000'3 beruecksichtigt ]";
exit ;







