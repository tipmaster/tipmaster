#!/usr/bin/perl

=head1 NAME
	TMI tipabgabe.pl

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
$mailprog = '/usr/sbin/sendmail';


print "Content-type: text/html\n\n";


require "/tmapp/tmsrc/cgi-bin/runde.pl";
require "/tmapp/tmsrc/cgi-bin/lib.pl";
#require "/home/res/cgi/config.pl";
#require "/home/res/cgi/ranking.pl";
require "/tmapp/tmsrc/cronjobs/blanko_process.pl";

# Retrieve Date
&get_date;

$query = new CGI;
$method = $query->param('method');
$prognose = $query->param('prognose');






&daten_lesen;

if ($method eq "blanko")
{&blanko;}

# Return HTML Page or Redirect User
&return_html;



sub get_date {

    # Define arrays for the day of the week and month of the year.           #
    @days   = ('Sunday','Monday','Tuesday','Wednesday',
               'Thursday','Friday','Saturday');
    @months = ('January','February','March','April','May','June','July',
	         'August','September','October','November','December');

    # Get the current time and format the hour, minutes and seconds.  Add    #
    # 1900 to the year to get the full 4 digit year.                         #
    ($sec,$min,$hour,$mday,$mon,$year,$wday) = (localtime(time+0))[0,1,2,3,4,5,6];
    $time = sprintf("%02d:%02d:%02d",$hour,$min,$sec);
    $year += 1900;

    # Format the date.                                                       #
    $date = "$days[$wday], $months[$mon] $mday, $year at $time";

}







sub daten_lesen {

$tipo[1] = "30....";
$tipo[2] = "31....";
$tipo[3] = "32....";
$tipo[4] = "33....";
$tipo[5] = "34....";
$tipo[6] = "35....";
$tipo[7] = "36....";
$tipo[8] = "37....";
$tipo[9] = "38....";
$tipo[10] = "39....";
$tipo[11] = "40....";
$tipo[12] = "41....";
$tipo[13] = "42....";
$tipo[14] = "43....";
$tipo[15] = "44....";
$tipo[16] = "45....";
$tipo[17] = "46....";
$tipo[18] = "47....";
$tipo[19] = "48....";
$tipo[20] = "49....";
$tipo[21] = "50....";
$tipo[22] = "51....";
$tipo[23] = "52....";
$tipo[24] = "53....";
$tipo[25] = "54....";




$rf ="0";
$rx = "x" ;
if ( $liga > 9 ) { $rf = "" }

$suche = '&'.$trainer.'&' ;
$s = 0;
open(D2,"/tmdata/tmi/history.txt");
while(<D2>) {
$s++;
if ($_ =~ /$suche/) {
@lor = split (/&/, $_);	
$liga = $s ;
}

}
close(D2);


$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
$y++;
chomp $lor[$y];
$data[$x] = $lor[$y];
$y++;
chomp $lor[$y];
$datb[$x] = $lor[$y];
if ( $datb[$x] eq $trainer ) {$id = $x }
if ( $datb[$x] eq $trainer ) {$coach = $data[$x] }
$y++;
chomp $lor[$y];
$datc[$x] = $lor[$y];
if ( $datb[$x] eq $trainer ) {$recipient = $datc[$x] }
}
$verein = $id ;


open(D7,"/tmdata/tmi/tip_status.txt");
$tip_status = <D7> ;

chomp $tip_status;
close(D7);

open(D7,"/tmdata/tmi/tip_datum.txt");
$spielrunde_ersatz = <D7> ;

chomp $spielrunde_ersatz;
close(D7);

$bx = "formular";
$by = int(( $spielrunde_ersatz + 3 ) / 4 );

$bv = ".txt";
$fg = "/tmdata/tmi/";
$datei_hiero = $fg . $bx . $by . $bv ;



open(DO,$datei_hiero);
while(<DO>) {
@ver = <DO>;
}
close(DO);

$y = 0;
for ( $x = 0; $x < 25;$x++ )
{
$y++;
chomp $ver[$y];
@ega = split (/&/, $ver[$y]);	
$flagge[$y] = $ega[0] ;
$paarung[$y] = $ega[1];
$qu_1[$y] = $ega[2];
$qu_0[$y] = $ega[3];
$qu_2[$y] = $ega[4];
$ergebnis[$y] = $ega[5];
}


open(D2,"/tmdata/tmi/heer.txt");
while(<D2>) {

@go = ();
@go = split (/&/ , $_);
$verein_platz{$go[5]} = $go[0] ;
}
close (D2);

if (!-e $datei_hiero) {
for ( $x = 0; $x <= 25;$x++ )
{
$paarung[$x] = ".: noch kein neues Formular online :.";
$flagge[$x]=9;
}}


open(D9,"/tmdata/tmi/spieltag.txt");
while(<D9>) {
@ego = <D9>;
}
close(D9);



$fa = 0 ;

