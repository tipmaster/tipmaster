#!/usr/bin/perl

=head1 NAME
	TMI login.pl

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

use strict;
use lib '/tmapp/tmsrc/cgi-bin/';
use TMSession;
my $session = TMSession::getSession( tmi_login => 1 );
my $trainer = $session->getUser();
my $leut    = $trainer;

use CGI;
use TMLogger;

my $output = '';
open O, '>', \$output or die "Can't open OUTPUT: $!";
select O;

my $acc_other          = "";
my $t                  = "";
my $chat_user          = "";
my $neu_news           = "";
my $mail_new           = "";
my @border             = ();
my @arte               = ();
my @tab_name           = ();
my @link_name          = ();
my @link_target        = ();
my @link_info          = ();
my $tab                = "";
my $table              = "";
my $ole                = "";
my $table              = "";
my $table              = "";
my %pop                = "";
my $table              = "";
my $table              = "";
my $click              = "";
my $sup                = "";
my $sup                = "";
my $sup                = "";
my $sup                = "";
my $sup                = "";
my $sup                = "";
my $sup                = "";
my $proz               = "";
my $sup                = "";
my $ima                = "";
my $color              = "";
my @pi                 = ();
my @pi                 = ();
my @pi                 = ();
my @wochen             = ();
my $uhr                = "";
my $game               = "";
my @ros                = ();
my @zeit               = ();
my @gegner1            = ();
my @gegner2            = ();
my @date               = ();
my @nr                 = ();
my $fa                 = "";
my $fb                 = "";
my $fc                 = "";
my $offset             = "";
my @make               = ();
my %tore_a             = ();
my %tore_b             = ();
my $fd                 = "";
my $error              = "";
my @error_fields       = ();
my $missing_field      = "";
my $missing_field_list = "";
my $error              = "";
my $error              = "";
my $error              = "";
my $error              = "";
my $error              = "";
my $error              = "";
my $error              = "";
my $c6                 = "";
my $c5                 = "";
my $xx                 = "";
my $trainer_evt        = "";
my $zeile              = "";
my $pi                 = "";
my $vi                 = "";
my $datei              = "";
my $visits             = "";
my $datum              = "";
my $hits               = "";
my $tage               = "";
my $monat              = "";
my $date               = "";
my @stern              = ();
my @img                = ();
my @img                = ();
my @img                = ();
my @img                = ();
my @img                = ();
my $run                = "";
my $xq                 = "";
my @punkte_tip         = ();
my @bonus              = ();
my @punkte_bonus       = ();
my @richtig            = ();
my @tendenz            = ();
my $ok                 = "";
my @ex_platz           = ();
my $platz_id           = "";
my $stand              = "";
my $sek                = "";
my $min                = "";
my $std                = "";
my $tag                = "";
my $mon                = "";
my $jahr               = "";
my $wt                 = "";
my $xa                 = "";
my $xb                 = "";
my $xc                 = "";
my $xd                 = "";
my $xe                 = "";
my $xf                 = "";
my $spielrunde         = "";
my $xg                 = "";
my $stunde             = "";
my $datum_1            = "";
my $zeit_1             = "";
my $stunde_1           = "";
my $fuxxactive         = "";
my $ff                 = "";
my $richtig1           = "";
my $db                 = "";
my $host               = "";
my $user               = "";
my $dbh                = "";
my $aktiv              = "";
my @liga_namen         = ();
my $ww                 = "";
my @img                = ();
my @img                = ();
my @img                = ();
my $alt                = "";
my @img                = ();
my @img                = ();
my @img                = ();
my @img                = ();
my @img                = ();
my $query              = "";
my $first              = "";
my $expire             = 0;
my $poll               = "";
my $wert               = "";

my $url                = "";
my $url                = "";
my $suche              = "";
my $verein             = "";
my $ein_trainer        = 0;
my $ein_pass           = 0;
my $r                  = "";
my $ab                 = "";
my $aa                 = "";
my $leer               = "";
my $richtig            = "";
my $linie              = "";
my $ein                = "";
my $verein_da          = "";
my @zeilen             = ();
my $liga               = "";
my @lor                = ();
my $y                  = "";
my $x                  = "";
my @data               = ();
my @datb               = ();
my $liga_login         = "";
my $verein_login       = "";
my $id                 = "";
my @datc               = ();
my $leute              = "";
my $c1                 = "";
my $c2                 = "";
my $c3                 = "";
my $c6                 = "";
my $c7                 = "";
my $c8                 = "";
my $c9                 = "";
my $c11                = "";
my $c10                = "";
my $c5                 = "";
my $c4                 = "";
my $sek1               = "";
my $min1               = "";
my $std1               = "";
my $tag1               = "";
my $mon1               = "";
my $jahr1              = "";
my $wt1                = "";
my $xa1                = "";
my $xb1                = "";
my $xc1                = "";
my $xd1                = "";
my $xe1                = "";
my $xf1                = "";
my $xg1                = "";
my @future_flag        = ();
my $c1                 = "";
my $c2                 = "";
my $c3                 = "";
my $c4                 = "";
my $id                 = "";
my $ww1                = "";
my $uhr1               = "";
my $suche1             = "";
my $datum1             = "";
my $leute              = "";
my @datc               = ();

use lib qw{/tmapp/tmsrc/cgi-bin};
use Test;
use CGI qw/:standard/;
use CGI::Cookie;
use DBI;

my $mlib         = new Test;
my $page_footer  = $mlib->page_footer();
my $banner_gross = $mlib->banner_gross();
my $banner_klein = $mlib->banner_klein();
my $aktiv_position;

$query = new CGI;

$first  = $query->param('first');
$expire = $query->param('expire');
$poll   = $query->param('poll');
$wert   = $query->param('wert');

open( D1, "</tmdata/top_tip.txt" );
$run = <D1>;
my $top_tip_aktiv = <D1>;
chomp $run;
chomp $top_tip_aktiv;
close(D1);

@liga_namen = (
	"---",
	"ITA I",
	"ITA II",
	"ITA III/A",
	"ITA III/B",
	"ITA IV/A",
	"ITA IV/B",
	"ITA IV/C",
	"ITA IV/D",
	"ENG I",
	"ENG II",
	"ENG III/A",
	"ENG III/B",
	"ENG IV/A",
	"ENG IV/B",
	"ENG IV/C",
	"ENG IV/D",
	"SPA I",
	"SPA II",
	"SPA III/A",
	"SPA III/B",
	"SPA IV/A",
	"SPA IV/B",
	"SPA IV/C",
	"SPA IV/D",
	"FRA I",
	"FRA II",
	"FRA III/A",
	"FRA III/B",
	"FRA IV/A",
	"FRA IV/B",
	"FRA IV/C",
	"FRA IV/D",
	"NED I",
	"NED II",
	"NED III/A",
	"NED III/B",
	"NED IV/A",
	"NED IV/B",
	"POR I",
	"POR II",
	"POR III/A",
	"POR III/B",
	"POR IV/A",
	"POR IV/B",
	"BEL I",
	"BEL II",
	"BEL III/A",
	"BEL III/B",
	"BEL IV/A",
	"BEL IV/B",
	"SUI I",
	"SUI II",
	"SUI III/A",
	"SUI III/B",
	"SUI IV/A",
	"SUI IV/B",
	"AUT I",
	"AUT II",
	"AUT III/A",
	"AUT III/B",
	"AUT IV/A",
	"AUT IV/B",
	"SCO I",
	"SCO II",
	"SCO III/A",
	"SCO III/B",
	"SCO IV/A",
	"SCO IV/B",
	"TUR I",
	"TUR II",
	"TUR III/A",
	"TUR III/B",
	"TUR IV/A",
	"TUR IV/B",
	"IRL I",
	"IRL II",
	"IRL III/A",
	"IRL III/B",
	"NIR I",
	"NIR II",
	"NIR III/A",
	"NIR III/B",
	"WAL I",
	"WAL II",
	"WAL III/A",
	"WAL III/B",
	"DEN I",
	"DEN II",
	"DEN III/A",
	"DEN III/B",
	"NOR I",
	"NOR II",
	"NOR III/A",
	"NOR III/B",
	"SWE I",
	"SWE II",
	"SWE III/A",
	"SWE III/B",
	"FIN I",
	"FIN II",
	"FIN III/A",
	"FIN III/B",
	"ISL I",
	"ISL II",
	"ISL III/A",
	"ISL III/B",
	"POL I",
	"POL II",
	"POL III/A",
	"POL III/B",
	"TCH I",
	"TCH II",
	"TCH III/A",
	"TCH III/B",
	"UNG I",
	"UNG II",
	"UNG III/A",
	"UNG III/B",
	"RUM I",
	"RUM II",
	"RUM III/A",
	"RUM III/B",
	"SLO I",
	"SLO II",
	"SLO III/A",
	"SLO III/B",
	"KRO I",
	"KRO II",
	"KRO III/A",
	"KRO III/B",
	"JUG I",
	"JUG II",
	"JUG III/A",
	"JUG III/B",
	"BoH I",
	"BoH II",
	"BoH III/A",
	"BoH III/B",
	"BUL I",
	"BUL II",
	"BUL III/A",
	"BUL III/B",
	"GRI I",
	"GRI II",
	"GRI III/A",
	"GRI III/B",
	"RUS I",
	"RUS II",
	"RUS III/A",
	"RUS III/B",
	"EST I",
	"EST II",
	"EST III/A",
	"EST III/B",
	"UKR I",
	"UKR II",
	"UKR III/A",
	"UKR III/B",
	"MOL I",
	"MOL II",
	"MOL III/A",
	"MOL III/B",
	"ISR I",
	"ISR II",
	"ISR III/A",
	"ISR III/B",
	"LUX I",
	"LUX II",
	"LUX III/A",
	"LUX III/B",
	"SLK I",
	"SLK II",
	"SLK III",
	"MAZ I",
	"MAZ II",
	"MAZ III",
	"LIT I",
	"LIT II",
	"LIT III",
	"LET I",
	"LET II",
	"LET III",
	"WRU I",
	"WRU II",
	"WRU III",
	"MAL I",
	"MAL II",
	"MAL III",
	"ZYP I",
	"ZYP II",
	"ZYP III",
	"ALB I",
	"ALB II",
	"GEO I",
	"GEO II",
	"ARM I",
	"ARM II",
	"ASE I",
	"ASE II",
	"AND I",
	"AND II",
	"FAE I",
	"SaM I"
);

