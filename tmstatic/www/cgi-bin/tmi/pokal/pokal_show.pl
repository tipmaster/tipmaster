#!/usr/bin/perl

=head1 NAME
	TMI pokal_show.pl

=head1 SYNOPSIS
	TBD
	
=head1 AUTHOR
	admin@socapro.com

=head1 CHANGELOG
	2015-06-09 Thomas: Added Session Management

=head1 COPYRIGHT
	Copyright (c) 2015, SocaPro Inc.
	Created 2015-06-09

=cut

use lib '/tmapp/tmsrc/cgi-bin/'; 
use TMSession;
my $session = TMSession::getSession(tmi_login => 1);
my $trainer = $session->getUser();
my $leut = $trainer;

use CGI;
$query = new CGI;

$pokal = $query->param('pokal');
$runde = $query->param('runde');



require "/tmapp/tmsrc/cgi-bin/runde.pl";

open(D7,"/tmdata/tmi/pokal/tip_status.txt");
$tip_status = <D7> ;
chomp $tip_status;
close(D7);

open(D7,"/tmdata/tmi/pokal/pokal_datum.txt");
$tip_date = <D7> ;
chomp $tip_date;
close(D7);

$bx = "/tmdata/tmi/formular$rrunde.txt";
$datei_hier = $bx ;

open(DO,$datei_hier);
while(<DO>) {
@vareine = <DO>;
}
close(DO);
$y = 0;
for ( $x = 0; $x < 25;$x++ )
{
$y++;
chomp $vareine[$y];
@ega = split (/&/, $vareine[$y]);	
$paarung[$y] = $ega[1];
$qu_1[$y] = $ega[2];
$qu_0[$y] = $ega[3];
$qu_2[$y] = $ega[4];
$ergebnis[$y] = $ega[5];
}

print "Content-type:text/html\n\n";

$pokal_aa = $pokal_id ;
$pokal_aa =~s/\#/\ /g ;
$pokal_aa =~s/-1/\ /g ;
$pokal_aa = $pokal_aa * 1;



require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl" ;

@pokal_name = ( "spacer" , "Italien" , 
"England" ,
"Spanien" ,
"Frankreich" ,
"Niederlande" ,
"Portugal" ,
"Belgien" ,
"Schweiz" ,
"Oesterreich" ,
"Schottland" ,
"Tuerkei" ,
"Irland" ,
"Nord Irland" ,
"Wales" ,
"Daenemark" ,
"Norwegen" ,
"Schweden" ,
"Finnland" ,
"Island" ,
"Polen" ,
"Tschechien" ,
"Ungarn" ,
"Rumaenien" ,
"Slowenien" ,
"Kroatien" ,
"Jugoslawien" ,
"Bosnien-Herz." ,
"Bulgarien" ,
"Griechenland" ,
"Russland" ,
"Estland" ,
"Ukraine" ,
"Moldawien" ,
"Israel" ,
"Luxemburg" ,
"Slowakei" ,
"Mazedonien" ,
"Litauen" ,
"Lettland" ,
"Weissrussland" ,
"Malta" ,
"Zypern" ,
"Albanien" ,
"Georgien" ,
"Armenien" ,
"Aserbaidschan" ,
"Andorra" ,
"Faeroer Inseln" ,
"San Marino" 
 ) ;
$ein = 0;


open(D7,"/tmdata/tmi/pokal/pokal_datum.txt");
$spielrunde_ersatz = <D7> ;

chomp $spielrunde_ersatz;
close(D7);

if ( $spielrunde_ersatz < $runde ) { $runde = $spielrunde_ersatz }
if ( $runde ==0 ) { $runde = $tip_date};


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
$trainer_liga = $li;
}

$verein_liga[$rr] = $li;
$verein_nr[$rr] = $x;
$y++;
}

}
close(D2);



$pokal_id = 0;
$pokal_dfb=0;

open(D2,"/tmdata/tmi/pokal/pokal.txt");

