#!/usr/bin/perl

=head1 NAME
	BTM create_tip.pl

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
my $session = TMSession::getSession( btm_login => 1 );
my $trainer = $session->getUser();
my $leut    = $trainer;

use CGI;

require "/tmapp/tmsrc/cgi-bin/runde.pl";
require "/tmapp/tmsrc/utility/parser/bwinFormularParser.pl";
require "/tmapp/tmsrc/utility/parser/bwinScreenCaptureParser.pl";

$query = new CGI;

$method = $query->param('method');
$all    = $query->param('all');

$system   = $query->param('system');
$datei_tf = $query->param('datei');
$url      = $query->param('url');
$text     = $query->param('text');
$info     = $query->param('info');
$parser   = $query->param('parser');

@accept = (
	"Werner Stengl",
	"Wally Dresel",
	"Bodo Pfannenschwarz",
	"Thomas Schnaedelbach",
	"Walter Eschbaumer",
	"Manfred Kiesel",
	"Calvin Gross",
	"Roberto Maisl",
	"Stefan Imhoff",
	"Rainer Mueller",
	"Markus Reiss",
	"Martin Ziegler",
	"Sascha Lobers",
	"Martin Forster",
	"Thomas Sassmannshausen"
);
%ac_id = (
	"Wally Dresel"           => "0",
	"Bodo Pfannenschwarz"    => "2",
	"Thomas Schnaedelbach"   => "3",
	"Walter Eschbaumer"      => "4",
	"Manfred Kiesel"         => "5",
	"Calvin Gross"           => "6",
	"Roberto Maisl"          => "7",
	"Stefan Imhoff"          => "8",
	"Rainer Mueller"         => "9",
	"Markus Reiss"           => "10",
	"Martin Ziegler"         => "11",
	"Sascha Lobers"          => "12",
	"Martin Forster"         => "13",
	"Thomas Sassmannshausen" => "14",
	"Werner Stengl"          => "15",

);

if ( $method eq "grep" )     { &quoten_grep }
if ( $method eq "grep_url" ) { &quoten_url }
if ( $method eq "select" )   { &select }
if ( $method eq "save" )     { &save }
if ( $method eq "config" )   { &config }

#if ( $method eq "tt" ) { `perl /tmapp/tmsrc/cronjobs/top_rank_w.pl &`; }
if ( $method eq "info" ) { &info }

print $query->header();

open( D1, "</tmdata/rrunde.txt" );
$run = <D1>;
chomp $run;
close(D1);

print "<HTML><HEAD>\n";
print "<title>TipMaster online - Tipformular</title>";
print "</HEAD>\n";
print "<body background=/img/karo.gif><center><font face=verdana size=1>";
print "Eingeloggter Trainer : $trainer<br>";

$exit = 0;
foreach $t (@accept) {
	if ( $trainer eq $t ) { $exit = 1; }
}
if ( $exit == 0 ) {
	print "Kein Zugriff !";
	exit;
}

print "<hr size=0 width=80%>";
print
"<font size=2>Wie funktioniert die Tipformularerstellung -> <a href=/howto.txt traget_new>howto.txt</a><font size=1><hr>";
print "<p align=left>Nachrichten - Box :<br>";
foreach $t (@accept) {
	$tt = $t;
	if ( $t eq "Wally Dresel" ) { $tt = "Thomas Prommer" }

	$mesg = "";
	$time = "---";
	open( D, "</tmdata/msgs/mesg$ac_id{$t}.txt" );
	$mesg = <D>;
	$time = <D>;
	close(D);

	if ( $t eq $trainer ) {
		print "<form action=create_tip.pl method=post> ( $time )
$tt : <input type=text size=100 style=\"font-family:verdana;font-size:10px;\"  name=info value=\"$mesg\">";
		print
" <input value=\"Info senden\" style=\"font-family:verdana;font-size:10px;\" type=submit><input type=hidden name=method value=info>";
	}
	else {
		print "( $time ) $tt : $mesg";
	}
	print "<br>";
}
print "</form><hr><center>";