#if ( $ein_trainer == 0 ) { &error('kein_trainer') }
#if ( $ein_pass == 0 ) { &error('falsches_passwort') }

#if ( $ein_trainer == 0 ) { &error('falscher_login') }
#if ( $ein_pass == 0 ) { &error('falscher_login') }

#if ( $verein_da == 0 ) { &error('kein_verein') }

$ein       = 0;
$r         = 0;
$verein_da = 0;
open( D2, "/tmdata/tmi/history.txt" );
while (<D2>) {
	$r++;
	$zeilen[$r] = $_;
	chomp $zeilen[$r];
	if ( $_ =~ /&$leut&/i ) {
		$verein_da = 1;
		$ein       = 1;
		$liga      = $r;
		@lor       = split( /&/, $_ );
		$linie     = $r;
	}
}
close(D2);

open( D2, "/tmdata/btm/history.txt" );
while (<D2>) {
	if ( $_ =~ /&$leut&/i ) {

		my @tmp = split( /&&/, $_ );
		my $z = 0;
		foreach $t (@tmp) {
			( my $tmp1, my $tmp2, my $tmp3 ) = split( /&/, $t );
			if ( $z == 0 ) { $tmp1 = $tmp2; $tmp2 = $tmp3; $z = 1 }
			if ( $leut eq $tmp2 ) { $acc_other = $tmp1 }
		}
	}
}
close(D2);

for ( $x = 1 ; $x < 19 ; $x++ ) {
	$y++;
	chomp $lor[$y];
	$data[$x] = $lor[$y];
	$y++;
	chomp $lor[$y];
	$datb[$x] = $lor[$y];
	if ( $datb[$x] eq $leut ) {
		$liga_login   = $linie;
		$verein_login = $data[$x];

		$id = $x;
	}
	$y++;
	chomp $lor[$y];
	$datc[$x] = $lor[$y];
}

$trainer = $leut;
$leute   = $leut;
$leute =~ s/\ /\_/g;

################# LAST 7 DAYS BONUS EINLESEN ############################
$zeile = 0;
$pi    = 0;
$vi    = 0;
$datei = '/tmdata/btm/logs/' . $trainer . '.txt';
open( D1, "$datei" );
while (<D1>) {
	$zeile++;
	if ( $zeile > 3 ) {
		$visits = 0;
		( $leer, $datum, $visits, $hits ) = split( /&/, $_ );
		( $tage, $monat ) = split( /\./, $datum );
		$date = ( $monat * 31 ) + $tage;
		if ( $hits > $stern[$date] ) {
			$stern[$date] = $hits;
		}
		$img[$date] = "/img/Stat7.gif";
		if ( $stern[$date] > 0 )   { $img[$date] = "/img/Stat6.gif" }
		if ( $stern[$date] > 50 )  { $img[$date] = "/img/Stat2.gif" }
		if ( $stern[$date] > 125 ) { $img[$date] = "/img/Stat5.gif" }
		if ( $stern[$date] > 200 ) { $img[$date] = "/img/Stat1.gif" }
	}
}
close(D1);
#########################################################################

open( D9, "/tmdata/tt_log/$trainer" );
my $top_tip_platz = <D9>;
chomp $top_tip_platz;
my $aktiv_position = <D9>;
chomp $aktiv_position;
my $top_tip_punkte = <D9>;
chomp $top_tip_punkte;
close(D9);

##############################################################

############# TOP - TIP + LOCALTIME #######################################
$x     = 0;
$datei = "/tmdata/btm/tt/rank_t5_$run.txt";
open( D1, "$datei" );
while (<D1>) {
	$x++;
	(
		$leer,             $xq,          $pi[$x],      $punkte_tip[$x], $bonus[$x],
		$punkte_bonus[$x], $richtig[$x], $tendenz[$x], $ok,             $ex_platz[$x]
	) = split( /&/, $_ );
	if ( $bonus[$x] eq $leut ) { $platz_id = $x }
}
close(D1);

$x     = 0;
$datei = "/tmdata/btm/tt/rank_datum$run.txt";
open( D1, "$datei" );
while (<D1>) {
	$stand = $_;
	chomp $stand;
}
close(D1);

( $sek, $min, $std, $tag, $mon, $jahr, $wt ) = localtime( time + 0 );
$mon++;
if ( $sek < 10 )        { $xa = "0" }
if ( $min < 10 )        { $xb = "0" }
if ( $std < 10 )        { $xc = "0" }
if ( $tag < 10 )        { $xd = "0" }
if ( $mon < 10 )        { $xe = "0" }
if ( $liga < 10 )       { $xf = "0" }
if ( $spielrunde < 10 ) { $xg = "0" }
$jahr   = $jahr + 1900;
$datum  = $xd . $tag . '.' . $xe . $mon . '.' . $jahr;
$stunde = $xc . $std;
( $datum_1,  $zeit_1 ) = split( / /,  $stand );
( $stunde_1, $leer )   = split( /\:/, $zeit_1 );
###########################################################################

my $trainer_enc = $leut;
$trainer_enc =~ s/ /%20/g;

#SSO Forum
print <<"(END ERROR HTML)";

<html>
<head>
  <title>TipMaster international : LogIn Bereich $leut</title>
<style type="text/css">
a.navi {text-decoration : none;color: black;font-family: verdana;font-size : 12px;}
a.navis {text-decoration : none;color: blue;font-family: verdana;font-size : 10px;}
a.navi:hover  {text-decoration : underline;color: darkred;font-family: verdana;font-size : 12px;}
a.navis:hover  {text-decoration : underline;color: darkred;font-family: verdana;font-size : 10px;}

<!--
BODY {OVERFLOW:scroll;OVERFLOW-X:hidden}
.DEK {POSITION:absolute;VISIBILITY:hidden;Z-INDEX:200;}
//-->
</style></head>
<body bgcolor="#eeeeee" vlink="darkred" link="darkred" text="black">
<DIV ID="dek" CLASS="dek"></DIV>
<SCRIPT TYPE="text/javascript">
<!--

/*
Pop up information box II (Mike McGrath (mike_mcgrath\@lineone.net, http://website.lineone.net/~mike_mcgrath))
*/

