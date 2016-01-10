#!/usr/bin/perl

=head1 NAME
	BTM login.pl

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

my $session = TMSession::getSession( btm_login => 1 );
my $trainer = $session->getUser();
my $leut    = $trainer;

if ( $session->getBTMTeam() eq "" && $session->getTMITeam() ne "" ) {
use CGI;
my $query = CGI->new();
my $user     = $query->param('user');
my $passwort = $query->param('pass');
	print "Content-type:text/html\n\n
<form name=Testform action=/cgi-mod/tmi/login.pl method=POST>	
<input type=hidden name=user value=\"".$user."\">
<input type=hidden name=pass value=\"".$passwort."\">
</form>

<script language=JavaScript>
function AbGehts()
{
document.Testform.submit();
}
window.setTimeout(\"AbGehts()\",0);
</script>";
	exit;
}

use CGI;
use TMLogger;

my $output = '';
open O, '>', \$output or die "Can't open OUTPUT: $!";
select O;

my $http_cookie = $ENV{'HTTP_COOKIE'};
my $c11         = "";
my $verein_id;
my $verein_nr;
my $acc_other          = "";
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
my $t                  = "";
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
my $c7                 = "";
my $c8                 = "";
my $c9                 = "";
my $c10                = "";
my $c5                 = "";
my @cookies            = ();
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

my $sek1        = "";
my $min1        = "";
my $std1        = "";
my $tag1        = "";
my $mon1        = "";
my $jahr1       = "";
my $wt1         = "";
my $xa1         = "";
my $xb1         = "";
my $xc1         = "";
my $xd1         = "";
my $xe1         = "";
my $xf1         = "";
my $xg1         = "";
my @future_flag = ();
my $c1          = "";
my $c2          = "";
my $c3          = "";
my $c4          = "";
my $id          = "";
my $ww1         = "";
my $uhr1        = "";
my $suche1      = "";
my $datum1      = "";
my $leute       = "";
my @datc        = ();

my @cup_btm_aktiv_f = ( 0, 0, 1, 1, 1, 1, 1, 1, 0, 1 );
my @cup_btm_round   = ( 0, 1, 1, 2, 3, 4, 5, 6, 7, 7 );

use lib qw{/tmapp/tmsrc/cgi-bin};

use Test;
use CGI qw/:standard/;
use CGI::Cookie;

#print $$;
#use Apache::DBI;
use DBI;

my $mlib         = new Test;
my $page_footer  = $mlib->page_footer();
my $banner_gross = $mlib->banner_gross();
my $banner_klein = $mlib->banner_klein();
my $banner_head  = $mlib->banner_head();
my @liga_namen   = $mlib->btm_liga_kuerzel();

my $aktiv_position;

$query = new CGI;

$first  = $query->param('first');
$expire = $query->param('expire');
$poll   = $query->param('poll');
$wert   = $query->param('wert');

#print "<font face=verdana size=1 color=#eeeeee>$http_cookie";

$ein_trainer = 0;
$ein_pass    = 0;
$r           = 0;
$ab          = "!&";
$aa          = "&";
$suche       = $ab . $trainer . $aa;

$ein       = 0;
$r         = 0;
$verein_da = 0;
open( D2, "/tmdata/btm/history.txt" );
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

open( D2, "/tmdata/tmi/history.txt" );
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

if ( $verein_da == 0 && $acc_other ne "" ) {
	print "Content-type: text/html\n\n";
	print "<form name=Testform action=/cgi-mod/tmi/login.pl method=post></
form>";
	print "<script language=JavaScript>\n";
	print "   function AbGehts()\n";
	print "   {\n";
	print "    document.Testform.submit();\n";
	print "    }\n";
	print "   window.setTimeout(\"AbGehts()\",0);\n";
	print "  </script>\n";
	exit;
}

if ( $verein_da == 0 ) { TMAuthenticationController::error_needslogin("no team") }

$y = 0;
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
		$verein_nr    = ( ( $liga - 1 ) * 18 ) + $x;
		$verein_id    = $verein_nr;
		if ( $verein_nr < 10 )   { $verein_nr = '0' . $verein_nr }
		if ( $verein_nr < 100 )  { $verein_nr = '0' . $verein_nr }
		if ( $verein_nr < 1000 ) { $verein_nr = '0' . $verein_nr }

		$id = $x;
	}
	$y++;
	chomp $lor[$y];
	$datc[$x] = $lor[$y];
}
########################################################################

$leute = $leut;
$leute =~ s/\ /\_/g;

