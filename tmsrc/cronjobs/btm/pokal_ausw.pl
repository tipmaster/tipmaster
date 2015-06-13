#!/usr/bin/perl

print "Content-Type: text/html \n\n";

require "/tmapp/tmsrc/cgi-bin/runde.pl" ;
if ( $cup_btm_aktiv != 1 ) { exit }

if ( $cup_btm == 7 ) {
$fff=0;
open(DJ,">/tmdata/btm/finals.txt");
}

$datei = "/tmdata/btm/formular" . $cup_btm_tf[$cup_btm] . '.txt';

open(DO,"$datei");
while(<DO>) {
@ereine = <DO>;
}
close(DO);

$y = 0;
for ( $x = 0; $x < 25;$x++ )
{
$y++;
chomp $ereine[$y];
@ga = split (/&/, $ereine[$y]);	
$flagge[$y] = $ga[0] ;
$paarung[$y] = $ga[1];
$qu_1[$y] = $ga[2];
$qu_0[$y] = $ga[3];
$qu_2[$y] = $ga[4];
$ergebnis[$y] = $ga[5];
}


open ( D , "/tmdata/blanko.txt" );
while (<D>) {
($tr , $dat1 ,  $pro ) = split (/&/ , $_ ) ;
chomp $pro ;
$blanko{$tr} = $pro ;

}
close (D) ;

open (RR , ">/tmdata/btm/pokal/pokal_qu$cup_btm.txt" );








@liga_namen = ( "spacer" , "1.Bundesliga" , "2.Bundesliga" ,"Regionalliga A" ,"Regionalliga B" ,"Oberliga A" ,"Oberliga B" ,"Oberliga C" ,"Oberliga D" ,
"Verbandsliga A" ,"Verbandsliga B" ,"Verbandsliga C" ,"Verbandsliga D" ,"Verbandsliga E" ,"Verbandsliga F" ,"Verbandsliga G" ,"Verbandsliga H" ,
"Landesliga A" ,"Landesliga B" ,"Landesliga C" ,"Landesliga D" ,"Landesliga E" ,"Landesliga F" ,"Landesliga G" ,"Landesliga H" ,
"Landesliga I" ,"Landesliga K" ,"Landesliga L" ,"Landesliga M" ,"Landesliga N" ,"Landesliga O" ,"Landesliga P" ,"Landesliga R" ,
"Bezirksliga 01" ,"Bezirksliga 02" ,"Bezirksliga 03" ,"Bezirksliga 04" ,"Bezirksliga 05" ,"Bezirksliga 06" ,"Bezirksliga 07" ,"Bezirksliga 08" ,
"Bezirksliga 09" ,"Bezirksliga 10" ,"Bezirksliga 11" ,"Bezirksliga 12" ,"Bezirksliga 13" ,"Bezirksliga 14" ,"Bezirksliga 15" ,"Bezirksliga 16" ,
"Bezirksliga 17" ,"Bezirksliga 18" ,"Bezirksliga 19" ,"Bezirksliga 20" ,"Bezirksliga 21" ,"Bezirksliga 22" ,"Bezirksliga 23" ,"Bezirksliga 24" ,
"Bezirksliga 25" ,"Bezirksliga 26" ,"Bezirksliga 27" ,"Bezirksliga 28" ,"Bezirksliga 29" ,"Bezirksliga 30" ,"Bezirksliga 31" ,"Bezirksliga 32" ,
"Kreisliga 01" ,"Kreisliga 02" ,"Kreisliga 03" ,"Kreisliga 04" ,"Kreisliga 05" ,"Kreisliga 06" ,"Kreisliga 07" ,"Kreisliga 08" ,
"Kreisliga 09" ,"Kreisliga 10" ,"Kreisliga 11" ,"Kreisliga 12" ,"Kreisliga 13" ,"Kreisliga 14" ,"Kreisliga 15" ,"Kreisliga 16" ,
"Kreisliga 17" ,"Kreisliga 18" ,"Kreisliga 19" ,"Kreisliga 20" ,"Kreisliga 21" ,"Kreisliga 22" ,"Kreisliga 23" ,"Kreisliga 24" ,
"Kreisliga 25" ,"Kreisliga 26" ,"Kreisliga 27" ,"Kreisliga 28" ,"Kreisliga 29" ,"Kreisliga 30" ,"Kreisliga 31" ,"Kreisliga 32" ) ;

