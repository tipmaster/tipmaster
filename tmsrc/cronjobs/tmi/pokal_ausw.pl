#!/usr/bin/perl

require "/tmapp/tmsrc/cgi-bin/runde.pl" ;

if ( $cup_tmi_aktiv != 1 ) { exit }

print "Content-Type: text/html \n\n";
print "<font face=verdana size=1>";

require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl" ;

if ( $cup_tmi == 5 ) {
$fff=0;
open(AA,">/tmdata/tmi/final.txt");
open(AAA,">/tmdata/tmi/finals.txt");
open(AAA,">/tmdata/cl/tmi_cup_finals.txt");

}

$datei = "/tmdata/tmi/formular" . $cup_tmi_tf[$cup_tmi] . '.txt';
print $datei ;
open(DO,"<$datei");
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
($tr , $dat1 , $pro ) = split (/&/ , $_ ) ;
chomp $pro ;
$blanko{$tr} = $pro ;

}
close (D) ;
$datei = "/tmdata/tmi/pokal/pokal_qu" . $cup_tmi . ".txt";
open (RR , ">$datei" );












$y = 0;
$rr = 0;
$li=0;
$liga=0;
open(D2,"/tmdata/tmi/history.txt");
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





$runde = $cup_tmi;

for ($pokal = 1 ; $pokal<=49 ; $pokal++ ) {

print RR "#$pokal-". $cup_tmi . "&";


if ( $runde == 1 ) {

$suche = '#' . $pokal . '-' . $runde . '&' ;

open(D2,"/tmdata/tmi/pokal/pokal.txt");
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

open(D2,"/tmdata/tmi/pokal/pokal_quote.txt");
while(<D2>) {


if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);

}


open(D2,"/tmdata/tmi/heer.txt");
while(<D2>) {
@egx = split (/&/ , $_ ) ;
$plazierung{"$egx[5]"} = $egx[0] ;
$liga{"$egx[5]"} = $egx[1] ;
}
close(D2);





if ( $runde > 1 ) {



$suche = '#' . $pokal . '-1&' ;

open(D2,"/tmdata/tmi/pokal/pokal.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@egb = split (/&/ , $_ ) ;
}
}
close(D2);



open(D2,"/tmdata/tmi/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote1 = split (/&/ , $_ ) ;
}
}
close(D2);

$c=0;
for ($a=1 ; $a<=32 ; $a = $a+2) {
$b=$a+1;
$c++;

if ( $quote1[$a] ==  $quote1[$b] ) { $egy[$c] = $egb[$b] }
if ( $quote1[$a] >  $quote1[$b] ) { $egy[$c] = $egb[$a] }
if ( $quote1[$a] <  $quote1[$b] ) { $egy[$c] = $egb[$b] }


if ( $egb[$b] == 9999 ) { $egy[$c] = $egb[$a] }

}








if ( $runde == 2 ) {

$suche = '#' . $pokal . '-2&' ;
open(D2,"/tmdata/tmi/pokal/pokal_quote.txt");
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
open(D2,"/tmdata/tmi/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote2 = split (/&/ , $_ ) ;
}
}
close(D2);

$c=0;
for ($a=1 ; $a<=16 ; $a = $a+2) {
$b=$a+1;
$c++;

if ( $quote2[$a] ==  $quote2[$b] ) { $egx[$c] = $egy[$b] }
if ( $quote2[$a] >  $quote2[$b] ) { $egx[$c] = $egy[$a] }
if ( $quote2[$a] <  $quote2[$b] ) { $egx[$c] = $egy[$b] }

}



}






if ( $runde == 3 ) {

$suche = '#' . $pokal . '-3&' ;
open(D2,"/tmdata/tmi/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);
@ega = @egx ;
}





if ( $runde > 3 ) {

$suche = '#' . $pokal . '-3&' ;
open(D2,"/tmdata/tmi/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote3 = split (/&/ , $_ ) ;
}
}
close(D2);

$c=0;
for ($a=1 ; $a<=8 ; $a = $a+2) {
$b=$a+1;
$c++;

if ( $quote3[$a] ==  $quote3[$b] ) { $egw[$c] = $egx[$b] }
if ( $quote3[$a] >  $quote3[$b] ) { $egw[$c] = $egx[$a] }
if ( $quote3[$a] <  $quote3[$b] ) { $egw[$c] = $egx[$b] }
}




}






