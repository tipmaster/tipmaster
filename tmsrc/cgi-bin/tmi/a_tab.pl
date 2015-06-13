#!/usr/bin/perl

=head1 NAME
	TMI a_tab.pl

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
my $session = TMSession::getSession(tmi_login => 1);
my $trainer = $session->getUser();
my $leut = $trainer;

require "/tmapp/tmsrc/cgi-bin/tmi/saison.pl";
print "Content-Type: text/html \n\n";
use CGI;
$query = new CGI;

$liga= $query->param('li');
$sp_start = $query->param('start');
$sp_ende = $query->param('ende');
$methode = $query->param('me');
$wert =$query->param('wert');
$id = $query->param('id');
$ligi = $query->param('ligi');

$saison = $query->param('saison');
$trainer = $leut ;

$ein_a = 0;
$ein_b = 0;

for ( $dd = 12; $dd <= $main_nr-1; $dd++ )
{
if ( $dd == $saison ) { $ein_a = 1 }
}

if ( $ein_a == 0 ) { $saison = $main_nr-1 }

@liga_namen = ( "spacer" , "Italien Serie A" , "Italien Serie B" ,
"England Premier League" ,"England 1.Divison" ,
"Spanien Primera Division" ,"Spanien Secunda Division" ,
"Frankreich Premiere Division" ,"Frankreich 1.Division" ,
"Niederlande Ehrendivision" ,"Niederlande 1.Division" ,
"Portugal 1.Divisao" ,"Portugal 2.Divisao" ,
"Belgien 1.Division" ,"Belgien 2.Division" ,
"Schweiz Nationalliga A" ,"Schweiz Nationalliga B" ,
"Oesterreich Bundesliga" ,"Oesterreich 1.Division" ,
"Schottland 1.Liga" ,"Schottland 2.Liga" ,
"Tuerkei 1.Liga" ,"Tuerkei 2.Liga" ,
"Irland 1.Liga" ,
"Nord Irland 1.Liga" ,
"Wales 1.Liga" ,
"Daenemark 1.Liga" ,
"Norwegen 1.Liga" ,
"Schweden 1.Liga" ,
"Finnland 1.Liga" ,
"Island 1.Liga" ,
"Faeroer Inseln 1.Liga" ,
"Polen 1.Liga" ,
"Tschechien 1.Liga" ,
"Slowakei 1.Liga" ,
"Ungarn 1.Liga" ,
"Rumaenien 1.Liga" ,
"Slowenien 1.Liga" ,
"Kroatien 1.Liga" ,
"Jugoslawien 1.Liga" ,
"Bosnien-Herz. 1.Liga" ,
"Mazedonien 1.Liga" ,
"Albanien 1.Liga" ,
"Bulgarien 1.Liga" ,
"Griechenland 1.Liga" ,
"Russland 1.Liga" ,
"Estland 1.Liga" ,
"Litauen 1.Liga" ,
"Lettland 1.Liga" ,
"Weissrussland 1.Liga" ,
"Ukraine 1.Liga" ,
"Moldawien 1.Liga" ,
"Georgien 1.Liga" ,
"Armenien 1.Liga" ,
"Aserbaidschan 1.Liga" ,
"Israel 1.Liga" ,
"Andorra 1.Liga" ,
"Luxemburg 1.Liga" ,
"Malta 1.Liga" ,
"San Marino 1.Liga" ,
"Zypern 1.Liga" 
 ) ;