@liga_kuerzel = ( "spacer" , 
"1.BL" , "2.BL" ,"RL A" ,"RL B" ,"OL A" ,"OL B" ,"OL C" ,"OL D" ,
"VL A" ,"VL B" ,"VL C" ,"VL D" ,"VL E" ,"VL F" ,"VL G" ,"VL H" ,
"LA A" ,"LA B" ,"LA C" ,"LA D" ,"LA E" ,"LA F" ,"LA G" ,"LA H" ,
"LA I" ,"LA K" ,"LA L" ,"LA M" ,"LA N" ,"LA O" ,"LA P" ,"LA R" ,
"BE 01" ,"BE 02" ,"BE 03" ,"BE 04" ,"BE 05" ,"BE 06" ,"BE 07" ,"BE 08" ,
"BE 09" ,"BE 10" ,"BE 11" ,"BE 12" ,"BE 13" ,"BE 14" ,"BE 15" ,"BE 16" ,
"BE 17" ,"BE 18" ,"BE 19" ,"BE 20" ,"BE 21" ,"BE 22" ,"BE 23" ,"BE 24" ,
"BE 25" ,"BE 26" ,"BE 27" ,"BE 28" ,"BE 29" ,"BE 30" ,"BE 31" ,"BE 32" ,
"KR 01" ,"KR 02" ,"KR 03" ,"KR 04" ,"KR 05" ,"KR 06" ,"KR 07" ,"KR 08" ,
"KR 09" ,"KR 10" ,"KR 11" ,"KR 12" ,"KR 13" ,"KR 14" ,"KR 15" ,"KR 16" ,
"KR 17" ,"KR 18" ,"KR 19" ,"KR 20" ,"KR 21" ,"KR 22" ,"KR 23" ,"KR 24" ,
"KR 25" ,"KR 26" ,"KR 27" ,"KR 28" ,"KR 29" ,"KR 30" ,"KR 31" ,"KR 32" ,
) ;



$y = 0;
$rr = 0;
$li=0;
$liga=0;
open(D2,"/tmdata/btm/history.txt");
while(<D2>) {

$li++;
@vereine = split (/&/, $_);	

$y=0;
for ( $x = 1; $x < 19; $x++ )
{

$rr++;
$y++;
chomp $verein[$y];
$team[$rr] = $vereine[$y];

$y++;
chomp $verein[$y];
$verein_trainer[$rr] = $vereine[$y];

if ( $verein_trainer[$rr] eq $trainer ) {
$trainer_verein = $team[$rr];
$trainer_id = ( ($li-1) * 18 ) + $x ;
}

$coach{$team[$rr]} = $verein_trainer[$rr] ;
$verein_liga[$rr] = $li;
$verein_nr[$rr] = $x;
$y++;
}

}
close(D2);

$pokal_id = 0;
$pokal_dfb=0;





$runde = $cup_btm;

for ($pokal = 1 ; $pokal<=17 ; $pokal++ ) {

print RR "#$pokal-" . $cup_btm . "&";



if ( $runde == 1 ) {

$suche = '#' . $pokal . '-' . $runde . '&' ;

open(D2,"/tmdata/btm/pokal/pokal.txt");
while(<D2>) {


if ($_ =~ /$suche/) {
@ega = split (/&/ , $_ ) ;
}


$rsuche = '&' . $trainer_id . '&' ;

if ($_ =~ /$rsuche/) {
( $pokal_id , $rest ) = split (/&/ , $_ ) ;
}


}
close(D2);

open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {


if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);

}


open(D2,"/tmdata/btm/heer.txt");
while(<D2>) {
@egx = split (/&/ , $_ ) ;
$plazierung{"$egx[5]"} = $egx[0] ;
$liga{"$egx[5]"} = $egx[1] ;
}
close(D2);





if ( $runde > 1 ) {

if ($pokal !=17 ) {

$suche = '#' . $pokal . '-1&' ;

open(D2,"/tmdata/btm/pokal/pokal.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@egb = split (/&/ , $_ ) ;
}
}
close(D2);
}


open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote1 = split (/&/ , $_ ) ;
}
}
close(D2);

