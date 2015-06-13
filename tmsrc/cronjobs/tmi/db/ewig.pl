#!/usr/bin/perl

require "/tmapp/tmsrc/cgi-bin/tmi/saison.pl";

open (D5,">/tmdata/tmi/ewig/all.txt");
$ti=0;

open (D1,"</tmdata/tmi/db/vereine.txt");
while(<D1>){
@sal=split(/&/,$_);
$idd{$sal[1]}=$sal[0];
$all_nr = $sal[0];
}
close(D1);


for ($liga=1;$liga<=203;$liga++){
$teams=0;


%dat_sp="";
%dat_gs="";
%dat_gu="";;
%dat_gn="";
%dat_tp="";
%dat_tm="";
%dat_qu="";
%aktiv="";
open (D1,">/tmdata/tmi/ewig/$liga.txt");
for ($saison=12;$saison<=$main_nr;$saison++){

$url = "/archiv/" . $main_kuerzel[$saison] . "/" ;

if ( $saison ==  12 ) { $saison_liga = 60 }
if ( $saison ==  13 ) { $saison_liga = 60 }
if ( $saison ==  14 ) { $saison_liga = 60 }
if ( $saison ==  15 ) { $saison_liga = 118 }
if ( $saison ==  16 ) { $saison_liga = 118 }
if ( $saison >  17 ) { $saison_liga = 203 }


$numero=$liga;

if ( $saison < 15 ) {

require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl";

@liga_namen_old = ( "spacer" , "Italien Serie A" , "Italien Serie B" ,
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

#@sort =  ( undef , 1 , 2 , 5 , 6 , 9 , 10 , 13 , 14 , 17 , 18 , 21 , 22, 25
#, 26 , 29 , 30 , 33 , 34 , 37 , 38 , 41 , 42 , 45 , 47 , 49 , 51 , 53 ,55 ,
#57 , 59 , 117 , 61 , 63 , 65 , 67 , 69 , 71 , 73 , 75 , 77 , 79 , 81 ,83 ,
#85 ,  87 , 89 , 91 , 93 , 95 , 97 , 99 , 101 , 103 , 105 , 107 , 109 ,111 ,113 , 118 , 115 );

#%id="";
#for ($x=1;$x<=60;$x++){
#$id{$sort[$x]}=$x;
#}

#if ( $id{$liga} == 0 ) { goto ki; }
#$numero=$id{$liga};
#}

$r=-1;$numero=0;
foreach $a (@liga_namen_old){
$r++;
if ( $a eq $liga_namen[$liga] ) { $numero = $r } 
}
if ( $numero == 0 ) { break;}
}


if (( $saison < 17 ) and ( $saison > 14 ) ){
require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl";
%id="";
for ($x=1;$x<=118;$x++){
$id{$old2new[$x]}=$x;
}
if ( $id{$liga} == 0 ) { break; }
$numero=$id{$liga};


}






$rf ="0";
$rx = "x" ;
if ( $numero > 9 ) { $rf = "" }
$suche = 'x' . $rf . $numero . '&';


$datei_quoten = '/tmdata/tmi/' . $url . 'history.txt';
@vereine=();
open(D2,"<$datei_quoten");
while(<D2>) {
$gg++;
if ($_ =~ /$suche/) {
@vereine = split (/&/, $_);	
$gp = $gg ;
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



$lok = $numero;
if ($numero<10) {$lok = '0' . $numero}

$bv = "DAT";
$txt = ".TXT";
$datei_quoten = '/tmdata/tmi/' . $url . 'spieltag.txt';
open(DO,"<$datei_quoten");
while(<DO>) {
@ego = <DO>;
}
close(DO);



$datei_quoten = '/tmdata/tmi/' . $url . $bv . $lok . $txt;
open(DO,$datei_quoten);
while(<DO>) {
@quoten_row = <DO>;
}
close(DO);

for ( $spieltag = 0; $spieltag < 34; $spieltag++ )
{
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


$datum=1+$spieltag+(($saison-4)*34);

if ( $saison_liga >= $liga){
$database[$idd{$data[$ega[$x]]}][$idd{$data[$ega[$y]]}] .= $datum.'#'.$liga.'#H#'.$quoten_zahl[$ega[$x]-1].'#'. $quoten_zahl[$ega[$y]-1].'!';
$database[$idd{$data[$ega[$y]]}][$idd{$data[$ega[$x]]}] .= $datum.'#'.$liga.'#A#'.$quoten_zahl[$ega[$y]-1].'#'. $quoten_zahl[$ega[$x]-1].'!';
}

$y=$x+1;

if ($aktiv{$data[$ega[$x]]} != 1){
$teams++;
$team[$teams] = $data[$ega[$x]];
$aktiv{$data[$ega[$x]]} = 1;
}
if ($aktiv{$data[$ega[$y]]} != 1){
$teams++;
$team[$teams] = $data[$ega[$y]];
$aktiv{$data[$ega[$y]]} = 1;
}

if ($eaktiv{$data[$ega[$x]]} != 1){
$eteams++;
$eteam[$eteams] = $data[$ega[$x]];
$eaktiv{$data[$ega[$x]]} = 1;
}
if ($eaktiv{$data[$ega[$y]]} != 1){
$eteams++;
$eteam[$eteams] = $data[$ega[$y]];
$eaktiv{$data[$ega[$y]]} = 1;
}

$dat_sp{$data[$ega[$x]]}++;
$dat_sp{$data[$ega[$y]]}++;
#$dat_hsp[$ega[$x]]++;
#$dat_asp[$ega[$y]]++;


$dat_qu{$data[$ega[$x]]} = $quoten_zahl[$ega[$x]-1] + $dat_qu{$data[$ega[$x]]} ;
$dat_qu{$data[$ega[$y]]} = $quoten_zahl[$ega[$y]-1] + $dat_qu{$data[$ega[$y]]} ;
#$dat_gqu[$ega[$x]] = $quoten_zahl[$ega[$y]-1] + $dat_gqu[$ega[$x]] ;
#$dat_gqu[$ega[$y]] = $quoten_zahl[$ega[$x]-1] + $dat_gqu[$ega[$y]] ;
#$dat_hqu[$ega[$x]] = $quoten_zahl[$ega[$x]-1] + $dat_hqu[$ega[$x]] ;
#$dat_ghqu[$ega[$x]] = $quoten_zahl[$ega[$y]-1] + $dat_ghqu[$ega[$x]] ;
#$dat_aqu[$ega[$y]] = $quoten_zahl[$ega[$y]-1] + $dat_aqu[$ega[$y]] ;
#$dat_gaqu[$ega[$y]] = $quoten_zahl[$ega[$x]-1] + $dat_gaqu[$ega[$y]] ;


$dat_tp{$data[$ega[$x]]} = $dat_tp{$data[$ega[$x]]} + $tora ;
$dat_tm{$data[$ega[$x]]} = $dat_tm{$data[$ega[$x]]} + $torb ;
$dat_tp{$data[$ega[$y]]} = $dat_tp{$data[$ega[$y]]} + $torb ;
$dat_tm{$data[$ega[$y]]} = $dat_tm{$data[$ega[$y]]} + $tora ;
#$dat_htp[$ega[$x]] = $dat_htp[$ega[$x]] + $tora ;
#$dat_htm[$ega[$x]] = $dat_htm[$ega[$x]] + $torb ;
#$dat_atp[$ega[$y]] = $dat_atp[$ega[$y]] + $torb ;
#$dat_atm[$ega[$y]] = $dat_atm[$ega[$y]] + $tora ;



if ( $tora > $torb ) {
$dat_gs{$data[$ega[$x]]}++;
$dat_hs{$data[$ega[$x]]}++;
$dat_gpu{$data[$ega[$x]]} = $dat_gpu{$data[$ega[$x]]} + 3;
$dat_gn{$data[$ega[$y]]}++;
$dat_an{$data[$ega[$y]]}++;
}

if ( $tora < $torb ) {
$dat_gs{$data[$ega[$y]]}++;
$dat_as{$data[$ega[$y]]}++;
$dat_gpu{$data[$ega[$y]]} = $dat_gpu{$data[$ega[$y]]} + 3;
$dat_gn{$data[$ega[$x]]}++;
$dat_hn{$data[$ega[$x]]}++;
}


if ( $tora == $torb ) {
$dat_gu{$data[$ega[$x]]}++;
$dat_hu{$data[$ega[$x]]}++;
$dat_gpu{$data[$ega[$x]]} = $dat_gpu{$data[$ega[$x]]} + 1;
$dat_gu{$data[$ega[$y]]}++;
$dat_au{$data[$ega[$y]]}++;
$dat_gpu{$data[$ega[$y]]} = $dat_gpu{$data[$ega[$y]]} + 1;
}


}    
}
}


ki:
}

for ($x=1;$x<=$teams;$x++){

$pu = $dat_gu{$team[$x]} + ( $dat_gs{$team[$x]}*3);

$oo=0;$oq = int ( ($pu / $dat_sp{$team[$x]} ) * 1000 ) / 1000 ;
$xx="111"; ( $yy , $xx ) = split (/\./ , $oq ) ; $oo = length($xx) ;
if ($oo==2 ) { $oq = $oq . '0' }
if ($oo==1 ) { $oq = $oq . '00' }
if ($oo==0 ) { $oq = $oq . '.000' }

$oo=0;$ox = int ( ($dat_qu{$team[$x]} / $dat_sp{$team[$x]} ) * 1000 ) / 1000 ;
$xx="111"; ( $yy , $xx ) = split (/\./ , $ox ) ; $oo = length($xx) ;
if ($oo==2 ) { $ox = $ox . '0' }
if ($oo==1 ) { $ox = $ox . '00' }
if ($oo==0 ) { $ox = $ox . '.000' }

print D1"$team[$x]#$dat_sp{$team[$x]}#$pu#$oq#$ox#$dat_gs{$team[$x]}#$dat_gu{$team[$x]}#$dat_gn{$team[$x]}#$dat_tp{$team[$x]}#$dat_tm{$team[$x]}#\n";



$edat_sp{$team[$x]}=$edat_sp{$team[$x]}+$dat_sp{$team[$x]};
$edat_gs{$team[$x]}=$edat_gs{$team[$x]}+$dat_gs{$team[$x]};
$edat_gu{$team[$x]}=$edat_gu{$team[$x]}+$dat_gu{$team[$x]};
$edat_gn{$team[$x]}=$edat_gn{$team[$x]}+$dat_gn{$team[$x]};
$edat_tp{$team[$x]}=$edat_tp{$team[$x]}+$dat_tp{$team[$x]};
$edat_tm{$team[$x]}=$edat_tm{$team[$x]}+$dat_tm{$team[$x]};
$edat_qu{$team[$x]}=$edat_qu{$team[$x]}+$dat_qu{$team[$x]};

}
close(D1);

}





for ($x=1;$x<=$eteams;$x++){

$pu = $edat_gu{$eteam[$x]} + ( $edat_gs{$eteam[$x]}*3);

$oo=0;$oq = int ( ($pu / $edat_sp{$eteam[$x]} ) * 1000 ) / 1000 ;
$xx="111"; ( $yy , $xx ) = split (/\./ , $oq ) ; $oo = length($xx) ;
if ($oo==2 ) { $oq = $oq . '0' }
if ($oo==1 ) { $oq = $oq . '00' }
if ($oo==0 ) { $oq = $oq . '.000' }

$oo=0;$ox = int ( ($edat_qu{$eteam[$x]} / $edat_sp{$eteam[$x]} ) * 1000 ) / 1000 ;
$xx="111"; ( $yy , $xx ) = split (/\./ , $ox ) ; $oo = length($xx) ;
if ($oo==2 ) { $ox = $ox . '0' }
if ($oo==1 ) { $ox = $ox . '00' }
if ($oo==0 ) { $ox = $ox . '.000' }

print D5"$eteam[$x]#$edat_sp{$eteam[$x]}#$pu#$oq#$ox#$edat_gs{$eteam[$x]}#$edat_gu{$eteam[$x]}#$edat_gn{$eteam[$x]}#$edat_tp{$eteam[$x]}#$edat_tm{$eteam[$x]}#\n";
}





close(D5);

for ($x=1;$x<=$all_nr;$x++) {
open(A,">/tmdata/tmi/db/head2head/$x.txt");
for ($y=1;$y<=$all_nr;$y++) {
if ($database[$x][$y] ne "") {
print A "$y!".$database[$x][$y]."\n";
}
}
close(A);
}