if ($saison > 15 ) {
@liga_namen = ( "spacer" , "Italien Serie A" , "Italien Serie B" , "Italien Amateurliga A" , "Italien Amateurliga B" ,
"England Premier League" ,"England 1.Divison" ,  "England Amateurliga A" , "England Amateurliga B" ,
"Spanien Primera Division" ,"Spanien Secunda Division" ,  "Spanien Amateurliga A" , "Spanien Amateurliga B" ,
"Frankreich Premiere Division" ,"Frankreich 1.Division" ,  "Frankreich Amateurliga A" , "Frankreich Amateurliga B" ,
"Niederlande Ehrendivision" ,"Niederlande 1.Division" ,  "Niederlande Amateurliga A" , "Niederlande Amateurliga B" ,
"Portugal 1.Divisao" ,"Portugal 2.Divisao" ,  "Portugal Amateurliga A" , "Portugal Amateurliga B" ,
"Belgien 1.Division" ,"Belgien 2.Division" ,  "Belgien Amateurliga A" , "Belgien Amateurliga B" ,
"Schweiz Nationalliga A" ,"Schweiz Nationalliga B" ,  "Schweiz Amateurliga A" , "Schweiz Amateurliga B" ,
"Oesterreich Bundesliga" ,"Oesterreich 1.Division" ,  "Oesterreich Amateurliga A" , "Oesterreich Amateurliga B" ,
"Schottland 1.Liga" ,"Schottland 2.Liga" ,  "Schottland Amateurliga A" , "Schottland Amateurliga B" ,
"Tuerkei 1.Liga" ,"Tuerkei 2.Liga" ,  "Tuerkei Amateurliga A" , "Tuerkei Amateurliga B" ,
"Irland 1.Liga" ,
"Irland 2.Liga" ,
"Nord Irland 1.Liga" ,
"Nord Irland 2.Liga" ,
"Wales 1.Liga" ,
"Wales 2.Liga" ,
"Daenemark 1.Liga" ,
"Daenemark 2.Liga" ,
"Norwegen 1.Liga" ,
"Norwegen 2.Liga" ,
"Schweden 1.Liga" ,
"Schweden 2.Liga" ,
"Finnland 1.Liga" ,
"Finnland 2.Liga" ,
"Island 1.Liga" ,
"Island 2.Liga" ,
"Polen 1.Liga" ,
"Polen 2.Liga" ,
"Tschechien 1.Liga" ,
"Tschechien 2.Liga" ,
"Slowakei 1.Liga" ,
"Slowakei 2.Liga" ,
"Ungarn 1.Liga" ,
"Ungarn 2.Liga" ,
"Rumaenien 1.Liga" ,
"Rumaenien 2.Liga" ,
"Slowenien 1.Liga" ,
"Slowenien 2.Liga" ,
"Kroatien 1.Liga" ,
"Kroatien 2.Liga" ,
"Jugoslawien 1.Liga" ,
"Jugoslawien 2.Liga" ,
"Bosnien-Herz. 1.Liga" ,
"Bosnien-Herz. 2.Liga" ,
"Mazedonien 1.Liga" ,
"Mazedonien 2.Liga" ,
"Albanien 1.Liga" ,
"Albanien 2.Liga" ,
"Bulgarien 1.Liga" ,
"Bulgarien 2.Liga" ,
"Griechenland 1.Liga" ,
"Griechenland 2.Liga" ,
"Russland 1.Liga" ,
"Russland 2.Liga" ,
"Estland 1.Liga" ,
"Estland 2.Liga" ,
"Litauen 1.Liga" ,
"Litauen 2.Liga" ,
"Lettland 1.Liga" ,
"Lettland 2.Liga" ,
"Weissrussland 1.Liga" ,
"Weissrussland 2.Liga" ,
"Ukraine 1.Liga" ,
"Ukraine 2.Liga" ,
"Moldawien 1.Liga" ,
"Moldawien 2.Liga" ,
"Georgien 1.Liga" ,
"Georgien 2.Liga" ,
"Armenien 1.Liga" ,
"Armenien 2.Liga" ,
"Aserbaidschan 1.Liga" ,
"Aserbaidschan 2.Liga" ,
"Israel 1.Liga" ,
"Israel 2.Liga" ,
"Andorra 1.Liga" ,
"Andorra 2.Liga" ,
"Luxemburg 1.Liga" ,
"Luxemburg 2.Liga" ,
"Malta 1.Liga" ,
"Malta 2.Liga" ,
"Zypern 1.Liga" ,
"Zypern 2.Liga" ,
"Faeroer Inseln 1.Liga" ,
"San Marino 1.Liga" 
 ) ;
}

