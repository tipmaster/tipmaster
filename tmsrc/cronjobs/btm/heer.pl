#!/usr/bin/perl

require "/tmapp/tmsrc/cgi-bin/btm_ligen.pl";

print "Erzeuge Heer.txt ...\n";


$gg=0;
for ($liga=1;$liga<=384;$liga++){





$ro = "x";
$suche = $ro . $liga . '&' ;
$rf=0;
$rx = "x" ;
if ( $liga > 9 ) { $rf = "" }

$suche = $rx . $rf . $liga . '&' ;

open(D2,"/tmdata/btm/history.txt");
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

open(DO,"/tmdata/btm/spieltag.txt");
while(<DO>) {
@ego = <DO>;
}
close(DO);

$hg = "DAT";
$anton = "0";
if ( $liga > 9 ) { $anton = "" }
$beta = ".TXT" ;

$datei_data = '/tmdata/btm/' . $hg . $anton . $liga . $beta ;

open(DO,$datei_data);
while(<DO>) {
@quoten_row = <DO>;
}
close(DO);

@quoten_zahl=();
@dat_sp = ();
@dat_hsp = ();
@dat_asp = ();
@dat_qu = ();
@dat_hqu = ();
@dat_aqu = ();
@dat_tp = ();
@dat_tm = ();
@dat_htp = ();
@dat_htm = ();
@dat_atp = ();
@dat_atm = ();
@dat_gpu = ();
@dat_tp = ();
@dat_hpu = ();
@dat_apu = ();
@dat_gs = ();
@dat_hs = ();
@dat_as = ();
@dat_gu = ();
@dat_hu = ();
@dat_au = ();
@dat_gn = ();
@dat_hn = ();
@dat_an = ();
@dat_qu_m = ();


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



if ( $tora > $torb ) {
$dat_gs[$ega[$x]]++;
$dat_hs[$ega[$x]]++;
$dat_gpu[$ega[$x]] = $dat_gpu[$ega[$x]] + 3;
$dat_gn[$ega[$y]]++;
$dat_an[$ega[$y]]++;
}

if ( $tora < $torb ) {
$dat_gs[$ega[$y]]++;
$dat_as[$ega[$y]]++;
$dat_gpu[$ega[$y]] = $dat_gpu[$ega[$y]] + 3;
$dat_gn[$ega[$x]]++;
$dat_hn[$ega[$x]]++;
}


if ( $tora == $torb ) {
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



@pl = ();
@tab = ();




for ( $x = 1; $x < 19; $x++ )
{

$dat_td[$x] = $dat_tp[$x] - $dat_tm[$x] ;
$dat_htd[$x] = $dat_htp[$x] - $dat_htm[$x] ;
$dat_atd[$x] = $dat_atp[$x] - $dat_atm[$x] ;
$dat_hpu[$x] = ( $dat_hs[$x] * 3 ) + ( $dat_hu[$x] * 1 ) ;
$dat_apu[$x] = ( $dat_as[$x] * 3 ) + ( $dat_au[$x] * 1 ) ;

@plx = ();
@tab = () ;




for ( $x = 1; $x < 19; $x++ )
{

$dat_td[$x] = $dat_tp[$x] - $dat_tm[$x] ;
$dat_htd[$x] = $dat_htp[$x] - $dat_htm[$x] ;
$dat_atd[$x] = $dat_atp[$x] - $dat_atm[$x] ;
$dat_hpu[$x] = ( $dat_hs[$x] * 3 ) + ( $dat_hu[$x] * 1 ) ;
$dat_apu[$x] = ( $dat_as[$x] * 3 ) + ( $dat_au[$x] * 1 ) ;




for ( $x = 1; $x < 19; $x++ )
{

$dat_td[$x] = $dat_tp[$x] - $dat_tm[$x] ;
$dat_htd[$x] = $dat_htp[$x] - $dat_htm[$x] ;
$dat_atd[$x] = $dat_atp[$x] - $dat_atm[$x] ;
$dat_hpu[$x] = ( $dat_hs[$x] * 3 ) + ( $dat_hu[$x] * 1 ) ;
$dat_apu[$x] = ( $dat_as[$x] * 3 ) + ( $dat_au[$x] * 1 ) ;


}




for ( $x = 1; $x < 19; $x++ )
{

for ( $y = 1; $y < 19; $y++ )
{

if ( $dat_gpu[$x] < $dat_gpu[$y] ) { $plx[$x]++ }

if ( $dat_gpu[$x] == $dat_gpu[$y] ) {

if ( $dat_td[$x] < $dat_td[$y] ) { $plx[$x]++ }
if ( $dat_td[$x] == $dat_td[$y] ) {

if ( $dat_tp[$x] < $dat_tp[$y] ) { $plx[$x]++ }
if ( $dat_tp[$x] == $dat_tp[$y] ) {


if ( $x > $y ) { $plx[$x]++ } 
if ( $x == $y ) { $plx[$x]++ } 
}

}
}
}

$ple[$plx[$x]] = $x ;

}

}

}

$hohe = 1 ;

if ( $liga > 1 ) {$hohe++}
if ( $liga > 2 ) {$hohe++}
if ( $liga > 4 ) {$hohe++}
if ( $liga > 8 ) {$hohe++}
if ( $liga > 16 ) {$hohe++}
if ( $liga > 32 ) {$hohe++}
if ( $liga > 64 ) {$hohe++}
if ( $liga > 128 ) {$hohe++}
if ( $liga > 256 ) {$hohe++}




for ($xy=1 ; $xy<=48;$xy++) {

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





$h=">>";
if ($liga==1) {$h=">"}
$datei = $h . "/tmdata/btm/heer.txt";
open (D2, "$datei") ;
$gg++;
for ($x=1;$x<=18;$x++) {
print D2 "$x&$gg&$hohe&&$ple[$x]&$data[$ple[$x]]&\n";
# $datb[$ple[$x]]&$dat_sp[$ple[$x]]&$dat_gpu[$ple[$x]]&$dat_tp[$ple[$x]]&$dat_tm[$ple[$x]]&$dat_qu[$ple[$x]]$dat_qu_m[$ple[$x]]\n";
}
close (D2);






}

1;


