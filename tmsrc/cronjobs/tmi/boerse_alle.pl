#!/usr/bin/perl


print "Content-Type: text/html \n\n";

require "/tmapp/tmsrc/cgi-bin/runde.pl";

require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl" ;
require "/tmapp/tmsrc/cgi-bin/runde.pl" ;
open(U,"/tmdata/tmi/datum.txt");
$u=<U>; chomp $u;
close(U);

if ( $rrunde < 2 ) { exit; }
if ( $rrunde == 9 && $u == 33 ) { exit; }

open (D,">/tmdata/tmi/boerse_aktiv.txt");
print D "1";
close (D);
$datei_save = "/tmdata/tmi/history_sb_" . $rrunde . ".txt" ;
open(L,">$datei_save");
open(U,"</tmdata/tmi/history.txt");
while (<U>) {
print L "$_";
}
close (U);
close (L);

$datei_save = "/tmdata/tmi/boerse_" . $rrunde . ".txt" ;
open(L,">$datei_save");
open(U,"</tmdata/tmi/boerse.txt");
while (<U>) {
print L "$_";
}
close (U);
close (L);

($sek, $min, $std, $tag, $mon, $jahr) =  localtime(time+0);
$mon++ ;
if ( $sek <10 ) { $xa = "0" }
if ( $min <10 ) { $xb = "0" }
if ( $std <10 ) { $xc = "0" }
if ( $tag <10 ) { $xd = "0" }
if ( $mon <10 ) { $xe = "0" }
if ( $liga <10 ) { $xf = "0" }
if ( $spielrunde <10 ) { $xg = "0" }
$jahr = $jahr + 1900 ;

open(D9,">/tmdata/tmi/go_change.txt");

$frei = 0;
$gh = 0;
for ( $liga = 1 ; $liga <= $rr_ligen ; $liga++ ) {

$liga_aktuell = $liga ;

$rf ="0";
$rx = "x" ;
if ( $liga > 9 ) { $rf = "" }

$suche = $rx . $rf . $liga_aktuell . '&' ;
$g=0;
open(D2,"/tmdata/tmi/history.txt");
while(<D2>) {
$g++;
if ($_ =~ /$suche/) {
@vereine = split (/&/, $_);	
}

}

$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
$y++;
chomp $verein[$y];
$data[$x] = $vereine[$y];
$y++;
chomp $verein[$y];
$datb[$x] = $vereine[$y];
$exx{$datb[$x]} = 1;
if ( &listOnBoerse($liga) ) {
if ( $datb[$x] eq "Trainerposten frei" ) { 
$frei++;
$auswahl_verein[$frei] = $data[$x] ;
$auswahl_liga[$frei] = $liga ;
$auswahl_id[$frei] = $x ;
}
}


$y++;
chomp $verein[$y];
$datc[$x] = $vereine[$y];
}



close (D2) ;
}





print $frei ;