open( D1, "</tmdata/rrunde.txt" );
$run = <D1>;
chomp $run;
close(D1);
open( D1, "</tmdata/top_tip.txt" );
$top1 = <D1>;
$top2 = <D1>;
chomp $top1;
chomp $top2;
close(D1);

open( D1, "</tmdata/btm/tip_status.txt" );
$btm_tip_status = <D1>;
chomp $btm_tip_status;
close(D1);
open( D1, "</tmdata/tmi/tip_status.txt" );
$tmi_tip_status = <D1>;
chomp $tmi_tip_status;
close(D1);
open( D1, "</tmdata/btm/main_nr.txt" );
$btm_main_nr = <D1>;
chomp $btm_main_nr;
close(D1);
open( D1, "</tmdata/tmi/main_nr.txt" );
$tmi_main_nr = <D1>;
chomp $tmi_main_nr;
close(D1);

open( D1, "</tmdata/btm/tip_datum.txt" );
$btm_tip_datum = <D1>;
chomp $btm_tip_datum;
close(D1);
open( D1, "</tmdata/tmi/tip_datum.txt" );
$tmi_tip_datum = <D1>;
chomp $tmi_tip_datum;
close(D1);
open( D1, "</tmdata/btm/pokal/tip_status.txt" );
$btm_ptip_status = <D1>;
chomp $btm_ptip_status;
close(D1);
open( D1, "</tmdata/tmi/pokal/tip_status.txt" );
$tmi_ptip_status = <D1>;
chomp $tmi_ptip_status;
close(D1);
open( D1, "</tmdata/btm/pokal/pokal_datum.txt" );
$btm_ptip_datum = <D1>;
chomp $btm_ptip_datum;
close(D1);
open( D1, "</tmdata/tmi/pokal/pokal_datum.txt" );
$tmi_ptip_datum = <D1>;
chomp $tmi_ptip_datum;
close(D1);
open( D1, "</tmdata/cl/runde.dat" );
$ec_runde = <D1>;
chomp $ec_runde;
close(D1);
print "\n<!-- read from ec runden file: $ec_runde //-->\n";

print "<form action=/cgi-bin/btm/create_tip.pl method=post>\n";
print "<input type=hidden name=method value=config>\n";
print "<font color=green>Aktueller Tiprundenwert in der /cgi-bin/runde.pl -> 
<input style=\"font-family:verdana;font-size:10px;\"
type=text size=1 value=$run name=run>
<br><font color=black>";

print "TOP - TIP Wochenwertung Nr. # ->
<input style=\"font-family:verdana;font-size:10px;\"
type=text size=1 value=$top1 name=top1>
<br>[ <a href=/cgi-bin/btm/create_tip.pl?method=tt>TOP - TIP Ranking aktualisieren</a> ]<br><br>";
$ja[1] = "ja";
$ja[0] = "nein";
print "TOP - TIP Spielbetrieb ( 1=ja / 0=nein )  ->
<input style=\"font-family:verdana;font-size:10px;\"
type=text size=1 value=$top2 name=top2>
<br><br>";

#if ( $trainer eq "Bodo Pfannenschwarz" || $trainer eq "Wally Dresel" ) {
#print "
#<a href=create_tip.pl?method=sw_btm>BTM Saisonwechsel einlaeuten</a><br><br>
#<a href=create_tip.pl?method=sw_tmi>TMI Saisonwechsel einlaeuten ( + BTM /TMI Pokal )</a><br><br>
#";}

print "<table border=1 cellpadding=15><tr>";
print "<td align=center><font face=verdana size=1>";
print "
Saison Nr. BTM &nbsp; 
<input style=\"font-family:verdana;font-size:10px;\" 
type=text size=1 value=$btm_main_nr name=btm_main_nr>
<br>