$c=0;
for ($a=1 ; $a<=128 ; $a = $a+2) {
$b=$a+1;
$c++;

if ( $quote1[$a] ==  $quote1[$b] ) { $egy[$c] = $egb[$b] }
if ( $quote1[$a] >  $quote1[$b] ) { $egy[$c] = $egb[$a] }
if ( $quote1[$a] <  $quote1[$b] ) { $egy[$c] = $egb[$b] }


if ( $egb[$b] == 9999 ) { $egy[$c] = $egb[$a] }

}



if ($pokal == 17 ) {
open(D2,"/tmdata/btm/pokal/pokal_id.txt");
while(<D2>) {
@egy = split (/&/ , $_ ) ;
}
close(D2);
}






if ( $runde == 2 ) {

$suche = '#' . $pokal . '-2&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);
@ega = @egy ;
}





if ( $runde > 2 ) {

$suche = '#' . $pokal . '-2&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote2 = split (/&/ , $_ ) ;
}
}
close(D2);

$c=0;
for ($a=1 ; $a<=64 ; $a = $a+2) {
$b=$a+1;
$c++;

if ( $quote2[$a] ==  $quote2[$b] ) { $egx[$c] = $egy[$b] }
if ( $quote2[$a] >  $quote2[$b] ) { $egx[$c] = $egy[$a] }
if ( $quote2[$a] <  $quote2[$b] ) { $egx[$c] = $egy[$b] }

}


if ( $pokal == 17 ) {
@xex = () ;
@tausch = () ;



open(D2,"/tmdata/btm/pokal/pokal_dfb.txt");
while(<D2>) {
$suche = '1#' ;
if ($_ =~ /$suche/) {
( $rest , $long ) = split (/#/ , $_ ) ;
@tausch = split (/&/ , $long ) ;
for ($a=1 ; $a<=32 ; $a++) {
$xex[$a] = $egx[$tausch[$a-1]] ;
}
}
}
close(D2);

for ($ax=1 ; $ax<=32 ; $ax=$ax+2) {
$bx=$ax+1;


if ( ( $liga{$team[$xex[$bx]]} > 2 ) and ( $liga{$team[$xex[$ax]]} < 3 ) ) {



$xa = $xex[$ax] ;
$xb = $xex[$bx] ;
$xex[$ax] = $xb ;
$xex[$bx] = $xa ;


}
}


@egx = @xex ;
}






if ( $runde == 3 ) {

$suche = '#' . $pokal . '-3&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);
@ega = @egx ;
}

}



if ( $runde > 3 ) {

$suche = '#' . $pokal . '-3&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote3 = split (/&/ , $_ ) ;
}
}
close(D2);

$c=0;
for ($a=1 ; $a<=32 ; $a = $a+2) {
$b=$a+1;
$c++;

if ( $quote3[$a] ==  $quote3[$b] ) { $egw[$c] = $egx[$b] }
if ( $quote3[$a] >  $quote3[$b] ) { $egw[$c] = $egx[$a] }
if ( $quote3[$a] <  $quote3[$b] ) { $egw[$c] = $egx[$b] }
}


if ( $pokal == 17 ) {
@xex = () ;
@tausch = () ;
open(D2,"/tmdata/btm/pokal/pokal_dfb.txt");
while(<D2>) {
$suche = '2#' ;
if ($_ =~ /$suche/) {
( $rest , $long ) = split (/#/ , $_ ) ;
@tausch = split (/&/ , $long ) ;
for ($a=1 ; $a<=16 ; $a++) {
$xex[$a] = $egw[$tausch[$a-1]] ;
}
}
}
close(D2);

for ($ax=1 ; $ax<=16 ; $ax=$ax+2) {
$bx=$ax+1;



if ( ( $liga{$team[$xex[$bx]]} > 2 ) and ( $liga{$team[$xex[$ax]]} < 3 ) ) {



$xa = $xex[$ax] ;
$xb = $xex[$bx] ;
$xex[$ax] = $xb ;
$xex[$bx] = $xa ;


}
}


@egw = @xex ;
}






if ( $runde == 4 ) {

$suche = '#' . $pokal . '-4&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);
@ega = @egw ;
}

}



