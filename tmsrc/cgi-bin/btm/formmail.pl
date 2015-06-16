#!/usr/bin/perl

=head1 NAME
	BTM formmail.pl

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

$mailprog = '/usr/sbin/sendmail';

open( D7, "/tmdata/btm/tip_status.txt" );
$tip_status = <D7>;
chomp $tip_status;
close(D7);

if ( $tip_status != 1 ) {
	print "Content-type: text/html \n\n";
	print "<font face=verdana size=2><b>";
	print "Leider ist der letztmoegliche Tipabgabtermin - Freitag 18.oo Uhr - ueberschritten !";
	exit;
}

$query   = new CGI;
$mail_ja = $query->param('mail_ja');

$tipo[1]  = $query->param('30....');
$tipo[2]  = $query->param('31....');
$tipo[3]  = $query->param('32....');
$tipo[4]  = $query->param('33....');
$tipo[5]  = $query->param('34....');
$tipo[6]  = $query->param('35....');
$tipo[7]  = $query->param('36....');
$tipo[8]  = $query->param('37....');
$tipo[9]  = $query->param('38....');
$tipo[10] = $query->param('39....');
$tipo[11] = $query->param('40....');
$tipo[12] = $query->param('41....');
$tipo[13] = $query->param('42....');
$tipo[14] = $query->param('43....');
$tipo[15] = $query->param('44....');
$tipo[16] = $query->param('45....');
$tipo[17] = $query->param('46....');
$tipo[18] = $query->param('47....');
$tipo[19] = $query->param('48....');
$tipo[20] = $query->param('49....');
$tipo[21] = $query->param('50....');
$tipo[22] = $query->param('51....');
$tipo[23] = $query->param('52....');
$tipo[24] = $query->param('53....');
$tipo[25] = $query->param('54....');

$team    = $query->param('team');

&parse_form;

&check_required;

&return_html;

&send_mail;

sub parse_form {

	( $liga, $verein ) = split( /&/, $team );

	$rf = "0";
	$rx = "x";
	if ( $liga > 9 ) { $rf = "" }

	$suche = '&' . $trainer . '&';
	$f     = 0;
	open( D2, "/tmdata/btm/history.txt" );
	while (<D2>) {
		$f++;
		if ( $_ =~ /$suche/ ) {
			@lor = split( /&/, $_ );
			$liga = $f;
		}

	}
	close(D2);

	$y = 0;
	for ( $x = 1 ; $x < 19 ; $x++ ) {
		$y++;
		chomp $lor[$y];
		$data[$x] = $lor[$y];
		$y++;
		chomp $lor[$y];
		$datb[$x] = $lor[$y];

		if ( $datb[$x] eq $trainer ) { $verein = $x }

		$y++;
		chomp $lor[$y];
		$datc[$x] = $lor[$y];
	}

	open( D9, "/tmdata/btm/spieltag.txt" );
	while (<D9>) {
		@ego = <D9>;
	}
	close(D9);

	open( D7, "/tmdata/btm/tip_datum.txt" );
	$spielrunde_ersatz = <D7>;
	chomp $spielrunde_ersatz;
	close(D7);

	$bx         = "/tmdata/btm/formular";
	$by         = int( ( $spielrunde_ersatz + 3 ) / 4 );
	$bv         = ".txt";
	$datei_hier = $bx . $by . $bv;

	open( DO, $datei_hier );
	while (<DO>) {
		@ver = <DO>;
	}
	close(DO);

	$y = 0;
	for ( $x = 0 ; $x < 25 ; $x++ ) {
		$y++;
		chomp $ver[$y];
		@ega = split( /&/, $ver[$y] );
		$paarung[$y]  = $ega[1];
		$qu_1[$y]     = $ega[2];
		$qu_0[$y]     = $ega[3];
		$qu_2[$y]     = $ega[4];
		$ergebnis[$y] = $ega[5];
	}

	$rg = 0;

	$ax = $spielrunde_ersatz - 1;
	$ay = $spielrunde_ersatz + 3;

	if ( $ay == 36 ) { $ay = 34 }

	for ( $spieltag = $ax ; $spieltag < $ay ; $spieltag++ ) {

		$rg++;
		@ega = split( /&/, $ego[$spieltag] );

		chop $quoten_row[$spieltag];

		for ( $x = 0 ; $x < 18 ; $x = $x + 1 ) {
			if ( $datb[ $ega[$x] ] eq $trainer ) { $id = $x }
		}

		$ein = 0;
		for ( $x = 0 ; $x < 18 ; $x = $x + 2 ) {
			if ( $datb[ $ega[$x] ] eq $trainer ) { $ein = 1 }
		}
		if ( $ein == 1 ) { $hier_ort[$rg]    = "H" }
		if ( $ein == 0 ) { $hier_ort[$rg]    = "A" }
		if ( $ein == 1 ) { $hier_gegner[$rg] = $data[ $ega[ $id + 1 ] ] }
		if ( $ein == 0 ) { $hier_gegner[$rg] = $data[ $ega[ $id - 1 ] ] }

		$aa = 0;
		$ab = 0;
		$ac = 0;
		$ad = 0;

		for ( $x = 1 ; $x < 26 ; $x++ ) {
			chomp $tipo[$x];
			( $ca[$x], $cb[$x] ) = split( /&/, $tipo[$x] );

		}

		for ( $x = 1 ; $x < 26 ; $x++ ) {
			if ( $ca[$x] == 1 ) {
				$aa++;
				$pro1[$aa] = $cb[$x];
				$sp1[$aa]  = $x;

			}
			if ( $ca[$x] == 2 ) {
				$ab++;
				$pro2[$ab] = $cb[$x];
				$sp2[$ab]  = $x;
			}
			if ( $ca[$x] == 3 ) {
				$ac++;
				$pro3[$ac] = $cb[$x];
				$sp3[$ac]  = $x;
			}
			if ( $ca[$x] == 4 ) {
				$ad++;
				$pro4[$ad] = $cb[$x];
				$sp4[$ad]  = $x;
			}
		}

	}

}