if ($saison > 17 ) { require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl" }

$url = "/tmdata/tmi/archiv/" . $main_kuerzel[$saison] . "/" ;

@saison_name=@main_saison;


$saison_namen = "$main_saison[$saison] ";


if ( $saison ==  4 ) { $saison_liga = 6 }
if ( $saison ==  5 ) { $saison_liga = 12 }
if ( $saison ==  6 ) { $saison_liga = 24 }
if ( $saison ==  7 ) { $saison_liga = 24 }
if ( $saison ==  8 ) { $saison_liga = 32 }
if ( $saison ==  9 ) { $saison_liga = 48 }
if ( $saison ==  10 ) { $saison_liga = 48 }
if ( $saison ==  11 ) { $saison_liga = 48 }
if ( $saison ==  12 ) { $saison_liga = 96 }
if ( $saison ==  13 ) { $saison_liga = 60 }
if ( $saison ==  14 ) { $saison_liga = 60 }
if ( $saison ==  15 ) { $saison_liga = 60 }
if ( $saison ==  16 ) { $saison_liga = 118 }
if ( $saison ==  17 ) { $saison_liga = 118 }
if ( $saison >  17 ) { $saison_liga = 203 }







$datei = $url . "datum.txt" ;

open(D7,"$datei");
$leer = <D7> ;
$spielrunde_ersatz = <D7> ;
chomp $spielrunde_ersatz;
close(D7);





$ein = 0 ;
if ( ($methode eq "G" ) or ( $methode eq "H" ) or ( $methode eq "A" ) or ( $methode eq "HR" ) or ( $methode eq "RR" ) or ( $methode eq "I" ) ) { $ein =1 }
if ( $ein == 0 ) {$methode = "G" }

if ( $methode eq "HR" ) { ($sp_start = 1) and ($sp_ende = 17 ) }
if ( $methode eq "RR" ) { ($sp_start = 18) and ($sp_ende = 34 ) }


$ein = 0 ;
if ( ($wert eq "P" ) or ( $wert eq "OT" ) or ( $wert eq "DT" ) or ( $wert eq "OQ" ) or ( $wert eq "DQ" )  ) { $ein =1 }
if ( $ein == 0 ) {$wert = "P" }

$ein_a = 0;
$ein_b = 0;

for ( $spieltag = 1; $spieltag < 35; $spieltag++ )
{
if ( $sp_start == $spieltag ) { $ein_a = 1 }
if ( $sp_ende == $spieltag ) { $ein_b = 1 }
}

if ( $ein_a == 0 ) { $sp_start =1 }
if ( $ein_b  == 0 ) { $sp_ende = $spielrunde_ersatz }

if  ( $sp_ende > $spielrunde_ersatz ) { $sp_ende = $spielrunde_ersatz }
if  ( $sp_start > $sp_ende ) { $sp_start = $sp_ende }

$ein_a = 0;

for ( $spieltag = 1; $spieltag < 257; $spieltag++ )
{
if ( $liga == $spieltag ) { $ein_a = 1 }
}

if ( $ein_a == 0 ) { $liga = 1 }

if ( $liga > $saison_liga ) { $liga = $saison_liga }


$ro = "x";
$suche = $ro . $liga ;

$rf ="0";
$rx = "x" ;
if ( $liga > 9 ) { $rf = "" }

$suche = $rx . $rf . $liga .'&' ;


$datei = $url . "history.txt" ;

open(D2,"$datei");
while(<D2>) {

if ($_ =~ /$suche/) {
@vereine = split (/&/, $_);	
}

}
close(D2);


$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
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

$datei = $url . "spieltag.txt" ;


open(D9,"$datei");
while(<D9>) {
@ego = <D9>;
}
close(D9);

$hg = $url . "DAT";
$anton = "0";
if ( $liga > 9 ) { $anton = "" }
$beta = ".TXT" ;

$datei_data = $hg . $anton . $liga . $beta ;
open(DO,$datei_data);
while(<DO>) {
@quoten_row = <DO>;
}
close(DO);




srand();  
$nn = int(rand(1500)) ;
$nn = $nn + $ve + $liga ;




print "<script language=JavaScript>\n";
print "<!--\n";
print "function targetLink(URL)\n";
print "  {\n";
print "    if(document.images)\n";
print "      targetWin = open(URL,\"Neufenster1\",\"scrollbars=yes,toolbar=no,directories=no,menubar=no,status=no,resizeable=yes,width=850,height=240\");\n";
print " }\n";
print "  //-->\n";
print "  </script>\n";

print "<html><title>Tabelle $liga_namen[$liga]</title><p align=left><body bgcolor=white text=black>\n";
require "/tmapp/tmsrc/cgi-bin/tag.pl" ;
require "/tmapp/tmsrc/cgi-bin/tag_small.pl" ;
print "<br>\n";
# if ( ($methode eq "G" ) or ($methode eq "HR" ) or ($methode eq "RR" )) { print "<font face=verdana size=2>Gesamttabelle von Spieltag $sp_start bis $sp_ende</b></font>" }
# if ( ($methode eq "H" )) { print "<font face=verdana size=2>Heimtabelle von Spieltag $sp_start bis $sp_ende</b></font>" }
# if ( ($methode eq "A" )) { print "<font face=verdana size=2>Auswartstabelle von Spieltag $sp_start bis $sp_ende</b></font>" }

print "<br><font face=verdana size=2><b>Archivtabelle $saison_namen</b><font size=1>\n";
print "<font face=verdana size=1><form method=post action=/cgi-bin/tmi/a_tab.pl target=_top>";

print "<select style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=saison>";

for ( $x=12; $x<=$main_nr-1;$x++ )
{
$gh = "";
if ( $x == $saison ) { $gh = "selected" }
print "<option value=$x $gh>$saison_name[$x] \n";
}
print "</select>&nbsp;&nbsp;\n";


print "<select style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=li>";

for ( $x=1; $x<=$saison_liga;$x++ )
{
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
print "Sp.&nbsp;<input type=text size=2 maxlenght=2 value=$sp_start name=start>&nbsp;bis&nbsp;<input type=text size=2 maxlenght=2 value=$sp_ende name=ende>&nbsp;&nbsp;";
print "&nbsp;&nbsp;&nbsp;<input type=hidden name=id value=\"$id\" ><input type=hidden name=ligi value=\"$ligi\" ><input type=submit value=\"Tabelle laden\"></form>";

$fa = 0 ;
$fc= -1;
for ( $spieltag = ($sp_start - 1); $spieltag < ($sp_ende); $spieltag++ )
{

if ( ( $methode ne "A" ) and ( $methode ne "H") ) {
if ( ($spieltag + 7 ) >= ($sp_ende-1) ) {$fc++ }
}

if ( ( $methode eq "A" ) or ( $methode eq "H") ) {
if ( ($spieltag + 18 ) >= ($sp_ende-1) ) {$fc++ }
}


@ega = split (/&/, $ego[$spieltag]);	

chop $quoten_row[$spieltag];
@quoten_zahl = split (/&/, $quoten_row[$spieltag]);	
for ( $x = 0; $x < 18; $x=$x + 2 )
{

$tora = 0;
$torb = 0;
$y=$x+1;
$wa=$x-1;
$wb=$y-1;

if ( $quoten_zahl[$ega[$x]-1] != "1" ) { 


if ( $quoten_zahl[$ega[$x]-1] > 14 ) { $tora = 1 }
if ( $quoten_zahl[$ega[$x]-1] > 39 ) { $tora = 2 }
if ( $quoten_zahl[$ega[$x]-1] > 59 ) { $tora = 3 }
if ( $quoten_zahl[$ega[$x]-1] > 79 ) { $tora = 4 }
if ( $quoten_zahl[$ega[$x]-1] > 104 ) { $tora = 5 }
if ( $quoten_zahl[$ega[$x]-1] > 129 ) { $tora = 6 }
if ( $quoten_zahl[$ega[$x]-1] > 154 ) { $tora = 7 }

if ( $quoten_zahl[$ega[$y]-1] > 14 ) { $torb = 1 }
if ( $quoten_zahl[$ega[$y]-1] > 39 ) { $torb = 2 }
if ( $quoten_zahl[$ega[$y]-1] > 59 ) { $torb = 3 }
if ( $quoten_zahl[$ega[$y]-1] > 79 ) { $torb = 4 }
if ( $quoten_zahl[$ega[$y]-1] > 104 ) { $torb = 5 }
if ( $quoten_zahl[$ega[$y]-1] > 129 ) { $torb = 6 }
if ( $quoten_zahl[$ega[$y]-1] > 154 ) { $torb = 7 }


$y=$x+1;

$dat_sp[$ega[$x]]++;
$dat_sp[$ega[$y]]++;
$dat_hsp[$ega[$x]]++;
$dat_asp[$ega[$y]]++;


$dat_qu[$ega[$x]] = $quoten_zahl[$ega[$x]-1] + $dat_qu[$ega[$x]] ;
$dat_qu[$ega[$y]] = $quoten_zahl[$ega[$y]-1] + $dat_qu[$ega[$y]] ;
$dat_gqu[$ega[$x]] = $quoten_zahl[$ega[$y]-1] + $dat_gqu[$ega[$x]] ;
$dat_gqu[$ega[$y]] = $quoten_zahl[$ega[$x]-1] + $dat_gqu[$ega[$y]] ;
$dat_hqu[$ega[$x]] = $quoten_zahl[$ega[$x]-1] + $dat_hqu[$ega[$x]] ;
$dat_ghqu[$ega[$x]] = $quoten_zahl[$ega[$y]-1] + $dat_ghqu[$ega[$x]] ;
$dat_aqu[$ega[$y]] = $quoten_zahl[$ega[$y]-1] + $dat_aqu[$ega[$y]] ;
$dat_gaqu[$ega[$y]] = $quoten_zahl[$ega[$x]-1] + $dat_gaqu[$ega[$y]] ;


$dat_tp[$ega[$x]] = $dat_tp[$ega[$x]] + $tora ;
$dat_tm[$ega[$x]] = $dat_tm[$ega[$x]] + $torb ;
$dat_tp[$ega[$y]] = $dat_tp[$ega[$y]] + $torb ;
$dat_tm[$ega[$y]] = $dat_tm[$ega[$y]] + $tora ;
$dat_htp[$ega[$x]] = $dat_htp[$ega[$x]] + $tora ;
$dat_htm[$ega[$x]] = $dat_htm[$ega[$x]] + $torb ;
$dat_atp[$ega[$y]] = $dat_atp[$ega[$y]] + $torb ;
$dat_atm[$ega[$y]] = $dat_atm[$ega[$y]] + $tora ;

$lr = 0;
$ls = 0;

if ( $fc>-1 ) {
$ll = ( $fc ) * 18;
$lr = $ll + $ega[$x];
$ls = $ll + $ega[$y];
} 


if ( $tora > $torb ) {
if  ($methode ne "A" ) { $dat_hi[$lr] = "S" }
if  ($methode ne "H" ) { $dat_hi[$ls] = "n" }

$dat_gs[$ega[$x]]++;
$dat_hs[$ega[$x]]++;
$dat_gpu[$ega[$x]] = $dat_gpu[$ega[$x]] + 3;
$dat_gn[$ega[$y]]++;
$dat_an[$ega[$y]]++;
}

if ( $tora < $torb ) {
if  ($methode ne "A" ) { $dat_hi[$lr] = "N" }
if  ($methode ne "H" ) { $dat_hi[$ls] = "s" }

$dat_gs[$ega[$y]]++;
$dat_as[$ega[$y]]++;
$dat_gpu[$ega[$y]] = $dat_gpu[$ega[$y]] + 3;
$dat_gn[$ega[$x]]++;
$dat_hn[$ega[$x]]++;
}


if ( $tora == $torb ) {

if  ($methode ne "A" ) { $dat_hi[$lr] = "U" }
if  ($methode ne "H" ) { $dat_hi[$ls] = "u" }

$dat_gu[$ega[$x]]++;
$dat_hu[$ega[$x]]++;
$dat_gpu[$ega[$x]] = $dat_gpu[$ega[$x]] + 1;
$dat_gu[$ega[$y]]++;
$dat_au[$ega[$y]]++;
$dat_gpu[$ega[$y]] = $dat_gpu[$ega[$y]] + 1;
}

}
}




}    

@plx = ();
@tab = () ;

for ( $xy = 1; $xy < 19; $xy++ )
{
$dat_td[$xy] = $dat_tp[$xy] - $dat_tm[$xy] ;
$dat_htd[$xy] = $dat_htp[$xy] - $dat_htm[$xy] ;
$dat_atd[$xy] = $dat_atp[$xy] - $dat_atm[$xy] ;
$dat_hpu[$xy] = ( $dat_hs[$xy] * 3 ) + ( $dat_hu[$xy] * 1 ) ;
$dat_apu[$xy] = ( $dat_as[$xy] * 3 ) + ( $dat_au[$xy] * 1 ) ;

$dat_sp[$xy] = $dat_sp[$xy] * 1;
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

$dat_hqu[$xy] = $dat_hqu[$xy] * 1;
$dat_aqu[$xy] = $dat_aqu[$xy] * 1;
$dat_ghqu[$xy] = $dat_ghqu[$xy] * 1;
$dat_gaqu[$xy] = $dat_gaqu[$xy] * 1;


$v = $dat_sp[$xy] ;
if ( $v == 0 ) { $v = 1 }
$e = int($dat_qu[$xy] / $v);
$dat_qu[$xy] = int(($dat_qu[$xy] / $v) * 10 ) / 10;
if ( $e == $dat_qu[$xy] ) { $dat_qu_m[$xy] = ".0" }

$v = $dat_sp[$xy] ;
if ( $v == 0 ) { $v = 1 }
$e = int($dat_gqu[$xy] / $v);
$dat_gqu[$xy] = int(($dat_gqu[$xy] / $v) * 10 ) / 10;
if ( $e == $dat_gqu[$xy] ) { $dat_gqu_m[$xy] = ".0" }


$v = $dat_hsp[$xy] ;
if ( $v == 0 ) { $v = 1 }
$e = int($dat_hqu[$xy] / $v);
$dat_hqu[$xy] = int(($dat_hqu[$xy] / $v) * 10 ) / 10;
if ( $e == $dat_hqu[$xy] ) { $dat_hqu_m[$xy] = ".0" }

$v = $dat_hsp[$xy] ;
if ( $v == 0 ) { $v = 1 }
$e = int($dat_ghqu[$xy] / $v);
$dat_ghqu[$xy] = int(($dat_ghqu[$xy] / $v) * 10 ) / 10;
if ( $e == $dat_ghqu[$xy] ) { $dat_ghqu_m[$xy] = ".0" }


$v = $dat_asp[$xy] ;
if ( $v == 0 ) { $v = 1 }
$e = int($dat_aqu[$xy] / $v);
$dat_aqu[$xy] = int(($dat_aqu[$xy] / $v) * 10 ) / 10;
if ( $e == $dat_aqu[$xy] ) { $dat_aqu_m[$xy] = ".0" }

$v = $dat_asp[$xy] ;
if ( $v == 0 ) { $v = 1 }
$e = int($dat_gaqu[$xy] / $v);
$dat_gaqu[$xy] = int(($dat_gaqu[$xy] / $v) * 10 ) / 10;
if ( $e == $dat_gaqu[$xy] ) { $dat_gaqu_m[$xy] = ".0" }



}




if ( ( $methode eq "G" )  or ( $methode eq "HR" )  or  ( $methode eq "RR" )      ) {

for ( $xx = 1; $xx < 19; $xx++ )
{
for ( $yx = 1; $yx < 19; $yx++ )
{

if ( $dat_gpu[$xx] < $dat_gpu[$yx] ) { $pl1[$xx]++ }

if ( $dat_gpu[$xx] == $dat_gpu[$yx] ) {

if ( $dat_td[$xx] < $dat_td[$yx] ) { $pl1[$xx]++ }
if ( $dat_td[$xx] == $dat_td[$yx] ) {

if ( $dat_tp[$xx] < $dat_tp[$yx] ) { $pl1[$xx]++ }
if ( $dat_tp[$xx] == $dat_tp[$yx] ) {


if ( $xx > $yx ) { $pl1[$xx]++ } 
if ( $xx == $yx ) { $pl1[$xx]++ } 
}
}
}
}

$tab[$pl1[$xx]] = $xx ;
}


print "<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0>\n";


$fa = 0 ;
for ( $yx = 1; $yx < 19; $yx++ )
{
$fa++;
if ( $fa == 3 ) {$fa = 1}
if ( $fa == 1 ) {$farbe = "#eeeeee"}
if ( $fa == 2 ) {$farbe = "white"}



$ce_1 = "";
$ce_2 = "";

$ce_3 = "";
$ce_4 = "";
$ce_5 = "";

if ( $dat_tp[$tab[$yx]] < 10 ) {$ce_1 = "0"}
if ( $dat_tm[$tab[$yx]] < 10 ) {$ce_2 = "0"}
if ( $dat_gs[$tab[$yx]] < 10 ) {$ce_3 = "0"}
if ( $dat_gu[$tab[$yx]] < 10 ) {$ce_4 = "0"}
if ( $dat_gn[$tab[$yx]] < 10 ) {$ce_5 = "0"}


print "<TR BGCOLOR=$farbe>\n";

print "<TD ALIGN=RIGHT><FONT FACE=verdana SIZE=1>&nbsp;&nbsp;$yx.&nbsp;&nbsp;</FONT></TD>\n";
$color=black;
if ( ($data[$tab[$yx]] eq $id)  ) {$color="red" }
print "<form name=y$tab[$yx] method=post action=/cgi-mod/tmi/verein.pl target=_top><input type=hidden name=ident value=\"$data[$tab[$yx]]\"><input type=hidden name=saison value=\"$saison\"><input type=hidden name=li value=\"$liga\"><input type=hidden name=ve value=\"$tab[$yx]\"><TD ALIGN=LEFT><a href=javascript:document.y$tab[$yx].submit()><img src=/img/h1.jpg heigth=10 width=10  alt=\"Vereinsseite $data[$tab[$yx]]\" border=0></a>&nbsp;&nbsp;<FONT FACE=verdana SIZE=1 color=$color>$data[$tab[$yx]]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></TD></form>\n";

print "<td align=left><font face=verdana size=1>";

for ( $xx = 0 ;$xx < 10; $xx++ )

{
$t = $xx * 18;
print "$dat_hi[$tab[$yx]+$t]";
}
print "</font>&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";

print  "<TD ALIGN=RIGHT><FONT FACE=verdana SIZE=1>$dat_sp[$tab[$yx]]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></TD>\n";
print "<TD ALIGN=RIGHT><FONT FACE=verdana SIZE=1>$ce_3$dat_gs[$tab[$yx]]&nbsp;&nbsp;&nbsp;</font></TD>\n";
print  "<TD ALIGN=RIGHT><FONT FACE=verdana SIZE=1>$ce_4$dat_gu[$tab[$yx]]&nbsp;&nbsp;&nbsp;</FONT></TD>\n";
print "<TD ALIGN=RIGHT><FONT FACE=verdana SIZE=1>$ce_5$dat_gn[$tab[$yx]]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></TD>\n";
print "<TD ALIGN=CENTER><FONT FACE=verdana SIZE=1>$ce_1$dat_tp[$tab[$yx]] : $ce_2$dat_tm[$tab[$yx]]&nbsp;&nbsp;&nbsp;</FONT></TD>\n";
print  "<TD ALIGN=RIGHT><FONT FACE=verdana SIZE=1>$dat_td[$tab[$yx]]</FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>\n";
print "<TD ALIGN=RIGHT><FONT FACE=verdana SIZE=1>$dat_gpu[$tab[$yx]]</FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>\n";
print "<TD ALIGN=center><FONT FACE=verdana SIZE=1>$dat_qu[$tab[$yx]]$dat_qu_m[$tab[$yx]] - $dat_gqu[$tab[$yx]]$dat_gqu_m[$tab[$yx]]</FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>\n";
if ( $datb[$tab[$yx]] ne 'Trainerposten frei' ) {
print "<form name=x$tab[$yx] method=post action=/cgi-bin/tmi/trainer.pl target=new><input type=hidden name=li value=$liga><input type=hidden name=ligi value=$ligi><input type=hidden name=id value=$id><input type=hidden name=liga value=\"$liga\"><input type=hidden name=verein value=\"$tab[$yx]\"><TD ALIGN=left><FONT FACE=verdana SIZE=1><img src=/img/h1.jpg heigth=10 width=10  alt=\"Trainerprofil $datb[$tab[$yx]]\" border=0>&nbsp;&nbsp;$datb[$tab[$yx]]&nbsp;&nbsp;</FONT></TD></form>\n";
} 
else {
print "<TD ALIGN=left><FONT FACE=verdana SIZE=1><img src=/img/h1.jpg heigth=10 width=10 border=0>&nbsp;&nbsp;$datb[$tab[$yx]]&nbsp;&nbsp;</FONT></TD></form>\n";
}

print "</TR>\n";
$ein = 0;
if ( ($yx == 3) and ($liga ==1) ) { $ein = 1 }
if ( ($yx == 15) and ($liga ==1) ) { $ein = 1 }
if ( ($yx == 7) and ($liga ==1) ) { $ein = 1 }
if ( ($yx == 3) and ($liga ==2) ) { $ein = 1 }
if ( ($yx == 14) and ($liga >1) ) { $ein = 1 }
if ( ($yx == 2) and ($liga > 2 and $liga < 33) ) { $ein = 1 }
if ( ($yx == 3) and ($liga > 33) ) { $ein = 1 }

$ein=0;
if ( $ein == 1 ) {
print "<tr>";
for ( $a = 1 ; $a < 19 ; $a ++ )
{
print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
}
print "</tr>";
}


}


print "</table>\n";


}


if ( $methode eq "H" ) {

for ( $xx = 1; $xx < 19; $xx++ )
{
for ( $yx = 1; $yx < 19; $yx++ )
{

if ( $dat_hpu[$xx] < $dat_hpu[$yx] ) { $pl1[$xx]++ }

if ( $dat_hpu[$xx] == $dat_hpu[$yx] ) {

if ( $dat_htd[$xx] < $dat_htd[$yx] ) { $pl1[$xx]++ }
if ( $dat_htd[$xx] == $dat_htd[$yx] ) {

if ( $dat_htp[$xx] < $dat_htp[$yx] ) { $pl1[$xx]++ }
if ( $dat_htp[$xx] == $dat_htp[$yx] ) {


if ( $xx > $yx ) { $pl1[$xx]++ } 
if ( $xx == $yx ) { $pl1[$xx]++ } 
}
}
}
}

$tab[$pl1[$xx]] = $xx ;
}


print "<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0>\n";
$fa = 0 ;
for ( $yx = 1; $yx < 19; $yx++ )
{
$fa++;
if ( $fa == 3 ) {$fa = 1}
if ( $fa == 1 ) {$farbe = "#eeeeee"}
if ( $fa == 2 ) {$farbe = "white"}



$r = 0;
for ( $x = 0; $x < 19; $x++ )
{
$y = $x * 18 ;
if ( ( $dat_hi[$tab[$yx]+$y] eq "S" ) or ( $dat_hi[$tab[$yx]+$y] eq "U" ) or ( $dat_hi[$tab[$yx]+$y] eq "N" ) ) {
$r++ ;
$merk[$r] = $tab[$yx] + $y ;
}
}

if ( $r == 9 ) { $dat_hi[$merk[1]] = "" }
if ( $r == 10 ) { 
$dat_hi[$merk[1]] = "" ;
$dat_hi[$merk[2]] = "" ;
}
if ( $r == 11 ) { 
$dat_hi[$merk[1]] = "" ;
$dat_hi[$merk[2]] = "" ;
$dat_hi[$merk[3]] = "" ;
}





$ce_1 = "";
$ce_2 = "";

$ce_3 = "";
$ce_4 = "";
$ce_5 = "";

if ( $dat_htp[$tab[$yx]] < 10 ) {$ce_1 = "0"}
if ( $dat_htm[$tab[$yx]] < 10 ) {$ce_2 = "0"}
if ( $dat_hs[$tab[$yx]] < 10 ) {$ce_3 = "0"}
if ( $dat_hu[$tab[$yx]] < 10 ) {$ce_4 = "0"}
if ( $dat_hn[$tab[$yx]] < 10 ) {$ce_5 = "0"}




print "<TR BGCOLOR=$farbe>\n";
$color=black;
if ( ($data[$tab[$yx]] eq $id) ) {$color="red" }
print "<TD ALIGN=RIGHT><FONT FACE=verdana SIZE=1>&nbsp;&nbsp;$yx.&nbsp;&nbsp;</FONT></TD>\n";
print "<form name=y$tab[$yx] method=post action=/cgi-mod/tmi/verein.pl target=_top><input type=hidden name=saison value=\"$saison\"><input type=hidden name=li value=\"$liga\"><input type=hidden name=ve value=\"$tab[$yx]\"><TD ALIGN=LEFT><a href=javascript:document.y$tab[$yx].submit()><img src=/img/h1.jpg heigth=10 width=10  alt=\"Vereinsseite $data[$tab[$yx]]\" border=0></a>&nbsp;&nbsp;<FONT FACE=verdana SIZE=1 color=$color>$data[$tab[$yx]]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></TD></form>\n";

print "<td align=left><font face=verdana size=1>";

for ( $xx = 0 ;$xx < 19; $xx++ )

{
$t = $xx * 18;
print "$dat_hi[$tab[$yx]+$t]";
}
print "</font>&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";

print  "<TD ALIGN=RIGHT><FONT FACE=verdana SIZE=1>$dat_hsp[$tab[$yx]]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></TD>\n";
print "<TD ALIGN=RIGHT><FONT FACE=verdana SIZE=1>$ce_3$dat_hs[$tab[$yx]]&nbsp;&nbsp;&nbsp;</font></TD>\n";
print  "<TD ALIGN=RIGHT><FONT FACE=verdana SIZE=1>$ce_4$dat_hu[$tab[$yx]]&nbsp;&nbsp;&nbsp;</FONT></TD>\n";
print "<TD ALIGN=RIGHT><FONT FACE=verdana SIZE=1>$ce_5$dat_hn[$tab[$yx]]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></TD>\n";
print "<TD ALIGN=CENTER><FONT FACE=verdana SIZE=1>$ce_1$dat_htp[$tab[$yx]] : $ce_2$dat_htm[$tab[$yx]]&nbsp;&nbsp;&nbsp;</FONT></TD>\n";
print  "<TD ALIGN=RIGHT><FONT FACE=verdana SIZE=1>$dat_htd[$tab[$yx]]</FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>\n";
print "<TD ALIGN=RIGHT><FONT FACE=verdana SIZE=1>$dat_hpu[$tab[$yx]]</FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>\n";
print "<TD ALIGN=center><FONT FACE=verdana SIZE=1>$dat_hqu[$tab[$yx]]$dat_hqu_m[$tab[$yx]] - $dat_ghqu[$tab[$yx]]$dat_ghqu_m[$tab[$yx]]</FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>\n";
print "<form name=x$tab[$yx] method=post action=/img/trainer.pl target=new><input type=hidden name=li value=$liga><input type=hidden name=ligi value=$ligi><input type=hidden name=id value=$id><input type=hidden name=liga value=\"$liga\"><input type=hidden name=verein value=\"$tab[$yx]\"><TD ALIGN=left><FONT FACE=verdana SIZE=1><img src=/img/h1.jpg heigth=10 width=10  alt=\"Trainerprofil $datb[$tab[$yx]]\" border=0>&nbsp;&nbsp;$datb[$tab[$yx]]&nbsp;&nbsp;</FONT></TD></form>\n";
print "</TR>\n";

$ein = 0;
if ( ($yx == 3) and ($liga ==1) ) { $ein = 1 }
if ( ($yx == 15) and ($liga ==1) ) { $ein = 1 }
if ( ($yx == 7) and ($liga ==1) ) { $ein = 1 }
if ( ($yx == 3) and ($liga ==2) ) { $ein = 1 }
if ( ($yx == 14) and ($liga >1) ) { $ein = 1 }
if ( ($yx == 2) and ($liga > 2 and $liga < 33) ) { $ein = 1 }
if ( ($yx == 3) and ($liga > 32) ) { $ein = 1 }
$ein=0;
if ( $ein == 1 ) {
print "<tr>";
for ( $a = 1 ; $a < 19 ; $a ++ )
{
print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
}
print "</tr>";
}


}


print "</table>\n";


}





if ( $methode eq "A" ) {

for ( $xx = 1; $xx < 19; $xx++ )
{
for ( $yx = 1; $yx < 19; $yx++ )
{

if ( $dat_apu[$xx] < $dat_apu[$yx] ) { $pl1[$xx]++ }

if ( $dat_apu[$xx] == $dat_apu[$yx] ) {

if ( $dat_atd[$xx] < $dat_atd[$yx] ) { $pl1[$xx]++ }
if ( $dat_atd[$xx] == $dat_atd[$yx] ) {

if ( $dat_atp[$xx] < $dat_atp[$yx] ) { $pl1[$xx]++ }
if ( $dat_atp[$xx] == $dat_atp[$yx] ) {


if ( $xx > $yx ) { $pl1[$xx]++ } 
if ( $xx == $yx ) { $pl1[$xx]++ } 
}
}
}
}

$tab[$pl1[$xx]] = $xx ;
}



print "<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0>\n";



$fa = 0 ;
for ( $yx = 1; $yx < 19; $yx++ )
{
$fa++;
if ( $fa == 3 ) {$fa = 1}
if ( $fa == 1 ) {$farbe = "#eeeeee"}
if ( $fa == 2 ) {$farbe = "white"}



$r = 0;
for ( $x = 0; $x < 19; $x++ )
{
$y = $x * 18 ;
if ( ( $dat_hi[$tab[$yx]+$y] eq "s" ) or ( $dat_hi[$tab[$yx]+$y] eq "u" ) or ( $dat_hi[$tab[$yx]+$y] eq "n" ) ) {
$r++ ;
$merk[$r] = $tab[$yx] + $y ;
}
}

if ( $r == 9 ) { $dat_hi[$merk[1]] = "" }
if ( $r == 10 ) { 
$dat_hi[$merk[1]] = "" ;
$dat_hi[$merk[2]] = "" ;
}
if ( $r == 11 ) { 
$dat_hi[$merk[1]] = "" ;
$dat_hi[$merk[2]] = "" ;
$dat_hi[$merk[3]] = "" ;
}

$ce_1 = "";
$ce_2 = "";

$ce_3 = "";
$ce_4 = "";
$ce_5 = "";

if ( $dat_atp[$tab[$yx]] < 10 ) {$ce_1 = "0"}
if ( $dat_atm[$tab[$yx]] < 10 ) {$ce_2 = "0"}
if ( $dat_as[$tab[$yx]] < 10 ) {$ce_3 = "0"}
if ( $dat_au[$tab[$yx]] < 10 ) {$ce_4 = "0"}
if ( $dat_an[$tab[$yx]] < 10 ) {$ce_5 = "0"}



print "<TR BGCOLOR=$farbe>\n";
$color=black;
if ( ($data[$tab[$yx]] eq $id) ) {$color="red" }
print "<TD ALIGN=RIGHT><FONT FACE=verdana SIZE=1>&nbsp;&nbsp;$yx.&nbsp;&nbsp;</FONT></TD>\n";
print "<form name=y$tab[$yx] method=post action=/cgi-mod/tmi/verein.pl target=_top><input type=hidden name=saison value=\"$saison\"><input type=hidden name=li value=\"$liga\"><input type=hidden name=ve value=\"$tab[$yx]\"><TD ALIGN=LEFT><a href=javascript:document.y$tab[$yx].submit()><img src=/img/h1.jpg heigth=10 width=10  alt=\"Vereinsseite $data[$tab[$yx]]\" border=0></a>&nbsp;&nbsp;<FONT FACE=verdana SIZE=1 color=$color>$data[$tab[$yx]]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></TD></form>\n";

print "<td align=left><font face=verdana size=1>";

for ( $xx = 0 ;$xx < 19; $xx++ )

{
$t = $xx * 18;
print "$dat_hi[$tab[$yx]+$t]";
}
print "</font>&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";

print  "<TD ALIGN=RIGHT><FONT FACE=verdana SIZE=1>$dat_asp[$tab[$yx]]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></TD>\n";
print "<TD ALIGN=RIGHT><FONT FACE=verdana SIZE=1>$ce_3$dat_as[$tab[$yx]]&nbsp;&nbsp;&nbsp;</font></TD>\n";
print  "<TD ALIGN=RIGHT><FONT FACE=verdana SIZE=1>$ce_4$dat_au[$tab[$yx]]&nbsp;&nbsp;&nbsp;</FONT></TD>\n";
print "<TD ALIGN=RIGHT><FONT FACE=verdana SIZE=1>$ce_5$dat_an[$tab[$yx]]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></TD>\n";
print "<TD ALIGN=CENTER><FONT FACE=verdana SIZE=1>$ce_1$dat_atp[$tab[$yx]] : $ce_2$dat_atm[$tab[$yx]]&nbsp;&nbsp;&nbsp;</FONT></TD>\n";
print  "<TD ALIGN=RIGHT><FONT FACE=verdana SIZE=1>$dat_atd[$tab[$yx]]</FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>\n";
print "<TD ALIGN=RIGHT><FONT FACE=verdana SIZE=1>$dat_apu[$tab[$yx]]</FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>\n";
print "<TD ALIGN=center><FONT FACE=verdana SIZE=1>$dat_aqu[$tab[$yx]]$dat_aqu_m[$tab[$yx]] - $dat_gaqu[$tab[$yx]]$dat_gaqu_m[$tab[$yx]]</FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>\n";
print "<form name=x$tab[$yx] method=post action=/img/trainer.pl target=new><input type=hidden name=li value=$liga><input type=hidden name=ligi value=$ligi><input type=hidden name=id value=$id><input type=hidden name=liga value=\"$liga\"><input type=hidden name=verein value=\"$tab[$yx]\"><TD ALIGN=left><FONT FACE=verdana SIZE=1><img src=/img/h1.jpg heigth=10 width=10  alt=\"Trainerprofil $datb[$tab[$yx]]\" border=0>&nbsp;&nbsp;$datb[$tab[$yx]]&nbsp;&nbsp;</FONT></TD></form>\n";


print "</TR>\n";


$ein = 0;
if ( ($yx == 3) and ($liga ==1) ) { $ein = 1 }
if ( ($yx == 15) and ($liga ==1) ) { $ein = 1 }
if ( ($yx == 7) and ($liga ==1) ) { $ein = 1 }
if ( ($yx == 3) and ($liga ==2) ) { $ein = 1 }
if ( ($yx == 14) and ($liga >1) ) { $ein = 1 }
if ( ($yx == 2) and ($liga > 2 and $liga < 33) ) { $ein = 1 }
if ( ($yx == 3) and ($liga > 32) ) { $ein = 1 }

if ( $ein == 1 ) {
print "<tr>";
for ( $a = 1 ; $a < 19 ; $a ++ )
{
print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
}
print "</tr>";
}




}


print "</table>\n";


}


exit ;