Tipabgabestatus BTM &nbsp; 
<input style=\"font-family:verdana;font-size:10px;\" 
type=text size=1 value=$btm_tip_status name=btm_tip_status>
<br>
Tipstatus Pokal BTM
<input style=\"font-family:verdana;font-size:10px;\"
type=text size=1 value=$btm_ptip_status name=btm_ptip_status>

<br>( 1=offen / 2=geschlossen )<br>
<br>
BTM Tipabgabe von Sp. &nbsp;
$btm_tip_datum 
<br>
BTM Tiprunde Pokal &nbsp;
$btm_ptip_datum <br><br>
Runde Am-Cup = $cup_btm_name[$rrunde]<br>
Runde DFB-Cup = $cup_dfb_name[$rrunde]<br>
Pokal aktiv diese Runde ? $ja[$cup_btm_aktiv]
</td>  ";

print "<td align=center><font face=verdana size=1>";
print "
<form action=/cgi-bin/btm/create_tip.pl method=post><input type=hidden name=method value=config>

Saison Nr. TMI &nbsp; 
<input style=\"font-family:verdana;font-size:10px;\" 
type=text size=1 value=$tmi_main_nr name=tmi_main_nr>
<br>
Tipabgabestatus TMI &nbsp;
<input style=\"font-family:verdana;font-size:10px;\"
type=text size=1 value=$tmi_tip_status name=tmi_tip_status>
<br>
Tipstatus Pokal TMI
<input style=\"font-family:verdana;font-size:10px;\"
type=text size=1 value=$tmi_ptip_status name=tmi_ptip_status>

<br>( 1=offen / 2=geschlossen )<br>
<br>
TMI Tipabgabe von Sp. &nbsp;
$tmi_tip_datum
<br>
TMI Tiprunde Pokal &nbsp;
$tmi_ptip_datum<br><br>
Runde Liga-Cup = $cup_tmi_name[$rrunde]<br>
Pokal aktiv diese Runde ? $ja[$cup_tmi_aktiv]

</td>  ";
print "</tr><tr><td colspan=2 align=center>EC-Runde: <select name=ec_runde>", &get_ec_selector($ec_runde),
  "</select></td>\n";

print
"</tr></table><br><input type=submit style=\"font-family:verdana;font-size:10px;\" value=\"Daten aktualisieren\"></form>";

print "<hr size=0 width=80%>";
print "<table border=1 cellpadding=15><tr>";
print "<td align=center><font face=verdana size=1>";
print "Unteres Formular als BTM<br>Formular speichern<form action=/cgi-bin/btm/create_tip.pl method=post>

Dateiname :<br><input style=\"font-family:verdana;font-size:10px;\" type=text size=15 value=\"formular", $rrunde + 1,
  ".txt\" name=datei>
<input type=hidden name=method value=save>
<input type=hidden name=system value=btm><br><input type=submit value=\"Speichern\" style=\"font-family:verdana;font-size:10px;\"></form></td>  ";

print "<td align=center><font face=verdana size=1>";
print "Unteres Formular als TMI<br>Formular speichern<form action=/cgi-bin/btm/create_tip.pl method=post>
Dateiname :<br><input style=\"font-family:verdana;font-size:10px;\" type=text size=15 value=\"formular", $rrunde + 1,
  ".txt\"
name=datei>
<input type=hidden name=method value=save>
<input type=hidden name=system value=tmi><br><input type=submit value=\"Speichern\" 
style=\"font-family:verdana;font-size:10px\">
</form></td>  ";

print "<td align=center><font face=verdana size=1>";
print "Testen!<b>
<a href=\"/cgi-bin/drucktip.pl?tm=test\" target=\"_blank\">Testansicht</a></b>
</td>  ";

print "</tr></table>";
print "<br>Offizielle Formular Dateinamen je nach Tiprunde formular1.txt bis formular9.txt<br>";