sub check_required {

	local ( $require, @error );

	if ( ( $hier_ort[1] eq "H" ) and ( $aa != 5 ) ) { &error }
	if ( ( $hier_ort[1] eq "A" ) and ( $aa != 4 ) ) { &error }
	if ( ( $hier_ort[2] eq "H" ) and ( $ab != 5 ) ) { &error }
	if ( ( $hier_ort[2] eq "A" ) and ( $ab != 4 ) ) { &error }
	if ( ( $hier_ort[3] eq "H" ) and ( $ac != 5 ) ) { &error }
	if ( ( $hier_ort[3] eq "A" ) and ( $ac != 4 ) ) { &error }
	if ( ( $hier_ort[4] eq "H" ) and ( $ad != 5 ) ) { &error }
	if ( ( $hier_ort[4] eq "A" ) and ( $ad != 4 ) ) { &error }

}

sub return_html {

	# Print HTTP header and opening HTML tags.                           #

	print "Content-type: text/html\n\n";
	@line = ();

	$suche = ( ( $liga - 1 ) * 18 ) + $verein;
	$log   = ( ( $liga - 1 ) * 18 ) + $verein;

	$cc = "0";
	if ( $suche < 100 )  { $suche = $cc . $suche }
	if ( $suche < 10 )   { $suche = $cc . $suche }
	if ( $suche < 1000 ) { $suche = $cc . $suche }

	$ax = "Ihr Tip wurde ans uns gesendet .";

	$datei = '/tmdata/btm/tips/' . $spielrunde_ersatz . '/' . $suche . '.txt';

	open( MAIL, ">$datei" );
	flock( MAIL, 2 );
	print MAIL "$suche#";
	for ( $x = 1 ; $x < 26 ; $x++ ) {
		$y = ",";
		if ( $x == 25 ) { $y = "" }
		if ( $tipo[$x] eq "0&0" ) { print MAIL "0&0." }
		if ( $tipo[$x] eq "1&1" ) { print MAIL "1&1." }
		if ( $tipo[$x] eq "1&2" ) { print MAIL "1&2." }
		if ( $tipo[$x] eq "1&3" ) { print MAIL "1&3." }
		if ( $tipo[$x] eq "2&1" ) { print MAIL "2&1." }
		if ( $tipo[$x] eq "2&2" ) { print MAIL "2&2." }
		if ( $tipo[$x] eq "2&3" ) { print MAIL "2&3." }
		if ( $tipo[$x] eq "3&1" ) { print MAIL "3&1." }
		if ( $tipo[$x] eq "3&2" ) { print MAIL "3&2." }
		if ( $tipo[$x] eq "3&3" ) { print MAIL "3&3." }
		if ( $tipo[$x] eq "4&1" ) { print MAIL "4&1." }
		if ( $tipo[$x] eq "4&2" ) { print MAIL "4&2." }
		if ( $tipo[$x] eq "4&3" ) { print MAIL "4&3." }
	}
	print MAIL "\n";
	flock( MAIL, 8 );
	close(MAIL);

	print "<html><title>Tipabgabe erfolgreich</title><p align=left><body bgcolor=white text=black>\n";

	require "/tmapp/tmsrc/cgi-bin/tag.pl";
	require "/tmapp/tmsrc/cgi-bin/tag_small.pl";
	require "/tmapp/tmsrc/cgi-bin/runde.pl";

	print "<br><br>\n";
	print "<form name=daten method=post action=/cgi-bin/btm/daten/daten.pl target=_top></form>\n";
	print "<font face=verdana size=2 color=black><b>\n";
	print ">> Tipabgabe - Antwortseite<br><br></b>";

	print "<font face=verdana size=3 color=green><b>\n";
	print "Die Tipabgabe hat geklappt !<br><br></b>";

	print "<font face=verdana size=2 color=black><b>\n";
	print
"Vielen Dank $trainer fuer Ihre Tipabgabe<br>fuer Ihren Verein $data[$verein] !</b><br><font size=1><br>Bis Freitag 18.oo Uhr koennen Sie ihren Tip noch aendern .<br>\n";
	print "<font color=black>


Achtung : Bitte besuchen Sie nach Ihrer Tipabgabe erneut den<br>Tipabgabe - Bereich um zu pruefen ob Ihr Tip registriert wurde .<br>";

	print
"<font face=verdana size=1 color=black><br>&nbsp;Auch keine Tipabgabe fuer relevante<br>&nbsp;und anstehende Pokalrunden vergessen ? <br>
<br>&nbsp;<font size=2><a href=/cgi-bin/cup_time.pl target=_new>Blick auf den Rahmenterminkalender</a> <br><br>";

	if ( $mail_ja == 1 ) {
		print
"<font size=1>&nbsp;Ihr Tip wurde Ihnen auch an folgende E-Mail Adresse gemailt :<br><font color=darkred>&nbsp;$mail_adresse<font color=black>&nbsp;&nbsp; [ -> <a href=javascript:document.daten.submit()>E-Mail Adresse aendern</a> ]<br><br>";
	}
	print "
&nbsp;<font color=darkred>Achtung : Bitte besuchen Sie nach Ihrer Tipabgabe erneut den<br>&nbsp;Tipabgabe - Bereich um zu pruefen ob Ihr Tip registriert wurde .<br><br>";

	print
"<br><form method=post action=/cgi-mod/btm/login.pl target=_top><input type=image src=/img/men_sta.gif border=0></form>\n";
	print "<p align=left><hr size=0 width=100%><br>";
}