my $c_forum;

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

open( D9, "/home/tm/tt_log/$trainer" );
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

print <<"(END ERROR HTML)";

<html>
<head>
  <title>Bundesliga - TipMaster : LogIn Bereich $leut</title>
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

#if ( ! -e "/btm/popu/$trainer" ) {
#print '
#<script language="javascript" type="text/javascript">
#<!--
#function fenster()
#{
#var win;
#win=window.open("/pop1.htm","NeuesFenster","width=400,height=400");
#}
#//-->
#</script>
#<body onload=fenster()>
#';

#open(D,">/btm/popup/$trainer");
#close(D);
#}

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

	# popup only if not already voted
	my $plib = new PollLib();
	$plib->openDB();
	my $voteSoFar = $plib->hasAlreadyVoted($leut);
	if ( !$voteSoFar ) {
		print "<!-- Vote for $leut bislang: $voteSoFar... popup launch //-->\n";
		$ff = $leut;
		$ff =~ s/ /%20/g;
		$richtig1 = $richtig;
		$richtig1 =~ s/ /%20/g;
		print "
<script language=\"JavaScript\">
window.open(\"/cgi-bin/fuxx/fuxx.pl?user=$ff&passwd=$richtig1\", \"Zweitfenster\", \"width=700,height=500,scrollbars\");
</script>
		";
	}
	else {
		print "<!-- Vote for $leut bislang: $voteSoFar... NO popup launch //-->\n";
	}
	$plib->closeDB();
	$plib = "";
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
	print "<br>&nbsp;&nbsp;[ Zum TMI Account <a href=javascript:document.tmi.submit()>$acc_other</a> ]</td>
<form method=post name=tmi action=/cgi-mod/tmi/login.pl>
</td></form>
";
}
else {
	print "</td>";
}

print "
<td align=left width=160 valign=bottom>


";

#<font face=verdana size=1>Last-7-Days Aktivitaet
#";
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
if ( $ff > 100 ) { $ff = 100 }

#print "<font color=darkred> [heute $ff%]<br>";

#print "<td align=right valign=top><font face=verdana size=1> ";

#my $ras=0;
#open(AA,"</tmdata/btm/tip_datum.txt");
#$ras=<AA>;
#chomp $ras;
#close(AA);
#$datei = "/btm/tips/".$ras."/".$verein_nr.".txt";
#my $cc="";my $cd="";
#if ( -e $datei) { $cc = "11" ; $cd = "Tippabgabe erfolgt"}else{$cc="00";$cd="Tippabgabe steht noch aus"}
#print "Tippabgabe Liga <img src=/img/li$cc.gif alt=\"$cd\"> ";

#my $tmp5;
#$tmp5=0;
#open(AA,"</tmdata/btm/pokal/pokal_id.txt");
#if ( <AA> =~ /&$verein_id&/ ){ $tmp5=1 }
#close(AA);

#if( $tmp5 == 1){
#print "<br>Tippabgabe DFB Pokal <img src=/img/li10.gif alt=\"Tippabgabe erfolgt\"> ";} else
#{ print "<br>Tippabgabe DFB Pokal <img src=/img/li20.gif alt=\"nicht fuer den DFB - Pokal qualifiziert\">"}

#my $tmp5;
#$tmp5=0;
#open(AA,"</tmdata/btm/pokal/pokal.txt");
#while(<AA>){
#if ( $_ =~ /&$verein_id&/ ){ $tmp5=1 }}
#close(AA);

#if ($tmp5 == 1 ) {

#$cc="10";$cd="Verein noch im Wettbewerb / diese Woche keine Tippabgabe noetig";

#} else
#{$cc="20";$cd="Nicht fuer den Amateurpokal quailifiziert"}

#print "<br>Tippabgabe Amateurpokal <img src=/img/li$cc.gif alt=\"$cd\"> ";

if ($fuxxactive) {
	print
"<a class=navis href=/cgi-bin/fuxx/fuxx.pl target\"fuxx\" onClick=\"targetLink('/cgi-bin/fuxx/fuxx.pl');return false\">Stand Fuxx-Wahl</a><br>";
}
#
print
"<br> <a class=navis href=/cgi-bin/online_who.pl target\"_blank\" onClick=\"targetLink('/cgi-bin/btm/online_who.pl');return false\">Wer ist gerade online ?</a>";