#print "<hr size=0 width=80%>";
#print "<center><a href=/cgi-bin/btm/create_tip.pl?method=grep>QUOTEN FRISCH HOLEN VON SPORTWETTEN-ONLINE.COM</a></center>";
print "<hr size=0 width=80%>";

#print "
#<form action=/cgi-bin/btm/create_tip.pl method=post><input type=hidden name=method value=grep_url>
#<input type=text style=\"font-family:verdana;font-size:10px\" size=140 name=url value=\"https://www.sportwetten-online.de/spowon/servlet/spowon?cmd=getquotedetail&jahr=2002&woche=4&spielquote=1\">";
#print "<br><input type=submit style=\"font-family:verdana;font-size:10px\" value=\"URL greppen\"></form>";
print "<hr size=0 width=80%>";

print "<p align=left>";

print
"<center>Laenderkuerzel ( = Erste Zahl jeder Spielzeile ) :<br>0 = UEFA Spiele | 1 = GER 1.BL | 2 = GER 2.BL | 3 = ENG | 
4 = FRA | 5 = ITA |<br>6 = SUI | 7 = AUT | 8 = ESP | 9 = 'weisse Fahne' | 
10 = SWE | 11 = NOR | 12 = FIN | 13 = DEN |<br> 14 = NED | 15 = SCO | 16 = WM Spiele | 17 = GER RL | 18 = RUS | 19 = POR | 20 = IRL |<br>21 = USA | 22 = ISL | 23 = BEL | 24 = UKR | 25 = TUR | 26 = POL | 27 = GRI | 28 = CZE | <br> 29 = BEL | 30 = FIFA 2014 | 31 = BRA | 32 = JPN | 33= EM2016 <br>
 34 = KOR und 35 = WRU
<br><br>
FORMAT DER ZEILEN DES TIPFORMULARS :<br>
[Laenderkuerzel Nummer]&[Vereinsname1] - [Vereinsname 2]&[QUOTE 1]&[QUOTE 0]&[QUOTE 2]&0&_ : _&[DATUM]&[UHRZEIT]&

</center><br>";
print "
<form action=/cgi-bin/btm/create_tip.pl method=post><input type=hidden name=method value=select>";
$p = 0;
open( D2, "</tmdata/formular_tmp.txt" );
while (<D2>) {
	$p++;
	$line = $_;
	chomp $line;
	$sp = "";
	if ( $p < 100 ) { $sp = "0" }
	if ( $p < 10 )  { $sp = "00" }
	print
"Spiel # $sp$p &nbsp; <input type=checkbox name=$p value=1> &nbsp; <input type=text size=100 name=inhalt$p style=\"font-family:courier new;font-size:11px;\" value=\"$line\">";
	print "<br>";
}
close(D2);

print "<br><input type=checkbox name=all value=1> Nur die Zeileninhalte aktualisieren und keine Auswahl taetigen !";
print
"<br><br><input type=hidden name=spiele value=$p><input type=submit value=\"Auswahl taetigen bzw. ggf. nur aktualisieren\"></form>";
print "<br><br>
<form action=/cgi-bin/btm/create_tip.pl method=post><input type=hidden name=method value=grep_url>

<textarea name=text rows=40 cols=80  wrap=virtual>

Anleitung zum Betbrain Screen-Capture

1) Firefox verwenden!

2) http://www.betbrain.com aufrufen. Dort links in der Leiste die interessanten Ligen aufrufen.
Vorsicht, nicht die Laender, sondern die Liga selber anwaehlen.
Dann mit STRG-A, STRG-C, STRG-V den kompletten Browserinhalt in das Textfenster hier kopieren.
Dies fuer alle Ligen wiederholen, die auf das Formular sollen.
Danach Quelltext speichern (unterster Button) druecken!
Dann muesste sich der Arbeitsbereich (oberhalb von hier) mit neuen Quoten gefuellt haben.