Xoffset=-10; // modify these values to ...
Yoffset= 25; // change the popup position.

var nav,old,iex=(document.all),yyy=-1000;

if(!old){
var skn=(nav)?document.dek:dek.style;
if(nav)document.captureEvents(Event.MOUSEMOVE);
document.onmousemove=get_mouse;
}

function popup(msg,bak,title){
var content="<TABLE background=/img/karo.gif WIDTH=350 BORDER=1 BORDERCOLOR=black CELLPADDING=8 CELLSPACING=0 "+
"BGCOLOR="+bak+"><TD ALIGN=center><FONT face=verdana COLOR=black SIZE=2><b>"+title+"</b><font size=1><br><br>"+msg+"<br><br></FONT></TD></TABLE>";
if(old){alert(msg);return;} 
else{yyy=Yoffset;
if(nav){skn.document.write(content);skn.document.close();skn.visibility="visible"}
if(iex){document.all("dek").innerHTML=content;skn.visibility="visible"}
}
}

function get_mouse(e){
var x=(nav)?e.pageX:event.x+document.body.scrollLeft;skn.left=x+Xoffset;
var y=(nav)?e.pageY:event.y+document.body.scrollTop;skn.top=y+yyy;
}

function kill(){
if(!old){yyy=-1000;skn.visibility="hidden";}
}

//-->
</SCRIPT>
(END ERROR HTML)

print "<script language=JavaScript>\n";
print "<!--\n";
print "function targetLink(URL)\n";
print "  {\n";
print "    if(document.images)\n";
print
"      targetWin = open(URL,\"Neufenster\",\"scrollbars=yes,toolbar=no,directories=no,menubar=no,status=no,resizeable=yes,width=750,height=540\");\n";
print " }\n";
print "  //-->\n";
print "  </script>\n";
print "<script language=JavaScript>\n";
print "<!--\n";
print "function targetLink(URL)\n";
print "  {\n";
print "    if(document.images)\n";
print
"      targetWin = open(URL,\"online\",\"scrollbars=yes,toolbar=no,directories=no,menubar=no,status=no,resizeable=yes,width=750,height=540\");\n";
print " }\n";
print "  //-->\n";
print "  </script>\n";