if ( $runde > 4 ) {

$suche = '#' . $pokal . '-4&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote4 = split (/&/ , $_ ) ;
}
}
close(D2);

$c=0;
for ($a=1 ; $a<=16 ; $a = $a+2) {
$b=$a+1;
$c++;

if ( $quote4[$a] ==  $quote4[$b] ) { $egv[$c] = $egw[$b] }
if ( $quote4[$a] >  $quote4[$b] ) { $egv[$c] = $egw[$a] }
if ( $quote4[$a] <  $quote4[$b] ) { $egv[$c] = $egw[$b] }
}


if ( $pokal == 17 ) {
@xex = () ;
@tausch = () ;

open(D2,"/tmdata/btm/pokal/pokal_dfb.txt");
while(<D2>) {
$suche = '3#' ;
if ($_ =~ /$suche/) {
( $rest , $long ) = split (/#/ , $_ ) ;
@tausch = split (/&/ , $long ) ;
for ($a=1 ; $a<=8 ; $a++) {
$xex[$a] = $egv[$tausch[$a-1]] ;
}
}
}
close(D2);
for ($ax=1 ; $ax<=8 ; $ax=$ax+2) {
$bx=$ax+1;


if ( ( $liga{$team[$xex[$bx]]} > 2 ) and ( $liga{$team[$xex[$ax]]} < 3 ) ) {



$xa = $xex[$ax] ;
$xb = $xex[$bx] ;
$xex[$ax] = $xb ;
$xex[$bx] = $xa ;


}
}

@egv = @xex ;
}




if ( $runde == 5 ) {

$suche = '#' . $pokal . '-5&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);
@ega = @egv ;
}

}



if ( $runde > 5 ) {

$suche = '#' . $pokal . '-5&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote5 = split (/&/ , $_ ) ;
}
}
close(D2);

$c=0;
for ($a=1 ; $a<=8 ; $a = $a+2) {
$b=$a+1;
$c++;

if ( $quote5[$a] ==  $quote5[$b] ) { $egm[$c] = $egv[$b] }
if ( $quote5[$a] >  $quote5[$b] ) { $egm[$c] = $egv[$a] }
if ( $quote5[$a] <  $quote5[$b] ) { $egm[$c] = $egv[$b] }
}

if ( $pokal == 17 ) {
@xex = () ;
@tausch = () ;

open(D2,"/tmdata/btm/pokal/pokal_dfb.txt");
while(<D2>) {
$suche = '4#' ;
if ($_ =~ /$suche/) {
( $rest , $long ) = split (/#/ , $_ ) ;
@tausch = split (/&/ , $long ) ;
for ($a=1 ; $a<=4 ; $a++) {
$xex[$a] = $egm[$tausch[$a-1]] ;
}
}
}
close(D2);

for ($ax=1 ; $ax<=4 ; $ax=$ax+2) {
$bx=$ax+1;



if ( ( $liga{$team[$xex[$bx]]} > 2 ) and ( $liga{$team[$xex[$ax]]} < 3 ) ) {



$xa = $xex[$ax] ;
$xb = $xex[$bx] ;
$xex[$ax] = $xb ;
$xex[$bx] = $xa ;


}
}


@egm = @xex ;
}




if ( $runde == 6 ) {

$suche = '#' . $pokal . '-6&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);
@ega = @egm ;
}

}



if ( $runde > 6 ) {

$suche = '#' . $pokal . '-6&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote6 = split (/&/ , $_ ) ;
}
}
close(D2);

