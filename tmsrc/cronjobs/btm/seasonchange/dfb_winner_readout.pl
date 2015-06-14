#!/usr/bin/perl


open(PE,">/tmdata/btm/pokal_erfolge.txt");

print PE "2&1.Bundesliga&Hessen Kassel&???&\n";
print PE "3&1.Bundesliga&Werder Bremen&Thomas Kapitzke&\n";
print PE "4&1.Bundesliga&Fortuna Duesseldorf&Matthias Schlueter&\n";
print PE "5&1.Bundesliga&Hertha BSC Berlin&Oliver Sandhoefer&\n";
print PE "6&1.Bundesliga&SG Wattenscheid 09&Juergen Leikep&\n";
print PE "7&1.Bundesliga&1.FC Kaiserslautern&Fritz Fellmann&\n";
print PE "8&1.Bundesliga&VfL Wolfsburg&Holger Leuck&\n";
print PE "9&1.Bundesliga&Tennis-Bor. Berlin&Magnus Daum&\n";
print PE "10&1.Bundesliga&FV Bad Vilbel&Bruno Behler&\n";
print PE "11&1.Bundesliga&Fortuna Duesseldorf&Matthias Schlueter&\n";
print PE "12&1.Bundesliga&Fortuna Duesseldorf&Matthias Schlueter&\n";
print PE "13&1.Bundesliga&Hamburger SV&Daniel Houghton&\n";





require "/tmapp/tmsrc/cgi-bin/btm_ligen.pl" ;
require "/tmapp/tmsrc/cgi-bin/btm/saison.pl" ;

for ($saison=14;$saison<=($main_nr-1);$saison++){


$url=$main_kuerzel[$saison];


$ein = 0;
for ( $x = 1; $x <= 17; $x++ )
{
if ( $x == $pokal ) { $ein = 1 }
}
if ( $ein == 0 ) { $pokal = 17 }
$pokal=17;


$ein = 0;
for ( $x = 1; $x <= 7; $x++ )
{
if ( $x == $runde ) { $ein = 1 }
}
if ( $ein == 0 ) { $runde = 1 }
$runde=7;



$spielrunde_ersatz=7;


if (( $pokal == 17) and ( $runde == 1 )) { $runde = 2 }

$y = 0;
$rr = 0;
$li=0;
$liga=0;
open(D2,"/tmdata/btm/archiv/$url/history.txt");
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

$cc{$team[$rr]} = $verein_trainer[$rr];

$verein_liga[$rr] = $li;
$verein_nr[$rr] = $x;
$y++;
}

}
close(D2);

$pokal_id = 0;
$pokal_dfb=0;

open(D2,"/tmdata/btm/archiv/$url/pokal/pokal.txt");

$rsuche = '&' . $trainer_id . '&' ;
while(<D2>) {
if ($_ =~ /$rsuche/) {
( $pokal_id , $rest ) = split (/&/ , $_ ) ;
}


}
close(D2);

open(D2,"/tmdata/btm/archiv/$url/pokal/pokal_id.txt");


$rsuche = '&' . $trainer_id . '&' ;
while(<D2>) {
if ($_ =~ /$rsuche/) {
$pokal_dfb = 1 ;
}


}
close(D2);



if ( $runde == 1 ) {

$suche = '#' . $pokal . '-' . $runde . '&' ;

open(D2,"/tmdata/btm/archiv/$url/pokal/pokal.txt");
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

open(D2,"/tmdata/btm/archiv/$url/pokal/pokal_quote.txt");
while(<D2>) {


if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);

}


open(D2,"/tmdata/btm/archiv/$url/heer.txt");
while(<D2>) {
@egx = split (/&/ , $_ ) ;
$plazierung{"$egx[5]"} = $egx[0] ;
$liga{"$egx[5]"} = $egx[1] ;
}
close(D2);