sub send_mail {
	%mail  = ();
	$topic = $data[$verein];

	$mail{Message} =
	  "*** Tipabgabe Bundesliga - TipMaster [ Tiprunde $rrunde / 9 ] ***        http://www.tipmaster.de \n\n";
	$mail{Message} .= "Tipabgabe $topic  ( Trainer $trainer )  \n\n";

	$mail{Message} .= "*************************************************************************\n";
	$mail{Message} .= "Sportingbet.com - 100% Einzahlungsbonus bis zu 100 Euro!\n";
	$mail{Message} .= "[http://ad-emea.doubleclick.net/clk;227424770;51590056;f]\n";
	$mail{Message} .= "*************************************************************************\n";

#$mail{Message} .=  "Nutzen Sie unseren neuen Live - Ergebnisservice um 7 Tage die Woche \n";
#$mail{Message} .=  "und 24 Stunden rund um die Uhr immer die aktuellen Zwischenstaende\n";
#$mail{Message} .=  "und Ergebnisse der internationalen Ligen zu bekommen !\nBesuchen Sie http://www.live-resultate.net/ !\n\n";

	for ( $x = 1 ; $x < 6 ; $x++ ) {
		$pre1[$x] = $pro1[$x];
		if ( $pre1[$x] == 2 ) { $pre1[$x] = 0 }
		if ( $pre1[$x] == 3 ) { $pre1[$x] = 2 }

		$pre2[$x] = $pro2[$x];
		if ( $pre2[$x] == 2 ) { $pre2[$x] = 0 }
		if ( $pre2[$x] == 3 ) { $pre2[$x] = 2 }

		$pre3[$x] = $pro3[$x];
		if ( $pre3[$x] == 2 ) { $pre3[$x] = 0 }
		if ( $pre3[$x] == 3 ) { $pre3[$x] = 2 }

		$pre4[$x] = $pro4[$x];
		if ( $pre4[$x] == 2 ) { $pre4[$x] = 0 }
		if ( $pre4[$x] == 3 ) { $pre4[$x] = 2 }

	}

	if ( ( $hier_ort[1] ne "" ) ) {
		$ss = $spielrunde_ersatz + 0;

		$mail{Message} .= "\n$ss.Spieltag  :  $hier_ort[1]  - $hier_gegner[1]\n";
		$aa1 = 0;
		$aa2 = 0;
		$aa3 = 0;
		$aa4 = 0;

		$mail{Message} .= "---------------------------------------------------\n";
		for ( $x = 1 ; $x <= $aa ; $x++ ) {
			if ( $pre1[$x] == 1 ) {
				$aa1 += $qu_1[ $sp1[$x] ];
				$mail{Message} .= "Tip $pre1[$x] | Quote $qu_1[$sp1[$x]] | $paarung[$sp1[$x]] \n";
			}
			if ( $pre1[$x] == 0 ) {
				$aa1 += $qu_0[ $sp1[$x] ];
				$mail{Message} .= "Tip $pre1[$x] | Quote $qu_0[$sp1[$x]] | $paarung[$sp1[$x]] \n";
			}
			if ( $pre1[$x] == 2 ) {
				$aa1 += $qu_2[ $sp1[$x] ];
				$mail{Message} .= "Tip $pre1[$x] | Quote $qu_2[$sp1[$x]] | $paarung[$sp1[$x]] \n";
			}
		}
		$mail{Message} .= "---------------------------------------------------\n";
		$tmp = $aa1;
		if ( $tmp > 14 )  { $dd = 15;  $tora = 1 }
		if ( $tmp > 39 )  { $dd = 40;  $tora = 2 }
		if ( $tmp > 59 )  { $dd = 60;  $tora = 3 }
		if ( $tmp > 79 )  { $dd = 80;  $tora = 4 }
		if ( $tmp > 104 ) { $dd = 105; $tora = 5 }
		if ( $tmp > 129 ) { $dd = 130; $tora = 6 }
		if ( $tmp > 154 ) { $dd = 155; $tora = 7 }
		$mail{Message} .= "Max. Summe  : $aa1 [ = $tora Tore | Torgrenze bei $dd ]\n\n";
	}

	if ( ( $hier_ort[2] ne "" ) ) {
		$ss = $spielrunde_ersatz + 1;
		$mail{Message} .= "\n$ss.Spieltag  :  $hier_ort[2]  - $hier_gegner[2]  \n";
		$mail{Message} .= "---------------------------------------------------\n";
		for ( $x = 1 ; $x <= $ab ; $x++ ) {
			if ( $pre2[$x] == 1 ) {
				$aa2 += $qu_1[ $sp2[$x] ];
				$mail{Message} .= "Tip $pre2[$x] | Quote $qu_1[$sp2[$x]] | $paarung[$sp2[$x]] \n";
			}
			if ( $pre2[$x] == 0 ) {
				$aa2 += $qu_0[ $sp2[$x] ];
				$mail{Message} .= "Tip $pre2[$x] | Quote $qu_0[$sp2[$x]] | $paarung[$sp2[$x]] \n";
			}
			if ( $pre2[$x] == 2 ) {
				$aa2 += $qu_2[ $sp2[$x] ];
				$mail{Message} .= "Tip $pre2[$x] | Quote $qu_2[$sp2[$x]] | $paarung[$sp2[$x]] \n";
			}
		}
		$mail{Message} .= "---------------------------------------------------\n";
		$tmp = $aa2;
		if ( $tmp > 14 )  { $dd = 15;  $tora = 1 }
		if ( $tmp > 39 )  { $dd = 40;  $tora = 2 }
		if ( $tmp > 59 )  { $dd = 60;  $tora = 3 }
		if ( $tmp > 79 )  { $dd = 80;  $tora = 4 }
		if ( $tmp > 104 ) { $dd = 105; $tora = 5 }
		if ( $tmp > 129 ) { $dd = 130; $tora = 6 }
		if ( $tmp > 154 ) { $dd = 155; $tora = 7 }
		$mail{Message} .= "Max. Summe  : $aa2 [ = $tora Tore | Torgrenze bei $dd ]\n\n";
	}

	if ( ( $hier_ort[3] ne "" ) ) {
		$ss = $spielrunde_ersatz + 2;
		$mail{Message} .= "\n$ss.Spieltag  :  $hier_ort[3]  - $hier_gegner[3]\n";

		$mail{Message} .= "---------------------------------------------------\n";
		for ( $x = 1 ; $x <= $ac ; $x++ ) {
			if ( $pre3[$x] == 1 ) {
				$aa3 += $qu_1[ $sp3[$x] ];
				$mail{Message} .= "Tip $pre3[$x] | Quote $qu_1[$sp3[$x]] | $paarung[$sp3[$x]] \n";
			}
			if ( $pre3[$x] == 0 ) {
				$aa3 += $qu_0[ $sp3[$x] ];
				$mail{Message} .= "Tip $pre3[$x] | Quote $qu_0[$sp3[$x]] | $paarung[$sp3[$x]] \n";
			}
			if ( $pre3[$x] == 2 ) {
				$aa3 += $qu_2[ $sp3[$x] ];
				$mail{Message} .= "Tip $pre3[$x] | Quote $qu_2[$sp3[$x]] | $paarung[$sp3[$x]] \n";
			}
		}
		$mail{Message} .= "---------------------------------------------------\n";
		$tmp = $aa3;
		if ( $tmp > 14 )  { $dd = 15;  $tora = 1 }
		if ( $tmp > 39 )  { $dd = 40;  $tora = 2 }
		if ( $tmp > 59 )  { $dd = 60;  $tora = 3 }
		if ( $tmp > 79 )  { $dd = 80;  $tora = 4 }
		if ( $tmp > 104 ) { $dd = 105; $tora = 5 }
		if ( $tmp > 129 ) { $dd = 130; $tora = 6 }
		if ( $tmp > 154 ) { $dd = 155; $tora = 7 }
		$mail{Message} .= "Max. Summe  : $aa3 [ = $tora Tore | Torgrenze bei $dd ]\n\n";
	}

	if ( ( $hier_ort[4] ne "" ) ) {
		$ss = $spielrunde_ersatz + 3;
		$mail{Message} .= "\n$ss.Spieltag  :  $hier_ort[4]  - $hier_gegner[4] \n";

		$mail{Message} .= "---------------------------------------------------\n";

		for ( $x = 1 ; $x <= $ad ; $x++ ) {
			if ( $pre4[$x] == 1 ) {
				$aa4 += $qu_1[ $sp4[$x] ];
				$mail{Message} .= "Tip $pre4[$x] | Quote $qu_1[$sp4[$x]] | $paarung[$sp4[$x]] \n";
			}
			if ( $pre4[$x] == 0 ) {
				$aa4 += $qu_0[ $sp4[$x] ];
				$mail{Message} .= "Tip $pre4[$x] | Quote $qu_0[$sp4[$x]] | $paarung[$sp4[$x]] \n";
			}
			if ( $pre4[$x] == 2 ) {
				$aa4 += $qu_2[ $sp4[$x] ];
				$mail{Message} .= "Tip $pre4[$x] | Quote $qu_2[$sp4[$x]] | $paarung[$sp4[$x]] \n";
			}
		}
		$mail{Message} .= "---------------------------------------------------\n";
		$tmp = $aa4;
		if ( $tmp > 14 )  { $dd = 15;  $tora = 1 }
		if ( $tmp > 39 )  { $dd = 40;  $tora = 2 }
		if ( $tmp > 59 )  { $dd = 60;  $tora = 3 }
		if ( $tmp > 79 )  { $dd = 80;  $tora = 4 }
		if ( $tmp > 104 ) { $dd = 105; $tora = 5 }
		if ( $tmp > 129 ) { $dd = 130; $tora = 6 }
		if ( $tmp > 154 ) { $dd = 155; $tora = 7 }
		$mail{Message} .= "Max. Summe  : $aa4 [ = $tora Tore | Torgrenze bei $dd ]\n\n";
	}
	$mail{Message} .= "\n\nNutzen Sie den spannenden Live - Service beim Bundesliga - TipMaster !\n";
	$mail{Message} .= "Ab sofort koennen Sie am Wochenende auf den Resultatseiten die \n";
	$mail{Message} .= "Zwischenergebnisse ihrer Partien einsehen und damit live mitfiebern .\n";

	if ( $mail_ja == 1 ) {
		open( MAIL, "|$mailprog -t" );

		print MAIL "To: $mail_adresse\n";
		print MAIL "From: noreply\@tipmaster.de\n";

		$sp1 = ( ( $rrunde - 1 ) * 4 ) + 1;
		$sp2 = $sp1 + 3;
		if ( $sp2 > 34 ) { $sp2 = 34 }

		print MAIL "Subject: [BTM] Tipabgabe $topic [ Sp. $sp1 bis $sp2 ]\n\n";
		print MAIL "$mail{Message}";
		close(MAIL);
	}

	$mail{Message} =~ s/\n/\n<br>/g;
	print "<font face=courier size=2 color=black>Ihre Tipabgabe zum Drucken :<br>
<br>$mail{Message}";

}