$c=0;
for ($a=1 ; $a<=4 ; $a = $a+2) {
$b=$a+1;
$c++;

if ( $quote6[$a] ==  $quote6[$b] ) { $egn[$c] = $egm[$b] }
if ( $quote6[$a] >  $quote6[$b] ) { $egn[$c] = $egm[$a] }
if ( $quote6[$a] <  $quote6[$b] ) { $egn[$c] = $egm[$b] }
}


if ( $pokal == 17 ) {
@xex = () ;
@tausch = () ;

open(D2,"/tmdata/btm/pokal/pokal_dfb.txt");
while(<D2>) {
$suche = '5#' ;
if ($_ =~ /$suche/) {
( $rest , $long ) = split (/#/ , $_ ) ;
@tausch = split (/&/ , $long ) ;
for ($a=1 ; $a<=2 ; $a++) {
$xex[$a] = $egn[$tausch[$a-1]] ;
}
}
}
close(D2);

@egn = @xex ;
}





if ( $runde == 7 ) {

$suche = '#' . $pokal . '-7&' ;
open(D2,"/tmdata/btm/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);
@ega = @egn ;
}

}






}









print "<font face=verdana size=1>\n";

if ( $runde == 1 ) { $aa = 128 }
if ( $runde == 2 ) { $aa = 64 }
if ( $runde == 3 ) { $aa = 32 }
if ( $runde == 4 ) { $aa = 16 }
if ( $runde == 5 ) { $aa = 8 }
if ( $runde == 6 ) { $aa = 4 }
if ( $runde == 7 ) { $aa = 2 }