$rsuche = '&' . $trainer_id . '&' ;
while(<D2>) {
if ($_ =~ /$rsuche/) {
( $pokal_id , $rest ) = split (/&/ , $_ ) ;
}


}
close(D2);
if ( $pokal < 1 ) {
$pokal= $pokal_id ;
$pokal=~s/\-1//;
$pokal=~s/\-2//;
$pokal=~s/\-3//;
$pokal=~s/\-4//;
$pokal=~s/\-5//;

$pokal=~s/#//;
}
for ( $x = 1; $x <= 49; $x++ )
{
if ( $x == $pokal ) { $ein = 1 }
}
if ( $ein == 0 ) { 
	$i=0;
	foreach(@pokal_name) {
		if ($liga_namen[$trainer_liga] =~/$_/){$pokal = $i;}
		$i++;
	}
 }

$ein = 0;
for ( $x = 1; $x <= 5; $x++ )
{
if ( $x == $runde ) { $ein = 1 }
}
if ( $ein == 0 ) { $runde = 1 }


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





$team[9999] = "<font color=darkred>Freilos";
$verein_liga[9999] = "97";
$liga_kuerzel[97] = "----";

print "<html><title>Pokal Paarungen</title><p align=left><body bgcolor=white text=black>\n";
require "/tmapp/tmsrc/cgi-bin/tag.pl" ;
require "/tmapp/tmsrc/cgi-bin/tag_small.pl" ;
require "/tmapp/tmsrc/cgi-bin/loc_tmi.pl" ;
print "<script language=JavaScript>\n";
print "<!--\n";
print "function targetLink(URL)\n";
print "  {\n";
print "    if(document.images)\n";
print "      targetWin = open(URL,\"Neufenster\",\"scrollbars=yes,toolbar=no,directories=no,menubar=no,status=no,resizeable=yes,width=850,height=240\");\n";
print " }\n";
print "  //-->\n";
print "  </script>\n";

print "<p align=left>\n";



print "<font face=verdana size=1><form method=post action=/cgi-bin/tmi/pokal/pokal_show.pl target=_top>";

print "&nbsp;&nbsp;<select  style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\"  name=pokal>";
$y=0;
for ( $x=1; $x<=49;$x++ ) {
$y++;
if ($x==2) {$y++}
if ($x==4) {$y++}
if ($x==6) {$y++}
if ($x==8) {$y++}
if ($x==10) {$y++}
if ($x==12) {$y++}


$gh = "";
if ( $pokal == $x ) { $gh = "selected" }
print "<option value=$x $gh>Pokal $pokal_name[$x] \n";
}
print "</select>&nbsp;&nbsp;\n";



print "<select  style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=runde>";


$gh = "";
if ( $runde ==1 ) { $gh = "selected" }
print "<option value=1 $gh>1.Hauptrunde \n";
$gh = "";
if ( $runde ==2 ) { $gh = "selected" }
print "<option value=2 $gh>Achtelfinale \n";
$gh = "";
if ( $runde ==3 ) { $gh = "selected" }
print "<option value=3 $gh>Viertelfinale \n";
$gh = "";
if ( $runde ==4 ) { $gh = "selected" }
print "<option value=4 $gh>Halbfinale \n";
$gh = "";
if ( $runde ==5 ) { $gh = "selected" }
print "<option value=5 $gh>Finale \n";
print "</select>&nbsp;&nbsp;\n";


print "&nbsp;&nbsp;<input type=hidden name=ligi value=\"$ligi\"><input type=hidden name=id value=\"$id\"><iNPUT TYPE=SUBMIT  style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" VALUE=\"Resultate laden\"></form>";

$sp01 = $spielrunde + 1;
$sp02 = $spielrunde - 1;

if ($spielrunde ==1) { $sp02 = 1 }
if ($spielrunde ==34) { $sp01 = 34 }


$pokal_aa="";
$pokal_aa = $pokal_id ;
$pokal_aa =~s/\#/\ /g ;
$pokal_aa =~s/-1/\ /g ;
$pokal_aa = $pokal_aa * 1;



if ( $pokal_id ne "0" ) {
print "<form name=tip method=post action=/cgi-bin/tmi/pokal/pokal_tip.pl target=_top><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=pokal value=\"$pokal_aa\"></form>\n";
print "<font face=verdana size=1>&nbsp;&nbsp;Ihr Verein $trainer_verein startet im Pokal $pokal_name[$pokal_aa]  ... "; 

if ( $cup_tmi_name[$rrunde] ne "" ) {

print "<a href=javascript:document.tip.submit()>Zur Tipabgabe [ $cup_tmi_name[$rrunde] ]</a><br><br>\n";
} else {
print "[ Diese Woche keine Tiprunde in diesem Wettbewerb ]<br><br>\n";
}


}