for ( $yy=1 ; $yy<=$frei;$yy++) {


$be = 0;
@bewerber = ();
@anzahl = ();
open(D2,"/tmdata/tmi/boerse.txt");
while(<D2>) {

if ($_ =~ /$auswahl_verein[$yy]/) { 
@kohl=();
@kohl = split (/#/ , $_);
if ( $exx{$kohl[0]} == 1 ) {
$be++;
$bewerber[$be] = $kohl[0] ;
$anzahl[$be] = $kohl[1] ;


$t = 1;
for ($x=1;$x<=$anzahl[$be];$x++) {
$t++;
$leer = $kohl[$t] ;
if ($leer eq $auswahl_verein[$yy]) { 
$prio[$be] = $kohl[$t+1];

 }

$t++;
}}



}
}
close (D2);

print $be ;

$li=0;
open(D2,"/tmdata/tmi/history.txt");
while(<D2>) {
$li++;
for ($xf=1 ; $xf<=$be ; $xf++ ) {

if ($_ =~ /$bewerber[$xf]/) { 
@vereine = ();
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
if ( $datb[$x] eq $bewerber[$xf] ) { 
$bewerber_verein[$xf] = $data[$x] ;
$bewerber_verein_basis{$data[$x]} = $liga_kat[$li] ;
$bewerber_verein_id[$x] = $x ;
}
$y++;
chomp $verein[$y];
$datc[$x] = $vereine[$y];
}


}
}
}
close (D2);


open(D2,"/tmdata/tmi/heer.txt");
while(<D2>) {

$cc = $auswahl_verein . '&' ;

if ($_ =~ /$cc/) { 
@go = split (/&/ , $_);
$job_platz = $go[0] ;
$job_liga = $go[1] ;
}
}
close (d2);


open(D2,"/tmdata/tmi/heer.txt");
while(<D2>) {
@go = ();
@go = split (/&/ , $_);
$bewerber_verein_platz{"$go[5]"} = $go[0] ;
$bewerber_verein_liga{"$go[5]"}= $go[1];

}
close (D2);



for ($xf=1 ; $xf<=$be ; $xf++ ) {
if ( $bewerber_verein_basis{$bewerber_verein[$xf]} == 1 ) { $bewerber_punkte[$xf] = 300 - (($bewerber_verein_platz{$bewerber_verein[$xf]}-1)*3)}
if ( $bewerber_verein_basis{$bewerber_verein[$xf]} == 2 ) { $bewerber_punkte[$xf] = 270 - (($bewerber_verein_platz{$bewerber_verein[$xf]}-1)*3)}
if ( $bewerber_verein_basis{$bewerber_verein[$xf]} == 3 ) { $bewerber_punkte[$xf] = 240 - (($bewerber_verein_platz{$bewerber_verein[$xf]}-1)*3)}
if ( $bewerber_verein_basis{$bewerber_verein[$xf]} == 4 ) { $bewerber_punkte[$xf] = 210 - (($bewerber_verein_platz{$bewerber_verein[$xf]}-1)*3)}
if ( $bewerber_verein_basis{$bewerber_verein[$xf]} == 5 ) { $bewerber_punkte[$xf] = 180 - (($bewerber_verein_platz{$bewerber_verein[$xf]}-1)*3)}
if ( $bewerber_verein_basis{$bewerber_verein[$xf]} == 6 ) { $bewerber_punkte[$xf] = 150 - (($bewerber_verein_platz{$bewerber_verein[$xf]}-1)*3)}
if ( $bewerber_verein_basis{$bewerber_verein[$xf]} == 7 ) { $bewerber_punkte[$xf] = 120 - (($bewerber_verein_platz{$bewerber_verein[$xf]}-1)*3)}
if ( $bewerber_verein_basis{$bewerber_verein[$xf]} == 8 ) { $bewerber_punkte[$xf] = 90 - (($bewerber_verein_platz{$bewerber_verein[$xf]}-1)*3)}
if ( $bewerber_verein_basis{$bewerber_verein[$xf]} == 9 ) { $bewerber_punkte[$xf] = 60 - (($bewerber_verein_platz{$bewerber_verein[$xf]}-1)*3)}

}


$r = 0;
open(D2,"/tmdata/tmi/allquotes.txt");
while(<D2>) {

($ff , $sp1[$xf] , $qu1[$xf] , $sp2[$xf] , $qu2[$xf] , $sp3[$xf] , $qu3[$xf] ) = split (/&/, $_);	
($xx , $sp1{"$ff"} , $qu1{"$ff"} , $sp2{"$ff"} , $qu2{"$ff"} , $sp3{"$ff"} , $qu3{"$ff"} ) = split (/&/, $_);	

#if ($qu1{"$ff"}<20) { $sp1{"$ff"} = "----" }
#if ($qu2{"$ff"}<20) { $sp2{"$ff"}  = "----" }
#if ($qu3{"$ff"}<20) { $sp3{"$ff"} = "----" }

#if ( $sp1{"$ff"} eq "" ) { $sp1{"$ff"} = "----" }
#if ( $sp2{"$ff"} eq "" ) { $sp2{"$ff"} = "----" }
#if ( $sp3{"$ff"} eq "" ) { $sp3{"$ff"} = "----" }
}
close(D2);


for ($xf=1 ; $xf<=$be ; $xf++ ) {
$ff = $bewerber[$xf] ;
if (($sp1{"$ff"} ne "----") and ( $sp1{"$ff"} > 0) ) { $bewerber_punkte[$xf] = int ( $bewerber_punkte[$xf] + ($sp1{"$ff"}-0)) }
if (($sp2{"$ff"} ne "----") and ( $sp2{"$ff"} > 0) ) { $bewerber_punkte[$xf] = int ( $bewerber_punkte[$xf] + ($sp2{"$ff"}-0)) }
if (($sp3{"$ff"} ne "----") and ( $sp3{"$ff"} > 0) ) { $bewerber_punkte[$xf] = int ( $bewerber_punkte[$xf] + ($sp3{"$ff"}-0)) }
}





@rank = ();
@place = ();

for ($xf=1 ; $xf<=$be ; $xf++ ) {
$y="";
if ( $bewerber_punkte[$xf] < 100 ) { $y="0" }
if ( $bewerber_punkte[$xf] < 10 ) { $y="00" }
$x="00";
if ( $xf > 9 ) { $x="0" }
if ( $xf > 99 ) { $x="" }
$rank[$xf] = $y . $bewerber_punkte[$xf] . '#' . $x . $xf ;
}

@folge = sort @rank ;


for ($xf=1 ; $xf<=$be ; $xf++ ) {
($egal , $place[$xf] ) = split (/#/ , $folge[$xf]);
}


$zo = 0;

$close=0;

$pl = 0;

for ($xf=$be ; $xf>=1 ; $xf-- ) {

$pl++;
if (($pl<16) or ($bewerber[$place[$xf]] eq $trainer)) {

$ein = 0;
open(D2,"/tmdata/tmi/wechsel.txt");
while (<D2>) {

$suche = '&' . $bewerber[$place[$xf]] . '&' ;
if ($_ =~ /$suche/) { $ein = 1 }
}
close (D2) ;
$coloro= "#eeeeff";

if ( $ein == 0 ) {

if ($close == 0 ) {


if ( $rad{$bewerber[$place[$xf]]} ne "1" ) {
print D9 "&$xd$tag.$xe$mon.$jahr&$auswahl_verein[$yy]&$bewerber[$place[$xf]]&$bewerber_verein[$place[$xf]]&$bewerber_punkte[$place[$xf]]&$be&\n";
$close = 1 ;
$rad{$bewerber[$place[$xf]]} = 1 ;
$coloro = "yellow" ;
}
}








$ff = $bewerber[$place[$xf]];

if ( $sp1{$ff} eq "" ) { $sp1{$ff} = "----" }
if ( $sp2{$ff} eq "" ) { $sp2{$ff} = "----" }
if ( $sp3{$ff} eq "" ) { $sp3{$ff} = "----" }

if ($prio[$xf] == 5) {$c = "sehr hoch" }
if ($prio[$xf] == 4) {$c = "hoch" }
if ($prio[$xf] == 3) {$c = "mittel" }
if ($prio[$xf] == 2) {$c = "niedrig" }
if ($prio[$xf] == 1) {$c = "sehr niedrig" }

}
}
}
print "</table>";

}

close (D9) ;



$x=0;
open (D9 , "/tmdata/tmi/history.txt") ;
while (<D9>) {


$x++;
$lines[$x] = $_ ;
chomp $lines[$x] ;
}
close (D9) ;

open (D19 , ">>/tmdata/tmi/wechsel.txt") ;


open (D9 , "/tmdata/tmi/go_change.txt") ;
while (<D9>) {
($leer , $datum , $verein , $trainer , $ex_verein , $bewerber ) = split (/&/ , $_ ) ;
print D19 "$_";
chomp $verein ;
chomp $trainer ;
print "$verein / $trainer\n";

for ($a=1 ; $a<=$x ; $a++ ) {
$xa = '&' . $trainer . '&' ;
$xb = '&Trainerposten frei&' ;
$lines[$a] =~ s/$xa/$xb/g ;
}


for ($a=1 ; $a<=$x ; $a++ ) {
$xa = $verein . '&Trainerposten frei' ;
$xb = $verein . '&' . $trainer ;
$lines[$a] =~ s/$xa/$xb/g ;
}






}
close (D9) ;


open (D9 , ">/tmdata/tmi/history.txt") ;
flock (D9,2);
for ($a=1 ; $a<=$x ; $a++ ) {
print D9 "$lines[$a]\n";
}
flock (D9,8);
close (D9) ;


open (D9 , ">/tmdata/tmi/boerse.txt") ;

close (D9) ;




close (D19) ;
open (D,">/tmdata/tmi/boerse_aktiv.txt");
print D "0";
close (D);



#require "/tmsrc/tmapp/cronjobs/tmi/neuvergabe.pl";