if ( $leut ne "Gast Zugang" ) {

	$neu_news = $mail_new;
	$datei    = "/tmdata/btm/newmail/" . $trainer;
	if ( -e "$datei" ) {
		print "<tr><td align=center colspan=2><br><font face=verdana size=1>
<img src=/img/mi.gif> &nbsp; Sie haben <a href=javascript:document.link15.submit()>ungelesene Post</a> in Ihrer Message Box &nbsp; <img src=/img/mi.gif>
</td></tr>\n";
	}

	#print "<tr><td align=center colspan=2><br><font face=verdana size=1>
	#<i>Derzeit ist hier keine Information ueber ungelesene Messages in der Box moeglich</i></td></tr>\n";

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
"<tr><td align=center colspan=2><br><font face=verdana size=1 color=black>*** Sie haben <font color=darkred>Ihr Trainerprofil<font color=black> noch nicht angelegt ***<br>*** Dies koennen Sie ueber den unteren Link <font color=darkred> 'Profil anlegen'  <font color=black> nacholen ***<br></td></tr>\n";
}
print "</td></tr></table>\n";

if ( $poll > 0 ) {
	$datei = "/tmdata/btm/poll/" . $trainer;
	$datei =~ s/ /_/g;
	$datei = $datei . '.txt';
	open( D1, ">$datei" );
	print D1 "$poll";
	close(D1);
}

print <<"(END ERROR HTML)";





<form name=link1b action=/cgi-bin/btm/tipabgabe_neu.pl method=post target=_top>
</form>

<form name=link1 action=/cgi-bin/btm/tipabgabe.pl method=post target=_top>
</form>

<form name=link2 action=/cgi-mod/btm/spiel.pl method=post target=_top>
<input type=hidden name=id value="$id"><input type=hidden name=ligi value="$liga"><input type=hidden name=li value="$liga"></form>

<form name=link3 action=/cgi-mod/btm/tab.pl method=post target=_top>
<input type=hidden name=id value="$id"><input type=hidden name=ligi value="$liga"><input type=hidden name=li value="$liga"></form>

<form name=link4 action=/cgi-bin/btm/boerse.pl method=post target=_top>
</form>

<form name=link5 action=/cgi-bin/btm/award.pl method=post target=_top>
</form>

<form name=link6 action=/cgi-bin/btm/last100.pl method=post target=_top>
</form>

<form name=link7 action=/cgi-bin/btm/vranking.pl method=post target=_top>
</form>

<form name=link8 action=/cgi-bin/btm/ligaquote.pl method=post target=_top>
</form>

<form name=link9 action=/cgi-bin/btm/ewigtab.pl method=post target=_top>
</form>

<form name=link10 action=/cgi-bin/btm/friendly.pl method=post target=_top>
<input type=hidden name=method value="liste"></form>

<form name=link11 action=/cgi-mod/forum.pl method=post target=_top>

<input type=hidden name=ref value=btm>
</form>

<form name=link12 action=/cgi-bin/btm/pokal/pokal_show.pl method=post target=_top>
</form>

<form name=link13 action=/cgi-bin/cl/login.pl method=post target=_top>
<input type=hidden name=referrer value="btm"></form>

<form name=link14 action=/cgi-mod/btm/tab.pl method=post target=new>
</form>

<form name=link15 action=/cgi-bin/btm/mail/mailbox.pl method=post target=_top>
</form>

<form name=link16 action=/cgi-bin/change_profile.pl method=post target=_top>
</form>

<form name=link17 action=/cgi-bin/btm/daten/profile.pl method=post target=_top>
</form>

<form name=link18 action=/cgi-bin/btm/wechsel.pl method=post target=_top>
</form>

<form name=link19 action=/cgi-bin/btm/daten/werben.pl method=post target=_top>
</form>

<form name=link20 action=/cgi-bin/btm/suche.pl method=post target=_top>
</form>

<form name=link21 action=/cgi-bin/btm/account_delete.pl method=post target=_top>
</form>

(END ERROR HTML)

#@border = ( 0 ,4 , 8 , 12 , 16 , 20 , 24 , 27 , 31 , 35 );
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
	"DFB-/Amateurpokal",
	"Europapokal",
	"",
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
	"<b>TM Hauptseite</b>",
	"TipMaster - Links",

	"<b>Live - Resultate</b>",
	"Fussball Live Streams",
	"info\@tipmaster.de",
	"",
);

