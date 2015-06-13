#!/usr/bin/perl

=head1 NAME
	BTM tips_fr.pl

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
my $session = TMSession::getSession(btm_login => 1);
my $trainer = $session->getUser();
my $leut = $trainer;

use CGI;
$query = new CGI;
$spielrunde = $query->param('ru');
$line1 = $query->param('line1');
$line2 = $query->param('line2');
$verein1 = $query->param('ve1');
$verein2 = $query->param('ve2');
$ru = $query->param('ru');



require "/tmapp/tmsrc/cgi-bin/runde.pl";


$fgh = $spielrunde;
$lok = "";
$lo = $liga ;
if ( $lo < 10 ) { $lok = "0" }



$ros1 = $iab[$jo-1] ;
$ros2 = $iab[$jo] ;

$bx = "/tmdata/btm/formular";
$by =$spielrunde;
$by++ ;
$bv = ".txt";
$datei_hier = $bx . $ru . $bv ;

open(DO,$datei_hier);
while(<DO>) {
@vereine = <DO>;
}
close(DO);
$y = 0;
for ( $x = 0; $x < 25;$x++ )
{
$y++;
chomp $vereine[$y];
@ega = split (/&/, $vereine[$y]);	
$flagge[$y] = $ega[0] ;
$paarung[$y] = $ega[1];
$qu_1[$y] = $ega[2];
$qu_0[$y] = $ega[3];
$qu_2[$y] = $ega[4];
$ergebnis[$y] = $ega[5];

if ($ergebnis[$y] == 4 ) {
$qu_1[$y] =10;
$qu_0[$y] =10;
$qu_2[$y] =10;
}

}


$row1 = $line1;
$row2 = $line2;

chomp $row1;
chomp $row2;