for ( $spieltag = 0; $spieltag < 34; $spieltag++ )
{

@ega = split (/&/, $ego[$spieltag]);	
for ( $x = 0; $x < 18; $x=$x + 2 )
{

$tora = 0;
$torb = 0;
$y=$x+1;
$wa=$x-1;
$wb=$y-1;





if ($ega[$x] == $id ) {
$gegner[$spieltag] = $ega[$y];
$ort[$spieltag] = "H";
$tip[$spieltag] = $gc + $x + 1;
}

if ($ega[$y] == $id ) {
$gegner[$spieltag] = $ega[$x];
$ort[$spieltag] = "A";
$tip[$spieltag] = $gc + $x +1;
}

}
}







$rg = 0;
for ( $spieltag = $spielrunde_ersatz + 3; $spieltag < $spielrunde_ersatz +7; $spieltag++ )
{

$rg++ ;

$hier_gegner[$rg] = $data[$gegner[$spieltag]];
$hier_ort[$rg] = $ort[$spieltag];
$hier_platz[$rg] = $verein_platz{$data[$gegner[$spieltag]]};

}



$aa = 0;
$ab = 0;
$ac = 0;
$ad = 0;

for ( $x=1 ; $x < 26 ; $x++ )
{
chomp $tipo[$x];
($ca[$x] , $cb[$x] ) = split (/&/, $tipo[$x]);


}

for ( $x=1 ; $x < 26 ; $x++ )
{
if ( $ca[$x] == 1 ) {
$aa++;
$pro1[$aa] = $cb[$x];
$sp1[$aa] = $x;

}
if ( $ca[$x] == 2 ) {
$ab++;
$pro2[$ab] = $cb[$x];
$sp2[$ab] = $x;
}
if ( $ca[$x] == 3 ) {
$ac++;
$pro3[$ac] = $cb[$x];
$sp3[$ac] = $x;
}
if ( $ca[$x] == 4 ) {
$ad++;
$pro4[$ad] = $cb[$x];
$sp4[$ad] = $x;
}

}

$verein = $id ;


$suche = ( ($liga - 1 ) * 18 ) + $verein ;
$log = ( ($liga - 1 ) * 18 ) + $verein ;

$cc = "0";
if ( $suche < 100 ) { $suche = $cc . $suche }
if ( $suche < 10 ) { $suche = $cc . $suche }
if ( $suche < 1000 ) { $suche = $cc . $suche }


for ($xt=$spielrunde_ersatz-1 ; $xt<=$spielrunde_ersatz+2 ; $xt++ ){
$status[$gegner[$xt]] = "Gegner Tip ist noch nicht eingegangen" ;

$so = ( ($liga - 1 ) * 18 ) + $gegner[$xt] ;
$cc = $so;
if ( $so < 100 ) { $cc = '0' . $cc  }
if ( $so < 10 ) { $cc = '0' . $cc  }
if ( $so < 1000 ) { $cc = '0' . $cc}

if ( $spielrunde_ersatz  < 10 ) { $xx = "0" }

$datei = '/tmdata/tmi/tips/' . $spielrunde_ersatz . '/' . $cc . '.txt' ;
if(-e "$datei") { $status[$gegner[$xt]] = "Gegner Tip ist bereits eingegangen" }
}




$ein = 0 ;

$linie = 0;


$count = $suche * 1 ;

