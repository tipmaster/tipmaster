#!/usr/bin/perl


open(U,">/tmdata/tmi/tip_status.txt");
print U "2";
close (U);

open(U,">/tmdata/tmi/pokal/tip_status.txt");
print U "2";
close (U);

require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl";
require "/tmapp/tmsrc/cgi-bin/runde.pl";
$spielrunde = $rrunde;
$hier = ($spielrunde*4) - 3;
$datei_error = "/tmdata/tmi/error_tips_" . $spielrunde . ".txt" ;
open(ER,">$datei_error");

$datei_save = "/tmdata/tmi/history_st_" . $spielrunde . ".txt" ;
open(L,">$datei_save");
open(U,"</tmdata/tmi/history.txt");
while (<U>) {
print L "$_";
}
close (U);
close (L);

$path = "/tmdata/tmi/";


print "Content-type: text/html\n\n<font face=verdana size=1>";

$tips = 3654; 

for ($x=1;$x<=3654;$x++){
$datei = $x;
$nummer = $x;

if ($x<1000) {$datei = '0' . $datei }
if ($x<100) {$datei = '0' . $datei }
if ($x<10) {$datei = '0' . $datei }



$dot = "/tmdata/tmi/tips/$hier/" . $datei . '.txt' ;
#print "$dot<br>";


open (D, "$dot");
$hierp = "";
$hierp = <D> ;
chomp $hierp ;
close (D);

#print "$hierp<br>";


if ($hierp eq "") {$tips--}
if ($hierp eq "") { $hierp = $datei . '#-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.' }


$u = ">>";
if ($x==1) { $u = ">" }
open (E, "$u/tmdata/tmi/tips/$hier/all.txt");
print E "$hierp\n";
close (E);
}

print "<br>TMI : Es wurden $tips Tips abgegeben ...";



open(U,">>/tmdata/tmi/tipanzahl.txt");
print U "$tips\n";
close (U) ;

open(U,">/tmdata/tmi/zat$hier.txt");
close (U) ;

open(U,">/tmdata/tmi/zatneu.txt");
close (U) ;


srand($spielrunde);
$r=0;
open(U,"/tmdata/tmi/history.txt");

while (<U>) {
$r++;
chomp $_;
$history[$r] = $_ ;
#print "$r $history[$r]\n";
}
close (U);



$vv = 0;
open(D2,"/tmdata/tmi/history.txt");
while(<D2>) {
@vereine = ();
$e++ ;

@vereine = split (/&/, $_);	

$ya = 0;
for ( $x = 1; $x < 19; $x++ )
{
$ya++;
$y++;
$zoll = $x;
chomp $vereine[$ya];
$datq[$y] = $vereine[$ya];

$ya++;
chomp $vereine[$ya];
$datb[$y] = $vereine[$ya];
#print "$y $datb[$y]\n";
$ya++;
chomp $vereine[$ya];
$datc[$y] = $vereine[$ya];
$liga[$y] = $e ;
}


}
close(D2);

$zoll = 0;
open(DO,"/tmdata/tmi/spieltag.txt");
while(<DO>) {
@ego = <DO>;
}
close(DO);

$ff=0;


$u = 2;
if ($hier == 33 ) { $u = 0 }

for ( $spieltag = ($hier-1); $spieltag <= ($hier+$u); $spieltag++ )
{
$ff++;
@ega = split (/&/, $ego[$spieltag]);	

chop $quoten_row[$spieltag];
for ( $sq = 0; $sq <= 16; $sq = $sq + 2 ){
if  ( $ff == 1 ){ $ort_1[$ega[$sq]] = "H" }
if  ( $ff == 2 ){ $ort_2[$ega[$sq]] = "H" }
if  ( $ff == 3 ){ $ort_3[$ega[$sq]] = "H" }
if  ( $ff == 4 ){ $ort_4[$ega[$sq]] = "H" }
}
for ( $sq = 1; $sq <= 17; $sq = $sq + 2 ){
if  ( $ff == 1 ){ $ort_1[$ega[$sq]] = "A" }
if  ( $ff == 2 ){ $ort_2[$ega[$sq]] = "A" }
if  ( $ff == 3 ){ $ort_3[$ega[$sq]] = "A" }
if  ( $ff == 4 ){ $ort_4[$ega[$sq]] = "A" }
}



}