@tip1 = split (/,/, $row1);
@tip2 = split (/,/, $row2);
$y = 0;
for ( $x = 1; $x < 11;$x = $x + 2 )
{

$y = $y + 1;
$pro1[$y] = $tip1[$x];
$sp1[$y] = $tip1[$x-1];
$sp2[$y] = $tip2[$x-1];
$pro2[$y] = $tip2[$x];
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

if ( $su_1 > 14 ) { $tora = 1 }
if ( $su_1 > 39 ) { $tora = 2 }
if ( $su_1 > 59 ) { $tora = 3 }
if ( $su_1 > 79 ) { $tora = 4 }
if ( $su_1 > 104 ) { $tora = 5 }
if ( $su_1 > 129 ) { $tora = 6 }
if ( $su_1 > 154 ) { $tora = 7 }

if ( $su_2 > 14 ) { $torb = 1 }
if ( $su_2 > 39 ) { $torb = 2 }
if ( $su_2 > 59 ) { $torb = 3 }
if ( $su_2 > 79 ) { $torb = 4 }
if ( $su_2 > 104 ) { $torb = 5 }
if ( $su_2 > 129 ) { $torb = 6 }
if ( $su_2 > 154 ) { $torb = 7 }

if ( $tora == 0 ) { $tora = 0 }
if ( $torb == 0 ) { $torb = 0 }





print "Content-Type: text/html \n\n";


print "<html><title>Tipabgabe Freundschaftsspiel</title><body bgcolor=#eeeeee text=black vlink=blue link=blue><font face=verdana size=1><center>\n";

require "/tmapp/tmsrc/cgi-bin/tag.pl" ;
require "/tmapp/tmsrc/cgi-bin/tag_small.pl" ;
print "<br><br>\n";

if ( $pro1[1] == 0 ) {
print "<center><br><br><font face=verdana size=2><b>Die beiden Tipabgaben fuer dieses Spiel sind noch<br>nicht erfolgt bzw. noch nicht zur Einsicht freigegeben.<br><br><font color=darkred> Die Tipabgaben der aktuellen Spielrunde sind<br>ab Freitags 18.oo Uhr hier einsehbar.";
exit ;
}


print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=#eeeeee><tr>\n";
print "<td></td><td bgcolor=white><font face=verdana size=1 color=#390505>&nbsp;&nbsp;$verein1</font></td><td bgcolor=white>&nbsp;</td><td align=right bgcolor=white><font face=verdana size=1>$tora &nbsp;</td><td bgcolor=white>&nbsp</td><td></td><td bgcolor=white><font face=verdana size=1 color=4E2F2F>&nbsp;&nbsp;$verein2</td><td bgcolor=white>&nbsp;</td><td align=right bgcolor=white><font face=verdana size=1>$torb &nbsp;</td><td bgcolor=white>&nbsp;</td></tr>\n";
print "<tr><td align=left valign=top><font face=verdana size=1><img src=http://www.tipmaster.de/img/tips.JPG><br>";
for ( $x = 1; $x < 6; $x++ ) {

if ( ($pro1[$x] == 1) and ( $ergebnis[$sp1[$x]] == 0 ) ) { $r = k1 }
if ( ($pro1[$x] == 2) and ( $ergebnis[$sp1[$x]] == 0 ) ) { $r = k0 }
if ( ($pro1[$x] == 3) and ( $ergebnis[$sp1[$x]] == 0 ) ) { $r = k2 }
if ( ($pro1[$x] == 1) and ( $ergebnis[$sp1[$x]] == 1 ) ) { $r = k11 }
if ( ($pro1[$x] == 2) and ( $ergebnis[$sp1[$x]] == 2 ) ) { $r = k00 }
if ( ($pro1[$x] == 3) and ( $ergebnis[$sp1[$x]] == 3 ) ) { $r = k22 }
if ( ($pro1[$x] == 1) and ( $ergebnis[$sp1[$x]] == 3 ) ) { $r = k12 }
if ( ($pro1[$x] == 2) and ( $ergebnis[$sp1[$x]] == 3 ) ) { $r = k02 }
if ( ($pro1[$x] == 3) and ( $ergebnis[$sp1[$x]] == 2 ) ) { $r = k20 }
if ( ($pro1[$x] == 1) and ( $ergebnis[$sp1[$x]] == 2 ) ) { $r = k10 }
if ( ($pro1[$x] == 2) and ( $ergebnis[$sp1[$x]] == 1 ) ) { $r = k01 }
if ( ($pro1[$x] == 3) and ( $ergebnis[$sp1[$x]] == 1 ) ) { $r = k21 }
if ( ($pro1[$x] == 1) and ( $ergebnis[$sp1[$x]] == 4 ) ) { $r = k1102 }
if ( ($pro1[$x] == 2) and ( $ergebnis[$sp1[$x]] == 4 ) ) { $r = k0102 }
if ( ($pro1[$x] == 3) and ( $ergebnis[$sp1[$x]] == 4 ) ) { $r = k2102 }

if ($pro1[$x] == 0) { $r = k102 }

print "<img src=/img/$r.JPG><br>\n";
}
print "</font></td>\n";
print "<td align=left width=250 valign=middle><font face=verdana size=1><img src=/img/loch.JPG border=0><br><font color=black>\n";
for ( $x = 1; $x < 6;$x++ ) {

$flag=$main_flags[$flagge[$sp1[$x]]];









print "&nbsp;&nbsp;&nbsp;&nbsp;<img HEIGHT=10 WIDTH=14 src=http://www.tipmaster.de/img/$flag border=0>&nbsp;&nbsp;&nbsp;&nbsp;<a href=javascript:document.xr$x.submit()>$paarung[$sp1[$x]]</a><br>\n";




}
print "</font>\n";
for ( $x = 1; $x < 6; $x++ ) {

($verein1,$verein2) = split (/ \- /,$paarung[$sp1[$x]]);
$verein1=~s/  //g;
$verein2=~s/  //g;
if ($flagge[$sp1[$x]] == 1) { $vv = "ger1" }
if ($flagge[$sp1[$x]] == 2) { $vv = "ger2" }
if ($flagge[$sp1[$x]] == 3) { $vv = "eng0" }
if ($flagge[$sp1[$x]] == 4) { $vv = "fre0" }
if ($flagge[$sp1[$x]] == 5) { $vv = "ita0" }

}

print "</td>\n";
print "<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td align=left valign=top><font face=verdana size=1><img src=http://www.tipmaster.de/img/loch.JPG><br>\n";

for ( $x = 1; $x < 6;$x++ ) {

if ( $pro1[$x] == $ergebnis[$sp1[$x]] ) { $r = black}
if ( $pro1[$x] != $ergebnis[$sp1[$x]] ) { $r = silver}
if ( $ergebnis[$sp1[$x]] == 4 ) { $r = black}

if ( $ergebnis[$sp1[$x]] == 0 ) { $r = gray}

print "<font color=$r>\n";

if ( $pro1[$x] == 1 ) { print "&nbsp;&nbsp; $qu_1[$sp1[$x]] &nbsp;</font><br>\n" }
if ( $pro1[$x] == 2 ) { print "&nbsp;&nbsp; $qu_0[$sp1[$x]] &nbsp;</font><br>\n" }
if ( $pro1[$x] == 3 ) { print "&nbsp;&nbsp; $qu_2[$sp1[$x]] &nbsp;</font><br>\n" }
if ( $pro1[$x] == 0 ) { print "<font face=verdana color=black size=1>&nbsp;&nbsp;&nbsp;**</font><br>\n" }
}
print "</font></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";
print "<td align=left valign=top><font face=verdana size=1><img src=/img/tips.JPG><br>\n";
for ( $x =1; $x < 6; $x++ ) {
if ( ($pro2[$x] == 1) and ( $ergebnis[$sp2[$x]] == 0 ) ) { $r = k1 }
if ( ($pro2[$x] == 2) and ( $ergebnis[$sp2[$x]] == 0 ) ) { $r = k0 }
if ( ($pro2[$x] == 3) and ( $ergebnis[$sp2[$x]] == 0 ) ) { $r = k2 }
if ( ($pro2[$x] == 1) and ( $ergebnis[$sp2[$x]] == 1 ) ) { $r = k11 }
if ( ($pro2[$x] == 2) and ( $ergebnis[$sp2[$x]] == 2 ) ) { $r = k00 }
if ( ($pro2[$x] == 3) and ( $ergebnis[$sp2[$x]] == 3 ) ) { $r = k22 }
if ( ($pro2[$x] == 1) and ( $ergebnis[$sp2[$x]] == 3 ) ) { $r = k12 }
if ( ($pro2[$x] == 2) and ( $ergebnis[$sp2[$x]] == 3 ) ) { $r = k02 }
if ( ($pro2[$x] == 3) and ( $ergebnis[$sp2[$x]] == 2 ) ) { $r = k20 }
if ( ($pro2[$x] == 1) and ( $ergebnis[$sp2[$x]] == 2 ) ) { $r = k10 }
if ( ($pro2[$x] == 2) and ( $ergebnis[$sp2[$x]] == 1 ) ) { $r = k01 }
if ( ($pro2[$x] == 3) and ( $ergebnis[$sp2[$x]] == 1 ) ) { $r = k21 }
if ( ($pro2[$x] == 1) and ( $ergebnis[$sp2[$x]] == 4 ) ) { $r = k1102 }
if ( ($pro2[$x] == 2) and ( $ergebnis[$sp2[$x]] == 4 ) ) { $r = k0102 }
if ( ($pro2[$x] == 3) and ( $ergebnis[$sp2[$x]] == 4 ) ) { $r = k2102 }
if ($pro2[$x] == 0) { $r = k102 }

print "<img src=/img/$r.JPG><br>\n";
}
print "</font></td>\n";
print "<td align=left width=250 valign=middle><font face=verdana size=1><img src=/img/loch.JPG border=0><br><font color=black>\n";
for ( $x = 1; $x < 6;$x++ ) {

$flag = $main_flags[$flagge[$sp2[$x]]];
if ( $sp2[$x] == 0 ) { ($flag = "tip_leer.jpg")}

print "&nbsp;&nbsp;&nbsp;&nbsp;<img HEIGHT=10 WIDTH=14 src=http://www.tipmaster.de/img/$flag border=0>&nbsp;&nbsp;&nbsp;&nbsp;<a href=javascript:document.xs$x.submit()>$paarung[$sp2[$x]]</a><br>\n";

}


print "</font>\n";
for ( $x = 1; $x < 6; $x++ ) {

($verein1,$verein2) = split (/ \- /,$paarung[$sp2[$x]]);
$verein1=~s/  //g;
$verein2=~s/  //g;
if ($flagge[$sp2[$x]] == 1) { $vv = "ger1" }
if ($flagge[$sp2[$x]] == 2) { $vv = "ger2" }
if ($flagge[$sp2[$x]] == 3) { $vv = "eng0" }
if ($flagge[$sp2[$x]] == 4) { $vv = "fre0" }
if ($flagge[$sp2[$x]] == 5) { $vv = "ita0" }

}

print "</td>\n";
print "<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td align=left valign=top><font face=verdana size=1><img src=/img/loch.JPG><br>\n";




for ( $x = 1; $x < 6;$x++ ) {

if ( $pro2[$x] == $ergebnis[$sp2[$x]] ) { $r = black }
if ( $pro2[$x] != $ergebnis[$sp2[$x]] ) { $r = silver }
if ( $ergebnis[$sp2[$x]] == 4 ) { $r = black }

if ( $ergebnis[$sp2[$x]] == 0 ) { $r = gray}

print "<font color=$r>\n";

if ( $pro2[$x] == 1 ) { print "&nbsp;&nbsp; $qu_1[$sp2[$x]] &nbsp;</font><br>\n" }
if ( $pro2[$x] == 2 ) { print "&nbsp;&nbsp; $qu_0[$sp2[$x]] &nbsp;</font><br>\n" }
if ( $pro2[$x] == 3 ) { print "&nbsp;&nbsp; $qu_2[$sp2[$x]] &nbsp;</font><br>\n" }
if ( $pro2[$x] == 0 ) { print "<font face=verdana color=black size=1>&nbsp;&nbsp;&nbsp;**</font><br>\n" }
}

print "</font></td></tr><tr><td></td><td></td><td></td><td bgcolor=#000000><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
print "<td></td><td></td><td></td><td></td><td bgcolor=#000000><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr>\n";
print "<tr><td></td><td></td><td></td><td align=right><font face=verdana size=1>$su_1&nbsp;&nbsp;</td><td></td><td></td><td></td><td></td>\n";
print "<td align=right><font face=verdana size=1>$su_2&nbsp;&nbsp;</td></tr></table>\n";
print '
<!-- Google Tag Manager -->
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-KX6R92"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':
new Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=
\'//www.googletagmanager.com/gtm.js?id=\'+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,\'script\',\'dataLayer\',\'GTM-KX6R92\');</script>
<!-- End Google Tag Manager -->';


exit ;