# ----------------------------------FUXX WAHL ------------------------
if ($fuxxactive) {
	my $plib = new PollLib();
	$plib->openDB();
	my $voteSoFar = $plib->hasAlreadyVoted($leut);
	if ( !$voteSoFar ) {

		$ff = $leut;
		$ff =~ s/ /%20/g;
		$richtig1 = $richtig;
		$richtig1 =~ s/ /%20/g;
		print "
<script language=\"JavaScript\">
<!--\n
window.open(\"/cgi-bin/fuxx/fuxx.pl?user=$ff&passwd=$richtig1\", \"Fuxxfenster\", \"width=700,height=500,scrollbars\");
//-->
</script>
";
	}
	else {
		print "<!-- Vote for $leut bislang: $voteSoFar... NO popup launch //-->\n";
	}
}

#----------------------------------------------------------------------------------

my $leut_s = $leut;
$leut_s =~ s/ /%20/g;
$banner_gross =~ s/trainer=/trainer=$leut_s/g;
$banner_klein =~ s/trainer=/trainer=$leut_s/g;

print <<"(END ERROR HTML)";
&nbsp; $banner_gross

<table border=0 bgcolor=#eeeeee><tr>
<td width=5></td>


<td valign=top>
<font color=#eeeeee face=verdana size=1>
(END ERROR HTML)

print <<"(END ERROR HTML)";

<table border=0 cellspacing=1 cellpadding=0 bgcolor=#eeeeee width=100%><tr>
<td align=left valign=top>
<font face=verdana size=1><font color=darkred>&nbsp;&nbsp;LogIn Bereich $leut&nbsp;&nbsp;(<a style=\"font-size:10px;\" href=\"/?logout=1\">Logout</a>)


<br><font color=black>&nbsp;&nbsp;$verein_login / $liga_namen[$liga_login]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>

(END ERROR HTML)

if ( $acc_other ne "" ) {
	print "<br>&nbsp;&nbsp;[ Zum BTM Account <a href=javascript:document.btm.submit()>$acc_other</a> ]</td>
<form method=post name=btm action=/cgi-mod/btm/login.pl>
</td></form>
";
}
else {
	print "</td>";
}

print "

<td align=left valign=bottom>

";
( $sek, $min, $std, $tag, $mon, $jahr, $ww ) = localtime( time + 0 );
$mon++;
if ( $sek < 10 )        { $xa = "0" }
if ( $min < 10 )        { $xb = "0" }
if ( $std < 10 )        { $xc = "0" }
if ( $tag < 10 )        { $xd = "0" }
if ( $mon < 10 )        { $xe = "0" }
if ( $liga < 10 )       { $xf = "0" }
if ( $spielrunde < 10 ) { $xg = "0" }
$jahr = $jahr + 1900;
$aa   = ( $mon * 31 ) + $tag;
$ff   = int( ( $stern[$aa] / 200 ) * 100 );

#if ($ff>100){$ff=100}

print "<br>";

for ( $ab = $aa - 6 ; $ab <= $aa ; $ab++ ) {

	if ( $img[$ab] eq "" ) { $img[$ab] = "/img/Stat7.gif" }

	if ( $img[$ab] eq "/img/Stat7.gif" ) { $alt = "Keine Aktivitaet" }
	if ( $img[$ab] eq "/img/Stat6.gif" ) { $alt = "Aktivitaet Blank / 0 Bonuspunkte" }
	if ( $img[$ab] eq "/img/Stat2.gif" ) { $alt = "Aktivitaet Bronze / 1 Bonuspunkt" }
	if ( $img[$ab] eq "/img/Stat5.gif" ) { $alt = "Aktivitaet Silber / 2 Bonuspunkte" }
	if ( $img[$ab] eq "/img/Stat1.gif" ) { $alt = "Aktivitaet Gold / 3 Bonuspunkte" }

	#print "<img src=$img[$ab] alt=\"$alt\">";

}
print "<br>";
if ($fuxxactive) {
	print
"<a class=navis href=/cgi-bin/fuxx/fuxx.pl target\"fuxx\" onClick=\"targetLink('/cgi-bin/fuxx/fuxx.pl');return false\">Stand Fuxx-Wahl</a><br>";
}

print
"<a class=navis href=/cgi-bin/online_who.pl target\"_blank\" onClick=\"targetLink('/cgi-bin/btm/online_who.pl');return false\">Wer ist gerade online ?</a>";

open( D, "</tmdata/www/chat_user.htm" );
while (<D>) {
	if ( $_ =~ /&nbsp;/ ) { $chat_user++ }
}
close(D);
if ( $chat_user == 0 ) { $chat_user = "keine" }

if ( $chat_user > 2 ) {
	print "\n\n";
	print "<br><font color=black>[ Aktuell $chat_user Trainer im \n
<A class=navis HREF=# onclick='window.open(\"/chat/\",\"Chatbox\",
\"width=900,height=700,resizeable=yes,toolbar=no,menubar=no,location=no,scrollbars=auto,fullscreen=no\")' >Trainer - Chat</a> ]";
}

if ( $leut ne "Gast Zugang" ) {

	$neu_news = $mail_new;

	#print "<tr><td align=center colspan=2><br><font face=verdana size=1>
	#<i>Derzeit ist hier keine Information &uml;ber ungelesene Messages in der Box m&ouml;glich</i></td></tr>\n";

	$datei = "/tmdata/tmi/newmail/" . $trainer;
	if ( -e "$datei" ) {
		print "<tr><td align=center colspan=2><br><font face=verdana size=1>
<img src=/img/mi.gif> &nbsp; Sie haben <a href=javascript:document.link15.submit()>ungelesene Post</a> in 
Ihrer Message Box &nbsp; <img src=/img/mi.gif>
</td></tr>\n";
	}

	if ( $neu_news > 1 ) {
		print
"<tr><td align=center colspan=2><br><font face=verdana size=1>*** Sie haben <font color=darkred>$neu_news ungelesene Nachrichten<font color=black> in ihrer Message Box ***<br></td></tr>\n";
	}
	if ( $neu_news == 1 ) {
		print
"<tr><td align=center colspan=2><br><font face=verdana size=1>*** Sie haben <font color=darkred>eine ungelesene Nachricht<font color=black> in ihrer Message Box ***<br></td></tr>\n";
	}
}

$datei = '/tmdata/btm/db/profile/' . $trainer . '.txt';

if ( !-e $datei ) {
	print
"<tr><td align=center colspan=2><br><font face=verdana size=1 color=black>*** Sie haben <font color=darkred>Ihr Trainerprofil<font color=black> noch nicht angelegt ***<br>*** Dies koennen Sie ueber den unteren Link <font color=darkred> 'Profil verwalten'  <font color=black> nacholen ***<br></td></tr>\n";
}
print "</td></tr></table>\n";

if ( $poll == 1 ) {
	$datei = "/tmdata/btm/poll/" . $leut;
	$datei =~ s/ /_/g;
	$datei = $datei . '.txt';
	open( D1, ">$datei" );
	print D1 "$wert";
	close(D1);
}

print <<"(END ERROR HTML)";

<form name=link1b action=/cgi-bin/tmi/tipabgabe_neu.pl method=post target=_top>
</form>

<form name=link1 action=/cgi-bin/tmi/tipabgabe.pl method=post target=_top>
</form>

<form name=link2 action=/cgi-mod/tmi/spiel.pl method=post target=_top>
<input type=hidden name=id value="$id"><input type=hidden name=ligi value="$liga"><input type=hidden name=li value="$liga"></form>

<form name=link3 action=/cgi-mod/tmi/tab.pl method=post target=_top>
<input type=hidden name=id value="$id"><input type=hidden name=ligi value="$liga"><input type=hidden name=li value="$liga"></form>

<form name=link4 action=/cgi-bin/tmi/boerse.pl method=post target=_top>
</form>

<form name=link5 action=/cgi-bin/tmi/award.pl method=post target=_top>
</form>

<form name=link6 action=/cgi-bin/tmi/last100.pl method=post target=_top>
</form>

<form name=link7 action=/cgi-bin/tmi/teamranking.pl method=post target=_top>
</form>

<form name=link8 action=/cgi-bin/tmi/ligaquote.pl method=post target=_top>
</form>

<form name=link9 action=/cgi-bin/tmi/ewigtab.pl method=post target=_top>
</form>

<form name=link10 action=/cgi-bin/tmi/friendly.pl method=post target=_top>
<input type=hidden name=method value="liste"></form>

<form name=link11 action=/cgi-mod/forum.pl method=post target=_top>

<input type=hidden name=ref value="tmi">
</form>

<form name=link12 action=/cgi-bin/tmi/pokal/pokal_show.pl method=post target=_top>
</form>

<form name=link13 action=/cgi-bin/cl/login.pl method=post target=_top>
<input type=hidden name=referrer value="tmi"></form>

<form name=link14 action=/cgi-bin/tmi/a_tab.pl method=post target=_top>
</form>

<form name=link15 action=/cgi-bin/tmi/mail/mailbox.pl method=post target=_top>
</form>

<form name=link16 action=/cgi-bin/change_profile.pl method=post target=_top>
</form>

<form name=link17 action=/cgi-bin/tmi/daten/profile.pl method=post target=_top>
</form>

<form name=link18 action=/cgi-bin/tmi/wechsel.pl method=post target=_top>
</form>

<form name=link19 action=/cgi-bin/tmi/daten/werben.pl method=post target=_top>
</form>

<form name=link20 action=/cgi-bin/tmi/suche.pl method=post target=_top>
</form>

<form name=link21 action=/cgi-bin/tmi/account_delete.pl method=post target=_top>
</form>

<form name=link22 action=/cgi-bin/tmi/tipabgabe_ls.pl method=post target=_top>
</form>


(END ERROR HTML)

@border = ( 0, 4, 8, 12, 16, 20, 24, 27, 31, 35 );
@arte = ( 0, 0, 1, 1, 2, 1, 1, 2, 1, 1, 1, 2 );
@tab_name = (
	"",           "AKTUELLES", "LIGAEXTERN",  "KARRIERE", "COMMUNITY", "RANKINGS",
	"VERWALTUNG", "HISTORY",   "OFFIZIELLES", "SERVICE"
);

@link_name = (
	"Aktuelle Tippabgabe",
	"Aktuelle Resultate ",
	"Aktuelle Tabellen ",
	"Tippabgabe Classic ",
	"Freundschaftsspiele",
	"Landespokal",
	"Europapokal",
	"Nationalmannschaft",
	"Job - Boerse",
	"Vereinstausch",
	"TipMaster - Suche",
	"",
	"Stammtisch",
	"Message - Box",
	"Liga - Forum",
	"",
	"Saison - Awards",
	"Trainer - Ranking",
	"Vereins - Ranking ",
	"Liga - Ranking ",
	"Passwort &auml;ndern",
	"Profil anlegen",
	"Account loeschen",
	"Freunde einladen",
	"Ewige Tabellen",
	"Archiv Tabellen",
	"Bisherige Titeltraeger<br>",
	"TM - Regelbuch",
	"Haeufige Fragen",
	"TM Hauptseite",
	"TipMaster - Links",

	"<b>Live - Resultate</b>",
	"Fussball Live Streams",
	"info\@tipmaster.de",
	""
);
@link_target = (
	"javascript:document.link1b.submit()",
	"javascript:document.link2.submit()",
	"javascript:document.link3.submit()",
	"javascript:document.link1.submit()",
	"javascript:document.link10.submit()",
	"javascript:document.link12.submit()",
	"javascript:document.link13.submit()",
	"javascript:document.link22.submit()",

	"javascript:document.link4.submit()",
	"javascript:document.link18.submit()",
	"javascript:document.link20.submit()",
	"",
	"http://community.tipmaster.de/",
	"javascript:document.link15.submit()",
	"http://community.tipmaster.de/forumdisplay.php?f=25",
	"",
	"javascript:document.link5.submit()",
	"javascript:document.link6.submit()",
	"javascript:document.link7.submit()",
	"javascript:document.link8.submit()",
	"javascript:document.link16.submit()",
	"javascript:document.link17.submit()",
	"javascript:document.link21.submit()",
	"javascript:document.link19.submit()",

	"javascript:document.link9.submit()",
	"javascript:document.link14.submit()",
	"/cgi-bin/tmi/titel.pl?liga=$liga",
	"https://github.com/tipmaster/tipmaster/wiki/Regelbuch",
	"https://github.com/tipmaster/tipmaster/wiki/FAQs",
	"/btm/",
	"/cgi-bin/list.pl?id=links",

	"http://www.fussball-liveticker.eu",
	"http://www.fussballlivestream.tv",
	"mailto:info\@tipmaster.de",
	""
);

$datei = "/tmdata/tmi/help/" . $leut;
if ( -e $datei ) {

	@link_info = (
"Hier k&ouml;nnen Sie die Tipabgabe f&uuml;r die aktuelle Tiprunde f&uuml;r den Ligabetrieb Ihres Vereins t&auml;tigen . Ebenfalls gelangen Sie &uml;ber diesen Link zur Blankotipabgabe Seite falls Sie einmal f&uuml;r einen Zeitraum keine Tipabgabe beim TipMaster t&auml;tigen k&ouml;nnen .<br><br>Die Tipabgabe ist jeweils ab sp�testens Montag abend bis Freitag 18.oo Uhr m&ouml;glich .",
"Hier k&ouml;nnen Sie die neusten und kompletten Resultate Ihres Vereins und Ihrer Liga samt der Tipabgaben der Trainer der aktuellen Saison einsehen . Am Wochenende k&ouml;nnen Sie live die Zwischenergebnisse der Partien Ihres Vereins verfolgen samt Livetabellen berechnet anhand der Zwischenergebnisse . Spannung pur ist angesagt .",
"Hier k&ouml;nnen Sie die Tabellen der aktuellen Saison aller Ligen einsehen . Die Tabellen lassen sich nach diversen Kriterien sortieren ( Heim , Ausw�rts , Hinrunde etc. ) . Alles was das Statistikherz begehrt ist m&ouml;glich !",
		"",
"Unter diesem Link k&ouml;nnen Sie zum einen Trainerkollegen Freundschaftsspielangebote machen bzw. unterbreitete Angebote wahrnehmen in dem Sie die Tipabgabe f&uuml;r das Freundschaftsspiel unter diesem Link t&auml;tigen .",
"Unter diesem Link finden Sie die Ansetzungen , Ergebnisse sowie den Link zur Tipabgabe f&uuml;r die Landespokalwettbewerbde der einzelnen L�nder. Welche Kriterien f&uuml;r den Startplatz in einem der Pokale erf�llt werden m&uuml;ssen entnehmen Sie bitte dem Regelbuch.",
"Unter diesem Link finden Sie die Ansetzungen , Ergebnisse sowie den Link zur Tipabgabe f&uuml;r den Europapokal. Welche Kriterien f&uuml;r den Startplatz in einem der Europapokal erf�llt werden m&uuml;ssen entnehmen Sie bitte dem Regelbuch.",
"Die Tipabgabe f&uuml;r die Nationalmannschft sowie alle wichtigen Informationen und Links zu den Nationalmannschaften finden Sie unter diesem Link.",
"Bei der Job - B�rse k&ouml;nnen Sie sich f&uuml;r alle freien Vereine ( bis Kategorie 5 )  bewerben . Als Vergabekriterien wird Ihre Tipquote der vergangenen drei Saisons sowie Ihre aktuelle Vereinsplazierung unter Ber�cksichtigung des Liganiveaus herangezogen .<br><br>Die w�chentlichen Vergaberunden finden Dienstags um 12.oo Uhr und Donnerstags um 16.oo Uhr statt.",
"Wenn Sie sich mit einem Trainerkollegen &uml;ber einen Vereinstausch geeinigt haben k&ouml;nnen Sie unter diesem Link Ihr Tuaschinteresse eintragen und offiziell machen . Die Vereinstauschgesch�ft werden w�chentlich mittwochs um 14.oo Uhr ausgef�hrt .",
"Mit der TipMaster - Suchmaschine k&ouml;nnen Sie bsp. pr�fen ob Ihr gesuchter Verein beim TipMaster vetreten ist oder welchen Verein Ihr Bekannter beim TipMaster trainiert .",
		"",
"Am TipMaster - Stammtisch wird rund um das aktuelle TipMaster sowie reale Fu�ball Geschehen diskutiert. Beachten Sie: wenn Sie selbst ein Posting im Stammtisch verfassen wollen m&uuml;ssen Sie sich zun�chst f&uuml;r den Stammtisch registrieren lassen .",
"&uml;ber die Message - Box k&ouml;nnen Sie einfach durch das Versenden von Messages mit Ihren Trainerkollegen Kontakt aufnehmen und pflegen.",
"Das Liga-Forum dient Ihnen und Ihren Ligakonkurrenten als weitere eigene Dikussionsplattform um bspw. &uml;ber das aktuelle Spielgeschehen in Ihrer Liga zu diskutieren.",
"&uml;ber den TipMaster-Chat k&ouml;nnen Sie sich schnell und ohne erneutes Einloggen mit Trainerkollegen ins Gespr�ch kommen . Sonntags um 21.oo Uhr ist der offizielle TM - Chat Termin , dann meist auch mit der Spielleitung.",
"Jede Saison werden an die besten drei Trainer in den Kategorien Top League-Player, Quotenk�nig , Torsch�tzenk�nig , Top Optimizer und gr�sste Schiessbude die entspr. Saisonawards in Gold , Silber und Bronze verliehen.",
"Gelistet nach unterschiedlichen Kriterien k&ouml;nnen Sie im Trainer-Ranking einsehen welche Trainer in der Vergangenheit in der entspr. Kategorie beim TipMaster auf sich aufmerksam machen konnten",
"Gelistet nach unterschiedlichen Kriterien k&ouml;nnen Sie im Vereins-Ranking einsehen welche Vereine in der Vergangenheit in der entspr. Kategorie beim TipMaster auf sich aufmerksam machen konnten",
"Das Liga-Ranking liefert Ihnen einen Vergleich wie stark tats�chlich in den einzelnen Ligen Tore erzielt,getippt oder optimiert wird.",
"Hier k&ouml;nnen Sie Ihr Passwort sowie Ihre E-Mail Adresse bei der Sie beim TipMaster registriert sind �ndern. Die �nderung Ihres Trainernamens oder Ihres Vereinsnamens ist nicht m&ouml;glich.",
"Um den TipMaster nicht allzu anonym werden zu lassen hat jeder Trainer die M�glichkeit ein Trainerprofil &uml;ber sich anzulegen. Alle Angaben sind freiwillig und sollen allein der F�rderung der Kommunikation unter den Trainern dienen.",
"Wenn Sie keine Lust mehr haben am TipMaster teilzunehmen bzw. lange Zeit keinen Tip abgeben k&ouml;nnen, k&ouml;nnen Sie hier Ihren Trainer - Account unwiderrruflich l&ouml;schen lassen.",
"Sie haben fussballbegeisterte Bekannte und m�chten Sich mit diesen beim TipMaster messen ? Hier k&ouml;nnen Sie Ihre Freunde schnell und einfach via E-Mail mit allen notwendigen Infos zum TipMaster informieren.",
"Zu jeder Liga beim TipMaster k&ouml;nnen Sie hier die entsprechende ewige Tabelle einsehen. Sortiert werden k&ouml;nnen die Tabellen nach absolut erzielten Punkten bzw. den relativen Punkten eines Vereins in der entspr.Liga.",
		"Die Tabellen der vielen vergangenen Saisons k&ouml;nnen unter diesem Link nocheinmal abgerufen werden .",
		"Alle Meister der ersten Ligen des TMIs k&ouml;nnen hier eingesehen werden .",
"Im Regelbuch k&ouml;nnen Sie alle wichtigen Regeln des TipMasters nachlesen. Egal ob Sie Fragen zur Tipabgabe, dem Spielsystem oder den Vergabekriterien f&uuml;r die Europapokalpl�tze haben - hier sollten Sie f�ndig werden.",
"Sehr h�ufig gestellte Fragen und Antworten zum TipMaster finden Sie auf unserer FAQ Seite. Ein Besuch lohnt sich bei Unklarheiten immer.",
"Der Bundesliga - TipMaster ist das nationale Pendant zum TipMaster international. In 256 Ligen und 9 Ligastufen k�mpfen die Trainer um die duetsche Meisterschaft bzw. um den Einzug in Bundesliga.",
"Bet-at-home.com bietet Ihnen mit Ihrem stets aktuellem Quoten-Channel die M�glichkeit Ihren Fussballsachverstand in bare M�nze zu wandeln.",
"Live-Resultate.net liefert Ihnen 7 Tage die Woche rund um die Uhr aktuellste Zwischenergebnisse , Tabellen , Resultate , Statistiken etc. nationaler und internationaler Fu�ballligen.",
		""
	);
}
### for test of new tipabgabe

$tab   = 0;
$table = -1;

print "<table border=0><tr><td>";

foreach $ole (@link_name) {
	$table++;

	if ( $border[$tab] == $table ) {
		$tab++;

		if ( $tab > 1 ) {
			print '<br></td></tr></table> 
</td></tr></table>';
		}

		if ( $arte[$tab] == 1 ) {
			print "</td><td>";
		}

		if ( $arte[$tab] == 2 ) {
			print "</td></tr><tr><td>";
		}

		print "

<TABLE cellSpacing=0 cellPadding=0 width=150 border=0 bgcolor=black><tr><td>
<TABLE cellSpacing=1 cellPadding=2 width=150 border=0>
<TR><TD bgcolor=#E1E6F0 align=center><font face=verdana size=2><b>$tab_name[$tab]</b></td></tr>
<tr><td bgcolor=white align=center background=/img/karo.gif><br><font face=verdana size=2>
";
	}
	$pop{Stammtisch}               = " new";
	$pop{'TipMaster intern.'}      = " new";
	$pop{'Live - Resultate'}       = " new";
	$pop{'Bisherige Titeltraeger'} = " new";

	$xc = "";
	if ( $pop{$ole} ne "" ) { $xc = " target=new" }

	if ( -e $datei ) {
		print "
<a class=navi href=$link_target[$table] ONMOUSEOVER=\"popup('$link_info[$table]','white','$ole')\"; ONMOUSEOUT=\"kill()\"$xc>$ole</a>
<br>";
	}
	else {
		print "<a class=navi href=$link_target[$table]$xc>$ole</a><br>";
	}
}

print '
<br></td></tr></table> 
</td></tr></table>
</td></tr>';

print '
</table>';

#if (0) {
if ( ( $ww > 5 || ( $ww == 5 && $std > 17 ) ) || ( $ww == 0 && $std < 24 ) || ( $ww == 1 && $std < 12 ) ) {

	my $tr = $trainer;
	$tr =~ s/ /%20/g;

	print "
<br>
<table border=0><tr><td> &nbsp; </td><td align=left><font face=verdana size=2 color=darkred>
<font color=black><br><font size=1>
Alle <font color=red>eigenen und gegnerischen<font color=black> Tippabgaben des<br>
Wochenendes zum Drucken auf einer Seite
<br><a href=/cgi-bin/druck_tip.pl?coach=$tr>Tippuebersicht</a> fuer diese WE fuer $trainer

</td><td valign=bottom>
&nbsp; &nbsp; &nbsp; &nbsp;<a href=/cgi-bin/druck_tip.pl?coach=$tr><img src=/img/printer.gif border=0></a></td></tr></table>
";
}
else {

	open( N, "</tmdata/news_tmi.txt" );
	while (<N>) {
		print $_;
	}
	close(N);
}

print "
</td>
<td width=1></td>
<td valign=top align=left>
";
print $banner_klein;

open( D1, "/tmdata/btm/click.txt" );
while (<D1>) {
	if ( $_ =~ /$trainer/ ) { $click++ }
}
close(D1);
if ( $click == 0 ) { $sup = "leider noch gar keine" }
if ( $click > 0 )  { $sup = "sehr gering" }
if ( $click > 3 )  { $sup = "gering" }
if ( $click > 7 )  { $sup = "mittel" }
if ( $click > 15 ) { $sup = "gut" }
if ( $click > 25 ) { $sup = "sehr gut" }
if ( $click > 40 ) { $sup = "spitze" }

$proz = int( ( $click * 100 ) / 41 );

print <<"(END ERROR HTML)";
<!--
<table border=0><tr><td>
<TABLE cellSpacing=0 cellPadding=0 border=0 bgcolor=black><tr><td>
<TABLE cellSpacing=1 cellPadding=8  border=0>
<tr><td bgcolor=white align=center background=/img/karo.gif><font face=verdana size=1>

<font face=verdana size=1 color=darkred>
Bitte besuchen Sie die Webseiten unserer<br>
Anzeigenkunden und nutzen Sie deren Angebot<br>
um den TipMaster auch in Zukunft moeglich zu<br>
machen und <font color=blue>ohne Spielgebuehren<font color=darkred> zu erhalten.<br>
</td></tr></table></tr>
</table><br>
-->
(END ERROR HTML)

################## START TOP TIP #################################################################

if ( $top_tip_aktiv == 1 ) {
	print "<!--
<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>
<table border=0 cellpadding=1 cellspacing=1>
";

	print "<tr>\n";

	print
"<td align=center colspan=5 bgcolor=#E1E6F0><font face=verdana size=1>Bet5.net Gewinnspiel Aktuelle Wochenwertung<br>
 [ Wochenwertung jeweils von Mittwoch bis Dienstag ]<br> Stand $stand 
</td></tr>";

#print "<td align=center colspan=5 bgcolor=#98bdcb><font face=verdana size=1>TOP - TIP Gewinnspiel Aktuelle Wochenwertung<br>Stand $stand GMT<br><b>p Punktauswertung grade defekt</b><br>Tips aber alle gespeichert. </b></td>\n";
	print "</tr>\n";

	for ( $x = 1 ; $x <= 5 ; $x++ ) {

		$ff = $bonus[$x];
		$ff =~ s/ /%20/g;

		$ex_platz[$x] = $punkte_bonus[$x];
		if ( $x == $ex_platz[$x] ) { $ima = "pfeil=.gif" }
		if ( $x < $ex_platz[$x] )  { $ima = "pfeil++.gif" }
		if ( $x > $ex_platz[$x] )  { $ima = "pfeil--.gif" }
		if ( $x < ( $ex_platz[$x] - 10 ) ) { $ima = "pfeil+.gif" }
		if ( $x > ( $ex_platz[$x] + 10 ) ) { $ima = "pfeil-.gif" }
		if ( $ex_platz[$x] == 0 ) { $ima = "pfeil=.gif" }

		#$ima="pfeil=.gif";

		print "<tr>\n";
		print "<td align=right bgcolor=#eeeeff><font face=verdana size=1>&nbsp;$x.&nbsp;</td>\n";
		$color = "black";

		#if ( $bonus[$x] eq $trainer ) { $color = "red" }

		print
"<td align=left bgcolor=#e6e6fa><font face=verdana size=1 color=$color>&nbsp;&nbsp;<img src=/img/$ima alt=\"von Platz $ex_platz[$x]\">&nbsp;&nbsp;<a href=/cgi-bin/btm/show_tip.pl?trainer=$ff target\"_blank\" onClick=\"targetLink('/cgi-bin/btm/show_tip.pl?trainer=$ff');return false\"><img src=/img/tt4.JPG border=0 alt=\"Bisherige Tips von $bonus[$x] anzeigen\"></a> &nbsp;&nbsp;$bonus[$x] &nbsp; &nbsp; </td>\n";
		$pi[$x]         = $pi[$x] * 1;
		$richtig[$x]    = $richtig[$x] * 1;
		$punkte_tip[$x] = $punkte_tip[$x] * 1;

		if ( $pi[$x] < 10 )      { $pi[$x]      = '0' . $pi[$x] }
		if ( $richtig[$x] < 10 ) { $richtig[$x] = '0' . $richtig[$x] }

		print "<td align=center bgcolor=#eeeeff><font face=verdana size=1>&nbsp;$richtig[$x] Tips&nbsp;</td>\n";
		print "<td align=center bgcolor=#e6e6fa><font face=verdana size=1>&nbsp;$pi[$x] Pu.&nbsp;</td>\n";

		print "</tr>\n";

		if ( ( $x == 5 ) ) {

			$ff = $leut;
			$ff =~ s/ /%20/g;

			if ( $top_tip_platz > 5 ) {
				print "<tr>\n";
				print
"<td align=right bgcolor=#eeeeff nowrap><font face=verdana size=1> &nbsp;&nbsp;$top_tip_platz.&nbsp;</td>\n";
				print
"<td align=left bgcolor=#e6e6fa nowrap><font face=verdana size=1 color=darkred>&nbsp;&nbsp;<img src=/img/pfeil=.gif>&nbsp;&nbsp;<a href=/cgi-bin/btm/show_tip.pl?trainer=$ff target\"_blank\" onClick=\"targetLink('/cgi-bin/btm/show_tip.pl?trainer=$ff');return false\"><img src=/img/tt4.JPG border=0 alt=\"Bisherige Tips von $leut anzeigen\"></a>  &nbsp;&nbsp;$leut &nbsp; &nbsp; </td>\n";

				print "<td align=center bgcolor=#eeeeff nowrap><font face=verdana size=1>&nbsp;----&nbsp;</td>\n";
				print
"<td align=center bgcolor=#e6e6fa nowrap><font face=verdana size=1>&nbsp;$top_tip_punkte Pu.&nbsp;</td>\n";

				print "</tr>\n";
			}
		}

	}

	$ff = $trainer;
	$ff =~ s/ /%20/g;

	print <<"(END ERROR HTML)";




</table>
</td></tr></table>
<font size=1 face=verdana><br>Wettguthaben fuer den Wochengewinner: 15 Euro.<br><br>
-->
&nbsp;<a href=http://www.bet5.net/?method=showRank target=blank><img src=/img/tt1.JPG border=0></a>&nbsp;&nbsp;<a href=http://www.bet5.net/?method=showRules target=blank><img src=/img/tt2.JPG border=0></a>
<p align=left>
(END ERROR HTML)
}
@wochen = ( "So.", "Mo.", "Di.", "Mi.", "Do.", "Fr.", "Sa." );

( $sek, $min, $std, $tag, $mon, $jahr, $ww ) = localtime( time + 0 );
$mon++;
if ( $sek < 10 )        { $xa = "0" }
if ( $min < 10 )        { $xb = "0" }
if ( $std < 10 )        { $xc = "0" }
if ( $tag < 10 )        { $xd = "0" }
if ( $mon < 10 )        { $xe = "0" }
if ( $liga < 10 )       { $xf = "0" }
if ( $spielrunde < 10 ) { $xg = "0" }
$jahr = $jahr + 1900;

$datum = $xd . $tag . '.' . $xe . $mon . '.' . $jahr;
$suche = '&' . $datum . '&';
$uhr   = $std . ':' . $min;

( $sek1, $min1, $std1, $tag1, $mon1, $jahr1, $ww1 ) = localtime( time + ( 60 * 60 * 24 ) );
$mon1++;
if ( $sek1 < 10 ) { $xa1 = "0" }
if ( $min1 < 10 ) { $xb1 = "0" }
if ( $std1 < 10 ) { $xc1 = "0" }
if ( $tag1 < 10 ) { $xd1 = "0" }
if ( $mon1 < 10 ) { $xe1 = "0" }
$jahr1 = $jahr1 + 1900;

$datum1 = $xd1 . $tag1 . '.' . $xe1 . $mon1 . '.' . $jahr1;
$suche1 = '&' . $datum1 . '&';
$uhr1   = $std1 . ':' . $min1;

open( D1, "/home/bet/top_tip.txt" );
while (<D1>) {

	if ( $_ =~ /$suche/ ) {
		$game++;
		@ros = split( /&/, $_ );
		$zeit[$game]    = $ros[9];
		$gegner1[$game] = $ros[1];
		$gegner2[$game] = $ros[2];

		$date[$game] = $ros[8];

		#my @tmp = (/\./,$date[$game]);
		#$date[$game]=$tmp[0].".".$tmp[1].".";

		$nr[$game] = $ros[0];
	}

	if ( $_ =~ /$suche1/ ) {
		$game++;
		@ros = split( /&/, $_ );
		$zeit[$game]    = $ros[9];
		$gegner1[$game] = $ros[1];
		$gegner2[$game] = $ros[2];

		$date[$game] = $ros[8];

		#my @tmp = (/\./,$date[$game]);
		#$date[$game]=$tmp[0].".".$tmp[1].".";

		$nr[$game]          = $ros[0];
		$future_flag[$game] = 1;
	}

}
close(D1);

( $fa, $fb ) = split( /\:/, $uhr );
$fc = ( $fa * 60 ) + $fb;
$fc = $fc + $offset;
$fc = $fc + 30;

$datei = "/home/bet/tt/" . $trainer . '.txt';

open( D1, "$datei" );
while (<D1>) {
	@make = split( /&/, $_ );
	$tore_a{ $make[1] } = $make[2];
	$tore_b{ $make[1] } = $make[3];
}
close(D1);

if ( $game == 0 ) {

	if ( $top_tip_aktiv == 1 ) {
		print "<table border=0 cellpadding=0 cellspacing=1 bgcolor=black><tr><td>\n";
		print "<table border=0 cellpadding=18 cellspacing=1 background=/img/karo.gif><tr><td align=center>\n";
		print
"<font face=verdana size=2 color=darkred>Am heutigen Tag gibt es (noch) kein\n<br>Spiel bei Bet5.net  zu tippen !</b>\n";
		print "</td></tr></table></td></tr></table><br>";
	}
	else {

		print "<!-- table border=0 cellpadding=0 cellspacing=1 bgcolor=black><tr><td>\n";
		print "<table border=0 cellpadding=18 cellspacing=1 background=/img/karo.gif><tr><td align=center>\n";
		print "<font face=verdana size=2 color=darkred>";
		print "Diese Woche wird keine Bet5.net<br>Wochenwertung ausgespielt !<br></b>";

		#print "N�chste TOP-TIP Wochenwertung<br>startet naechsten Mittwoch !<br></b>";

		print "</td></tr></table></td></tr></table><br>

-->";
	}
}
if ( $game > 0 ) {

	print "<form action=http://www.bet5.net/ method=post name=send>
<input type=hidden name=user value=\"$leut\">
<input type=hidden name=method value=sendBets>

<input type=hidden name=extern value=tm>
\n";

	print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>\n";
	print "<table border=0 cellpadding=1 cellspacing=1>\n";
	print
"<tr><td colspan=2 align=left bgcolor=#E1E6F0><font size=2>&nbsp;<font face=verdana size=1>Bet5.net Spiele</td></tr>\n";

	for ( $x = 1 ; $x <= $game ; $x++ ) {

		( $fa, $fb ) = split( /\:/, $zeit[$x] );
		$fd = ( $fa * 60 ) + $fb;

		if ( $fd <= $fc && $future_flag[$x] == 0 ) {

			if ( $tore_a{ $nr[$x] } eq "" ) { $tore_a{ $nr[$x] } = "-" }
			if ( $tore_b{ $nr[$x] } eq "" ) { $tore_b{ $nr[$x] } = "-" }

			print
"<tr><td colspan=1 align=left bgcolor=#eeeeff><font face=tahoma size=1>&nbsp;$date[$x] $zeit[$x] Uhr&nbsp;&nbsp;&nbsp;$gegner1[$x] - $gegner2[$x]&nbsp;&nbsp;&nbsp;&nbsp;</td><td colspan=1 align=center bgcolor=#cbccff><font face=verdana size=1>&nbsp;$tore_a{$nr[$x]}&nbsp;:&nbsp;$tore_b{$nr[$x]}&nbsp;</td></tr>\n";
		}

		if ( $fd > $fc || $future_flag[$x] == 1 ) {

			print
"<tr><td colspan=1 align=left bgcolor=#eeeeff><font face=tahoma size=1>&nbsp;$date[$x] $zeit[$x] Uhr&nbsp;&nbsp;&nbsp;$gegner1[$x] - $gegner2[$x]&nbsp;&nbsp;&nbsp;&nbsp;</td><td colspan=1 align=center bgcolor=#cbccff><font face=verdana size=1>&nbsp;<input  style=\"font-family: Verdana; font-size: 10px; font-weight: normal; color: #000000; background-color: #FFFFFF;\" type=text size=1 maxlength=1 name=$nr[$x]a value=$tore_a{$nr[$x]}>&nbsp;:&nbsp;<input type=text  style=\"font-family: Verdana; font-size: 10px; font-weight: normal; color: #000000; background-color: #FFFFFF;\" size=1 maxlength=1 name=$nr[$x]b value=$tore_b{$nr[$x]}>&nbsp;</td></tr>\n";

		}

	}
	print "</form></table></td></tr></table>\n";

	print "<font face=verdana size=1>\n";

	if ( $leut ne "Gast Zugang" ) {
		print "<br><a href=javascript:document.send.submit()>
<img src=/img/tt.JPG alt=\"Tippen und Gewinnen ! Viel Glueck ! \" border=0></a>\n";
	}
	else {
		print "<br><img src=/img/tt.JPG alt=\"Tipabgabe im Gastmodus deaktiviert \" border=0>\n";

	}

	print "<br><br>\n";
}

################# ENDE TOP TIP ###################################################################

print <<"(END ERROR HTML)";

<font color=darkred>
<table border=0 bgcolor=#eeeeee>
<tr>

<td align=left><font face=verdana size=1>


<div style="min-width:235px;max-width:235px;padding:10px;background-color:white;border:1px solid black">
<b>Aktion Fehlerbereinigung</b><br/><br/>
Wir arbeiten aktiv daran Fehler beim TipMaster zu eliminieren.
Wenn euch Fehler auffallen meldet sie bitte im Stammtisch
in <a href="http://community.tipmaster.de/showthread.php?t=27483">diesem Posting</a>.
</div>
<br/>
<div style="min-width:235px;max-width:235px;padding:10px;background-color:white;border:1px solid black">
<b>Trainerentlassungen</b><br/><br/>
Am kommenden Donnerstag (16.06.2016) werden die ersten inaktive Trainer entlassen. 
Die Entlassungen erfolgen nach der Vergabe durch die Jobbörse. </a>.
</div>
<br/>
<div style="min-width:235px;max-width:235px;padding:10px;background-color:white;border:1px solid black">
<b>Tranerfuxx Wahl</b><br/><br/>
<a href="http://community.tipmaster.de/showthread.php?t=30393">Hier abstimmen!</a></div>
<br/>

<br/><br/>

</td>



</tr>
</table>
</td>
</tr>
</table>
</td></tr></table>

(END ERROR HTML)

print $page_footer;

select STDOUT;
$session->writeSession();
print $output;

exit;

sub error {

	$error = shift;

	if ( $error eq 'bad_referer' ) {

	}

	elsif ( $error eq 'request_method' ) {

	}

	elsif ( $error eq 'kein_trainer' ) {
		print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>TMI - Tipabgabe : Trainername nicht gefunden</title>
 </head>
<body bgcolor=#eeeeee>
<font color=#eeeeee face=verdana size=1>.......................<img src=/img/trail.gif>
<br>
<table border=0><tr><td valign=top><img src=/img/url.gif border=0></td>
<td colspan=10></td><td valign=top>
<form action=/cgi-mod/tmi/login.pl method=post>
<input type=hidden name=first value=1>

<br><font face=verdana size=1>Trainername :<br><input type=text lenght=25 name=trainer value="$trainer">
<br><br>Passwort :<br><input type=password lenght=25 name=pass>
<br><br><input type=image src=/img/log_in.jpg border=0></form><br>
<font face=verdana size=1>Der angegebene Trainername ist nicht<br>im Trainerverzeichnis eingetragen .<br><br>
Bitte ueberpruefen Sie ihre Eingabe ,<br>
und kontrollieren Sie ob Ihre Eingabe<br>
mit der bei der Anmeldung uebereinstimmt .<br><br>
Desweiteren ueberpruefen Sie ob Sie<br>
Umlaute in Ihrem Trainernamen entsprechend<br>
ersetzt haben und keine Leerzeichen am Anfang<br> 
bzw. am Ende Ihrer Eingabe stehen .<br><br>
Sollte der angegebene Trainername korrekt sein<br>
ist evtl. Ihr Traineraccount gel&ouml;scht wurden .<br><br>
Hauefigste Ursache hierfuer ist eine<br>
den Regelbuch entsprechende Entlassung<br>
aufgrund zwei verpasster Tipabgaben in Folge<br>
oder auch die Angabe eines Phantasie-/<br>
Prominentennamen als Trainernamen .<br><br>
Haben Sie zwei Tipabgaben verpasst und<br>
wollen aber trotzdem witerhin am Spielbetrieb<br>
teilnehmen muessen Sie sich neu registrieren .<br>

Bei Problemen wenden sie sich bitte vai Mail <br>
an service\@tipmaster.net . <br>


</td><td><br>
<br><br><font color=#eeeeee face=verdana size=1>..................
<img src=/img/header.gif valign=top></td></tr></table>

 </body>
</html>
(END ERROR HTML)
	}

	elsif ( $error eq 'falsches_passwort' ) {
		print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>TMI - Tipabgabe : Falsches Passwort</title>
 </head>
<body bgcolor=#eeeeee>
<font color=#eeeeee face=verdana size=1>.......................<img src=/img/trail.gif>
<br>
<table border=0><tr><td valign=top><img src=/img/url.gif border=0></td>
<td colspan=10></td><td valign=top>
<form action=/cgi-mod/tmi/login.pl method=post>
<input type=hidden name=first value=1>

<br><font face=verdana size=1>Trainername :<br><input type=text lenght=25 name=trainer value="$leut">
<br><br>Passwort :<br><input type=password lenght=25 name=pass>
<br><br><input type=image src=/img/log_in.jpg border=0></form><br>
<font face=verdana size=1>Der angegebene Trainername existiert , <br>aber das angegebene Passwort ist falsch .
<br><br>
<b>ACHTUNG : Sollten Sie einen Account beim BTM und TMI unter<br>
dem gleichen Trainernnamen haben, aber unterschiedliche Passwoerter<br>
verwendet haben, ist Ihr bisheriges BTM Passwort Ihr neues TMI<br>
Passwort !<br><br></b>




 </body>
</html>
(END ERROR HTML)
	}
	elsif ( $error eq 'kein_verein' ) {
		print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>Vereinsaccount nicht mehr vorhanden</title>
 </head>
<body bgcolor=#eeeeee>
<font color=#eeeeee face=verdana size=1>.......................<img src=/img/trail.gif>
<br>
<table border=0><tr><td valign=top><img src=/img/url.gif border=0></td>
<td colspan=10></td><td valign=top>
<form action=/cgi-mod/tmi/login.pl method=post>
<input type=hidden name=first value=1>

<br><font face=verdana size=1>Trainername :<br><input type=text lenght=25 name=trainer value="$trainer">
<br><br>Passwort :<br><input type=password lenght=25 name=pass>
<br><br><input type=image src=/img/log_in.jpg border=0></form><br>
<font face=verdana size=1>Der angegebene Trainername ist zwar<br>im Trainerverzeichnis eingetragen<br>
jedoch ist dem Account kein TMI Verein<br>zugeordnet.<br><br>
Hauefigste Ursache hierfuer ist eine<br>
den Regelbuch entsprechende Entlassung<br>
aufgrund zwei verpasster Tipabgaben in Folge,<br>
die Angabe eines Phantasie-/<br>
Prominentennamen als Trainernamen oder <br>
die Teilnahme beschr�nkt sich auf den BTM.<br><br>
Haben Sie zwei Tipabgaben verpasst und<br>
wollen aber trotzdem witerhin am Spielbetrieb<br>
teilnehmen muessen Sie sich neu registrieren .<br>
Eine Wiedereinstellung bei Ihrem alten Verein <br>
ist nicht m&ouml;glich .<br><br>
Bevor Sie sich wieder neu anmelden k&ouml;nnen, muss<br>
Ihr Trainername freigeschaltet werden ; die Freischaltung<br>
wird t�glich um 4.oo Uhr nachts vollzogen .<br><br>

Falls keine der oben genannten Gr�nde zur L�schung<br>
Ihres Accounts f�hren konnte wenden Sie sich bitte<br>
via Mail an info\@tipmaster.net . <br><br>

</td><td><br>
<br><br><font color=#eeeeee face=verdana size=1>..................
<img src=/img/header.gif valign=top></td></tr></table>

 </body>
</html>
(END ERROR HTML)
	}

	elsif ( $error eq 'falscher_login' ) {
		print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>Das hat leider nicht geklappt ...</title>
 </head>
<body bgcolor=#eeeeee>
<font color=#eeeeee face=verdana size=1>.......................<img src=/img/trail.gif>
<br>
<table border=0><tr><td valign=top><img src=/img/url.gif border=0></td>
<td colspan=10></td><td valign=top>
<form action=/cgi-mod/tmi/login.pl method=post>
<input type=hidden name=first value=1>

<br><font face=verdana size=1>Trainername :<br><input type=text lenght=25 name=trainer>
<br><br>Passwort :<br><input type=password lenght=25 name=pass>
<br><br><input type=image src=/img/log_in.jpg border=0></form><br>
<font face=verdana size=1>
Entweder der angegebene Trainername bzw. das<br>
angegebene Passwort ist nicht korrekt oder<br>
ein erneuter LogIn ist notwendig.<br><br>
Bitte versuchen Sie es erneut .<br><br>
<b>ACHTUNG : Sollten Sie einen Account beim BTM und TMI unter<br>
dem gleichen Trainernnamen haben, aber unterschiedliche Passwoerter<br>
verwendet haben, ist Ihr bisheriges BTM Passwort Ihr neues TMI<br>
Passwort !<br><br>

Haben Sie Ihr Passwort vergessen ?<br>
Kein Problem ! <a href=/url.shtml>Wir mailen es Ihnen</a> !<br><br><br>

Bei Problemen bitte Information<br>
via Mail an info\@tipmaster.net . <br><br>


</td><td><br>
<br><br><font color=#eeeeee face=verdana size=1>..................
<img src=/img/header.gif valign=top></td></tr></table>

 </body>
</html>
(END ERROR HTML)
	}
	elsif ( $error eq 'kein_passwort' ) {
		print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>TMI - Tipabgabe : Kein Passwort angegeben</title>
 </head>
 <body bgcolor=#eeeeee text=#000000>
<p align=left><body bgcolor=white text=black>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br><br>
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

	elsif ( $error eq 'spielauswahl' ) {

	}

	exit;
}

exit;
