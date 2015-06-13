#!/usr/bin/perl

require "/tmapp/tmsrc/cgi-bin/runde.pl";
$spielrunde = $rrunde;



$hier = ($spielrunde*4) - 3;



for ($liga=1;$liga<=384;$liga++){
$lok = $liga;
if ($liga<10) {$lok = '0' . $liga}

$bv = "DAT";
$txt = ".TXT";
$datei1 = '/tmdata/btm/exdat/' . $bv . $lok . '-' . $spielrunde . $txt;
$datei2 = '/tmdata/btm/' . $bv . $lok . $txt;

open (D1,">$datei1");
open (D2,"<$datei2");
while (<D2>) {
print D1 "$_";
}
close (D2);
close (D1);
}

#print "Ex - Dat Dateien erzeugt ...\n";



for ($liga=1;$liga<=384;$liga++){


$spielhier= ($spielrunde*4) - 3;


$fgh= $spielrunde ;


$lok = $liga;
if ($liga<10) {$lok = '0' . $liga}

$bv = "DAT";
$txt = ".TXT";

$datei_quoten = '/tmdata/btm/exdat/' . $bv . $lok . '-' . $spielrunde . $txt;
#$datei_quoten = '/tmdata/btm/' . $bv . $lok . $txt;

$t=0;
open(DO,"<$datei_quoten");

while(<DO>) {
$t++;
$lin[$t] = $_;
chomp $lin[$t];
}
close(DO);

$lok = $liga;
if ($liga<10) {$lok = '0' . $liga}

$bv = "QU";
$txt = ".TXT";
$rtz = "S";
$datei_quoten ='/tmdata/btm/' . 'tipos/' . $bv . $lok . $lo . $rtz . $fgh . $txt;



$bx = "formular";
$by = int(( $spielrunde - 1 ) / 4 );
$by++ ;
$bv = ".txt";
$datei_hier = '/tmdata/btm/' . $bx . $spielrunde . $bv ;

#print "$datei_hier\n";

open(DO,$datei_hier);
while(<DO>) {
@vereine = <DO>;
}
close(DO);

open(DO,"/tmdata/btm/spieltag.txt");
while(<DO>) {
@ego = <DO>;
}
close(DO);


$y = 0;
for ( $x = 0; $x < 25;$x++ )
{
$y++;
chomp $vereine[$y];
@egx = split (/&/, $vereine[$y]);	
$paarung[$y] = $ega[1];
$qu_1[$y] = $egx[2];
$qu_0[$y] = $egx[3];
$qu_2[$y] = $egx[4];
$ergebnis[$y] = $egx[5];

}
print "$datei_quoten\n";
open(DO,$datei_quoten);
while(<DO>) {
print $_;
@tips = <DO>;

}
close(DO);
$paar=-2;


for ($sp=$spielhier;$sp<=$spielhier+3;$sp++) {
$lin[$sp+1] = "";
@ega = split (/&/, $ego[$sp-1]);	
for ($qq=1;$qq<=17;$qq=$qq+2) {
$paar=$paar+2;
$row1 = $tips[$paar];
$row2 = $tips[$paar+1];

chomp $row1;
chomp $row2;

@tip1 = split (/,/, $row1);
@tip2 = split (/,/, $row2);
$y = 0;
for ( $x = 1; $x < 11;$x = $x + 2 )
{
$y = $y + 1;
$pro1[$y] = $tip1[$x-1];
$sp1[$y] = $tip1[$x];
$pro2[$y] = $tip2[$x-1];
$sp2[$y] = $tip2[$x];
}

$su_1 = 0 ;
$su_2 = 0 ;
for ( $x = 1; $x < 6; $x++ ) {
if ( ($pro1[$x] == 1) and ( $ergebnis[$sp1[$x]] == 1 ) ) { $su_1 = $su_1 + $qu_1[$sp1[$x]] }
if ( ($pro1[$x] == 2) and ( $ergebnis[$sp1[$x]] == 2 ) ) { $su_1 = $su_1 + $qu_0[$sp1[$x]] }
if ( ($pro1[$x] == 3) and ( $ergebnis[$sp1[$x]] == 3 ) ) { $su_1 = $su_1 + $qu_2[$sp1[$x]] }
if ( ($pro1[$x] == 1) and ( $ergebnis[$sp1[$x]] == 4 ) ) { $su_1 = $su_1 + 10 }
if ( ($pro1[$x] == 2) and ( $ergebnis[$sp1[$x]] == 4 ) ) { $su_1 = $su_1 + 10 }
if ( ($pro1[$x] == 3) and ( $ergebnis[$sp1[$x]] == 4 ) ) { $su_1 = $su_1 + 10 }


if ( ($pro2[$x] == 1) and ( $ergebnis[$sp2[$x]] == 1 ) ) { $su_2 = $su_2 + $qu_1[$sp2[$x]] }
if ( ($pro2[$x] == 2) and ( $ergebnis[$sp2[$x]] == 2 ) ) { $su_2 = $su_2 + $qu_0[$sp2[$x]] }
if ( ($pro2[$x] == 3) and ( $ergebnis[$sp2[$x]] == 3 ) ) { $su_2 = $su_2 + $qu_2[$sp2[$x]] }
if ( ($pro2[$x] == 1) and ( $ergebnis[$sp2[$x]] == 4 ) ) { $su_2 = $su_2 + 10 }
if ( ($pro2[$x] == 2) and ( $ergebnis[$sp2[$x]] == 4 ) ) { $su_2 = $su_2 + 10 }
if ( ($pro2[$x] == 3) and ( $ergebnis[$sp2[$x]] == 4 ) ) { $su_2 = $su_2 + 10 }


}


$sum[$ega[$qq-1]]=$su_1;
$sum[$ega[$qq]]=$su_2;



}

for ($x=1;$x<=18;$x++){
$lin[$sp+1] = $lin[$sp+1] . $sum[$x] .'&';
}


# $r = <stdin>;

$lok = $liga;
if ($liga<10) {$lok = '0' . $liga}

$bv = "DAT";
$txt = ".TXT";

$datei_daten = '/tmdata/btm/' . $bv . $lok . $txt;
$t=0;

open(DO,">$datei_daten");
for ($r=1;$r<=35;$r++){
if (( $lin[$r] eq "" ) and ( $r>1 )){ $lin[$r] = "1&1&1&1&1&1&1&1&1&1&1&1&1&1&1&1&1&1&" }
print DO "$lin[$r]\n";
}



close(DO);

}






}


open(U,">/tmdata/btm/datum.txt");
$va = (($spielrunde-1)*4)+1;
$vb = $va+3;
if ($vb>34){$vb=34}
print U "$va\n$vb\n";
close (U);



require "/tmapp/tmsrc/cronjobs/btm/heer.pl";

open(D,">/tmdata/btm_ausw.txt");
print D "0";
close(D);
open(D,">/tmdata/tmi_ausw.txt");
print D "0";
close(D);