@link_target = (
	"javascript:document.link1b.submit()",
	"javascript:document.link2.submit()",
	"javascript:document.link3.submit()",
	"javascript:document.link1.submit()",
	"javascript:document.link10.submit()",
	"javascript:document.link12.submit()",
	"javascript:document.link13.submit()",
	"",
	"javascript:document.link4.submit()",
	"javascript:document.link18.submit()",
	"javascript:document.link20.submit()",
	"",
	"http://community.tipmaster.de/",
	"javascript:document.link15.submit()",
	"http://community.tipmaster.de/",
	"/chat/",
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
	"/cgi-bin/btm/titel.pl",
	"https://github.com/tipmaster/tipmaster/wiki/Regelbuch",
	"https://github.com/tipmaster/tipmaster/wiki/FAQs",
	"/",
	"/cgi-bin/list.pl?id=links",

	"http://www.fussball-liveticker.eu/",
	"http://www.fussballlivestream.tv",
	"mailto:info\@tipmaster.de",
	""
);

$datei = "/tmdata/btm/help/" . $leut;
if ( -e $datei ) {
}

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
	$pop{'bisherige Titeltraeger'} = "  new";

	$xc = "";
	if ( $pop{$ole} ne "" ) { $xc = " target=new" }

	if ( -e $datei ) {
		print "
<a class=navi href=$link_target[$table] ONMOUSEOVER=\"popup('$link_info[$table]','white','$ole')\"; ONMOUSEOUT=\"kill()\"$xc>$ole</a><br>
";
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

$datei = "/tmdata/btm/poll/" . $trainer;
$datei =~ s/ /_/g;
$datei = $datei . '.txt';

if (   ( $ww > 5 || ( $ww == 5 && $std > 17 ) )
	|| ( $ww == 0 && $std < 24 )
	|| ( $ww == 1 && $std < 12 ) )
{

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

	#if (! -e $datei ) {
	open( N, "</tmdata/news.txt" );
	while (<N>) {
		print $_;
	}
	close(N);
}

#}

print "
</td>
<td width=1></td>
<td valign=top align=left>
";

my $ran = int( 5 * rand ) + 1;

#if ( $ran != 1 ) {
print $banner_klein;

#print "<br><br>";
#} else {
#oen (D1 , "/btm/click.txt") ;
#while(<D1>){
#if ( $_ =~ /$trainer/ ) {$click++}
#}
#close (D1);

#if ( $click == 0 ) { $sup="leider noch gar keine" }
#if ( $click > 0 ) { $sup="sehr gering" }
#if ( $click > 3 ) { $sup="gering" }
#if ( $click > 7 ) { $sup="mittel" }
#if ( $click > 15 ) { $sup="gut" }
#if ( $click > 25 ) { $sup="sehr gut" }
#if ( $click > 40 ) { $sup="spitze" }

#$proz = int(($click*100) / 41);

if ( $leut ne "Gast Zugang" ) {

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

}
else {
	# Ihre diesbzgl.
	# Unterstuetzung diese Woche :<br><font color=black>$sup<font color=gray> [$proz%]

	print <<"(END ERROR HTML)";
<br><br><table border=0 bgcolor=black cellpadding=0 cellspacing=1><tr><td>
<table border=0 cellpadding=3 cellspacing=1 bgcolor=#eeeeff><tr><td valign=top align=left>
<font face=verdana size=1 color=black>

Sie sind im Moment als Gast beim TipMaster <br>
eingeloggt. Besuchen Sie die Menuepunkte <br>
und lernen Sie die diversen Moeglichkeiten <br>
beim TipMaster kennen . Nach Ihrer Gastvisite<br>
gelangen Sie <a href=/cgi-bin/btm/anmeldung.pl target=top>hier zur Anmeldung</a>  !<br></td></tr></table></tr></table>
<br>

(END ERROR HTML)
}

print <<"(END ERROR HTML)";

<font color=darkred>
<table border=0 bgcolor=#eeeeee>
<tr>

<td align=left><font face=verdana size=1>


<br/><br>

<div style="min-width:235px;max-width:235px;padding:10px;background-color:white;border:1px solid black">
<b>Aktion Fehlerbereinigung</b><br/><br/>
Wir arbeiten aktiv daran Fehler beim TipMaster zu eliminieren.
Wenn euch Fehler auffallen meldet sie bitte im Stammtisch
in <a href="http://community.tipmaster.de/showthread.php?t=27483">diesem Posting</a>.
</div>
<br/>
<div style="min-width:235px;max-width:235px;padding:10px;background-color:white;border:1px solid black">
<b>Tranerfuxx Wahl</b><br/><br/>
<a href="http://community.tipmaster.de/showthread.php?t=29303">Hier abstimmen!</a></div>
<br/>

<br/><br/>
</td>




</tr>
</table>

<br>

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

1;
