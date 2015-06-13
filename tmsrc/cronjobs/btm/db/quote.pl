#!/usr/bin/perl

require "/tmapp/tmsrc/cgi-bin/btm/saison.pl";
open (D1,">/tmdata/btm/ligaquote.txt");

$ti=0;
for ($saison=1 ;$saison<=$main_nr;$saison++){

$url = "/archiv/" . $main_kuerzel[$saison] . "/" ;

if ( $saison ==  4 ) { $saison_liga = 6 }
if ( $saison ==  5 ) { $saison_liga = 12 }
if ( $saison ==  6 ) { $saison_liga = 24 }
if ( $saison ==  7 ) { $saison_liga = 24 }
if ( $saison ==  8 ) { $saison_liga = 32 }
if ( $saison ==  9 ) { $saison_liga = 48 }
if ( $saison ==  10 ) { $saison_liga = 48 }
if ( $saison ==  11 ) { $saison_liga = 48 }
if ( $saison ==  12 ) { $saison_liga = 96 }
if ( $saison ==  13 ) { $saison_liga = 128 }
if ( $saison ==  14 ) { $saison_liga = 128 }
if ( $saison >  14 ) { $saison_liga = 256 }
if ( $saison >  30 ) { $saison_liga = 384 }


for ($liga=1;$liga<=$saison_liga;$liga++){

$lok = $liga;
if ($liga<10) {$lok = '0' . $liga}

$bv = "DAT";
$txt = ".TXT";

$datei_quoten = '/tmdata/btm/' . $url . $bv . $lok . $txt;
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
print D1"$saison#$liga#$quote#$gesamt_quote#$gesamt_tore#$gesamt_uu#$oq#$ot#$op#\n";

}
}
close(D1);