open (D2 , "/tmdata/tmi/tips/$hier/all.txt");
while (<D2>) {
$x++;
$line[$x] = $_ ;
chomp $line[$x] ;
($nummer , $tip_row[$x]) = split(/#/, $_);
$richtig = int(($zoll-1)/18);
$richtig = $nummer - ($richtig * 18 );

@prognosen = split(/\./, $tip_row[$x]);


if ( $prognosen[1] ne "-" ) { 
$dd++ ;
$gg++ ;
$change[$dd] = $nummer . ',' ;
$vv++;



for ( $c=0 ; $c<=24 ; $c++){
if ( $prognosen[$c] eq "1&1" ) {$rost[$c] = "Sp.1__1"}
if ( $prognosen[$c] eq "2&1" ) {$rost[$c] = "Sp.2__1"}
if ( $prognosen[$c] eq "3&1" ) {$rost[$c] = "Sp.3__1"}
if ( $prognosen[$c] eq "4&1" ) {$rost[$c] = "Sp.4__1"}
if ( $prognosen[$c] eq "1&2" ) {$rost[$c] = "Sp.1__0"}
if ( $prognosen[$c] eq "2&2" ) {$rost[$c] = "Sp.2__0"}
if ( $prognosen[$c] eq "3&2" ) {$rost[$c] = "Sp.3__0"}
if ( $prognosen[$c] eq "4&2" ) {$rost[$c] = "Sp.4__0"}
if ( $prognosen[$c] eq "1&3" ) {$rost[$c] = "Sp.1__2"}
if ( $prognosen[$c] eq "2&3" ) {$rost[$c] = "Sp.2__2"}
if ( $prognosen[$c] eq "3&3" ) {$rost[$c] = "Sp.3__2"}
if ( $prognosen[$c] eq "4&3" ) {$rost[$c] = "Sp.4__2"}
if ( $prognosen[$c] eq "0&0" ) {$rost[$c] = "......."}

if ( $c < 24 ) { $change[$dd]  = $change[$dd] . $prognosen[$c] . ',' }
if ( $c == 24 ) { $change[$dd]  = $change[$dd] . $prognosen[$c] }
}
}

if ( $prognosen[1] eq "-" ) { 
$dd++;
$papa=0;
if ($datb[$nummer] ne "Trainerposten frei") {
$ein = 0;

$rw= 0;

open(U,"/tmdata/blanko.txt");
while (<U>) {
if ($_ =~ /$datb[$nummer]/) {
$a = chomp $_ ;
($xx , $zeit1 ,  $papa ) = split (/&/ , $_ ) ;
chomp $papa ;
if ( $papa != 1 && $papa != 2 && $papa != 3 ) { $papa = 1 }

$rw=1 ;
}
}
close (U) ;

if ( $rw == 1 ) { goto nix; }

$ff = $hier - 4;
if ( $ff < 0 ) { $ff = 33 }

open(U,"/tmdata/tmi/zat$ff.txt");
while (<U>) {
if ($_ =~ /$datb[$nummer]/) {
$ein = 1;
}


}
close (U);

if ( $datb[$nummer] eq "Wally Dresel" ) { $ein = 0 }


open(U,">>/tmdata/tmi/zat$hier.txt");
print U "$datb[$nummer]&$datq[$nummer]&$log1&$log2\n";
#print "$datb[$nummer]&$datq[$nummer]&$log1&$log2\n";

close (U);

#Trainerentlassung
## derzeit deaktiviert, problem mit blankotips.
## bodo, 26.06.2014

if ($ein == 1){



open(U,">>/tmdata/tmi/zatneu.txt");
print U "$datb[$nummer]&$datq[$nummer]&$log1&$log2\n";
close (U);


$vv = (($nummer-1)/18) + 1;
$vv = int($vv) ;




$frei = "Trainerposten frei";

@datos =();
@datos = split (/&/ , $history[$vv]);

$history[$vv] = "" ;
for ($g=0 ; $g<=54 ; $g++) {
if (0 &&  $datos[$g] eq $datb[$nummer] ) { $datos[$g] = "Trainerposten frei" } #deactivated!
$history[$vv] = $history[$vv] . $datos[$g] . '&' ;

nix:
}



}
}


$change[$dd] = $nummer . ',' ;

for ( $c=1 ; $c<=25 ; $c++){
@random=();

$rost[$c] = "0&0";
}

$nummer = $richtig ;

$bm = int(($nummer-1)/18);
$nummer = $richtig - ($bm*18);

$ae=0;
$ef=0;
if ($ort_1[$nummer] eq "H" )  { $ae=$ae+5 }
if ($ort_1[$nummer] eq "A" )  { $ae=$ae+4 }
if ($ort_2[$nummer] eq "H" )  { $ae=$ae+5 }
if ($ort_2[$nummer] eq "A" )  { $ae=$ae+4 }
if ($ort_3[$nummer] eq "H" )  { $ae=$ae+5 }
if ($ort_3[$nummer] eq "A" )  { $ae=$ae+4 }
if ($ort_4[$nummer] eq "H" )  { $ae=$ae+5 }
if ($ort_4[$nummer] eq "A" )  { $ae=$ae+4 }





$aa = 0;
$ab=0;
$ac=0;
$ad=0;
for ( $c=0 ; $c< $ae ; $c++){

$ro = $nummer + $c + $spieltag + $ae + $aa ;

tt1:


$ook = 4 ;
if ( $hier == 33 ) { $ook = 2 }


$li = int (rand($ook))+1;
$bb= int(rand(25))+1;


if ( $random[$bb] == 1 ) { goto tt1; }

if (($ort_1[$nummer] eq "H" ) and ( $aa==5 ) and ( $li == 1 )) { goto tt1; }
if (($ort_1[$nummer] eq "A" ) and ( $aa==4 ) and ( $li == 1 )) { goto tt1; }
if (($ort_2[$nummer] eq "H" ) and ( $ab==5 ) and ( $li == 2 )) { goto tt1; }
if (($ort_2[$nummer] eq "A" ) and ( $ab==4 ) and ( $li == 2 )) { goto tt1; }
if (($ort_3[$nummer] eq "H" ) and ( $ac==5 ) and ( $li == 3 )) { goto tt1; }
if (($ort_3[$nummer] eq "A" ) and ( $ac==4 ) and ( $li == 3 )) { goto tt1; }
if (($ort_4[$nummer] eq "H" ) and ( $ad==5 ) and ( $li == 4 )) { goto tt1; }
if (($ort_4[$nummer] eq "A" ) and ( $ad==4 ) and ( $li == 4 )) { goto tt1; }

$ef++;
if ( $li==1) {$aa++}
if ( $li==2) {$ab++}
if ( $li==3) {$ac++}
if ( $li==4) {$ad++}

$nn = int (rand(3))+1;
$random[$bb] = 1 ;

if ( $papa == 0 ) {

if ( $nn==1) {$rost[$bb] = $li . '&' . '1'}
if ( $nn==2) {$rost[$bb] = $li . '&' . '2'}
if ( $nn==3) {$rost[$bb] = $li . '&' . '3'}

} else {
if ( $nn==1) {$rost[$bb] = $li . '&' . '1'}
if ( $nn==2) {$rost[$bb] = $li . '&' . '2'}
if ( $nn==3) {$rost[$bb] = $li . '&' . '3'}
}

}


for ( $c=1 ; $c<=25 ; $c++){

if ( $c < 25 ) { $change[$dd]  = $change[$dd] . $rost[$c] . ',' }
if ( $c == 25 ) { $change[$dd]  = $change[$dd] . $rost[$c] }
}









}


}
close (D2);



open (D2 , ">/tmdata/tmi/tip$spielrunde_neu.txt");
for ( $c=0 ; $c<=$dd ; $c++){
print D2 "$change[$c]\n";
#print "$change[$c]\n";
}
close (D2) ;


for ( $liga = 1; $liga <=203; $liga++ ){
#print "$liga\n";
$xx="";
if ( $liga <10 ) { $xx="0"};
$datei ="/tmdata/tmi/" . 'tipos/' . 'QU' . $xx . $liga . "S$spielrunde.TXT" ;
open(U,">$datei");
print U "\n";
$ff = 0;
for ( $spieltag = $hier-1; $spieltag <= $hier+2; $spieltag++ )
{
$ff++;
@ega = split (/&/, $ego[$spieltag]);	
$gg = ($liga-1)*18;
$vb=0;
for ( $kk = 0; $kk <= 17; $kk++ )
{
$vb++;
if ($vb==3) {$vb=1}
$rj=$gg+$ega[$kk];
@kondi = split (/,/, $change[$rj]);	
$xa=0;
$xb=0;
$xc=0;
$xd=0;
$xg[1]=0;
$xg[2]=0;
$xg[3]=0;
$xg[4]=0;

for ( $kl = 1; $kl <= 25; $kl++ )
{

if ( $ff==1) {
if ($kondi[$kl] eq "1&1") { print U "1,$kl," } 
if ($kondi[$kl] eq "1&2") { print U "2,$kl," } 
if ($kondi[$kl] eq "1&3") { print U "3,$kl," } 
if ($kondi[$kl] eq "1&1") { $xa++} 
if ($kondi[$kl] eq "1&2") { $xa++} 
if ($kondi[$kl] eq "1&3") { $xa++} 
if ($kondi[$kl] eq "1&1") { $xg[$ff]++} 
if ($kondi[$kl] eq "1&2") { $xg[$ff]++} 
if ($kondi[$kl] eq "1&3") { $xg[$ff]++}
} 





if ( $ff==2) {
if ($kondi[$kl] eq "2&1") { print U "1,$kl," } 
if ($kondi[$kl] eq "2&2") { print U "2,$kl," } 
if ($kondi[$kl] eq "2&3") { print U "3,$kl," } 
if ($kondi[$kl] eq "2&1") { $xb++} 
if ($kondi[$kl] eq "2&2") { $xb++} 
if ($kondi[$kl] eq "2&3") { $xb++} 
if ($kondi[$kl] eq "2&1") { $xg[$ff]++} 
if ($kondi[$kl] eq "2&2") { $xg[$ff]++} 
if ($kondi[$kl] eq "2&3") { $xg[$ff]++}
}

if ($ff==3) {
if ($kondi[$kl] eq "3&1") { print U "1,$kl," } 
if ($kondi[$kl] eq "3&2") { print U "2,$kl," } 
if ($kondi[$kl] eq "3&3") { print U "3,$kl," } 
if ($kondi[$kl] eq "3&1") { $xc++} 
if ($kondi[$kl] eq "3&2") { $xc++} 
if ($kondi[$kl] eq "3&3") { $xc++} 
if ($kondi[$kl] eq "3&1") { $xg[$ff]++} 
if ($kondi[$kl] eq "3&2") { $xg[$ff]++} 
if ($kondi[$kl] eq "3&3") { $xg[$ff]++}
}

if ( $ff==4) {
if ($kondi[$kl] eq "4&1") { print U "1,$kl," } 
if ($kondi[$kl] eq "4&2") { print U "2,$kl," } 
if ($kondi[$kl] eq "4&3") { print U "3,$kl," } 
if ($kondi[$kl] eq "4&1") { $xd++} 
if ($kondi[$kl] eq "4&2") { $xd++} 
if ($kondi[$kl] eq "4&3") { $xd++} 
if ($kondi[$kl] eq "4&1") { $xg[$ff]++} 
if ($kondi[$kl] eq "4&2") { $xg[$ff]++} 
if ($kondi[$kl] eq "4&3") { $xg[$ff]++} 
}
}
print U "\n";

if ($ff==1){$ort_5[$ega[$kk]]=$ort_1[$ega[$kk]]}
if ($ff==2){$ort_5[$ega[$kk]]=$ort_2[$ega[$kk]]}
if ($ff==3){$ort_5[$ega[$kk]]=$ort_3[$ega[$kk]]}
if ($ff==4){$ort_5[$ega[$kk]]=$ort_4[$ega[$kk]]}

$tt = $xa + $xb + $xc + $xd;

$ort =$ort_5[$ega[$kk]] ;

if (( $ort eq "H" ) and ($tt !=5 )) {
$rr= $ega[$kk] + (($liga-1)*18) ;
print ER"$liga $datb[$rr] Sp.$ff$ort $xa $xb $xc $xd\n";
}
if (( $ort eq "A" ) and ($tt !=4 )) {
print ER"$liga $datb[$rr] Sp.$ff$ort $xa $xb $xc $xd\n";
}
if (($vb==1) and ($tt!=5)) {
print ER"$liga $datb[$rr] Sp.$ff$ort $xa $xb $xc $xd\n";
}
if (($vb==2) and ($tt!=4)) {
print ER"$liga $datb[$rr] Sp.$ff$ort $xa $xb $xc $xd\n";
}

}




}
}
open(U,">/tmdata/tmi/history.txt");
for ($x=1 ; $x<=$rr_ligen;$x++){
print U "$history[$x]\n";
}
close (U);



open(U,">/tmdata/tmi/tip_status.txt");
print U "2";
close (U);

open(U,">/tmdata/tmi/pokal/tip_status.txt");
print U "2";
close (U);

open(U,">/tmdata/tmi/datum.txt");
$va = (($spielrunde-1)*4)+1;
$vb = $va-1;
print U "$va\n$vb\n";
close (U);


close (ER);



#require "/tmsrc/tmapp/cronjobs/tmi/neuvergabe.pl";