if ( $runde > 1 ) {

if ($pokal !=17 ) {

$suche = '#' . $pokal . '-1&' ;

open(D2,"/tmdata/btm/archiv/$url/pokal/pokal.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@egb = split (/&/ , $_ ) ;
}
}
close(D2);
}


open(D2,"/tmdata/btm/archiv/$url/pokal/pokal_quote.txt");
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
open(D2,"/tmdata/btm/archiv/$url/pokal/pokal_id.txt");

while(<D2>) {
@egy = split (/&/ , $_ ) ;
}
close(D2);
}






if ( $runde == 2 ) {

$suche = '#' . $pokal . '-2&' ;
open(D2,"/tmdata/btm/archiv/$url/pokal/pokal_quote.txt");
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
open(D2,"/tmdata/btm/archiv/$url/pokal/pokal_quote.txt");
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


open(D2,"/tmdata/btm/archiv/$url/pokal/pokal_dfb.txt");

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
open(D2,"/tmdata/btm/archiv/$url/pokal/pokal_quote.txt");

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
open(D2,"/tmdata/btm/archiv/$url/pokal/pokal_quote.txt");
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
open(D2,"/tmdata/btm/archiv/$url/pokal/pokal_dfb.txt");
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
open(D2,"/tmdata/btm/archiv/$url/pokal/pokal_quote.txt");
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
open(D2,"/tmdata/btm/archiv/$url/pokal/pokal_quote.txt");
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

open(D2,"/tmdata/btm/archiv/$url/pokal/pokal_dfb.txt");
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
open(D2,"/tmdata/btm/archiv/$url/pokal/pokal_quote.txt");
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
open(D2,"/tmdata/btm/archiv/$url/pokal/pokal_quote.txt");
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

open(D2,"/tmdata/btm/archiv/$url/pokal/pokal_dfb.txt");
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
open(D2,"/tmdata/btm/archiv/$url/pokal/pokal_quote.txt");
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
open(D2,"/tmdata/btm/archiv/$url/pokal/pokal_quote.txt");
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

open(D2,"/tmdata/btm/archiv/$url/pokal/pokal_dfb.txt");
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
open(D2,"/tmdata/btm/archiv/$url/pokal/pokal_quote.txt");
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











if ( $runde == 1 ) { $aa = 128 }
if ( $runde == 2 ) { $aa = 64 }
if ( $runde == 3 ) { $aa = 32 }
if ( $runde == 4 ) { $aa = 16 }
if ( $runde == 5 ) { $aa = 8 }
if ( $runde == 6 ) { $aa = 4 }
if ( $runde == 7 ) { $aa = 2 }





$team[9999] = "<font color=darkred>Freilos";
$verein_liga[9999] = "9999";
$liga_kuerzel[9999] = "----";


$sp01 = $spielrunde + 1;
$sp02 = $spielrunde - 1;

if ($spielrunde ==1) { $sp02 = 1 }
if ($spielrunde ==34) { $sp01 = 34 }



$pokal_aa = $pokal_id ;
$pokal_aa =~s/\#/\ /g ;
$pokal_aa =~s/-1/\ /g ;
$pokal_aa = $pokal_aa * 1;



#nprint "<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0>";


for ($x=1 ; $x <= $aa ; $x = $x + 2 ) {
$y = $x +1 ;

	$fa = $fa + 1;
	if ( $fa == 3 ) { $fa = 1 }
	if ( $fa == 1 ) { $farbe = "#eeeeee" }
	if ( $fa == 2 ) { $farbe = "white" }

$color = "black";

	
#nprint  "<TR BGCOLOR=$farbe>\n";

$color=black ;
if ( $team[$ega[$x]] eq $trainer_verein ) { $color="#000099" }

#print  "<TD align=left>$url <FONT FACE=verdana SIZE=1 color=$color>&nbsp;&nbsp;<a href=/cgi-bin/btm/verein.pl?li=$verein_liga[$ega[$x]]&ve=$verein_nr[$ega[$x]]><img src=/img/h1.jpg heigth=10 width=10  alt=\"Vereinsseite $team[$ega[$x]]\" border=0></a>&nbsp;&nbsp;$team[$ega[$x]]&nbsp;&nbsp;&nbsp;&nbsp;</td></form>\n";

$mar = "" ;
if ( $plazierung{$team[$ega[$x]]} < 10 ) { $mar = 0 }
#print  "<td align=right><FONT FACE=verdana SIZE=1> $liga_kuerzel[$verein_liga[$ega[$x]]]&nbsp;&nbsp;( $mar$plazierung{$team[$ega[$x]]}.)&nbsp;&nbsp;</FONT></TD>\n";

$color = "black";
if ( ($id == $ega[$y]) and ($ligi == $liga) ) { $color="red" }

$color=black ;
if ( $team[$ega[$y]] eq $trainer_verein ) { $color="#000099" }


#print  "<TD align=left><FONT FACE=verdana SIZE=1 color=$color>-&nbsp;&nbsp;<a href=/cgi-bin/btm/verein.pl?li=$verein_liga[$ega[$y]]&ve=$verein_nr[$ega[$y]]><img src=/img/h1.jpg heigth=10 width=10  alt=\"Vereinsseite $team[$ega[$y]]\" border=0></a>&nbsp;&nbsp;$team[$ega[$y]]&nbsp;&nbsp;&nbsp;&nbsp;</td></form>\n";
$mar = "" ;
if ($plazierung{$team[$ega[$y]]}< 10 ) { $mar = 0 }

if ( $ega[$y] != 9999 ) {
#print  "<td align=right><FONT FACE=verdana SIZE=1> $liga_kuerzel[$verein_liga[$ega[$y]]]&nbsp;&nbsp;( $mar$plazierung{$team[$ega[$y]]}.)&nbsp;</FONT></TD>\n";
} else {
#print  "<td align=right><FONT FACE=verdana SIZE=1> &nbsp;</TD>\n";

}

#print  "<td colspan=10><font face=verdana size=3>&nbsp;</td>\n";
$kuerzel = "" ;


$cett = "black" ;
if ( ($ega[$y] == 9999) or ($quote[$y] == 1 ) ) {
#print  "<td align=center><FONT FACE=verdana SIZE=1>&nbsp;&nbsp; - : - &nbsp;&nbsp;</FONT></TD>\n";
#print  "<td align=left><FONT FACE=verdana SIZE=1>&nbsp;$kuerzel&nbsp;</TD>\n";
} 

if ( ($ega[$y] != 9999) and ($quote[$y] != 1 ) ) {

$tora=0;
$torb=0;

if ( $quote[$x] > 14 ) { $tora = 1 }
if ( $quote[$x]> 39 ) { $tora = 2 }
if ( $quote[$x]> 59 ) { $tora = 3 }
if ( $quote[$x]> 79 ) { $tora = 4 }
if ( $quote[$x]> 104 ) { $tora = 5 }
if ( $quote[$x]> 129 ) { $tora = 6 }
if ( $quote[$x]> 154 ) { $tora = 7 }

if ( $quote[$y] >  14 ) { $torb = 1 }
if ( $quote[$y]> 39 ) { $torb = 2 }
if ( $quote[$y]> 59 ) { $torb = 3 }
if ( $quote[$y]> 79 ) { $torb = 4 }
if ( $quote[$y]> 104 ) { $torb = 5 }
if ( $quote[$y]> 129 ) { $torb = 6 }
if ( $quote[$y]> 154 ) { $torb = 7 }


if ( $tora == $torb ) { 

$d = $quote[$x] - $quote[$y] ;
if ( $d > 5 ) { $kuerzel = "n.V." }
if ( $d > 5 ) { $tora++ }
if ( $d > 15 ) { $tora++ }
if ( $d < -5 ) { $kuerzel = "n.V." }
if ( $d < -5 ) { $torb++ }
if ( $d < -15 ) { $torb++ }

if ( $d == 0 ) { $kuerzel = "n.E." }
if ( $d == 0 ) { $tora=$tora+4 }
if ( $d == 0 ) { $torb=$torb+5 }

if ( $d == -1 ) { $kuerzel = "n.E." }
if ( $d == -1 ) { $tora=$tora+4 }
if ( $d == -1 ) { $torb=$torb+5 }

if ( $d == 1 ) { $kuerzel = "n.E." }
if ( $d == 1 ) { $tora=$tora+5 }
if ( $d == 1 ) { $torb=$torb+4 }

if ( ($d > 1) and ($d < 4) ) { $kuerzel = "n.E." }
if  ( ($d > 1) and ($d < 4) ) { $tora=$tora+5 }
if  ( ($d > 1) and ($d < 4) ) { $torb=$torb+3 }

if ( ($d > 3) and ($d < 6) ) { $kuerzel = "n.E." }
if  ( ($d > 3) and ($d < 6) ) { $tora=$tora+4 }
if  ( ($d > 3) and ($d < 6) ) { $torb=$torb+2 }


if ( ($d > -4) and ($d < -1) ) { $kuerzel = "n.E." }
if  ( ($d > -4) and ($d < -1) ) { $tora=$tora+3 }
if  ( ($d > -4) and ($d < -1) ) { $torb=$torb+5 }

if ( ($d > -6) and ($d < -3) ) { $kuerzel = "n.E." }
if  ( ($d > -6) and ($d < -3) ) { $tora=$tora+2 }
if  ( ($d > -6) and ($d < -3) ) { $torb=$torb+4 }



}





if ( $quote[$x] > $quote[$y] ) {
print PE "$saison&1.Bundesliga&$team[$ega[$x]]&$cc{$team[$ega[$x]]}&$team[$ega[$y]]&$cc{$team[$ega[$y]]}&$quote[$x]&$quote[$y]&\n";
} else {
print PE "$saison&1.Bundesliga&$team[$ega[$y]]&$cc{$team[$ega[$y]]}&$team[$ega[$x]]&$cc{$team[$ega[$x]]}&$quote[$y]&$quote[$x]&\n";

}

#print  "<td align=right><FONT FACE=verdana SIZE=1>&nbsp; $tora : $torb &nbsp;</TD>\n";
#print  "<td align=left><FONT FACE=verdana SIZE=1>&nbsp;$kuerzel&nbsp;</TD>\n";
}

if ( ($ega[$y] == 9999) or ($quote[$y] == 1 ) ) {
#print  "<td align=center><FONT FACE=verdana SIZE=1>&nbsp;&nbsp; [ __ - __ ] &nbsp;&nbsp;</FONT></TD>\n";
} else {
#print  "<td align=right><FONT FACE=verdana SIZE=1>&nbsp;&nbsp; [ $quote[$x] - $quote[$y] ] &nbsp;&nbsp;</TD>\n";

}

$ra1=$team[$ega[$x]];
$ra2=$team[$ega[$y]];
$ra1=~s/ /%20/g;
$ra2=~s/ /%20/g;

if ( $ega[$y] != 9999 ) {
#print  "<TD ALIGN=RIGHT colspan=30><a href=tips_cup.pl?po=$pokal&ru=$runde&row1=$ega[$x]&row2=$ega[$y]&ve1=$ra1&ve2=$ra2 target\"_blank\" onClick=\"targetLink('tips_cup.pl?po=$pokal&ru=$runde&row1=$ega[$x]&row2=$ega[$y]&ve1=$ra1&ve2=$ra2');return false\"><IMG SRC=/img/ti.jpg BORDER=0 alt=\"Detail - Tipansicht\"></A>&nbsp;&nbsp;</TD>\n";
}
#print "</TR>\n";

}

#print "</table>\n";
}

close(PE);
exit ;



