#!/usr/bin/perl

require "/tmapp/tmsrc/cgi-bin/tmi/saison.pl";

open (D1,">/tmdata/tmi/ligaquote.txt");

$ti=0;
for ($saison=11;$saison<=$main_nr-1;$saison++){


$url = "/archiv/" . $main_kuerzel[$saison+1] . "/" ;


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

if ($saison > 13 ) {
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

if ($saison > 15 ) { 
@liga_namen = ( "---" , "Italien Serie A" , "Italien Serie B" , "Italien Amateurliga A" , "Italien Amateurliga B" , "Italien Amateurklasse A" , "Italien Amateurklasse B" , "Italien Amateurklasse C" , "Italien Amateurklasse D" ,
"England Premier League" ,"England 1.Divison" ,  "England Amateurliga A" , "England Amateurliga B" , "England Amateurklasse A" , "England Amateurklasse B" , "England Amateurklasse C" , "England Amateurklasse D" ,
"Spanien Primera Division" ,"Spanien Secunda Division" ,  "Spanien Amateurliga A" , "Spanien Amateurliga B" ,  "Spanien Amateurklasse A" , "Spanien Amateurklasse B" ,  "Spanien Amateurklasse C" , "Spanien Amateurklasse D" ,
"Frankreich Premiere Division" ,"Frankreich 1.Division" ,  "Frankreich Amateurliga A" , "Frankreich Amateurliga B" , "Frankreich Amateurklasse A" , "Frankreich Amateurklasse B" , "Frankreich Amateurklasse C" , "Frankreich Amateurklasse D" ,
"Niederlande Ehrendivision" ,"Niederlande 1.Division" ,  "Niederlande Amateurliga A" , "Niederlande Amateurliga B" , "Niederlande Amateurklasse A" , "Niederlande Amateurklasse B" ,
"Portugal 1.Divisao" ,"Portugal 2.Divisao" ,  "Portugal Amateurliga A" , "Portugal Amateurliga B" , "Portugal Amateurklasse A" , "Portugal Amateurklasse B" ,
"Belgien 1.Division" ,"Belgien 2.Division" ,  "Belgien Amateurliga A" , "Belgien Amateurliga B" ,  "Belgien Amateurklasse A" , "Belgien Amateurklasse B" ,
"Schweiz Nationalliga A" ,"Schweiz Nationalliga B" ,  "Schweiz Amateurliga A" , "Schweiz Amateurliga B" ,  "Schweiz Amateurklasse A" , "Schweiz Amateurklasse B" ,
"Oesterreich Bundesliga" ,"Oesterreich 1.Division" ,  "Oesterreich Amateurliga A" , "Oesterreich Amateurliga B" , "Oesterreich Amateurklasse A" , "Oesterreich Amateurklasse B" ,
"Schottland 1.Liga" ,"Schottland 2.Liga" ,  "Schottland Amateurliga A" , "Schottland Amateurliga B" , "Schottland Amateurklasse A" , "Schottland Amateurklasse B" ,
"Tuerkei 1.Liga" ,"Tuerkei 2.Liga" ,  "Tuerkei Amateurliga A" , "Tuerkei Amateurliga B" ,"Tuerkei Amateurklasse A" , "Tuerkei Amateurklasse B" ,
"Irland 1.Liga" ,
"Irland 2.Liga" ,
"Irland Amateurliga A",
"Irland Amateurliga B",
"Nord Irland 1.Liga" ,
"Nord Irland 2.Liga" ,
"Nord Irland Amateurliga A",
"Nord Irland Amateurliga B",
"Wales 1.Liga" ,
"Wales 2.Liga" ,
"Wales Amateurliga A",
"Wales Amateurliga B",
"Daenemark 1.Liga" ,
"Daenemark 2.Liga" ,
"Daenemark Amateurliga A",
"Daenemark Amateurliga B",
"Norwegen 1.Liga" ,
"Norwegen 2.Liga" ,
"Norwegen Amateurliga A",
"Norwegen Amateurliga B",
"Schweden 1.Liga" ,
"Schweden 2.Liga" ,
"Schweden Amateurliga A",
"Schweden Amateurliga B",
"Finnland 1.Liga" ,
"Finnland 2.Liga" ,
"Finnland Amateurliga A",
"Finnland Amateurliga B",
"Island 1.Liga" ,
"Island 2.Liga" ,
"Island Amateurliga A",
"Island Amateurliga B",
"Polen 1.Liga" ,
"Polen 2.Liga" ,
"Polen Amateurliga A",
"Polen Amateurliga B",
"Tschechien 1.Liga" ,
"Tschechien 2.Liga" ,
"Tschechien Amateurliga A",
"Tschechien Amateurliga B",
"Ungarn 1.Liga" ,
"Ungarn 2.Liga" ,
"Ungarn Amateurliga A",
"Ungarn Amateurliga B",
"Rumaenien 1.Liga" ,
"Rumaenien 2.Liga" ,
"Rumaenien Amateurliga A",
"Rumaenien Amateurliga B",
"Slowenien 1.Liga" ,
"Slowenien 2.Liga" ,
"Slowenien Amateurliga A",
"Slowenien Amateurliga B",
"Kroatien 1.Liga" ,
"Kroatien 2.Liga" ,
"Kroatien Amateurliga A",
"Kroatien Amateurliga B",
"Jugoslawien 1.Liga" ,
"Jugoslawien 2.Liga" ,
"Jugoslawien Amateurliga A",
"Jugoslawien Amateurliga B",
"Bosnien-Herz. 1.Liga" ,
"Bosnien-Herz. 2.Liga" ,
"Bosnien-Herz. Amateurliga A",
"Bosnien-Herz. Amateurliga B",
"Bulgarien 1.Liga" ,
"Bulgarien 2.Liga" ,
"Bulgarien Amateurliga A",
"Bulgarien Amateurliga B",
"Griechenland 1.Liga" ,
"Griechenland 2.Liga" ,
"Griechenland Amateurliga A",
"Griechenland Amateurliga B",
"Russland 1.Liga" ,
"Russland 2.Liga" ,
"Russland Amateurliga A",
"Russland Amateurliga B",
"Estland 1.Liga" ,
"Estland 2.Liga" ,
"Estland Amateurliga A",
"Estland Amateurliga B",
"Ukraine 1.Liga" ,
"Ukraine 2.Liga" ,
"Ukraine Amateurliga A",
"Ukraine Amateurliga B",
"Moldawien 1.Liga" ,
"Moldawien 2.Liga" ,
"Moldawien Amateurliga A",
"Moldawien Amateurliga B",
"Israel 1.Liga" ,
"Israel 2.Liga" ,
"Israel Amateurliga A",
"Israel Amateurliga B",
"Luxemburg 1.Liga" ,
"Luxemburg 2.Liga" ,
"Luxemburg Amateurliga A",
"Luxemburg Amateurliga B",
"Slowakei 1.Liga" ,
"Slowakei 2.Liga" ,
"Slowakei Amateurliga",
"Mazedonien 1.Liga" ,
"Mazedonien 2.Liga" ,
"Mazedonien Amateurliga",
"Litauen 1.Liga" ,
"Litauen 2.Liga" ,
"Litauen Amateurliga",
"Lettland 1.Liga" ,
"Lettland 2.Liga" ,
"Lettland Amateurliga",
"Weissrussland 1.Liga" ,
"Weissrussland 2.Liga" ,
"Weissrussland Amateurliga" ,
"Malta 1.Liga" ,
"Malta 2.Liga" ,
"Malta Amateurliga" ,
"Zypern 1.Liga" ,
"Zypern 2.Liga" ,
"Zypern Amateurliga" ,
"Albanien 1.Liga" ,
"Albanien 2.Liga" ,
"Georgien 1.Liga" ,
"Georgien 2.Liga" ,
"Armenien 1.Liga" ,
"Armenien 2.Liga" ,
"Aserbaidschan 1.Liga" ,
"Aserbaidschan 2.Liga" ,
"Andorra 1.Liga" ,
"Andorra 2.Liga" ,
"Faeroer Inseln 1.Liga" ,
"San Marino 1.Liga" 
);
 }

if ( $saison ==  11 ) { $saison_liga = 60 }
if ( $saison ==  12 ) { $saison_liga = 60 }
if ( $saison ==  13 ) { $saison_liga = 60 }
if ( $saison ==  14 ) { $saison_liga = 118 }
if ( $saison ==  15 ) { $saison_liga = 118 }
if ( $saison >  15 ) { $saison_liga = 203 }

for ($liga=1;$liga<=$saison_liga;$liga++){


$lok = $liga;
if ($liga<10) {$lok = '0' . $liga}

$bv = "DAT";
$txt = ".TXT";

$datei_quoten = '/tmdata/tmi/' . $url . $bv . $lok . $txt;
$sp=-1;
$quote=0;
$gesamt_quote=0;
$gesamt_tore=0;
$gesamt_uu=0;
open(DO,"<$datei_quoten");
while(<DO>) {

$sp++;
@ogo = split (/&/, $_);	

for ($t=1;$t<=18;$t++){
if ( $ogo[$t-1] != 1 ) { 
$quote++;
$gesamt_quote = $ogo[$t-1] + $gesamt_quote ;

$tora=0;
if ( $ogo[$t-1]> 14 ) { $tora = 1 }
if ( $ogo[$t-1]> 39 ) { $tora = 2 }
if ( $ogo[$t-1]> 59 ) { $tora = 3 }
if ( $ogo[$t-1]> 79 ) { $tora = 4 }
if ( $ogo[$t-1]> 104 ) { $tora = 5 }
if ( $ogo[$t-1]> 129 ) { $tora = 6 }
if ( $ogo[$t-1]> 154 ) { $tora = 7 }

if ( $tora == 0 ) { $grenze_a = 0 }
if ( $tora == 1 ) { $grenze_a = 15 }
if ( $tora == 2 ) { $grenze_a = 40 }
if ( $tora == 3 ) { $grenze_a = 60 }
if ( $tora == 4 ) { $grenze_a = 80 }
if ( $tora == 5 ) { $grenze_a = 105 }
if ( $tora == 6 ) { $grenze_a = 130 }
if ( $tora == 7 ) { $grenze_a = 155 }

$gesamt_uu = $gesamt_uu + $ogo[$t-1] - $grenze_a ;

$gesamt_tore=$gesamt_tore+$tora;


}}

}
$quote=$quote-18;

$oo=0;$ot = int ( ($gesamt_tore / $quote ) * 1000 ) / 1000 ;
$xx="111"; ( $yy , $xx ) = split (/\./ , $ot ) ; $oo = length($xx) ;
if ($oo==2 ) { $ot = $ot . '0' }
if ($oo==1 ) { $ot = $ot . '00' }
if ($oo==0 ) { $ot = $ot . '.000' }

$oo=0;$oq = int ( ($gesamt_quote / $quote ) * 1000 ) / 1000 ;
$xx="111"; ( $yy , $xx ) = split (/\./ , $oq ) ; $oo = length($xx) ;
if ($oo==2 ) { $oq = $oq . '0' }
if ($oo==1 ) { $oq = $oq . '00' }
if ($oo==0 ) { $oq = $oq . '.000' }

$oo=0;$op = int ( ($gesamt_uu / $quote ) * 1000 ) / 1000 ;
$xx="111"; ( $yy , $xx ) = split (/\./ , $op ) ; $oo = length($xx) ;
if ($oo==2 ) { $op = $op . '0' }
if ($oo==1 ) { $op = $op . '00' }
if ($oo==0 ) { $op = $op . '.000' }

if ( $op < 10 ) { $op = '0' . $op }

print D1"$saison#$liga#$quote#$gesamt_quote#$gesamt_tore#$gesamt_uu#$oq#$ot#$op#$liga_namen[$liga]#\n";
}
}
close(D1);



open (D1,"/tmdata/tmi/ligaquote.txt");
while(<D1>){

@all = split(/#/,$_);
$saison{$all[9]}++;
$quote{$all[9]}+=$all[3];
$tore{$all[9]}+=$all[4];
$optimizer{$all[9]}+=$all[5];

$qu_row{$all[9]}.="&$all[6]";
$to_row{$all[9]}.="&$all[6]";
$op_row{$all[9]}.="&$all[6]";

#print "#$saison{$all[9]} $all[9] $quote{$all[9]}\n";

}
close(D1);


open (D1,">/tmdata/tmi/ligaquote-gesamt.txt");
foreach $t (@liga_namen){
if ( $saison{$t} == 10 ) {
print D1 "$t#$saison{$t}#$quote{$t}#$tore{$t}#$optimizer{$t}#$qu_row{$t}#$to_row{$t}#$op_row{$t}#\n";
}
print D1 
}
close (D1);