if ( $pokal_id eq "" ) {
print "<font face=verdana size=1>&nbsp;&nbsp;[ Ihr Verein $trainer_verein ist nicht fuer den Landespokal qualifiziert ]<br><br> ";
}


print "<TABLE CELLSPACING=0 CELLPADDING=2 BORDER=0>";


for ($x=1 ; $x <= $aa ; $x = $x + 2 ) {
$y = $x +1 ;

	$fa = $fa + 1;
	if ( $fa == 3 ) { $fa = 1 }
	if ( $fa == 1 ) { $farbe = "#eeeeee" }
	if ( $fa == 2 ) { $farbe = "white" }

$color = "black";

	
print  "<TR BGCOLOR=$farbe>\n";

$color=black ;
if ( $team[$ega[$x]] eq $trainer_verein ) { $color="red" }
$mar = "" ;
if ( $plazierung{$team[$ega[$x]]} < 10 ) { $mar = 0 }

#print "<td align=center valign=middle> 
#&nbsp; &nbsp;&nbsp;<FONT FACE=verdana SIZE=1>[ $liga_kuerzel[$verein_liga[$ega[$x]]] $mar$plazierung{$team[$ega[$x]]}. ]</td>";


print  "<TD align=right><FONT FACE=verdana SIZE=2 color=$color>&nbsp;&nbsp;<a href=/cgi-mod/tmi/verein.pl?li=$verein_liga[$ega[$x]]&ve=$verein_nr[$ega[$x]]>$team[$ega[$x]]</a> &nbsp;<font size=1><br>&nbsp;&nbsp;<font size=1>[ $liga_kuerzel[$verein_liga[$ega[$x]]] | $mar$plazierung{$team[$ega[$x]]}. ] &nbsp; $verein_trainer[$ega[$x]]&nbsp;&nbsp;</td></form>\n";
print "<td valign=center align=center><font face=verdana size=2> &nbsp; vs. &nbsp;</td>";



$color = "black";
if ( ($id == $ega[$y]) and ($ligi == $liga) ) { $color="red" }

$color=black ;
if ( $verein_trainer[$ega[$y]] eq $trainer ) { $color="red" }

$color=black ;
if ( $verein_trainer[$ega[$y]] eq $trainer ) { $color="red" }
$mar = "" ;
if ( $plazierung{$team[$ega[$y]]} < 10 ) { $mar = 0 }

print  "<TD align=left><FONT FACE=verdana SIZE=2 color=$color>&nbsp; 

<a href=/cgi-mod/tmi/verein.pl?li=$verein_liga[$ega[$y]]&ve=$verein_nr[$ega[$y]]>$team[$ega[$y]]</a><font size=1>

<br>&nbsp;&nbsp;&nbsp;<font size=1>$verein_trainer[$ega[$y]] &nbsp; [ $liga_kuerzel[$verein_liga[$ega[$y]]] | $mar$plazierung{$team[$ega[$y]]}. ]

</td></form>\n";
#print "<td align=center valign=middle> &nbsp; &nbsp;&nbsp;<FONT FACE=verdana SIZE=1>[ $liga_kuerzel[$verein_liga[$ega[$y]]] $mar$plazierung{$team[$ega[$y]]}. ]</td>";




print  "<td colspan=10><font face=verdana size=3>&nbsp;</td>\n";
$kuerzel = "" ;


if ( $tip_status ==2 && $runde == $spielrunde_ersatz && $cup_tmi_aktiv_f[$rrunde] == 1 && $quote[$x] == 1) { $live = 1 }
################################################
if ( $live == 1 ) {
# LIVE _ BERECHNUNG !

$xx=$ega[$x];
if ( $xx < 10 ) { $xx='0'.$xx }
if ( $xx < 100 ) { $xx='0'.$xx }
if ( $xx < 1000 ) { $xx='0'.$xx }

$datei1 ="/tmdata/tmi/pokal/tips/$xx-$pokal-$runde.txt";

$xx=$ega[$y];
if ( $xx < 10 ) { $xx='0'.$xx }
if ( $xx < 100 ) { $xx='0'.$xx }
if ( $xx < 1000 ) { $xx='0'.$xx }

$datei2 ="/tmdata/tmi/pokal/tips/$xx-$pokal-$runde.txt";

open(A1,"<$datei1");
$row1 =<A1>;chomp $row1;
close (A1);
open(A1,"<$datei2");
$row2 =<A1>;chomp $row2;
close (A1);

@tips=();
@tips = split (/\./ , $row1 ) ;
$quote=0;
for ($r=0;$r<=9;$r++) {
#print "<td>$ergebnis[$r+1] $tips[$r] -</td>";
if ( ($tips[$r] eq "1&1") and ($ergebnis[$r+1] == 1)) { $quote = $quote + $qu_1[$r+1] }
if ( ($tips[$r] eq "1&2") and ($ergebnis[$r+1] == 2)) { $quote = $quote + $qu_0[$r+1] }
if ( ($tips[$r] eq "1&3") and ($ergebnis[$r+1] == 3)) { $quote = $quote + $qu_2[$r+1] }
if ( ($ergebnis[$r+1] == 4) and ($tips[$r] > 0)) { $quote = $quote + 10 }
}
if ( $quote < 10 ) { $quote = '0' . $quote }
$quote[$x] = $quote;

@tips=();
@tips = split (/\./ , $row2 ) ;
$quote=0;
for ($r=0;$r<=9;$r++) {

if ( ($tips[$r] eq "1&1") and ($ergebnis[$r+1] == 1)) { $quote = $quote + $qu_1[$r+1] }
if ( ($tips[$r] eq "1&2") and ($ergebnis[$r+1] == 2)) { $quote = $quote + $qu_0[$r+1] }
if ( ($tips[$r] eq "1&3") and ($ergebnis[$r+1] == 3)) { $quote = $quote + $qu_2[$r+1] }
if ( ($ergebnis[$r+1] == 4) and ($tips[$r] > 0 )) { $quote = $quote + 10 }
}
if ( $quote < 10 ) { $quote = '0' . $quote }
$quote[$y] = $quote;
}
####################################################




$cett = "black" ;
if ( ($ega[$y] == 9999) or ($quote[$y] == 1 ) ) {
print  "<td align=center><FONT FACE=verdana SIZE=1>&nbsp;&nbsp; - : - &nbsp;&nbsp;</FONT></TD>\n";
print  "<td align=left><FONT FACE=verdana SIZE=1>&nbsp;$kuerzel&nbsp;</TD>\n";
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
if ( $live != 1 ) {
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
}








$color=black;

if ( $live ==1 ) { $color = "red" }


print  "<td align=right><FONT FACE=verdana SIZE=2 color=$color>&nbsp; <b>$tora</b> : <b>$torb</b> &nbsp;</TD>\n";
print  "<td align=left><FONT FACE=verdana SIZE=2>&nbsp;$kuerzel&nbsp;</TD>\n";
}

if ( ($ega[$y] == 9999 || $quote[$y] == 1) && $live==0) {
print  "<td align=center><FONT FACE=verdana SIZE=1>&nbsp;&nbsp; [ __ - __ ] &nbsp;&nbsp;</FONT></TD>\n";
} else {
print  "<td align=right><FONT FACE=verdana SIZE=1 color=black>&nbsp;&nbsp; [ <font color=$color>$quote[$x] - $quote[$y] <font color=black>] &nbsp;&nbsp;</TD>\n";

}

$ra1=$team[$ega[$x]];
$ra2=$team[$ega[$y]];
$ra1=~s/ /%20/g;
$ra2=~s/ /%20/g;

if ( $ega[$y] != 9999 ) {
print  "<TD ALIGN=RIGHT colspan=30><a href=tips_cup.pl?po=$pokal&ru=$runde&row1=$ega[$x]&row2=$ega[$y]&ve1=$ra1&ve2=$ra2 target\"_blank\" onClick=\"targetLink('tips_cup.pl?po=$pokal&ru=$runde&row1=$ega[$x]&row2=$ega[$y]&ve1=$ra1&ve2=$ra2');return false\"><IMG SRC=/img/ti.jpg BORDER=0 alt=\"Detail - Tipansicht\"></A>&nbsp;&nbsp;</TD>\n";
}
print "</TR>\n";

}

print "</table>\n";


exit ;