for ($xi=$count ; $xi<=$count ; $xi++ ) {
$cc=$xi;
if ( $xi < 100 ) { $cc = '0' . $cc  }
if ( $xi < 10 ) { $cc = '0' . $cc  }
if ( $xi < 1000 ) { $cc = '0' . $cc}

$datei = '/tmdata/tmi/tips/' . $spielrunde_ersatz . '/' . $cc . '.txt' ;

open(D2,"$datei");
while(<D2>) {

($nummer , $tipabgabe) = split (/#/, $_);	


$line[$nummer] = $_ ;
chomp $line[$nummer] ;
@voss = split (/\./, $tipabgabe);	


for ($d=0 ;$d<=24;$d++){
$rx = "";
$rr = "";
($rr , $rx ) = split (/&/, $voss[$d]);	
if ( $rx == 1 ) {$toto_1[$d+1]++ }
if ( $rx == 2 ) {$toto_2[$d+1]++ }
if ( $rx == 3 ) {$toto_3[$d+1]++ }
}

$count1 = $nummer * 1;

if ($count == $count1) {
($numero , $tipes) = split (/#/, $_);	
@tipos = split (/\./, $tipes);	
$ein = 1 ;
}

}
close(D2);
}




$tip_eingegangen = 0 ;

for ($x=0 ; $x <=24 ; $x++ ){
if ( $tipos[$x] eq "-" ) { $tip_eingegangen = 1 }
if ( $tipos[$x] eq "-" ) { $tipos[$x] = "0&0" }
if ( $tipos[$x] eq "" ) { $tipos[$x] = "0&0" }

}

$datei = '/tmdata/tmi/tips/' . $spielrunde_ersatz . '/bisher.txt' ;
open(D2,"$datei");
$p=0;
while(<D2>) {
$p++;

@set = split (/&/ , $_ ) ;
$toto_1[$p] = $set[1] ;
$toto_2[$p] = $set[2] ;
$toto_3[$p] = $set[3] ;


}

close (D2) ;



for ($d=1 ;$d<=25;$d++){
$toto_1[$d] = $toto_1[$d] * 1;
$toto_2[$d] =$toto_2[$d] * 1;
$toto_3[$d] = $toto_3[$d] * 1;

if ( $toto_1[$d] <100 ){ $toto_1[$d] ='0' . $toto_1[$d]  }
if ( $toto_1[$d] <10 ){ $toto_1[$d] = '0' .$toto_1[$d]  }
if ( $toto_2[$d] <100 ){ $toto_2[$d] = '0' .$toto_2[$d] }
if ( $toto_2[$d] <10 ){ $toto_2[$d] = '0' .$toto_2[$d]  }
if ( $toto_3[$d] <100 ){ $toto_3[$d] = '0' .$toto_3[$d] }
if ( $toto_3[$d] <10 ){ $toto_3[$d] = '0' .$toto_3[$d] }

}






}



sub return_html {
  
&readin_vereinsid("tmi");

        # Print HTTP header and opening HTML tags.                           #
       


print "<table border=0 cellpadding=0 cellspacing=0>";
$hh = $spielrunde_ersatz + 3;
if ( $hh > 34 ) { $hh = 34 }
print "<html><body bgcolor=white text=black link=blue vlink=blue><title>Tippabgabe $coach  Sp. $spielrunde_ersatz bis $hh</title>";
print "<p align=left>\n";



require "/tmapp/tmsrc/cgi-bin/tag.pl" ;
require "/tmapp/tmsrc/cgi-bin/tag_small.pl" ;



$rr = $spielrunde_ersatz+3  ;
if ( $rr > 33 ) { $rr = 33 }
$rs=$spielrunde_ersatz;
print "<br>";

print "<br><font face=verdana size=2 color=black>&nbsp;<b>Aktuelle Tippabgabe Sp. $rs bis $hh - $data[$id] [ $datb[$id] ] <br><br></b>";



print "
<form name=blanko1 action=tipabgabe.pl metod=post>
<input type=hidden name=method value=blanko><input type=hidden name=prognose value=1></form>\n
<form name=blanko2 action=tipabgabe.pl metod=post>
<input type=hidden name=method value=blanko><input type=hidden name=prognose value=2></form>\n
<form name=blanko3 action=tipabgabe.pl metod=post>
<input type=hidden name=method value=blanko><input type=hidden name=prognose value=3></form>\n

";
print "<font face=verdana size=1 color=darkred>Vor der Tippabgabe nochmal kurz die letzten Resultate bzw. Tabellenposition der Vereine checken ?<br><font color=black>
Unter <a href=https://www.fussball-liveticker.eu target=new11>fussball-liveticker.eu</a> gibts Ergebnisse ,
Tabellen und Statistiken sowie LiveScore zu den europ. und intern. Ligen !<br><br>\n";


print "<font face=verdana size=1>\n";
$gg=int($spielrunde_ersatz/4)+1;
print "
<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>
<table border=0 cellpadding=2 cellspacing=1>
<tr><td align=center bgcolor=#DEDFEC colspan=6><font face=verdana size=1>
Anstehende Spiele Ihres Vereins $data[$id] fuer die aktuelle $gg.Tiprunde</td>
<td align=center bgcolor=#DEDFEC colspan=7><font face=verdana size=1>Bilanz</td>


</tr>
";



$rr = $spielrunde_ersatz+2  ;
if ( $rr > 33 ) { $rr = 33 }

for ($x=$spielrunde_ersatz-1 ; $x <=$rr; $x++ ){
$ss = $x +1 ;



# get head2head
$h2h = &get_head2head("tmi",$gl_vereinsid{$data[$id]},$gl_vereinsid{$data[$gegner[$x]]});
@bilanz=();
@bilanz = &get_balance($h2h);
#print "$h2h $gl_vereinsid{$data[$id]} $gl_vereinsid{$data[$gegner[$x]]}<br>";

print "<tr><td align=left bgcolor=#eeeeee><font face=verdana size=1>&nbsp; Sp. $ss&nbsp;&nbsp;</td><td align=left bgcolor=#eeeeff><font face=verdana size=1>&nbsp;&nbsp;&nbsp; $ort[$x] &nbsp;&nbsp;&nbsp;</td>\n<td align=left bgcolor=#eeeeff>&nbsp;&nbsp;<a href=/cgi-mod/tmi/verein.pl?li=$liga&ve=$gegner[$x] target=new><img src=/img/h1.jpg border=0></a>&nbsp;&nbsp;<font face=verdana size=1> $data[$gegner[$x]]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>

<td align=left bgcolor=#eeeeee><font face=verdana size=1>";
$cc=$datb[$gegner[$x]];
$cc=~s/ /%20/g;
print "&nbsp;&nbsp;&nbsp;<a href=/cgi-mod/tmi/trainer.pl?ident=$cc target=new5><img src=/img/h1.jpg border=0></a>&nbsp;&nbsp; $datb[$gegner[$x]]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></form><td align=right bgcolor=#eeeeff><font face=verdana size=1>&nbsp;&nbsp;&nbsp;( $verein_platz{$data[$gegner[$x]]}.)&nbsp;&nbsp;&nbsp;</td><td align=center bgcolor=#eeeeee><font face=verdana size=1>&nbsp;&nbsp;&nbsp;$status[$gegner[$x]]&nbsp;&nbsp;&nbsp;</td> 


<td align=center bgcolor=#eeeeff><font face=verdana size=1> &nbsp;
<a href=/cgi-bin/head2head.pl?loc=tmi&id1=$gl_vereinsid{$data[$id]}&id2=$gl_vereinsid{$data[$gegner[$x]]} target=bilanz> 
$bilanz[0] - $bilanz[1] - $bilanz[2] </a>&nbsp; </td>

</tr>";
}
print "</table></td></tr></table>\n";


print "<font face=verdana size=1 color=black><br>&nbsp;&nbsp; Beim Click auf die Tipformular Paarungen erhalten Sie interessante Statistiken zu dem entspr. Spiel angezeigt .";
print "<font size=1><br>&nbsp;&nbsp; Auch keine Tippabgabe fuer relevante und anstehende Pokalrunden vergessen ? <a href=/cgi-bin/cup_time.pl target=_new>Blick auf den Rahmenterminkalender</a>";



print "<br><br>";
print "
<table border=0 cellspacing=1 cellpadding=0 bgcolor=black><tr><td>
<table border=0 cellpadding=4 cellspacing=1>
<tr bgcolor=#eeeeee>
<td align=center colspan=9 bgcolor=#eeeeff>
<font face=versdana size=1>Umrechnung Quotensumme --> Anzahl Tore &nbsp; &nbsp;              
[ <a href=https://github.com/tipmaster/tipmaster/wiki/Regelbuch>TM Regelbuch</a> ]</td></tr>
<tr bgcolor=#eeeeee>
<td align=center bgcolor=#eeeeff><font face=versdana size=1>Tore</td>
<td align=center><font face=versdana size=1>0</td>
<td align=center><font face=versdana size=1>1</td>
<td align=center><font face=versdana size=1>2</td>
<td align=center><font face=versdana size=1>3</td>
<td align=center><font face=versdana size=1>4</td>
<td align=center><font face=versdana size=1>5</td>
<td align=center><font face=versdana size=1>6</td>
<td align=center><font face=versdana size=1>7</td></tr>
<tr bgcolor=#eeeeee>
<td align=center bgcolor=#eeeeff><font face=versdana size=1> &nbsp; &nbsp; &nbsp; Quote &nbsp; &nbsp; &nbsp; </td>
<td align=center><font face=versdana size=1>0 - 14</td>
<td align=center><font face=versdana size=1>15 - 39</td>
<td align=center><font face=versdana size=1>40 - 59</td>
<td align=center><font face=versdana size=1>60 - 79</td>
<td align=center><font face=versdana size=1>80 - 104</td>
<td align=center><font face=versdana size=1>105 - 129</td>
<td align=center><font face=versdana size=1>130 - 154</td>
<td align=center><font face=versdana size=1>155 - ..... </td></tr></table>
</td></tr></table>";

#print "&nbsp; &nbsp; Aus gegebenem Anlass :<br><br>
#&nbsp; &nbsp; <img src=/img/tip_swe.gif height=10 width=14> &nbsp; 
#<a target=new href=http://www.live-resultate.de/cgi-bin/league.pl?index=swe0>Aktuelle Tabelle Schweden</a><br>
#&nbsp; &nbsp; <img src=/img/tip_nor.gif height=10 width=14> &nbsp; 
#<a target=new href=http://www.live-resultate.de/cgi-bin/league.pl?index=nor0>Aktuelle Tabelle Norwegen</a><br>
#&nbsp; &nbsp; <img src=/img/tip_den.gif height=10 width=14> &nbsp; 
#<a target=new href=http://www.live-resultate.de/cgi-bin/league.pl?index=den0>Aktuelle Tabelle Daenemark</a><br>
#&nbsp; &nbsp; <img src=/img/tip_fin.gif height=10 width=14> &nbsp; 
#<a target=new href=http://www.live-resultate.de/cgi-bin/league.pl?index=fin0>Aktuelle Tabelle Finnland</a><br>
#</b>";

print "<br>";

print &getHtmlBlankotip($trainer);

print "<form action=/cgi-bin/tmi/formmail.pl method=post>";

$xx = "&";
$aa = $liga . $xx . $id ;

print "<input type=hidden name=team value=\"$aa\">\n";
print "<input type=hidden name=recipient value=\"$mail\">\n";
print "<table border=0 bgcolor=white cellpadding=0 cellspacing=0><tr>";

print "<td align=right colspan=40><font face=verdana size=1>
[ <img src=/img/printer.png> <a href=/cgi-bin/drucktip.pl?tm=tmi style=\"text-decoration:none\" target=new>Formular Druckansicht</a> ]
<BR>
&nbsp;
</tr><tr></tr><tr>";


print "<td></td><td></td><td></td><td>\n";


if ( $spielrunde_ersatz != 33 ) {
print "<img src=/img/spacer11.gif></td><td></td><td>\n"; 
print "<img src=/img/spacer11.gif></td><td></td><td>\n";
}

print "<img src=/img/spacer11.gif></td><td></td><td>\n";
print "<img src=/img/spacer11.gif></td><td></td><td>\n";
print "<img src=/img/spacer2.gif></td><td><img src=/img/spacer4.gif><td></td><td><img src=/img/spacer3.gif></td></td></tr><tr>\n";

for ($x=1 ; $x <=16 ; $x++ ){print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n"}
print "</tr>\n";
print "<tr><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
print "<td bgcolor=#eeeeee>&nbsp;</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

$rr = $spielrunde_ersatz+3 ;
if ( $rr > 34 ) { $rr = 34 }

for ($x=$spielrunde_ersatz ; $x <=$rr ; $x++ ){
print "<td bgcolor=#eeeeee align=middle><font face=verdana size=1>Sp. $x &nbsp;[$ort[$x-1]] </td>\n";

print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
}
print "<td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;</td><td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;Quoten</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td><td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;&nbsp;&nbsp;bisherige Tipps</td>\n";
print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr><tr>\n";
for ($x=1 ; $x <=16 ; $x++ ){print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n"}
print "</tr>\n";
print "<tr><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td><td bgcolor=#eeeeee>&nbsp;</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

for ($x=1 ; $x <=4 ; $x++ ){
if ( ($x + $spielrunde_ersatz) < 36 ) {
print "<td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;2\n";
print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
}
}


print "<td bgcolor=#eeeeee>&nbsp;</td><td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2\n";
print "</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td><td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr><tr>\n";
for ($x=1 ; $x <=16 ; $x++ ){print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n"}

print "</tr>\n";

$tf = 0;

for ($x=1 ; $x <=25 ; $x++ ){


$tf++;

$farbe = "white" ;
if ( $tf == 3 ) { $tf = 1 }
if ( $tf == 2 ) { $farbe= "#eeeeee" }
@selected = ();
if ($tipos[$x-1] eq "0&0") { $selected[0] = " checked" }

if ($tipos[$x-1] eq "1&1") { $selected[1] = " checked" }
if ($tipos[$x-1] eq "1&2") { $selected[2] = " checked" }
if ($tipos[$x-1] eq "1&3") { $selected[3] = " checked" }
if ($tipos[$x-1] eq "2&1") { $selected[4] = " checked" }
if ($tipos[$x-1] eq "2&2") { $selected[5] = " checked" }
if ($tipos[$x-1] eq "2&3") { $selected[6] = " checked" }
if ($tipos[$x-1] eq "3&1") { $selected[7] = " checked" }
if ($tipos[$x-1] eq "3&2") { $selected[8] = " checked" }
if ($tipos[$x-1] eq "3&3") { $selected[9] = " checked" }
if ($tipos[$x-1] eq "4&1") { $selected[10] = " checked" }
if ($tipos[$x-1] eq "4&2") { $selected[11] = " checked" }
if ($tipos[$x-1] eq "4&3") { $selected[12] = " checked" }


print "<tr><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
print "<td bgcolor=$farbe>&nbsp;<input type=radio name=$tipo[$x] value=0&0$selected[0]>&nbsp;</td>\n";

print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
print "<td bgcolor=$farbe>&nbsp;<input type=radio name=$tipo[$x] value=1&1$selected[1]>\n";
print "<input type=radio name=$tipo[$x] value=1&2$selected[2]>\n";
print "<input type=radio name=$tipo[$x] value=1&3$selected[3]>&nbsp;</td>\n";


print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
print "<td bgcolor=$farbe>&nbsp;<input type=radio name=$tipo[$x] value=2&1$selected[4]>\n";
print "<input type=radio name=$tipo[$x] value=2&2$selected[5]>\n";
print "<input type=radio name=$tipo[$x] value=2&3$selected[6]>&nbsp;</td>\n";

if ( ( $spielrunde_ersatz  + 2 ) < 35 ) { 
print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
print "<td bgcolor=$farbe>&nbsp;<input type=radio name=$tipo[$x] value=3&1$selected[7]>\n";
print "<input type=radio name=$tipo[$x] value=3&2$selected[8]>\n";
print "<input type=radio name=$tipo[$x] value=3&3$selected[9]>&nbsp;</td>\n";
}

if ( ( $spielrunde_ersatz  + 3 ) < 35 ) { 
print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
print "<td bgcolor=$farbe>&nbsp;<input type=radio name=$tipo[$x] value=4&1$selected[10]>\n";
print "<input type=radio name=$tipo[$x] value=4&2$selected[11]>\n";
print "<input type=radio name=$tipo[$x] value=4&3$selected[12]>&nbsp;</td>\n";
}
print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

$flag = $main_flags[$flagge[$x]];


## Live-Resultate Syndication ##############
@res = split(/\-/,$paarung[$x]);
$verein1=$res[0];$verein2=$res[1];

#print "... $res[0] $res[1]" ;
$r1="";$r2="";$verein_k1="";$verein_k2="";
#&transfer;
if ( $t1{$verein_k1} < 10 ) {$r1="0"}
if ( $t1{$verein_k2} < 10 ) {$r2="0"}

if ( $t1{$verein_k1} ne "" && $t1{$verein_k2} ne "")
{
$paarung[$x] = "<!--a href=javascript:document.xr$x.submit()-->".$res[0] . "  - " . $res[1]. " </a>";
}
#############################################




if ( $flagge[$x] < 3 && $flagge[$x] > 0 ){
print "<td align=left bgcolor=$farbe>&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=1>
<img HEIGHT=10 WIDTH=14 src=/img/$flag border=0>&nbsp;&nbsp;&nbsp;$paarung[$x]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";

}elsif  (( $flagge[$x] == 3 )or ( $flagge[$x] == 4 )or ( $flagge[$x] == 5 ) or ( $flagge[$x] == 8)  ){
print "<td align=left bgcolor=$farbe nowrap>&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=1>
<img HEIGHT=10 WIDTH=14 src=/img/$flag border=0>&nbsp;&nbsp;&nbsp;$paarung[$x]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";


}else{
print "<td align=left bgcolor=$farbe nowrap>&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=1>
<img HEIGHT=10 WIDTH=14 src=/img/$flag border=0>&nbsp;&nbsp;&nbsp;$paarung[$x]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";
}

print "<td bgcolor=$farbe nowrap><font face=verdana size=1> $qu_1[$x] &nbsp;&nbsp; $qu_0[$x] &nbsp;&nbsp; $qu_2[$x] &nbsp;&nbsp;</td>\n";
print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
print "<td bgcolor=$farbe nowrap><font face=verdana size=1> &nbsp;&nbsp;$toto_1[$x] &nbsp; $toto_2[$x] &nbsp; $toto_3[$x] &nbsp;</td>\n";
print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr>\n";
}
print "<tr>";
for ($x=1 ; $x <=16 ; $x++ ){print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n"}

print "</tr></table>\n";

print "<br>&nbsp; <input type=checkbox name=mail_ja value=1 checked> &nbsp; <font size=2><b> Bitte die Tippabgabe auch als
E-Mail an mich senden</b>
<br>";



print "<font face=verdana size=1 color=black><br>Beim Click auf die Laenderflaggen werden die entsprechenden realen Ligatabellen geladen .<br>Nach dem Absenden des Formulars unbedingt auf die Antwortseite warten !<br><br>Die Tipabgabe ist jeweils bis Freitags 18.oo Uhr moeglich !\n";
if ( $tip_eingegangen == 1 ) { $ab = "Tipabgabe senden" }
if ( $tip_eingegangen == 0 ) { $ab = "Tipabgabe senden" }

print "<br><br>\n";
if ( $tip_status == 1 ) { print "<input type=submit value=\"$ab\"></form></html>\n"}
if ( $tip_status == 2 ) { print "Der Tipabgabetermin ist bereits abgelaufen .<br>Es ist keine Abgabe bzw. Aenderung Ihres Tips mehr moeglich .</html>\n"}


for ($x=1 ; $x <=25 ; $x++ ){
($verein1,$verein2) = split (/ \- /,$paarung[$x]);
$verein1=~s/  //g;
$verein2=~s/  //g;
if ($flagge[$x] == 1) { $vv = "ger1" }
if ($flagge[$x] == 2) { $vv = "ger2" }
if ($flagge[$x] == 3) { $vv = "eng0" }
if ($flagge[$x] == 4) { $vv = "fre0" }
if ($flagge[$x] == 5) { $vv = "ita0" }
if ($flagge[$x] == 8) { $vv = "spa1" }
if ($flagge[$x] == 19) { $vv = "por0" }
if ($flagge[$x] == 20) { $vv = "bel0" }


print "<form action=http://www.live-resultate.de/cgi-bin/show.pl method=post target=new name=xr$x><input type=hidden name=verein1 value=\"$verein1\"><input type=hidden name=index value=\"$vv\"><input type=hidden name=verein2 value=\"$verein2\"></form>\n";
}


}




sub error { 
    # Localize variables and assign subroutine input.                        #
    local($error,@error_fields) = @_;
    local($host,$missing_field,$missing_field_list);

    if ($error eq 'bad_referer') {
        if ($ENV{'HTTP_REFERER'} =~ m|^https?://([\w\.]+)|i) {
            $host = $1;
            print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>Bad Referrer - Access Denied</title>
 </head>
 <body bgcolor=#FFFFFF text=#000000>
  <center>
   <table border=0 width=600 bgcolor=#9C9C9C>
    <tr><th><font size=+2>Bad Referrer - Access Denied</font></th></tr>
   </table>
   <table border=0 width=600 bgcolor=#CFCFCF>
    <tr><td>The form attempting to use
     <a href="http://www.worldwidemart.com/scripts/formmail.shtml">FormMail</a>
     resides at <tt>$ENV{'HTTP_REFERER'}</tt>, which is not allowed to access
     this cgi script.<p>

     If you are attempting to configure FormMail to run with this form, you need
     to add the following to \@referers, explained in detail in the README file.<p>

     Add <tt>'$host'</tt> to your <tt><b>\@referers</b></tt> array.<hr size=1>
     <center><font size=-1>
      <a href="http://www.worldwidemart.com/scripts/formmail.shtml">FormMail</a> V1.6 &copy; 1995 - 1997  Matt Wright<br>
      A Free Product of <a href="http://www.worldwidemart.com/scripts/">Matt's Script Archive, Inc.</a>
     </font></center>
    </td></tr>
   </table>
  </center>
 </body>
</html>
(END ERROR HTML)
        }
        else {
            print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>FormMail v1.6</title>
 </head>
 <body bgcolor=#FFFFFF text=#000000>
  <center>
   <table border=0 width=600 bgcolor=#9C9C9C>
    <tr><th><font size=+2>FormMail</font></th></tr>
   </table>
   <table border=0 width=600 bgcolor=#CFCFCF>
    <tr><th><tt><font size=+1>Copyright 1995 - 1997 Matt Wright<br>
        Version 1.6 - Released May 02, 1997<br>
        A Free Product of <a href="http://www.worldwidemart.com/scripts/">Matt's Script Archive,
        Inc.</a></font></tt></th></tr>
   </table>
  </center>
 </body>
</html>
(END ERROR HTML)
        }
    }

    elsif ($error eq 'request_method') {
            print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>Error: Request Method</title>
 </head>
 <body bgcolor=#FFFFFF text=#000000>
  <center>
   <table border=0 width=600 bgcolor=#9C9C9C>
    <tr><th><font size=+2>Error: Request Method</font></th></tr>
   </table>
   <table border=0 width=600 bgcolor=#CFCFCF>
    <tr><td>The Request Method of the Form you submitted did not match
     either <tt>GET</tt> or <tt>POST</tt>.  Please check the form and make sure the
     <tt>method=</tt> statement is in upper case and matches <tt>GET</tt> or <tt>POST</tt>.<p>

     <center><font size=-1>
      <a href="http://www.worldwidemart.com/scripts/formmail.shtml">FormMail</a> V1.6 &copy; 1995 - 1997  Matt Wright<br>
      A Free Product of <a href="http://www.worldwidemart.com/scripts/">Matt's Script Archive, Inc.</a>
     </font></center>
    </td></tr>
   </table>
  </center>
 </body>
</html>
(END ERROR HTML)
    }

    elsif ($error eq 'kein_verein') {
            print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>TMI - Tipabgabe : Kein Verein ausgewaehlt</title>
 </head>
 <body bgcolor=#eeeeee text=#000000>
<p align=left><body bgcolor=white text=black>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href=http://www.vierklee.at target=_top>
<img src=/banner/werben_tip.JPG border=0></a><br><br>
<br><br>
<table border=0>
<tr><td colspan=30></td><td p align=center>
<font face=verdana size=2><b>
<font color=red>
Bei ihrer Tipabgabe ist ein Fehler aufgetreten .<br><br><br>
<font color=black size=2>
+++ Sie haben keinen Verein ausgewaehlt +++<br><br><br>
</b></b></b><font color=black face=verdana size=1>Bitte kehren Sie zur Tipabgabe zurueck <br>
und waehlen Sie ihren aktuellen Verein , so<br>
dass Ihr Tip richtig zugewiesen werden kann .
</td></tr></table>

</center>
 </body>
</html>
(END ERROR HTML)
    }

    elsif ($error eq 'no_recipient') {
            print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>TMI - Tipabgabe : Keine E-Mail Adresse angegeben</title>
 </head>
 <body bgcolor=#eeeeee text=#000000>
<p align=left><body bgcolor=white text=black>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href=http://www.vierklee.at target=_top>
<img src=/banner/werben_tip.JPG border=0></a><br><br>
<br><br>
<table border=0>
<tr><td colspan=30></td><td p align=center>
<font face=verdana size=2><b>
<font color=red>
Bei ihrer Tipabgabe ist ein Fehler aufgetreten .<br><br><br>
<font color=black size=2>
+++ Sie haben keine E-Mail Adresse eingetragen +++<br><br><br>
</b></b></b><font color=black face=verdana size=1>Bitte kehren Sie zur Tipabgabe zurueck <br>
und tragen Sie ihre E-Mail Adresse ein<br>
so dass ihr Tip an Sie gemailt werden kann .
</td></tr></table>

</center>
 </body>
</html>
(END ERROR HTML)
    }
 elsif ($error eq 'kein_trainer') {
            print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>TMI - Tipabgabe : Kein Trainername angegeben</title>
 </head>
 <body bgcolor=#eeeeee text=#000000>
<p align=left><body bgcolor=white text=black>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href=http://www.vierklee.at target=_top>
<img src=/banner/werben_tip.JPG border=0></a><br><br>
<br><br>
<table border=0>
<tr><td colspan=30></td><td p align=center>
<font face=verdana size=2><b>
<font color=red>
Bei ihrer Tipabgabe ist ein Fehler aufgetreten .<br><br><br>
<font color=black size=2>
+++ Sie haben keinen Trainernamen eingetragen +++<br><br><br>
</b></b></b><font color=black face=verdana size=1>Bitte kehren Sie zur Tipabgabe zurueck <br>
und tragen Sie ihren Trainernamen ein<br>
so dass ihr Tip gewertet werden kann .
</td></tr></table>

</center>
 </body>
</html>
(END ERROR HTML)
    }
 

 elsif ($error eq 'kein_passwort') {
            print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>TMI - Tipabgabe : Kein Passwort angegeben</title>
 </head>
 <body bgcolor=#eeeeee text=#000000>
<p align=left><body bgcolor=white text=black>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href=http://www.vierklee.at target=_top>
<img src=/banner/werben_tip.JPG border=0></a><br><br>
<br><br>
<table border=0>
<tr><td colspan=30></td><td p align=center>
<font face=verdana size=2><b>
<font color=red>
Bei ihrer Tipabgabe ist ein Fehler aufgetreten .<br><br><br>
<font color=black size=2>
+++ Sie haben kein Passwort eingetragen +++<br><br><br>
</b></b></b><font color=black face=verdana size=1>Bitte kehren Sie zur Tipabgabe zurueck <br>
und tragen Sie ihren Trainernamen ein<br>
so dass ihr Tip gewertet werden kann .
</td></tr></table>

</center>
 </body>
</html>
(END ERROR HTML)
    }

 elsif ($error eq 'spielauswahl') {
            print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>TMI - Tipabgabe : Spielauswahl nicht korrekt</title>
 </head>
 <body bgcolor=#eeeeee text=#000000>
<p align=left><body bgcolor=white text=black>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br><br><p align=left>
<br><br>
<table border=0>
<tr><td p align=center>
<font face=verdana size=2><b>
<font color=red>
Bei ihrer Tipabgabe ist ein Fehler aufgetreten .<br><br><br>
<font color=black size=2>
+++ Ihre Spielauswahl ist nicht korrekt +++<br><br><br></b></b></b></b></b>
(END ERROR HTML)

if ( ( $hier_ort[1] eq "H" ) and ($aa != 5 ) ) { 
print "<font face=verdana size=1>";
$ss=$spielrunde_ersatz + 4;
print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Heimspiel gegen  $hier_gegner[1].<br>";
print "An diesem Spieltag sind Ihnen also 5 Tips anstatt denen von Ihnen gewaehlten $aa Tips gestattet<br><br>";
 }
if ( ( $hier_ort[1] eq "A" )and ($aa != 4 ) ) { 
print "<font face=verdana size=1>";
$ss=$spielrunde_ersatz + 4;
print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Auswaertsspiel gegen  $hier_gegner[1] .<br>";
print "An diesem Spieltag sind Ihnen also 4 Tips anstatt denen von Ihnen gewaehlten $aa Tips gestattet .<br><br>";
 }
if ( ( $hier_ort[2] eq "H" ) and ($ab != 5 ) ) { 
print "<font face=verdana size=1>";
$ss=$spielrunde_ersatz + 5;
print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Heimspiel gegen  $hier_gegner[2].<br>";
print "An diesem Spieltag sind Ihnen also 5 Tips anstatt denen von Ihnen gewaehlten $ab Tips gestattet .<br><br>";
 }
if ( ( $hier_ort[2] eq "A" ) and ($ab != 4 ) ) { 
print "<font face=verdana size=1>";
$ss=$spielrunde_ersatz + 5;
print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Auswaertsspiel gegen  $hier_gegner[2]<br>";
print "An diesem Spieltag sind Ihnen also 4 Tips anstatt denen von Ihnen gewaehlten $ab Tips gestattet .<br><br>";
 }
if ( ( $hier_ort[3] eq "H" ) and ($ac != 5 )) { 
print "<font face=verdana size=1>";
$ss=$spielrunde_ersatz + 6;
print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Heimspiel gegen  $hier_gegner[3]<br>";
print "An diesem Spieltag sind Ihnen also 5 Tips anstatt denen von Ihnen gewaehlten $ac Tips gestattet .<br><br>";
 }
if ( ( $hier_ort[3] eq "A" ) and ($ac != 4 ) ){ 
print "<font face=verdana size=1>";
$ss=$spielrunde_ersatz + 6;
print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Auswaertsspiel gegen  $hier_gegner[3].<br>";
print "An diesem Spieltag sind Ihnen also 4 Tips anstatt denen von Ihnen gewaehlten $ac Tips gestattet .<br><br>";
 }
if ( ( $hier_ort[4] eq "H" ) and ($ad != 5 ) ){ 
print "<font face=verdana size=1>";
$ss=$spielrunde_ersatz + 7;
print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Heimspiel gegen  $hier_gegner[4].<br>";
print "An diesem Spieltag sind Ihnen also 5 Tips anstatt denen von Ihnen gewaehlten $ad Tips gestattet .<br><br>";
 }
if ( ( $hier_ort[4] eq "A" ) and ($ad != 4 ) ){ 
print "<font face=verdana size=1>";
$ss=$spielrunde_ersatz + 7;
print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Auswaertsspiel gegen  $hier_gegner[4].<br>";
print "An diesem Spieltag sind Ihnen also 4 Tips anstatt denen von Ihnen gewaehlten $ad Tips gestattet .<br><br>";
 }




            print <<"(END ERROR HTML)";
</b></b></b><font color=black face=verdana size=1>Bitte kehren Sie zur Tipabgabe zurueck <br>
und korrigieren Sie Ihre Spielauswahl<br>
so dass ihr Tip gewertet werden kann .
</td></tr></table>

</center>
</body>
</html>
(END ERROR HTML)
    }


    
    exit;
}