Schritt 2
- ggf. Arbeitsflaeche aktualisieren (Haekchen bei Nur Aktualisieren machen, dann Knopf drunter druecken
- ggf. manuelle Anpassung von Ligen-IDs, Schreibfehlern in den Vereinsnamen und krummen Quoten
- dann die gewuenschten 25 Spiele in der vorderen Checkbox markieren
- dann das Haekchen bei Nur Aktualisieren rausnehmen und den Knopf drunter druecken
- Wenn es ok aussieht, oberhalb der Arbeitsflaeche den Link Testansicht ueberpruefen.
- Wenn dann alles ok ist -> 

Schritt 3
- den richtigen Namen auswaehlen (formularX.txt mit X = 0-9 je nach Spielwochenende
- Speichern druecken und fertig!
- Jetzt noch ggf. die Spielrunde aufmachen in der Daten-aktualisiern-Box oben,  siehe howto.txt

Es ist auch eine Automatik aktiv, die sch&ouml;ne Vereinsnamen einsetzt, denn auf der gecaptureten Seite sind manchmal nur Stummel drauf. Falls die Automatik mal schiefgeht oder etwas nicht erkennt, bitte melden, dann pflege ich nach.



</textarea><br>



<br>
<table><tr><td>
<input type=radio name=parser value=baw> BetAndWin Mail Quoten <br>
<input type=radio name=parser value=gera> Gera Quoten <br> 
<input type=radio name=parser value=betbrain checked> Betbrain ScreenCapture<br>
<input type=radio name=parser value=bawscr> BetAndWin ScreenCapture<br>
</td><td id=\"optbox\">
<input type=radio name=leagueSelection value=btm>BTM Vorauswahl<br>
<input type=radio name=leagueSelection value=tmi>TMI Vorauswahl<br>
<input type=radio name=leagueSelection value=all checked>keine Vorauswahl<br>
</td></tr></table>
<br>


<input type=submit value=\"Quelltext speichern\"></form>
";

exit;

sub config {

	$btm_tip_status = $query->param('btm_tip_status');
	$tmi_tip_status = $query->param('tmi_tip_status');
	$btm_main_nr    = $query->param('btm_main_nr');
	$tmi_main_nr    = $query->param('tmi_main_nr');

	$btm_ptip_status = $query->param('btm_ptip_status');
	$tmi_ptip_status = $query->param('tmi_ptip_status');

	$ec_runde = $query->param('ec_runde');

	#$btm_tip_datum = $query->param('btm_tip_datum');
	#$tmi_tip_datum = $query->param('tmi_tip_datum');
	#$btm_ptip_datum = $query->param('btm_ptip_datum');
	#$tmi_ptip_datum = $query->param('tmi_ptip_datum');

	$run  = $query->param('run');
	$top1 = $query->param('top1');
	$top2 = $query->param('top2');

	$ende = 0;

	if ( ( $run < 1 ) or ( $run > 9 ) ) { $ende = 1 }

	if ( $ende == 1 ) {
		print "Eine Zahl hat falsches Format !";
		exit;
	}

	$btm_tip_datum = ( $run * 4 ) - 3;
	$tmi_tip_datum = ( $run * 4 ) - 3;

	$btm_ptip_datum = $cup_btm_round[$run];
	$tmi_ptip_datum = $cup_tmi_round[$run];

	open( D1, ">/tmdata/btm/tip_status.txt" );
	print D1 $btm_tip_status;
	close(D1);
	open( D1, ">/tmdata/tmi/tip_status.txt" );
	print D1 $tmi_tip_status;
	close(D1);
	open( D1, ">/tmdata/btm/main_nr.txt" );
	print D1 $btm_main_nr;
	close(D1);
	open( D1, ">/tmdata/tmi/main_nr.txt" );
	print D1 $tmi_main_nr;
	close(D1);

	open( D1, ">/tmdata/btm/tip_datum.txt" );
	print D1 $btm_tip_datum;
	close(D1);
	open( D1, ">/tmdata/tmi/tip_datum.txt" );
	print D1 $tmi_tip_datum;
	close(D1);
	open( D1, ">/tmdata/btm/pokal/tip_status.txt" );
	print D1 $btm_ptip_status;
	close(D1);
	open( D1, ">/tmdata/tmi/pokal/tip_status.txt" );
	print D1 $tmi_ptip_status;
	close(D1);
	open( D1, ">/tmdata/btm/pokal/pokal_datum.txt" );
	print D1 $btm_ptip_datum;
	close(D1);
	open( D1, ">/tmdata/tmi/pokal/pokal_datum.txt" );
	print D1 $tmi_ptip_datum;
	close(D1);
	if ($ec_runde) { open( D1, ">/tmdata/cl/runde.dat" ); print D1 $ec_runde; close(D1); }

	open( D1, ">/tmdata/rrunde.txt" );
	print D1 $run;
	close(D1);
	open( D1, ">/tmdata/top_tip.txt" );
	print D1 "$top1\n";
	print D1 $top2;
	close(D1);

	print "Location: create_tip.pl\n\n";
	exit;
}

sub save {

	$da = '/tmdata/' . $system . '/' . $datei_tf;

	open( D2, "</tmdata/formular_tmp.txt" );
	open( D1, ">$da" );
	print D1 "\n\n";
	while (<D2>) {
		print D1 $_;
	}
	close(D2);
	close(D1);
}

sub select {

	$sp = $query->param('spiele');
	for ( $x = 1 ; $x <= $sp ; $x++ ) {
		$y = $query->param("$x");
		if ( $y == 1 ) { $auswahl++ }
	}
	if ( $all != 1 ) {
		if ( $auswahl < 25 ) {
			print "Content-type:text/html\n\n";
			print "Es wurden nur $auswahl Spiele ausgewaehlt ( Minimum 25 ) !";
			exit;
		}
	}

	$x = 0;
	open( D2, ">/tmdata/formular_tmp.tmp" );
	open( D1, "</tmdata/formular_tmp.txt" );
	while (<D1>) {
		$x++;
		$y = 0;
		$y = $query->param("$x");
		if ( $all == 1 ) { $y = 1 }
		if ( $y == 1 ) {
			$inhalt = $query->param("inhalt$x");
			print D2 "$inhalt\n";
		}
	}

	#if ( $auswahl < 25 ){
	#for ($cc=$auswahl;$cc<=25;$cc++){
	#print D2 "\n";
	#}

	#}

	close(D2);
	close(D1);

	open( D2, "</tmdata/formular_tmp.tmp" );
	open( D1, ">/tmdata/formular_tmp.txt" );
	while (<D2>) {
		print D1 $_;
	}
	close(D2);
	close(D1);

}

sub quoten_grep {
	$inhalt = "";
	$at     = 0;
  here:
	$at++;
	$agentname   = "";
	$sec_timeout = 270;

	use LWP::UserAgent;
	$ua = new LWP::UserAgent;
	$ua->timeout($sec_timeout);

	if ($agentname) {
		$ua->agent($agentname);
	}

	$request = new HTTP::Request( 'GET', $url );

	$response = $ua->request($request);
	$inhalt   = $response->content;

	open( D1, ">/tmdata/sportwetten_tmp.txt" );
	print D1 "$inhalt";
	close(D1);

	open( D2, ">/tmdata/formular_tmp.txt" );
	open( D3, ">/tmdata/formular_bet.txt" );
	$spiel = 0;
	$nr    = $rrunde * 1000;
	$bet   = 0;

	open( A, "/tmdata/sportwetten_tmp.txt" );

	while (<A>) {

		if ( $_ =~ /new Array/ ) {

			while ( ( $a = <A> ) =~ "," ) {

				@all = split( /\",\"/, $a );

				if ( $all[5] =~ /Fr/ || $all[5] =~ /Sa/ || $all[5] =~ /So/ ) {
					if ( $all[13] ne "" ) {
						$nr++;
						$games[$nr][0] = $all[5];
						$games[$nr][1] = $all[3];
						$games[$nr][2] = int( $all[7] * 10 );
						$games[$nr][3] = int( $all[10] * 10 );
						$games[$nr][4] = int( $all[13] * 10 );
					}
				}

			}
		}
	}
	close(A);

	for ( $x = 0 ; $x <= $nr ; $x++ ) {
		@time = split( / /, $games[$x][0] );
		print D2 "0&$games[$x][1]&$games[$x][2]&$games[$x][3]&$games[$x][4]&0&_ : _&$time[1]&$time[2]&\n";
	}

}

close(D2);

$spiel = 0;

open( A, "form1.htm" );
while (<A>) {

	while (<A>) {

		if ( $_ =~ /new Array/ ) {

			while ( ( $a = <A> ) =~ "," ) {

				@all = split( /\",\"/, $a );

				if ( $all[5] =~ /Fr/ || $all[5] =~ /Sa/ || $all[5] =~ /So/ ) {
					if ( $all[13] ne "" ) {
						$nr++;
						$games[$nr][0] = $all[5];
						$games[$nr][1] = $all[3];
						$games[$nr][2] = int( $all[7] * 10 );
						$games[$nr][3] = int( $all[10] * 10 );
						$games[$nr][4] = int( $all[13] * 10 );
					}
				}

			}
		}
	}
	close(A);

	for ( $x = 0 ; $x <= $nr ; $x++ ) {
		@time = split( / /, $games[$x][0] );
		print D3 "0&$games[$x][1]&$games[$x][2]&$games[$x][3]&$games[$x][4]&0&_ : _&$time[1]&$time[2]&\n";
	}

	close(D3);

}

sub quoten_url {
	open( D, ">/tmdata/btm/Quoten.htm" );
	print D $text;
	close(D);

	if ( $parser eq "baw" ) {

		print "Content-type:text/html\n\n";
		print "Waz up";
		&parseBwinEmailOdds( "/tmdata/btm/Quoten.htm", "/tmdata/formular_tmp.txt" );
		print "Waz up";

		#require "/home/tm/SwToForm3.pl"; # Bodos Betandwin-Parser
	}
	elsif ( $parser eq "bawscr" ) {
		print "Content-type:text/html\n\n";
		print "Wazz down?";
		&parseBwinScreenOdds( "/tmdata/btm/Quoten.htm", "/tmdata/formular_tmp.txt" );
		print "Wazz down?";
	}
	elsif ( $parser eq "betbrain" ) {

		print "Content-type:text/html\n\n";
		print "Betbrain parsing start";

		&parseBetbrain( "/tmdata/btm/Quoten.htm", "/tmdata/formular_tmp.txt", $leagueSelection );
		print "Betbrain parsing done";
	}
	elsif ( $parser eq "stanley" ) {
		print "Content-type:text/html\n\n";
		print "Stanley parsing start";
		$leagueSelection = $query->param("leagueSelection");
		&parseStanley( "/tmdata/btm/Quoten.htm", "/tmdata/formular_tmp.txt", $leagueSelection );
		print "Stanley parsing done";

	}
	else {
		#require "/home/tm/SwToForm2.pl"; # Modified Gera-Parser
		#require "/home/tm/SwToFoBB.pl"; # Modified Gera-Parser
	}

}

sub get_ec_selector {
	my $curr = shift;

	my $ret = "<!-- come in: $curr -->";
	my @row = ( "Q1", "Q2", "Q3", "G1", "G2", "AC", "VI", "HA", "FI" );
	foreach $a_r (@row) {
		$ret .= "<OPTION value=\"$a_r\"";
		if ( $a_r eq $curr ) { $ret .= " selected"; }
		$ret .= ">$a_r</OPTION>\n";
	}
	return $ret;
}

sub info {

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

	open( D, ">/tmdata/msgs/mesg$ac_id{$trainer}.txt" );

	print D"$info\n$datum $uhr";
	close(D);
}