sub error {

	print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>BTM - Tipabgabe : Spielauswahl nicht korrekt</title>
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

	if ( ( $hier_ort[1] eq "H" ) and ( $aa != 5 ) ) {
		print "<font face=verdana size=1>";
		$ss = $spielrunde_ersatz + 0;
		print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Heimspiel gegen  $hier_gegner[1].<br>";
		print "An diesem Spieltag sind Ihnen also 5 Tips anstatt denen von Ihnen gewaehlten $aa Tips gestattet<br><br>";
	}
	if ( ( $hier_ort[1] eq "A" ) and ( $aa != 4 ) ) {
		print "<font face=verdana size=1>";
		$ss = $spielrunde_ersatz + 0;
		print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Auswaertsspiel gegen  $hier_gegner[1] .<br>";
		print
		  "An diesem Spieltag sind Ihnen also 4 Tips anstatt denen von Ihnen gewaehlten $aa Tips gestattet .<br><br>";
	}
	if ( ( $hier_ort[2] eq "H" ) and ( $ab != 5 ) ) {
		print "<font face=verdana size=1>";
		$ss = $spielrunde_ersatz + 1;
		print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Heimspiel gegen  $hier_gegner[2].<br>";
		print
		  "An diesem Spieltag sind Ihnen also 5 Tips anstatt denen von Ihnen gewaehlten $ab Tips gestattet .<br><br>";
	}
	if ( ( $hier_ort[2] eq "A" ) and ( $ab != 4 ) ) {
		print "<font face=verdana size=1>";
		$ss = $spielrunde_ersatz + 1;
		print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Auswaertsspiel gegen  $hier_gegner[2]<br>";
		print
		  "An diesem Spieltag sind Ihnen also 4 Tips anstatt denen von Ihnen gewaehlten $ab Tips gestattet .<br><br>";
	}
	if ( ( $hier_ort[3] eq "H" ) and ( $ac != 5 ) ) {
		print "<font face=verdana size=1>";
		$ss = $spielrunde_ersatz + 2;
		print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Heimspiel gegen  $hier_gegner[3]<br>";
		print
		  "An diesem Spieltag sind Ihnen also 5 Tips anstatt denen von Ihnen gewaehlten $ac Tips gestattet .<br><br>";
	}
	if ( ( $hier_ort[3] eq "A" ) and ( $ac != 4 ) ) {
		print "<font face=verdana size=1>";
		$ss = $spielrunde_ersatz + 2;
		print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Auswaertsspiel gegen  $hier_gegner[3].<br>";
		print
		  "An diesem Spieltag sind Ihnen also 4 Tips anstatt denen von Ihnen gewaehlten $ac Tips gestattet .<br><br>";
	}
	if ( ( $hier_ort[4] eq "H" ) and ( $ad != 5 ) ) {
		print "<font face=verdana size=1>";
		$ss = $spielrunde_ersatz + 3;
		print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Heimspiel gegen  $hier_gegner[4].<br>";
		print
		  "An diesem Spieltag sind Ihnen also 5 Tips anstatt denen von Ihnen gewaehlten $ad Tips gestattet .<br><br>";
	}
	if ( ( $hier_ort[4] eq "A" ) and ( $ad != 4 ) ) {
		print "<font face=verdana size=1>";
		$ss = $spielrunde_ersatz + 3;
		print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Auswaertsspiel gegen  $hier_gegner[4].<br>";
		print
		  "An diesem Spieltag sind Ihnen also 4 Tips anstatt denen von Ihnen gewaehlten $ad Tips gestattet .<br><br>";
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

	exit;
}

