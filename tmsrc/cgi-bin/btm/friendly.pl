#!/usr/bin/perl

=head1 NAME
	BTM friendly.pl

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
$query     = new CGI;
$such      = $query->param('suche');
$method    = $query->param('method');
$heim      = $query->param('heim');
$akt_runde = $query->param('akt_runde');
$huni      = $query->param('huni');

$gegner       = $query->param('gegner');
$gegner_n     = $query->param('gegner_n');
$id           = $query->param('id');
$runde        = $query->param('runde');
$verein_suche = $query->param('verein_suche');
$suche_ja     = $query->param('suche_ja');

require "/tmapp/tmsrc/cgi-bin/btm_ligen.pl";
require "/tmapp/tmsrc/cgi-bin/runde.pl";

print "Content-Type: text/html \n\n";

if ( $method eq "eintragen" )        { &eintragen }
if ( $method eq "eintragen_gegner" ) { &eintragen_gegner }
if ( $method eq "abgeben" )          { &abgeben }
if ( $method eq "abgeben_gegner" )   { &abgeben_gegner }
if ( $method eq "liste" )            { &liste }

$s    = 0;
$liga = 0;
open( D1, "</tmdata/btm/history.txt" );
while (<D1>) {
	$liga++;
	@lines = ();
	@lines = split( /&/, $_ );
	$y     = 0;
	for ( $x = 1 ; $x <= 18 ; $x++ ) {
		$ax = 0;
		$s++;
		$y++;
		$data[$s]   = $lines[$y];
		$liga[$s]   = $liga;
		$verein[$s] = $x;

		if ( $data[$s] =~ /$such/i ) {
			$hit++;
			$hit_art[$hit] = "V";
			$ax            = 1;
			$hit_nr[$hit]  = $s;
		}

		$y++;
		$datb[$s] = $lines[$y];
		$y++;

		if ( $datb[$s] eq $trainer ) {
			$team = $data[$s];
		}

		if ( $datb[$s] =~ /$such/i ) {

			if ( $ax == 0 ) {
				$hit_art[$hit] = "T";
				$hit++;
			}

			if ( $ax == 1 ) { $hit_art[$hit] = "VT" }

			$ax = 1;
			$hit_nr[$hit] = $s;
		}

		if ( $ort{"$datb[$s]"} =~ /$such/i ) {

			if ( $ax == 0 ) {
				$hit_art[$hit] = "T";
				$hit++;
			}

			if ( $ax == 1 ) { $hit_art[$hit] = "VT" }

			$ax = 1;
			$hit_nr[$hit] = $s;
		}

	}

}
close(D1);
print "<body bgcolor=#eeeeee text=black>\n";

print "<title>TipMaster Freundschaftsspiel</title>\n";

require "/tmapp/tmsrc/cgi-bin/tag.pl";
require "/tmapp/tmsrc/cgi-bin/tag_small.pl";
print "<br>\n";
require "/tmapp/tmsrc/cgi-bin/loc.pl";

print "<font face=verdana size=2><br>\n";
print "&nbsp;<b>Bundesliga - TipMaster Freundschaftsspiele</b><br><br>\n";
print
"<font size=1> &nbsp; <a href=/cgi-bin/btm/friendly.pl?method=liste>Bereits fixe Freundschaftsspiele diese Woche</a><br><br>\n";
print "<br><font size=2><font color=darkred><b> &nbsp; ~ Freundschaftspiel Angebot unterbreiten </b>\n";
print
"<br><br><font color=black size=1> &nbsp; Suchen Sie nach dem Verein / Trainer gegen den Sie ein Freundschaftspiel bestreiten wollen :<br><br>\n";

print "<font face=verdana size=1>\n";

print "<form action=/cgi-bin/btm/friendly.pl method=post>\n";
print "<input type=hidden name=method value=\"suche\">\n";

print
"&nbsp;&nbsp;<input type=text name=suche style=\"font-family=verdana;font-size=10px\" value=\"$such\" maxlength=25>\n";
print "<input style=\"font-family=verdana;font-size=10px\"  type=submit value=\"Verein / Trainer Suchen\">\n";
print "</form>\n";

print "<font face=verdana size=1>\n";

if ( ( $such eq "" ) or ( $such eq " " ) or ( $such eq "." ) ) {
	print "&nbsp; Sie haben keinen Suchbegriff angegeben ...<br><br>\n";
	goto jo;

}

if ( $hit > 100 ) {
	print
"&nbsp; Ihr Suchbegriff '$such' ergab mehr als 100 Treffer ...<br>&nbsp; Bitte konkrtisieren Sie Ihren Begriff ...<br>\n";
	goto jo;

}

if ( $hit == 0 ) {
	print "&nbsp; Der Suchbegriff '$such' ergab keine Treffer ...<br><br>\n";
	goto jo;

}
else {
	print "&nbsp; Der Suchbegriff '$such' ergab $hit Treffer ...<br><br>\n";
}

print "<table border=0>\n";

for ( $x = 1 ; $x <= $hit ; $x++ ) {

	print "<tr>\n";

	print "<form name=g$x action=/cgi-bin/btm/verein.pl method=post>\n";

	print "<input type=hidden name=li value=\"$liga[$hit_nr[$x]]\">\n";
	print "<input type=hidden name=ve value=\"$verein[$hit_nr[$x]]\">\n";

	$geg = $data[ $hit_nr[$x] ];

	if ( $data[ $hit_nr[$x] ] =~ /($such)/i ) {
		( $teil1, $teil2 ) = split( /$such/i, $data[ $hit_nr[$x] ] );

		print
"<td align=left bgcolor=#cbccff><font face=verdana size=1>&nbsp;&nbsp;<a href=javascript:document.g$x.submit()><img src=/img/h1.jpg border=0 alt=\"Vereinsseite $data[$hit_nr[$x]]\"></a>&nbsp;&nbsp;$teil1<font color=red>$1<font color=black>$teil2&nbsp;&nbsp;&nbsp;</td>\n";

	}
	else {
		print
"<td align=left bgcolor=#cbccff><font face=verdana size=1>&nbsp;&nbsp;<a href=javascript:document.g$x.submit()><img src=/img/h1.jpg border=0 alt=\"Vereinsseite $data[$hit_nr[$x]]\"></a>&nbsp;&nbsp;$data[$hit_nr[$x]]&nbsp;&nbsp;&nbsp;</td>\n";
	}

	print "</form>\n";

	open( D2, "/tmdata/btm/heer.txt" );
	while (<D2>) {
		if ( $_ =~ /$data[$hit_nr[$x]]/ ) {
			( $platz, $rest ) = split( /&/, $_ );
		}
	}
	close(D2);
	print
"<td align=left bgcolor=#CCCDF4><font face=verdana size=1>&nbsp;&nbsp;$liga_namen[$liga[$hit_nr[$x]]]&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";
	print
	  "<td align=right bgcolor=#CCCDF4><font face=verdana size=1>&nbsp;&nbsp;$platz. Platz&nbsp;&nbsp;&nbsp;</td>\n";

	print "<form name=h$x action=/cgi-mod/btm/trainer.pl method=post>\n";

	print "<input type=hidden name=ident value=\"$datb[$hit_nr[$x]]\">\n";
	print "<input type=hidden name=liga value=\"$liga[$hit_nr[$x]]\">\n";
	print "<input type=hidden name=verein value=\"$verein[$hit_nr[$x]]\">\n";

	$geg_n = $datb[ $hit_nr[$x] ];

	$flag = "tip_no.JPG";

	if ( $land{ $datb[ $hit_nr[$x] ] } eq "Deutschland" ) { $flag = "tip_ger.JPG" }
	if ( $land{ $datb[ $hit_nr[$x] ] } eq "Oesterreich" ) { $flag = "tip_aut.JPG" }
	if ( $land{ $datb[ $hit_nr[$x] ] } eq "Schweiz" )     { $flag = "tip_swi.JPG" }
	if ( $land{ $datb[ $hit_nr[$x] ] } eq "England" )     { $flag = "tip_eng.JPG" }
	if ( $land{ $datb[ $hit_nr[$x] ] } eq "Niederlande" ) { $flag = "tip_ned.JPG" }

	if ( $datb[ $hit_nr[$x] ] =~ /($such)/i ) {
		( $teil1, $teil2 ) = split( /$such/i, $datb[ $hit_nr[$x] ] );

		print
"<td align=left bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;<a href=javascript:document.h$x.submit()><img src=/img/h1.jpg border=0 alt=\"Trainerprofil $datb[$hit_nr[$x]]\"></a>&nbsp;&nbsp;<img src=/img/$flag>&nbsp;&nbsp;$teil1<font color=red>$1<font color=black>$teil2&nbsp;&nbsp;&nbsp;</td>\n";

	}
	else {
		print
"<td align=left bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;<a href=javascript:document.h$x.submit()><img src=/img/h1.jpg border=0 alt=\"Trainerprofil $datb[$hit_nr[$x]]\"></a>&nbsp;&nbsp;<img src=/img/$flag>&nbsp;&nbsp;$datb[$hit_nr[$x]]&nbsp;&nbsp;&nbsp;</td>\n";
	}

	print "</form>\n";

	if ( $ort{ $datb[ $hit_nr[$x] ] } =~ /($such)/i ) {
		( $teil1, $teil2 ) = split( /$such/i, $ort{ $datb[ $hit_nr[$x] ] } );

	}
	else {

	}

	print "<form name=i$x action=/cgi-bin/btm/friendly.pl method=post>\n";

	print "<input type=hidden name=heim value=\"$team\">\n";
	print "<input type=hidden name=gegner value=\"$geg\">\n";
	print "<input type=hidden name=gegner_n value=\"$geg_n\">\n";
	print "<input type=hidden name=method value=\"eintragen\">\n";

	if ( ( $datb[ $hit_nr[$x] ] ne "Trainerposten frei" ) and ( $team ne $data[ $hit_nr[$x] ] ) ) {
		print
"<td align=left bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;<a href=javascript:document.i$x.submit()>zum Freundschaftsspiel einladen</a>&nbsp;&nbsp;</td>\n";
	}
	else {
		print
"<td align=left bgcolor=white><font face=verdana size=1>&nbsp;&nbsp;Freundschaftsspiel nicht moeglich&nbsp;&nbsp;</td>\n";
	}
	print "</form>\n";

	print "</tr>\n";
}

