#!/usr/bin/perl

require "/tmapp/tmsrc/cgi-bin/btm/saison.pl";
print "Generiere Ewige Tabelle ...\n";
use DBI;

open (D5,">/tmdata/btm/ewig/all.txt");

$ti=0;

open (D1,"</tmdata/btm/db/vereine.txt");
while(<D1>){
@sal=split(/&/,$_);
$id{$sal[1]}=$sal[0];
$all_nr = $sal[0];
}
close(D1);

for ($liga=1;$liga<=384;$liga++){
$teams=0;


%dat_sp="";
%dat_gs="";
%dat_gu="";;
%dat_gn="";
%dat_tp="";
%dat_tm="";
%dat_qu="";
%aktiv="";
open (D1,">/tmdata/btm/ewig/$liga.txt");
for ($saison=6;$saison<=$main_nr;$saison++){




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
if ( $saison > 14 ) { $saison_liga = 256 }
if ( $saison > 30 ) { $saison_liga = 384 }


if ( $liga > $saison_liga ) { goto ki; }

$rf ="0";
$rx = "x" ;
if ( $liga > 9 ) { $rf = "" }
$suche = 'x' . $rf . $liga . '&';


$datei_quoten = '/tmdata/btm/' . $url . 'history.txt';

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



$lok = $liga;
if ($liga<10) {$lok = '0' . $liga}

$bv = "DAT";
$txt = ".TXT";
$datei_quoten = '/tmdata/btm/' . $url . 'spieltag.txt';
open(DO,"<$datei_quoten");
while(<DO>) {
@ego = <DO>;
}
close(DO);

$datei_quoten = '/tmdata/btm/' . $url . $bv . $lok . $txt;
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

$quoten_zahl[$ega[$x]-1]=$quoten_zahl[$ega[$x]-1]*1;
$quoten_zahl[$ega[$y]-1]=$quoten_zahl[$ega[$y]-1]*1;

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
# my $sql = "INSERT INTO btm_ewig VALUES ( $datum,$liga,$id{$data[$ega[$x]]},$id{$data[$ega[$y]]},$quoten_zahl[$ega[$x]-1], $quoten_zahl[$ega[$y]-1])";
# my $sth = $dbh->prepare($sql);
# $sth->execute();

$database[$id{$data[$ega[$x]]}][$id{$data[$ega[$y]]}] .= $datum.'#'.$liga.'#H#'.$quoten_zahl[$ega[$x]-1].'#'. $quoten_zahl[$ega[$y]-1].'!';
$database[$id{$data[$ega[$y]]}][$id{$data[$ega[$x]]}] .= $datum.'#'.$liga.'#A#'.$quoten_zahl[$ega[$y]-1].'#'. $quoten_zahl[$ega[$x]-1].'!';


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
open(A,">/tmdata/btm/db/head2head/$x.txt");
for ($y=1;$y<=$all_nr;$y++) {
if ($database[$x][$y] ne "") {
print A "$y!".$database[$x][$y]."\n";
}
}
close(A);
}