if ( $runde == 4 ) {

$suche = '#' . $pokal . '-4&' ;
open(D2,"/tmdata/tmi/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);
@ega = @egw ;
}




if ( $runde > 4 ) {

$suche = '#' . $pokal . '-4&' ;
open(D2,"/tmdata/tmi/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote4 = split (/&/ , $_ ) ;
}
}
close(D2);

$c=0;
for ($a=1 ; $a<=4 ; $a = $a+2) {
$b=$a+1;
$c++;

if ( $quote4[$a] ==  $quote4[$b] ) { $egv[$c] = $egw[$b] }
if ( $quote4[$a] >  $quote4[$b] ) { $egv[$c] = $egw[$a] }
if ( $quote4[$a] <  $quote4[$b] ) { $egv[$c] = $egw[$b] }
}



}




if ( $runde == 5 ) {

$suche = '#' . $pokal . '-5&' ;
open(D2,"/tmdata/tmi/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);
@ega = @egv ;
}







}











if ( $runde == 1 ) { $aa = 32 }
if ( $runde == 2 ) { $aa = 16 }
if ( $runde == 3 ) { $aa = 8 }
if ( $runde == 4 ) { $aa = 4 }
if ( $runde == 5 ) { $aa = 2 }





$d=0;
for ( $y= 1 ; $y<=$aa ; $y++ ) {
$d++ ;
if ( $d== 3 ) { $d=1 }

if ( $d==1 ) { $gegner_if = $ega[$y+1] }
if ( $d==2 ) { $gegner_if = $ega[$y-1] }
if ( $d==1 ) { $ort = "Heimspiel" }
if ( $d==2 ) { $ort = "Auswaertsspiel" }
if ( $runde == 5 ) { $ort="neutraler Platz" }

$xx="";
if ( $ega[$y] < 1000 ) { $xx = "0" }
if ( $ega[$y] < 100 ) { $xx = "00" }
if ( $ega[$y] < 10 ) { $xx = "000" }







$tip_datei = $xx . $ega[$y] . '-' . $pokal . '-' . $runde .'.txt' ;
$tip_datei = '/tmdata/tmi/pokal/tips/' . $tip_datei ;

for ($r=0;$r<=9;$r++) {
$tips[$r] = "0&0" ;
}


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

$ole = $tips ;


$ein = 0;
if ( -e "$tip_datei" ) { $ein = 1 }



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
if ( ($ergebnis[$r+1] == 4) and ($tips[$r] > 0 )) { $quote = $quote + 10 }
}
print "$ort Tips #$ole -> \n";


for ($r=0;$r<=9;$r++) {
print "$tips[$r]  " ;
}
print " $quote  $team[$ega[$y]] / $verein_trainer[$ega[$y]]<br>\n";




print RR "$quote&";
#print AA "&$team[$ega[$y]]&$quote&\n";

$fff++;
$fff_string[$fff]="&" . $team[$ega[$y]] . "&" .$quote. "&\n";

}


print RR "\n";

print "\n\n<br>";



}




close (RR) ;



$zeile=0;
open (D7,"</tmdata/tmi/pokal/pokal_quote.txt");
while(<D7>){
$zeile++;
$zeilen[$zeile] = $_;
chomp $zeilen[$zeile];
}
close (D7);

$zo=0;
for ($x=1;$x<=$cup_tmi;$x++){
$datei = "/tmdata/tmi/pokal/pokal_qu" . $x . ".txt";
open (D7,"<$datei");
while(<D7>){
$zo++;
$zeilen[$zo] = $_;
chomp $zeilen[$zo];
}
close (D7);
}

open (D8,">/tmdata/tmi/pokal/pokal_quote.txt");
for ($x=1;$x<=$zeile;$x++){
print D8 "$zeilen[$x]\n";
}
close(D8);

for($y=1;$y<=$fff;$y=$y+2){

@all1 = split(/&/,$fff_string[$y]);
@all2 = split(/&/,$fff_string[$y+1]);

if ( $all1[2] > $all2[2] ) {
print AA "$fff_string[$y]"} else {
print AA "$fff_string[$y+1]" }

if ( $all1[2] > $all2[2] ) {
print AAA "$fff_string[$y]$fff_string[$y+1]\n"} else {
print AAA "$fff_string[$y+1]$fff_string[$y]\n" }


}


if ( $cup_tmi < 5 ) { $cup_tmi++ }
open (D1,">/tmdata/tmi/pokal/pokal_datum.txt");
print D1 "$cup_tmi\n";
close (D1);

close (AA) ;
close (AAA) ;