$d=0;
for ( $y= 1 ; $y<=$aa ; $y++ ) {
$d++ ;
if ( $d== 3 ) { $d=1 }

if ( $d==1 ) { $gegner_if = $ega[$y+1] }
if ( $d==2 ) { $gegner_if = $ega[$y-1] }
if ( $d==1 ) { $ort = "Heimspiel" }
if ( $d==2 ) { $ort = "Auswaertsspiel" }
if ( $pokal == 7 ) { $ort="neutraler Platz" }

$xx="";
if ( $ega[$y] < 1000 ) { $xx = "0" }
if ( $ega[$y] < 100 ) { $xx = "00" }
if ( $ega[$y] < 10 ) { $xx = "000" }







$tip_datei = $xx . $ega[$y] . '-' . $pokal . '-' . $runde .'.txt' ;
$tip_datei = '/tmdata/btm/pokal/tips/' . $tip_datei ;

for ($r=0;$r<=9;$r++) {
$tips[$r] = "0&0" ;
}

if ( $pokal < 17 ) { $tips = 4 }

if ( $pokal == 17 ) {

$verein = $team[$ega[$y]] ;

if ( ($liga{$verein} == 1) and ($liga{$teams[$gegner_if]} == 1) and ( $ort eq "Heimspiel" ) ) { ( $tips = 5 ) and ( $tips_g = 4 ) }
if ( ($liga{$verein} == 1) and ($liga{$teams[$gegner_if]} == 1) and ( $ort eq "Auswaertsspiel" ) ) { ( $tips = 4 ) and ( $tips_g = 5 ) }
if ( ($liga{$verein} == 1) and ($liga{$teams[$gegner_if]} == 1) and ( $ort eq "neutraler Platz" ) ) { ( $tips = 5 ) and ( $tips_g = 5 ) }

if ( ($liga{$verein} == 2) and ($liga{$teams[$gegner_if]} == 2) and ( $ort eq "Heimspiel" ) ) { ( $tips = 5 ) and ( $tips_g = 4 ) }
if ( ($liga{$verein} == 2) and ($liga{$teams[$gegner_if]} == 2) and ( $ort eq "Auswaertsspiel" ) ) { ( $tips = 4 ) and ( $tips_g = 5 ) }
if ( ($liga{$verein} == 2) and ($liga{$teams[$gegner_if]} == 2) and ( $ort eq "neutraler Platz" ) ) { ( $tips = 5 ) and ( $tips_g = 5 ) }

if ( ($liga{$verein} == 3) and ($liga{$teams[$gegner_if]} == 3) and ( $ort eq "Heimspiel" ) ) { ( $tips = 5 ) and ( $tips_g = 4 ) }
if ( ($liga{$verein} == 3) and ($liga{$teams[$gegner_if]} == 3) and ( $ort eq "Auswaertsspiel" ) ) { ( $tips = 4 ) and ( $tips_g = 5 ) }
if ( ($liga{$verein} == 3) and ($liga{$teams[$gegner_if]} == 3) and ( $ort eq "neutraler Platz" ) ) { ( $tips = 5 ) and ( $tips_g = 5 ) }

if ( ($liga{$verein} == 1) and ($liga{$teams[$gegner_if]} == 3) and ( $ort eq "Heimspiel" ) ) { ( $tips = 5 ) and ( $tips_g = 3 ) }
if ( ($liga{$verein} == 1) and ($liga{$teams[$gegner_if]} == 3) and ( $ort eq "Auswaertsspiel" ) ) { ( $tips = 5 ) and ( $tips_g = 3 ) }
if ( ($liga{$verein} == 1) and ($liga{$teams[$gegner_if]} == 3) and ( $ort eq "neutraler Platz" ) ) { ( $tips = 5 ) and ( $tips_g = 3 ) }

if ( ($liga{$verein} == 3) and ($liga{$teams[$gegner_if]} == 1) and ( $ort eq "Heimspiel" ) ) { ( $tips = 3 ) and ( $tips_g = 5 ) }
if ( ($liga{$verein} == 3) and ($liga{$teams[$gegner_if]} == 1) and ( $ort eq "Auswaertsspiel" ) ) { ( $tips = 3 ) and ( $tips_g = 5 ) }
if ( ($liga{$verein} == 3) and ($liga{$teams[$gegner_if]} == 1) and ( $ort eq "neutraler Platz" ) ) { ( $tips = 3 ) and ( $tips_g = 5 ) }

if ( ($liga{$verein} == 1) and ($liga{$teams[$gegner_if]} == 2) and ( $ort eq "Heimspiel" ) ) { ( $tips = 5 ) and ( $tips_g = 3 ) }
if ( ($liga{$verein} == 1) and ($liga{$teams[$gegner_if]} == 2) and ( $ort eq "Auswaertsspiel" ) ) { ( $tips = 5 ) and ( $tips_g = 4 ) }
if ( ($liga{$verein} == 1) and ($liga{$teams[$gegner_if]} == 2) and ( $ort eq "neutraler Platz" ) ) { ( $tips = 5 ) and ( $tips_g = 4 ) }

if ( ($liga{$verein} == 2) and ($liga{$teams[$gegner_if]} == 1) and ( $ort eq "Heimspiel" ) ) { ( $tips = 4 ) and ( $tips_g = 5 ) }
if ( ($liga{$verein} == 2) and ($liga{$teams[$gegner_if]} == 1) and ( $ort eq "Auswaertsspiel" ) ) { ( $tips = 3 ) and ( $tips_g = 5 ) }
if ( ($liga{$verein} == 2) and ($liga{$teams[$gegner_if]} == 1) and ( $ort eq "neutraler Platz" ) ) { ( $tips = 4 ) and ( $tips_g = 5 ) }

if ( ($liga{$verein} == 2) and ($liga{$teams[$gegner_if]} == 3) and ( $ort eq "Heimspiel" ) ) { ( $tips = 5 ) and ( $tips_g = 3 ) }
if ( ($liga{$verein} == 2) and ($liga{$teams[$gegner_if]} == 3) and ( $ort eq "Auswaertsspiel" ) ) { ( $tips = 5 ) and ( $tips_g = 4 ) }
if ( ($liga{$verein} == 2) and ($liga{$teams[$gegner_if]} == 3) and ( $ort eq "neutraler Platz" ) ) { ( $tips = 5 ) and ( $tips_g = 4 ) }

if ( ($liga{$verein} == 3) and ($liga{$teams[$gegner_if]} == 2) and ( $ort eq "Heimspiel" ) ) { ( $tips = 4 ) and ( $tips_g = 5 ) }
if ( ($liga{$verein} == 3) and ($liga{$teams[$gegner_if]} == 2) and ( $ort eq "Auswaertsspiel" ) ) { ( $tips = 3 ) and ( $tips_g = 5 ) }
if ( ($liga{$verein} == 3) and ($liga{$teams[$gegner_if]} == 2) and ( $ort eq "neutraler Platz" ) ) { ( $tips = 4 ) and ( $tips_g = 5 ) }

}



#if ( $verein_trainer[$ega[$y]] eq "Trainerposten frei" ) {
#srand() ;
#print "$verein_trainer[$ega[$y]]\n";
#for ($r=0;$r<=$tips;$r++) {
#$ac = int(3*rand)+1 ;
#$tips[$r] = "1&" . $ac ;
#}
#}



$ein = 0;
if ( -e "$tip_datei" ) { $ein = 1 }

#if ( $ein == 0 ) {

#if ($blanko{$verein_trainer[$ega[$y]]} == 1 ) {
#print "$verein_trainer[$ega[$y]]\n";

#for ($r=0;$r<=$tips;$r++) {
#$tips[$r] = "1&1" ;

#}
#}

#if ($blanko{$verein_trainer[$ega[$y]]} == 2 ) {
#print "$verein_trainer[$ega[$y]]\n";

#for ($r=0;$r<=$tips;$r++) {
#$tips[$r] = "1&2" ;

#}
#}

#if ($blanko{$verein_trainer[$ega[$y]]} == 3 ) {
#print "$verein_trainer[$ega[$y]]\n";
#for ($r=0;$r<=$tips;$r++) {
#$tips[$r] = "1&3" ;

#}
#}

#}



open (D, "$tip_datei" ) ;
while (<D>) {
@tips = split (/\./ , $_ ) ;
}
close (D) ;






$quote=0;
for ($r=0;$r<=9;$r++) {

if ( ($tips[$r] eq "1&1") and ($ergebnis[$r+1] == 1)) { $quote = $quote + $qu_1[$r+1] }
if ( ($tips[$r] eq "1&2") and ($ergebnis[$r+1] == 2)) { $quote = $quote + $qu_0[$r+1] }
if ( ($tips[$r] eq "1&3") and ($ergebnis[$r+1] == 3)) { $quote = $quote + $qu_2[$r+1] }
if ( ($ergebnis[$r+1] == 4) and ($tips[$r] > 0)) { $quote = $quote + 10 }
}
print "<br>\n";


for ($r=0;$r<=9;$r++) {
print "$tips[$r]  " ;
}
print "$quote<br>\n";





print RR "$quote&";

#print DJ"&$team[$ega[$y]]&$quote&\n";

if ( $pokal < 17 ) {
$fff++;
$fff_string[$fff]="&" . $team[$ega[$y]] . "&" .$quote. "&\n";
}

}