print "</table>\n";

jo:
print "<br><hr size=0 width=80%>";

open( D2, "/tmdata/btm/heer.txt" );
while (<D2>) {
	@so = split( /&/, $_ );
	$r1{ $so[5] } = $so[0];
	$r2{ $so[5] } = $so[1];

}
close(D2);
require "/tmapp/tmsrc/cgi-bin/runde.pl";
print
"<br><font size=2><font color=darkred><b> &nbsp; ~ Eingegangene Freundschaftspiel Angebote dieser Tiprunde: </b><font color=black><br><br>\n";

open( D1, "</tmdata/btm/friendly/friendly.txt" );
while (<D1>) {
	@all = split( /#/, $_ );
	if ( $all[3] eq $team ) {
		if ( $all[1] == $rrunde ) {
			$sp_a++;
			$li_a[$sp_a] = $_;
		}
	}
}
close(D1);

if ( $sp_a == 0 ) {
	print "<font face=verdana size=1> Es sind noch keine Freundschaftsspiel Angebote eingegangen<br><br>";
}

if ( $sp_a > 0 ) {

	for ( $x = 1 ; $x <= $sp_a ; $x++ ) {
		@all = split( /#/, $li_a[$x] );

		if ( ( $all[5] eq "tips gegner" ) and ( $rrunde == $all[1] ) ) {

			print "<form name=tip$all[0] action=/cgi-bin/btm/friendly.pl method=post>\n";

			print "<input type=hidden name=id value=\"$all[0]\">\n";
			print "<input type=hidden name=heim value=\"$all[2]\">\n";

			print "<input type=hidden name=gegner value=\"$all[3]\">\n";
			print "<input type=hidden name=gegner_n value=\"$trainer\">\n";
			print "<input type=hidden name=method value=\"eintragen_gegner\">\n";

			if ( $all[1] == $rrunde ) {
				print
"[ Tiprunde $all[1] ] &nbsp; $all[2] ( $liga_kuerzel[$r2{$all[2]}] / $r1{$all[2]}. ) - $all[3] ( $liga_kuerzel[$r2{$all[3]}] / $r1{$all[3]}. ) [ -> <a href=javascript:document.tip$all[0].submit()>Zur Tipabgabe</a> ]<br>";
			}

			print "</form>";
		}

		elsif ( ( $all[5] ne "tips gegner" ) and ( $rrunde == $all[1] ) ) {
			print
"[ Tiprunde $all[1] ] &nbsp; $all[2] ( $liga_kuerzel[$r2{$all[2]}] / $r1{$all[2]}. ) - $all[3] ( $liga_kuerzel[$r2{$all[3]}] / $r1{$all[3]}. ) [ -> Tip getaetigt ]<br>";
		}

		else {
			print
"[ Tiprunde $all[1] ] &nbsp; $all[2] ( $liga_kuerzel[$r2{$all[2]}] / $r1{$all[2]}. ) - $all[3] ( $liga_kuerzel[$r2{$all[3]}] / $r1{$all[3]}. )<br>";

		}

	}

}

print "<br><hr size=0 width=80%>";

print
"<br><font size=2><font color=darkred><b> &nbsp; ~ Rausgeschickte Freundschaftspiel Angebote dieser Tiprunde: </b><br><br><font color=black>\n";

open( D1, "</tmdata/btm/friendly/friendly.txt" );
while (<D1>) {
	@all = split( /#/, $_ );
	if ( $all[2] eq $team ) {
		if ( $all[1] == $rrunde ) {
			$sp_b++;
			$li_b[$sp_b] = $_;
		}
	}
}
close(D1);

if ( $sp_b == 0 ) {
	print "<font face=verdana size=1> Es sind noch keine Freundschaftsspiel Angebote eingegangen<br><br>";
}

if ( $sp_b > 0 ) {

	for ( $x = 1 ; $x <= $sp_b ; $x++ ) {
		@all = split( /#/, $li_b[$x] );

		if ( ( $all[5] eq "tips gegner" ) ) {
			print
"[ Tiprunde $all[1] ] &nbsp; $all[2] ( $liga_kuerzel[$r2{$all[2]}] / $r1{$all[2]}. ) - $all[3] ( $liga_kuerzel[$r2{$all[3]}] / $r1{$all[3]}. )  [ -> Tip steht noch aus ]<br>";
		}
		else {
			print
"[ Tiprunde $all[1] ] &nbsp; $all[2] ( $liga_kuerzel[$r2{$all[2]}] / $r1{$all[2]}. ) - $all[3] ( $liga_kuerzel[$r2{$all[3]}] / $r1{$all[3]}. )  [ -> Tip getaetigt ]<br>";
		}

	}
}

print "<br><hr size=0 width=80%>";

exit;

sub eintragen {

	print "<body bgcolor=#eeeeee text=black>\n";

	print "<title>TipMaster Freundschaftsspiel Tipabgabe</title>\n";

	require "/tmapp/tmsrc/cgi-bin/tag.pl";
	require "/tmapp/tmsrc/cgi-bin/tag_small.pl";
	print "<br>\n";
	require "/tmapp/tmsrc/cgi-bin/loc.pl";

	print "<font face=verdana size=2><br><br>\n";
	print
	  "&nbsp;<b>Freundschaftsspiel Tipabgabe</b><br><br>&nbsp;<font color=darkred>$heim - $gegner<font color=black>\n";
	print
"<font size=1><br><br> Ihr Freundschaftsspiel Angebot kann erst nach g&uuml;ltiger Tipabgabe registriert werden.<br> Eine Modifizierung Ihrer Tipabgabe ist nach dem Absenden des Tipformulars nicht mehr m&ouml;glich .<br>\n";
	print "<br>\n";

	print "<font face=verdana size=1>\n";

	print "<form action=/cgi-bin/btm/friendly.pl method=post>\n";
	print "<input type=hidden name=method value=\"abgeben\">\n";

	print "<input type=hidden name=heim value=\"$heim\">\n";
	print "<input type=hidden name=gegner value=\"$gegner\">\n";
	print "<input type=hidden name=gegner_n value=\"$gegner_n\">\n";

	open( D7, "/tmdata/btm/tip_status.txt" );
	$tip_status = <D7>;
	chomp $tip_status;
	close(D7);

	open( D7, "/tmdata/btm/tip_datum.txt" );
	$spielrunde_ersatz = <D7>;
	chomp $spielrunde_ersatz;
	close(D7);

	$bx = "formular";
	$by = int( ( $spielrunde_ersatz + 3 ) / 4 );

	$bv          = ".txt";
	$fg          = "/tmdata/btm/";
	$datei_hiero = $fg . $bx . $by . $bv;

	open( DO, $datei_hiero );
	while (<DO>) {
		@ver = <DO>;
	}
	close(DO);

	$y = 0;
	for ( $x = 0 ; $x < 25 ; $x++ ) {
		$y++;
		chomp $ver[$y];
		@ega = split( /&/, $ver[$y] );
		$flagge[$y]   = $ega[0];
		$paarung[$y]  = $ega[1];
		$qu_1[$y]     = $ega[2];
		$qu_0[$y]     = $ega[3];
		$qu_2[$y]     = $ega[4];
		$ergebnis[$y] = $ega[5];
	}

	$tipo[1]  = "30....";
	$tipo[2]  = "31....";
	$tipo[3]  = "32....";
	$tipo[4]  = "33....";
	$tipo[5]  = "34....";
	$tipo[6]  = "35....";
	$tipo[7]  = "36....";
	$tipo[8]  = "37....";
	$tipo[9]  = "38....";
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

	print "<table border=0 cellpadding=0 cellspacing=0>";

	print "<table border=0 bgcolor=white cellpadding=0 cellspacing=0><tr>";
	print "<td></td><td></td><td></td><td>\n";

	print "<img src=/img/spacer11.gif></td><td></td><td>\n";
	print "<img src=/img/spacer2.gif></td><td><img src=/img/spacer4.gif><td></td></td></tr><tr>\n";

	for ( $x = 1 ; $x <= 16 ; $x++ ) { print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n" }
	print "</tr>\n";
	print "<tr><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
	print "<td bgcolor=#eeeeee>&nbsp;</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

	print "<td bgcolor=#eeeeee align=middle><font face=verdana size=1>Fuenf Tips</td>\n";
	print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
	print
"<td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;</td><td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;Quoten</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
	print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr><tr>\n";
	for ( $x = 1 ; $x <= 16 ; $x++ ) { print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n" }
	print "</tr>\n";
	print
"<tr><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td><td bgcolor=#eeeeee>&nbsp;</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

	print
"<td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;2\n";
	print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

	print
"<td bgcolor=#eeeeee><font size=1>&nbsp;</td><td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr><tr>\n";
	for ( $x = 1 ; $x <= 16 ; $x++ ) { print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n" }

	print "</tr>\n";

	$tf = 0;

	for ( $x = 1 ; $x <= 25 ; $x++ ) {

		$tf++;

		$farbe = "white";
		if ( $tf == 3 ) { $tf    = 1 }
		if ( $tf == 2 ) { $farbe = "#eeeeee" }
		@selected = ();
		$selected[0] = " checked";

		print "<tr><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
		print "<td bgcolor=$farbe>&nbsp;<input type=radio name=$tipo[$x] value=0&0$selected[0]>&nbsp;</td>\n";

		print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
		print "<td bgcolor=$farbe>&nbsp;<input type=radio name=$tipo[$x] value=1&1$selected[1]>\n";
		print "<input type=radio name=$tipo[$x] value=1&2$selected[2]>\n";
		print "<input type=radio name=$tipo[$x] value=1&3$selected[3]>&nbsp;</td>\n";

		print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

		$flag = $main_flags[ $flagge[$x] ];

		if ( $flagge[$x] < 3 ) {
			print
"<td align=left bgcolor=$farbe>&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=1><img src=/img/$flag width=14 height=10 border=0>&nbsp;&nbsp;&nbsp;<a href=javascript:document.xr$x.submit()>$paarung[$x]</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";

		}
		elsif ( ( $flagge[$x] == 3 ) or ( $flagge[$x] == 5 ) or ( $flagge[$x] == 4 ) or ( $flagge[$x] == 8 ) ) {
			print
"<td align=left bgcolor=$farbe>&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=1><img src=/img/$flag width=14 height=10 border=0>&nbsp;&nbsp;&nbsp;<a href=javascript:document.xr$x.submit()>$paarung[$x]</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";

		}
		else {
			print
"<td align=left bgcolor=$farbe>&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=1><img src=/img/$flag width=14 height=10 border=0>&nbsp;&nbsp;&nbsp;$paarung[$x]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";
		}

		print
"<td bgcolor=$farbe><font face=verdana size=1> $qu_1[$x] &nbsp;&nbsp; $qu_0[$x] &nbsp;&nbsp; $qu_2[$x] &nbsp;&nbsp;</td>\n";
		print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
	}
	print "<tr>";
	for ( $x = 1 ; $x <= 16 ; $x++ ) { print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n" }

	print "</tr></table>\n";
	print
"<font face=verdana size=1 color=black><br>Beim Click auf die Laenderflaggen werden die entsprechenden realen Ligatabellen geladen .<br>Nach dem Absenden des Formulars unbedingt auf die Antwortseite warten !<br><br>Die Tipabgabe ist jeweils bis Freitags 18.oo Uhr moeglich !\n";
	if ( $tip_eingegangen == 0 ) { $ab = "Tipabgabe senden" }
	if ( $tip_eingegangen == 1 ) { $ab = "Tipabgabe senden" }

	print "<br><br>\n";
	if ( $tip_status == 1 ) { print "<input type=submit value=\"$ab\"></form></html>\n" }
	if ( $tip_status == 2 ) {
		print
"Der Tipabgabetermin ist bereits abgelaufen .<br>Es ist keine Abgabe bzw. Aenderung Ihres Tips mehr moeglich .</html>\n";
	}

	for ( $x = 1 ; $x <= 25 ; $x++ ) {
		( $verein1, $verein2 ) = split( / \- /, $paarung[$x] );
		$verein1 =~ s/  //g;
		$verein2 =~ s/  //g;
		if ( $flagge[$x] == 1 ) { $vv = "ger1" }
		if ( $flagge[$x] == 2 ) { $vv = "ger2" }
		if ( $flagge[$x] == 3 ) { $vv = "eng0" }
		if ( $flagge[$x] == 4 ) { $vv = "fre0" }
		if ( $flagge[$x] == 5 ) { $vv = "ita0" }
		if ( $flagge[$x] == 8 ) { $vv = "spa1" }

	}

	exit;

}

sub abgeben {

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

	for ( $y = 1 ; $y <= 25 ; $y++ ) {
		if ( ( $tipo[$y] eq "1&2" ) or ( $tipo[$y] eq "1&1" ) or ( $tipo[$y] eq "1&3" ) ) {

			$tips++;
			$merk[$tips] = $y;
			( $rest, $quote[$tips] ) = split( /&/, $tipo[$y] );
			chomp $quote[$tips];

			$tip_line = $tip_line . $merk[$tips] . ',' . $quote[$tips] . ',';

			#if ( $quote[$tips] == 2 ) { $quote[$tips] = 0 }
			#if ( $quote[$tips] == 3 ) { $quote[$tips] = 2 }

			if ( $quote[$tips] == 1 ) { $quotex[$tips] = $qu_1[ $merk[$tips] ] }
			if ( $quote[$tips] == 0 ) { $quotex[$tips] = $qu_0[ $merk[$tips] ] }
			if ( $quote[$tips] == 2 ) { $quotex[$tips] = $qu_2[ $merk[$tips] ] }

			$mest[$tips] = $tipx[$y];
		}
	}

	if ( $tips == 0 ) {

		print "<body bgcolor=#eeeeee text=black>\n";
		print "<title>TipMaster Freundschaftsspiel Tipabgabe</title>\n";
		require "/tmapp/tmsrc/cgi-bin/tag.pl";
		require "/tmapp/tmsrc/cgi-bin/tag_small.pl";
		print "<br>\n";
		require "/tmapp/tmsrc/cgi-bin/loc.pl";

		print "<font face=verdana size=2><br><br>\n";
		print
"&nbsp;<b>Fehlermeldung - Freundschaftsspiel Tipabgabe</b><br><br>&nbsp;<font color=darkred><b>$heim - $gegner</b><font color=black>\n";
		print "<font size=1><br>\n";
		print "<br>\n";

		print
"<br><br><font face=verdana size=2 color=darkred> &nbsp; <b>Sie haben keinen Tip abgegeben ; dies ist bei einem Freundschaftsspiel nicht zulaeessig !<br><br> &nbsp; Bitte kehren Sie zur Tipabgabe zurueck und korregieren Sie Ihren Tip !\n";
		exit;
	}

	if ( $tips > 5 ) {
		print "<body bgcolor=#eeeeee text=black>\n";
		print "<title>TipMaster Freundschaftsspiel Tipabgabe</title>\n";

		require "/tmapp/tmsrc/cgi-bin/tag.pl";
		require "/tmapp/tmsrc/cgi-bin/tag_small.pl";
		print "<br>\n";
		require "/tmapp/tmsrc/cgi-bin/loc.pl";

		print "<font face=verdana size=2><br><br>\n";
		print
"&nbsp;<b>Fehlermeldung - Freundschaftsspiel Tipabgabe</b><br><br>&nbsp;<font color=darkred><b>$heim - $gegner</b><font color=black>\n";
		print "<font size=1><br>\n";
		print "<br>\n";

		print
"<br><br><font face=verdana size=2 color=darkred> &nbsp; <b>Sie haben mehr als 5 Tips abgegeben ( ihre Tipanzahl $tips ) ; dies ist bei einem Freundschaftsspiel nicht zulaessig !<br><br> &nbsp; Bitte kehren Sie zur Tipabgabe zurueck und reduzieren Sie Ihre Tipanzahl !\n";
		exit;
	}

	if ( $tips < 5 ) {
		print "<body bgcolor=#eeeeee text=black>\n";
		print "<title>TipMaster Freundschaftsspiel Tipabgabe</title>\n";

		require "/tmapp/tmsrc/cgi-bin/tag.pl";
		require "/tmapp/tmsrc/cgi-bin/tag_small.pl";
		print "<br>\n";
		require "/tmapp/tmsrc/cgi-bin/loc.pl";

		print "<font face=verdana size=2><br><br>\n";
		print
"&nbsp;<b>Fehlermeldung - Freundschaftsspiel Tipabgabe</b><br><br>&nbsp;<font color=darkred><b>$heim - $gegner</b><font color=black>\n";
		print "<font size=1><br>\n";
		print "<br>\n";

		print
"<br><br><font face=verdana size=2 color=darkred> &nbsp; <b>Sie haben weniger als 5 Tips abgegeben ( ihre Tipanzahl $tips ) ; dies ist bei einem Freundschaftsspiel nicht zulaessig !<br><br> &nbsp; Bitte kehren Sie zur Tipabgabe zurueck und reduzieren Sie Ihre Tipanzahl !\n";
		exit;
	}

	require "/tmapp/tmsrc/cgi-bin/runde.pl";

	$line = '#' . $rrunde . '#' . $heim . '#' . $gegner . '#';

	open( D1, "/tmdata/btm/friendly/friendly.txt" );
	while (<D1>) {
		if ( $_ =~ /$line/ ) {
			print "<body bgcolor=#eeeeee text=black>\n";
			print "<title>TipMaster Freundschaftsspiel Tipabgabe</title>\n";

			require "/tmapp/tmsrc/cgi-bin/tag.pl";
			require "/tmapp/tmsrc/cgi-bin/tag_small.pl";
			print "<br>\n";
			require "/tmapp/tmsrc/cgi-bin/loc.pl";

			print "<font face=verdana size=2><br><br>\n";
			print
"&nbsp;<b>Fehlermeldung - Freundschaftsspiel</b><br><br>&nbsp;<font color=darkred><b>$heim - $gegner</b><font color=black>\n";
			print "<font size=1><br>\n";
			print "<br>\n";

			print
"<br><br><font face=verdana size=2 color=black>Es existiert fuer diese Tiprunde bereits ein Freundschaftsspiel Angebot<br>fuer den Verein $gegner .<br><br>Pro Tiprunde ist nur ein Freundschaftsspiel gegen einen Verein moeglich !\n";
			exit;

		}

	}
	close(D1);

	$at = 0;
  read1:
	open( D1, "/tmdata/btm/friendly/nummer.txt" );
	$nummer = <D1>;
	chomp $nummer;
	close(D1);

	open( D1, ">/tmdata/btm/friendly/nummer.txt" );
	flock( D1, 2 );

	$nr = $nummer + 1;
	print D1 "$nr";
	flock( D1, 8 );
	close(D1);

	open( D1, ">>/tmdata/btm/friendly/friendly.txt" );
	flock( D1, 2 );
	print D1 "$nummer#$rrunde#$heim#$gegner#$tip_line#tips gegner#\n";
	flock( D1, 8 );
	close(D1);

	print "<body bgcolor=#eeeeee text=black>\n";
	print "<title>TipMaster Freundschaftsspiel</title>\n";

	require "/tmapp/tmsrc/cgi-bin/tag.pl";
	require "/tmapp/tmsrc/cgi-bin/tag_small.pl";
	print "<br>\n";
	require "/tmapp/tmsrc/cgi-bin/loc.pl";

	print "<font face=verdana size=2><br><br>\n";
	print
"&nbsp;<b>Freundschaftsspiel Tipabgabe</b><br><br>&nbsp;<font color=darkred><b>$heim - $gegner</b><font color=black>\n";
	print "<font size=1><br>\n";
	print "<br>\n";

	print "<br><font face=verdana size=2 color=black>\n";
	print
"Ihr Freundschaftsspiel Angebot wurde registriert .<br>Nur wenn Ihr Gegner seine Tipabgabe fuer das Freundschaftsspiel<br>bis Freitag 18.oo Uhr taetigt wird das Spiel ausgetragen .<br><br>Ihre Tipabgabe wurde registriert und kann nicht mehr modifiziert werden .\n";
	print
"<br><br>Sie haben nun die Moeglichkeit den Trainer $gegner_n von $gegner<br>eine Message zu schreiben so dass er von Ihrem Freundschaftsspiel Angebot Notiz nimmt :<br><br>\n";

	print "<hr size=1 width=90% color=black><align=left><br><br>\n";
	print "<form method=post action=/cgi-bin/btm/mail/mail_sent.pl>\n";
	print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>\n";
	print "<table border=0 cellpadding=2 cellspacing=1><tr>\n";

	print
"<td bgcolor=#F3C6F4 align=right>&nbsp;&nbsp;<font face=verdana size=1>Absender :&nbsp;&nbsp;</td><td align=left bgcolor=#d9daff><font face=verdana size=1>&nbsp;&nbsp;$trainer&nbsp;&nbsp;( $heim )&nbsp;&nbsp;</td></tr>\n";
	print
"<td bgcolor=#F3C6F4 align=right>&nbsp;&nbsp;<font face=verdana size=1>Empfaenger :&nbsp;&nbsp;</td><td align=left bgcolor=#d9daff><font face=verdana size=1>&nbsp;&nbsp;$gegner_n&nbsp;&nbsp;( $gegner )&nbsp;&nbsp;</td></tr>\n";
	print "<input type=hidden name=message value=personal>\n";
	print "<input type=hidden name=auswahl_adress value=\"$gegner_n\">\n";
	print "<input type=hidden name=link value=\"friend\">\n";

	print
"<td bgcolor=#F3C6F4 align=right>&nbsp;&nbsp;<font face=verdana size=1>Betreff :&nbsp;&nbsp;</td><td align=left bgcolor=#d9daff><font face=verdana size=1>&nbsp;&nbsp;<input style=\"font-family=verdana;font-size=10px\" type=text name=subject size=45 maxlength=35 value=\"Spiel - $heim\">&nbsp;&nbsp;</td></tr>\n";
	print
"<tr><td bgcolor=#F3C6F4 valign=top align=right>&nbsp;&nbsp;<font face=verdana size=1>Nachricht :&nbsp;&nbsp;</td></td><td align=left bgcolor=#d9daff><font face=verdana size=1>\n";
	print "\n";

	print
"&nbsp;&nbsp;<textarea style=\"font-family=verdana;font-size=10px;\" name=text rows=8 cols=90 maxrows=8 maxcols=90 wrap=virtual>Sehr geehrte(r) $gegner_n ,\n\nder Trainer $trainer von $heim hat Sie fuer die\naktuelle Tiprunde zu einem Freundschaftsspiel eingeladen.\n\nWenn Sie Interesse haben zu diesem Freundschaftsspiel anzutreten\ntaetigen Sie bitte fristgerecht bis Freitag 18.oo Uhr Ihre Tipabgabe\nunter dem Link Freundschaftsspiele in Ihrem LogIn Bereich .</textarea><br>\n";
	print
	  "<br>&nbsp;&nbsp;<input type=submit value=\"Nachricht senden\"><br></td></tr></table></td></tr></table></form>\n";

	exit;
}

sub eintragen_gegner {

	print "<body bgcolor=#eeeeee text=black>\n";

	print "<title>TipMaster Freundschaftsspiel Tipabgabe</title>\n";

	require "/tmapp/tmsrc/cgi-bin/tag.pl";
	require "/tmapp/tmsrc/cgi-bin/tag_small.pl";
	print "<br>\n";
	require "/tmapp/tmsrc/cgi-bin/loc.pl";

	print "<font face=verdana size=2><br><br>\n";
	print
	  "&nbsp;<b>Freundschaftsspiel Tipabgabe</b><br><br>&nbsp;<font color=darkred>$heim - $gegner<font color=black>\n";
	print "<font size=1><br>\n";
	print "<br>\n";

	print "<font face=verdana size=1>\n";

	print "<form action=/cgi-bin/btm/friendly.pl method=post>\n";
	print "<input type=hidden name=method value=\"abgeben_gegner\">\n";

	print "<input type=hidden name=heim value=\"$heim\">\n";
	print "<input type=hidden name=gegner value=\"$gegner\">\n";
	print "<input type=hidden name=gegner_n value=\"$gegner_n\">\n";
	print "<input type=hidden name=id value=\"$id\">\n";

	open( D7, "/tmdata/btm/tip_status.txt" );
	$tip_status = <D7>;
	chomp $tip_status;
	close(D7);

	open( D7, "/tmdata/btm/tip_datum.txt" );
	$spielrunde_ersatz = <D7>;
	chomp $spielrunde_ersatz;
	close(D7);

	$bx = "formular";
	$by = int( ( $spielrunde_ersatz + 3 ) / 4 );

	$bv          = ".txt";
	$fg          = "/tmdata/btm/";
	$datei_hiero = $fg . $bx . $by . $bv;

	open( DO, $datei_hiero );
	while (<DO>) {
		@ver = <DO>;
	}
	close(DO);

	$y = 0;
	for ( $x = 0 ; $x < 25 ; $x++ ) {
		$y++;
		chomp $ver[$y];
		@ega = split( /&/, $ver[$y] );
		$flagge[$y]   = $ega[0];
		$paarung[$y]  = $ega[1];
		$qu_1[$y]     = $ega[2];
		$qu_0[$y]     = $ega[3];
		$qu_2[$y]     = $ega[4];
		$ergebnis[$y] = $ega[5];
	}

	$tipo[1]  = "30....";
	$tipo[2]  = "31....";
	$tipo[3]  = "32....";
	$tipo[4]  = "33....";
	$tipo[5]  = "34....";
	$tipo[6]  = "35....";
	$tipo[7]  = "36....";
	$tipo[8]  = "37....";
	$tipo[9]  = "38....";
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

	print "<table border=0 cellpadding=0 cellspacing=0>";

	print "<table border=0 bgcolor=white cellpadding=0 cellspacing=0><tr>";
	print "<td></td><td></td><td></td><td>\n";

	print "<img src=/img/spacer11.gif></td><td></td><td>\n";
	print "<img src=/img/spacer2.gif></td><td><img src=/img/spacer4.gif><td></td></td></tr><tr>\n";

	for ( $x = 1 ; $x <= 16 ; $x++ ) { print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n" }
	print "</tr>\n";
	print "<tr><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
	print "<td bgcolor=#eeeeee>&nbsp;</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

	print "<td bgcolor=#eeeeee align=middle><font face=verdana size=1>Fuenf Tips</td>\n";
	print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
	print
"<td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;</td><td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;Quoten</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
	print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr><tr>\n";
	for ( $x = 1 ; $x <= 16 ; $x++ ) { print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n" }
	print "</tr>\n";
	print
"<tr><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td><td bgcolor=#eeeeee>&nbsp;</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

	print
"<td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;2\n";
	print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

	print
"<td bgcolor=#eeeeee><font size=1>&nbsp;</td><td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr><tr>\n";
	for ( $x = 1 ; $x <= 16 ; $x++ ) { print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n" }

	print "</tr>\n";

	$tf = 0;

	for ( $x = 1 ; $x <= 25 ; $x++ ) {

		$tf++;

		$farbe = "white";
		if ( $tf == 3 ) { $tf    = 1 }
		if ( $tf == 2 ) { $farbe = "#eeeeee" }
		@selected = ();
		$selected[0] = " checked";

		print "<tr><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
		print "<td bgcolor=$farbe>&nbsp;<input type=radio name=$tipo[$x] value=0&0$selected[0]>&nbsp;</td>\n";

		print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
		print "<td bgcolor=$farbe>&nbsp;<input type=radio name=$tipo[$x] value=1&1$selected[1]>\n";
		print "<input type=radio name=$tipo[$x] value=1&2$selected[2]>\n";
		print "<input type=radio name=$tipo[$x] value=1&3$selected[3]>&nbsp;</td>\n";

		print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

		$flag = $main_flags[ $flagge[$x] ];

		if ( $flagge[$x] < 3 ) {
			print
"<td align=left bgcolor=$farbe>&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=1><img src=/img/$flag width=14 height=10 border=0>&nbsp;&nbsp;&nbsp;<a href=javascript:document.xr$x.submit()>$paarung[$x]</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";

		}
		elsif ( ( $flagge[$x] == 3 ) or ( $flagge[$x] == 5 ) or ( $flagge[$x] == 4 ) or ( $flagge[$x] == 8 ) ) {
			print
"<td align=left bgcolor=$farbe>&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=1><img src=/img/$flag width=14 height=10 border=0>&nbsp;&nbsp;&nbsp;<a href=javascript:document.xr$x.submit()>$paarung[$x]</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";

		}
		else {
			print
"<td align=left bgcolor=$farbe>&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=1><img src=/img/$flag border=0 width=14 height=10>&nbsp;&nbsp;&nbsp;$paarung[$x]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";
		}

		print
"<td bgcolor=$farbe><font face=verdana size=1> $qu_1[$x] &nbsp;&nbsp; $qu_0[$x] &nbsp;&nbsp; $qu_2[$x] &nbsp;&nbsp;</td>\n";
		print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
	}
	print "<tr>";
	for ( $x = 1 ; $x <= 16 ; $x++ ) { print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n" }

	print "</tr></table>\n";
	print
"<font face=verdana size=1 color=black><br>Beim Click auf die Laenderflaggen werden die entsprechenden realen Ligatabellen geladen .<br>Nach dem Absenden des Formulars unbedingt auf die Antwortseite warten !<br><br>Die Tipabgabe ist jeweils bis Freitags 18.oo Uhr moeglich !\n";
	if ( $tip_eingegangen == 0 ) { $ab = "Tipabgabe senden" }
	if ( $tip_eingegangen == 1 ) { $ab = "Tipabgabe senden" }

	print "<br><br>\n";
	if ( $tip_status == 1 ) { print "<input type=submit value=\"$ab\"></form></html>\n" }
	if ( $tip_status == 2 ) {
		print
"Der Tipabgabetermin ist bereits abgelaufen .<br>Es ist keine Abgabe bzw. Aenderung Ihres Tips mehr moeglich .</html>\n";
	}

	for ( $x = 1 ; $x <= 25 ; $x++ ) {
		( $verein1, $verein2 ) = split( / \- /, $paarung[$x] );
		$verein1 =~ s/  //g;
		$verein2 =~ s/  //g;
		if ( $flagge[$x] == 1 ) { $vv = "ger1" }
		if ( $flagge[$x] == 2 ) { $vv = "ger2" }
		if ( $flagge[$x] == 3 ) { $vv = "eng0" }
		if ( $flagge[$x] == 4 ) { $vv = "fre0" }
		if ( $flagge[$x] == 5 ) { $vv = "ita0" }
		if ( $flagge[$x] == 8 ) { $vv = "spa1" }

	}

	exit;

}

sub abgeben_gegner {

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

	for ( $y = 1 ; $y <= 25 ; $y++ ) {
		if ( ( $tipo[$y] eq "1&2" ) or ( $tipo[$y] eq "1&1" ) or ( $tipo[$y] eq "1&3" ) ) {

			$tips++;
			$merk[$tips] = $y;
			( $rest, $quote[$tips] ) = split( /&/, $tipo[$y] );
			chomp $quote[$tips];

			$tip_line = $tip_line . $merk[$tips] . ',' . $quote[$tips] . ',';

			#if ( $quote[$tips] == 2 ) { $quote[$tips] = 0 }
			#if ( $quote[$tips] == 3 ) { $quote[$tips] = 2 }

			if ( $quote[$tips] == 1 ) { $quotex[$tips] = $qu_1[ $merk[$tips] ] }
			if ( $quote[$tips] == 0 ) { $quotex[$tips] = $qu_0[ $merk[$tips] ] }
			if ( $quote[$tips] == 2 ) { $quotex[$tips] = $qu_2[ $merk[$tips] ] }

			$mest[$tips] = $tipx[$y];
		}
	}

	if ( $tips == 0 ) {

		print "<body bgcolor=#eeeeee text=black>\n";
		print "<title>TipMaster Freundschaftsspiel Tipabgabe</title>\n";
		require "/tmapp/tmsrc/cgi-bin/tag.pl";
		require "/tmapp/tmsrc/cgi-bin/tag_small.pl";
		print "<br>\n";
		require "/tmapp/tmsrc/cgi-bin/loc.pl";

		print "<font face=verdana size=2><br><br>\n";
		print
"&nbsp;<b>Fehlermeldung - Freundschaftsspiel Tipabgabe</b><br><br>&nbsp;<font color=darkred><b>$heim - $gegner</b><font color=black>\n";
		print "<font size=1><br>\n";
		print "<br>\n";

		print
"<br><br><font face=verdana size=2 color=darkred> &nbsp; <b>Sie haben keinen Tip abgegeben ; dies ist bei einem Freundschaftsspiel nicht zulaessig !<br><br> &nbsp; Bitte kehren Sie zur Tipabgabe zurueck und korregieren Sie Ihren Tip !\n";
		exit;
	}

	if ( $tips > 5 ) {
		print "<body bgcolor=#eeeeee text=black>\n";
		print "<title>TipMaster Freundschaftsspiel Tipabgabe</title>\n";

		require "/tmapp/tmsrc/cgi-bin/tag.pl";
		require "/tmapp/tmsrc/cgi-bin/tag_small.pl";
		print "<br>\n";
		require "/tmapp/tmsrc/cgi-bin/loc.pl";

		print "<font face=verdana size=2><br><br>\n";
		print
"&nbsp;<b>Fehlermeldung - Freundschaftsspiel Tipabgabe</b><br><br>&nbsp;<font color=darkred><b>$heim - $gegner</b><font color=black>\n";
		print "<font size=1><br>\n";
		print "<br>\n";

		print
"<br><br><font face=verdana size=2 color=darkred> &nbsp; <b>Sie haben mehr als 5 Tips abgegeben ( ihre Tipanzahl $tips ) ; dies ist bei einem Freundschaftsspiel nicht zulaessig !<br><br> &nbsp; Bitte kehren Sie zur Tipabgabe zurueck und reduzieren Sie Ihre Tipanzahl !\n";
		exit;
	}

	if ( $tips < 5 ) {
		print "<body bgcolor=#eeeeee text=black>\n";
		print "<title>TipMaster Freundschaftsspiel Tipabgabe</title>\n";

		require "/tmapp/tmsrc/cgi-bin/tag.pl";
		require "/tmapp/tmsrc/cgi-bin/tag_small.pl";
		print "<br>\n";
		require "/tmapp/tmsrc/cgi-bin/loc.pl";

		print "<font face=verdana size=2><br><br>\n";
		print
"&nbsp;<b>Fehlermeldung - Freundschaftsspiel Tipabgabe</b><br><br>&nbsp;<font color=darkred><b>$heim - $gegner</b><font color=black>\n";
		print "<font size=1><br>\n";
		print "<br>\n";

		print
"<br><br><font face=verdana size=2 color=darkred> &nbsp; <b>Sie haben weniger als 5 Tips abgegeben ( ihre Tipanzahl $tips ) ; dies ist bei einem Freundschaftsspiel nicht zulaessig !<br><br> &nbsp; Bitte kehren Sie zur Tipabgabe zurueck und reduzieren Sie Ihre Tipanzahl !\n";
		exit;
	}

	require "/tmapp/tmsrc/cgi-bin/runde.pl";

	#print $id , $tip_line;
	#exit;

	$at = 0;
  read2:
	$top = 0;
	open( D1, "</tmdata/btm/friendly/friendly.txt" );
	while (<D1>) {
		$top++;
		$top_l[$top] = $_;
		@ko = split( /#/, $_ );
		if ( $ko[0] == $id ) {
			$top_l[$top] =~ s/tips gegner/$tip_line/;
		}
	}
	close(D1);
	if ( $top == 0 && $at < 10 ) { $at++; sleep 1; goto read2; }

	open( D1, ">/tmdata/btm/friendly/friendly.txt" );
	flock( D1, 2 );
	for ( $r = 1 ; $r <= $top ; $r++ ) {
		print D1 $top_l[$r];
	}
	flock( D1, 8 );
	close(D1);

	print "<body bgcolor=#eeeeee text=black>\n";
	print "<title>TipMaster Freundschaftsspiel</title>\n";

	require "/tmapp/tmsrc/cgi-bin/tag.pl";
	require "/tmapp/tmsrc/cgi-bin/tag_small.pl";
	print "<br>\n";
	require "/tmapp/tmsrc/cgi-bin/loc.pl";

	print "<font face=verdana size=2><br><br>\n";
	print
"&nbsp;<b>Freundschaftsspiel Tipabgabe</b><br><br>&nbsp;<font color=darkred><b>$heim - $gegner</b><font color=black>\n";
	print "<font size=1><br>\n";
	print "<br>\n";

	print "<br><font face=verdana size=2 color=black>\n";
	print
"Ihre Tipabgabe wurde registriert und damit wird das Freundschaftsspiel <br>an diesem Wochenende ausgetragen !<br><br>Ihre Tipabgabe kann nicht mehr modifiziert werden .\n";

	exit;
}

sub liste {

	$s    = 0;
	$liga = 0;
	open( D1, "</tmdata/btm/history.txt" );
	while (<D1>) {
		$liga++;
		@lines = ();
		@lines = split( /&/, $_ );
		$y     = 0;
		for ( $x = 1 ; $x <= 18 ; $x++ ) {
			$ax = 0;
			$s++;
			$y++;
			$data[$s]   = $lines[$y];
			$liga[$s]   = $liga;
			$verein[$s] = $x;
			$y++;
			$datb[$s] = $lines[$y];
			$y++;
			$coach{ $data[$s] } = $datb[$s];

			if ( $datb[$s] eq $trainer ) {
				$team = $data[$s];
			}
		}
	}
	close(D1);

	print "<title>TipMaster Freundschaftsspiel</title>\n";
	print "<head>\n";
	print "<style type=\"text/css\">";
	print "TD.trai { font-family:Verdana; font-size:8pt; color:black; }\n";
	print "TD.act { font-family:Verdana; font-size:8pt; color:red; }\n";
	print "TD.ri { font-family:Verdana; font-size:8pt; color:black; alignment: right; }\n";
	print "TD.ce { font-family:Verdana; font-size:8pt; color:black; text-align: center;}\n";
	print "TD.bl { font-family:Verdana; font-size:8pt;}\n";
	print "TD.le { font-family:Verdana; font-size:11pt; color:black; alignment: left;}\n";
	print "TD.ler { font-family:Verdana; font-size:8pt; color:red; alignment: left;}\n";
	print "TD.gr { font-family:Verdana; font-size:12pt; color:red; alignment: left;}\n";

	print "</style>\n";
	print "</head>\n";

	print "<script language=JavaScript>\n";
	print "<!--\n";
	print "function targetLink(URL)\n";
	print "  {\n";
	print "    if(document.images)\n";
	print
"      targetWin = open(URL,\"Neufenster\",\"scrollbars=yes,toolbar=no,directories=no,menubar=no,status=no,resizeable=yes,width=850,height=580\");\n";
	print " }\n";
	print "  //-->\n";
	print "  </script>\n";

	require "/tmapp/tmsrc/cgi-bin/tag.pl";
	require "/tmapp/tmsrc/cgi-bin/tag_small.pl";
	print "<br>\n";
	require "/tmapp/tmsrc/cgi-bin/loc.pl";

	print "<font face=verdana size=2><br>\n";

	require "/tmapp/tmsrc/cgi-bin/runde.pl";
	if ( $trainer ne "Gast Zugang" ) {
		print "<form name=ok action=/cgi-bin/btm/friendly.pl method=post>\n";
		print "<input type=hidden name=method value=\"\">\n";

		print
"&nbsp;<a href=javascript:document.ok.submit()>Eigenes Freundschaftsspiel austragen / Tipabgabe Freundschaftsspiel</a><br><br>\n";
		print "</form>\n";
	}
	if ( $akt_runde == 0 ) { $akt_runde = $rrunde }

	open( D2, "/tmdata/btm/heer.txt" );
	while (<D2>) {
		@so = split( /&/, $_ );
		$r1{ $so[5] } = $so[0];
		$r2{ $so[5] } = $so[1];

	}
	close(D2);

	if ( $huni != 9999 ) {
		open( D1, "/tmdata/btm/friendly/friendly.txt" );
		while (<D1>) {

			@all = split( /#/, $_ );
			if ( $all[1] == $akt_runde ) {
				if ( $all[4] ne "tips gegner" ) {
					if ( $all[5] ne "tips gegner" ) {
						if ( ( $all[2] eq $team ) or ( $all[3] eq $team ) ) {
							$spiel++;
							$spiel[$spiel] = $_;
						}
					}
				}
			}
		}
		close(D1);
	}
	else {

		open( D1, "/tmdata/btm/friendly/friendly.txt" );
		while (<D1>) {

			@all = split( /#/, $_ );
			if ( $all[1] == $akt_runde ) {
				if ( $all[4] eq "tips gegner" || $all[5] eq "tips gegner" ) {
					$spiel++;
					$spiel[$spiel] = $_;
				}
			}
		}
		close(D1);

	}
	$own = $spiel;

	open( D1, "/tmdata/btm/friendly/friendly.txt" );
	while (<D1>) {

		@all = split( /#/, $_ );
		if ( $all[1] == $akt_runde ) {
			if ( $all[4] ne "tips gegner" ) {
				if ( $all[5] ne "tips gegner" ) {
					if ( $all[2] ne $team ) {
						if ( $all[3] ne $team ) {
							$spiel++;
							$spiel[$spiel] = $_;
						}
					}
				}
			}
		}
	}
	close(D1);

	print "<form method=post action=/cgi-bin/btm/friendly.pl target=_top>\n";
	print "<font face=verdana size=1>";
	print "<input type=hidden name=method value=liste>\n";

	print "&nbsp;<font face=verdana size=2><b>Bundesliga - TipMaster Freundschaftsspiele&nbsp;&nbsp;\n";

#disabled again - no one cared anymore...
#print "</b><font size=1 color=red><br><br>&nbsp; Aus noch nicht geklaerten Gruenden wurden die errsten 114 angebotenenen Friendlys aus der Datenabnk gel&ouml;scht ! <br><br><font color=black>";
	print
	  "<select style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=akt_runde>";

	for ( $x = 1 ; $x <= $rrunde ; $x++ ) {
		$gh = "";
		if ( $akt_runde == $x ) { $gh = "selected" }
		print "<option value=$x $gh> -> Tiprunde $x \n";
	}
	print "</select> &nbsp; ";

	print
"<font face=verdana size=2><b>( $spiel Spiele ) &nbsp; &nbsp; <input type=submit value=\"Spiele laden\" style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\"></form>";
	print "<form method=post action=/cgi-bin/btm/friendly.pl target=_top>\n";
	print "</b></b><font face=verdana size=1> &nbsp; &nbsp; Vereins-/Trainernamensuche ( in Runde #$akt_runde ): ";

	print "<input type=hidden name=suche_ja value=1>\n";
	print "<input type=hidden name=method value=liste>\n";
	print "<input type=hidden name=akt_runde value=$akt_runde>\n";
	print
"<input type=text style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=verein_suche>";
	print
"&nbsp; &nbsp; <input type=submit value=\"Suche starten\" style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\"></form>";
	print "</form>";
	print "<TABLE CELLSPACING=0 CELLPADDING=4 BORDER=0>";

	if ( $huni == 9999 ) {

	}
	else {

		$bx = "formular";

		$bv          = ".txt";
		$fg          = "/tmdata/btm/";
		$datei_hiero = $fg . $bx . $akt_runde . $bv;

		open( DO, $datei_hiero );
		while (<DO>) {
			@ver = <DO>;
		}
		close(DO);

		$y = 0;
		for ( $x = 0 ; $x < 25 ; $x++ ) {
			$y++;
			chomp $ver[$y];
			@ega = split( /&/, $ver[$y] );
			$flagge[$y]   = $ega[0];
			$paarung[$y]  = $ega[1];
			$qu_1[$y]     = $ega[2];
			$qu_0[$y]     = $ega[3];
			$qu_2[$y]     = $ega[4];
			$ergebnis[$y] = $ega[5];
			if ( $ergebnis[$y] == 4 ) {
				$qu_1[$y] = 10;
				$qu_0[$y] = 10;
				$qu_2[$y] = 10;

			}

		}

		if ( $huni == 0 ) { $huni = 1 }
		$time   = ( $huni * 50 ) - 49;
		$time_a = $time + 49;

		for ( $x = 1 ; $x <= $spiel ; $x++ ) {

			if ( ( $own + 1 == $x ) ) {
				print "</table><hr size=0 width=100%>";
				print "</b></b><font face=verdana size=1>";
				$hu = 0;
				for ( $xx = 1 ; $xx <= $spiel ; $xx = $xx + 50 ) {
					$hu++;
					if ( $hu == 6 ) { print "<br>" }
					$xy = $xx + 49;
					if ( $spiel < $xy ) { $xy = $spiel }
					if ( $xx < 10 )     { $xx = '0' . $xx }
					if ( $xx < 100 )    { $xx = '0' . $xx }
					if ( $xy < 100 )    { $xy = '0' . $xy }

					print
"&nbsp; <a href=/cgi-bin/btm/friendly.pl?huni=$hu&method=liste&akt_runde=$akt_runde>Spiel $xx bis $xy</a> &nbsp; ";
					$li = 1;
				}

#print "<br>&nbsp; <a href=/cgi-bin/btm/friendly.pl?huni=9999&method=liste&akt_runde=$akt_runde>Ausstehende Einladungen</a>";

				print "<hr size=0 width=100%>";
				print "<TABLE CELLSPACING=0 CELLPADDING=4 BORDER=0>";
			}

			$ein = 0;
			if ( $x <= ($own) ) { $ein = 1 }
			if ( ( $x > $time ) and ( $x < $time_a ) ) { $ein = 1 }
			if ( $suche_ja == 1 ) { $ein = 1 }
			if ( $ein == 1 ) {

				$ll++;
				if ( ( $ll == 11 ) ) {
					print "</table><TABLE CELLSPACING=0 CELLPADDING=4 BORDER=0>";
					$ll = 1;

				}

				@all = split( /#/, $spiel[$x] );

				$color1 = "black";
				$color2 = "black";

				if ( $all[2] eq $team ) { $color1 = "darkred" }
				if ( $all[3] eq $team ) { $color2 = "darkred" }
				$los = 1;
				if ( $suche_ja == 1 )                       { $los = 0 }
				if ( $all[2] =~ /$verein_suche/ )           { $los = 1 }
				if ( $all[3] =~ /$verein_suche/ )           { $los = 1 }
				if ( $coach{ $all[2] } =~ /$verein_suche/ ) { $los = 1 }
				if ( $coach{ $all[3] } =~ /$verein_suche/ ) { $los = 1 }

				if ( $los == 1 ) {

					$fa = $fa + 1;
					if ( $fa == 3 ) { $fa    = 1 }
					if ( $fa == 1 ) { $farbe = "#e5e5e5" }
					if ( $fa == 2 ) { $farbe = "white" }
					print "<TR BGCOLOR=$farbe>\n";
					print
"<TD align=left width=260><font face=verdana color=$color1 size=2> &nbsp; <b>$all[2]</b><br><font size=1 color=black> &nbsp; &nbsp;$coach{$all[2]} ( $liga_kuerzel[$r2{$all[2]}] / $r1{$all[2]}. Platz )</td>\n";

					#print  "<td class=ce width=90> ( $liga_kuerzel[$r2{$all[2]}] / $r1{$all[2]}. ) -</TD>\n";
					#print  "<td class=ce width=30>-</td>\n";
					print
"<TD align=left width=260><font face=verdana color=$color2 size=2> &nbsp; <b>$all[3]</b><br><font size=1 color=black> &nbsp; &nbsp;$coach{$all[3]} ( $liga_kuerzel[$r2{$all[3]}] / $r1{$all[3]}. Platz )</td>\n";

					#print  "<td class=ce width=90>( $liga_kuerzel[$r2{$all[3]}] / $r1{$all[3]}. ) </TD>\n";

					$su_1   = 0;
					$sp     = 0;
					$su_2   = 0;
					$tora   = 0;
					$torb   = 0;
					@spiele = split( /,/, $all[4] );
					for ( $c = 1 ; $c <= 5 ; $c++ ) {
						$xx       = ( $c - 1 ) * 2;
						$xy       = ( $xx + 1 );
						$sp1[$c]  = $spiele[$xx];
						$pro1[$c] = $spiele[$xy];
					}

					for ( $xx = 1 ; $xx <= 5 ; $xx++ ) {
						if ( ( $pro1[$xx] == 1 ) and ( $ergebnis[ $sp1[$xx] ] == 1 ) ) {
							$su_1 = $su_1 + $qu_1[ $sp1[$xx] ];
						}
						if ( ( $pro1[$xx] == 2 ) and ( $ergebnis[ $sp1[$xx] ] == 2 ) ) {
							$su_1 = $su_1 + $qu_0[ $sp1[$xx] ];
						}
						if ( ( $pro1[$xx] == 3 ) and ( $ergebnis[ $sp1[$xx] ] == 3 ) ) {
							$su_1 = $su_1 + $qu_2[ $sp1[$xx] ];
						}
						if ( ( $pro1[$xx] == 1 ) and ( $ergebnis[ $sp1[$xx] ] == 4 ) ) { $su_1 = $su_1 + 10 }
						if ( ( $pro1[$xx] == 2 ) and ( $ergebnis[ $sp1[$xx] ] == 4 ) ) { $su_1 = $su_1 + 10 }
						if ( ( $pro1[$xx] == 3 ) and ( $ergebnis[ $sp1[$xx] ] == 4 ) ) { $su_1 = $su_1 + 10 }
						if ( $ergebnis[ $sp1[$xx] ] > 0 ) { $sp++ }
					}
					@spiele = split( /,/, $all[5] );
					for ( $c = 1 ; $c <= 5 ; $c++ ) {
						$xx       = ( $c - 1 ) * 2;
						$xy       = ( $xx + 1 );
						$sp1[$c]  = $spiele[$xx];
						$pro1[$c] = $spiele[$xy];
					}

					for ( $xx = 1 ; $xx <= 5 ; $xx++ ) {
						if ( ( $pro1[$xx] == 1 ) and ( $ergebnis[ $sp1[$xx] ] == 1 ) ) {
							$su_2 = $su_2 + $qu_1[ $sp1[$xx] ];
						}
						if ( ( $pro1[$xx] == 2 ) and ( $ergebnis[ $sp1[$xx] ] == 2 ) ) {
							$su_2 = $su_2 + $qu_0[ $sp1[$xx] ];
						}
						if ( ( $pro1[$xx] == 3 ) and ( $ergebnis[ $sp1[$xx] ] == 3 ) ) {
							$su_2 = $su_2 + $qu_2[ $sp1[$xx] ];
						}
						if ( ( $pro1[$xx] == 1 ) and ( $ergebnis[ $sp1[$xx] ] == 4 ) ) { $su_2 = $su_2 + 10 }
						if ( ( $pro1[$xx] == 2 ) and ( $ergebnis[ $sp1[$xx] ] == 4 ) ) { $su_2 = $su_2 + 10 }
						if ( ( $pro1[$xx] == 3 ) and ( $ergebnis[ $sp1[$xx] ] == 4 ) ) { $su_2 = $su_2 + 10 }
						if ( $ergebnis[ $sp1[$xx] ] > 0 ) { $sp++ }
					}
					if ( $su_1 > 14 )  { $tora = 1 }
					if ( $su_1 > 39 )  { $tora = 2 }
					if ( $su_1 > 59 )  { $tora = 3 }
					if ( $su_1 > 79 )  { $tora = 4 }
					if ( $su_1 > 104 ) { $tora = 5 }
					if ( $su_1 > 129 ) { $tora = 6 }
					if ( $su_1 > 154 ) { $tora = 7 }

					if ( $su_2 > 14 )  { $torb = 1 }
					if ( $su_2 > 39 )  { $torb = 2 }
					if ( $su_2 > 59 )  { $torb = 3 }
					if ( $su_2 > 79 )  { $torb = 4 }
					if ( $su_2 > 104 ) { $torb = 5 }
					if ( $su_2 > 129 ) { $torb = 6 }
					if ( $su_2 > 154 ) { $torb = 7 }

					if ( $sp != 0 ) {
						$cett = "red";
						if ( $sp == 10 ) { $cett = "black" }

						print
"<TD align=center width=60><font face=verdana size=2 color=$cett><b> $tora <font color=black>:<FONT color=$cett> $torb </FONT></TD>\n";
					}

					if ( $sp == 0 ) {
						print "<TD align=center width=60><font face=verdana size=2><b> - : - </TD>\n";
					}

					$yy = "";
					$yx = "";
					if ( $su_1 < 10 ) { $yy = "0" }
					if ( $su_2 < 10 ) { $yx = "0" }

					if ( $sp == 0 ) {
						print "<TD class=ce width=80> [ - ] </TD>\n";
					}
					else {
						print "<TD class=ce width=80> [ $yy$su_1 - $yx$su_2 ] </TD>\n";
					}

					$ra1 = $all[2];
					$ra1 =~ s/ /%20/g;
					$ra2 = $all[3];
					$ra2 =~ s/ /%20/g;

					print
"<TD ALIGN=RIGHT><a href=tips_fr.pl?ru=$all[1]&line1=$all[4]&line2=$all[5]&ve1=$ra1&ve2=$ra2 target\"_blank\" onClick=\"targetLink('tips_fr.pl?ru=$all[1]&line1=$all[4]&line2=$all[5]&ve1=$ra1&ve2=$ra2');return false\"><IMG SRC=/img/ti.jpg BORDER=0 alt=\"Detail - Tipansicht\"></A>&nbsp;</TD>\n";

					print "</TR>\n";
				}
			}
		}
		print "</table>\n";
	}
	require "/tmapp/tmsrc/cgi-bin/tag_bottom.pl";
	exit;

}