print RR "\n";

print "\n\n<br><br>";



}




close (RR) ;




$zeile=0;
open (D7,"</tmdata/btm/pokal/pokal_quote.txt");
while(<D7>){
$zeile++;
$zeilen[$zeile] = $_;
chomp $zeilen[$zeile];
}
close (D7);

$zo=0;
for ($x=1;$x<=$cup_btm;$x++){
$datei = "/tmdata/btm/pokal/pokal_qu" . $x . ".txt";
open (D7,"<$datei");
while(<D7>){
$zo++;
$zeilen[$zo] = $_;
chomp $zeilen[$zo];
}
close (D7);
}

open (D8,">/tmdata/btm/pokal/pokal_quote.txt");
for ($x=1;$x<=$zeile;$x++){
print D8 "$zeilen[$x]\n";
}
close(D8);

if ( $cup_btm < 7 ) { $cup_btm++ }
open (D1,">/tmdata/btm/pokal/pokal_datum.txt");
print D1 "$cup_btm\n";
close (D1);


for($y=1;$y<=$fff;$y=$y+2){

@all1 = split(/&/,$fff_string[$y]);
@all2 = split(/&/,$fff_string[$y+1]);

if ( $all1[2] > $all2[2] ) {
print DJ "$fff_string[$y]"} else {
print DJ "$fff_string[$y+1]" }
}

close (DJ);
