#!/usr/bin/perl

=head1 NAME
	BTM boerse.pl

=head1 SYNOPSIS
	TBD
	


=head1 CHANGELOG
	2015-06-09 Thomas: Added Session Management


	Created 2015-06-09

=cut

use lib '/tmapp/tmsrc/cgi-bin/';
use TMSession;
my $session = TMSession::getSession( btm_login => 1 );
my $trainer = $session->getUser();
my $leut    = $trainer;

use CGI;

## Set to 1 for inactive remark
my $inactive = 0;

print "Content-Type: text/html \n\n";

require "/tmapp/tmsrc/cgi-bin/btm_ligen.pl";
require "/tmapp/tmsrc/cgi-bin/runde.pl";

$g = 0;

open( D2, "/tmdata/btm/history.txt" );
while (<D2>) {
	$g++;
	$loos[$g] = $_;
	if ( $_ =~ /$trainer/ ) {
		@vereine = split( /&/, $_ );
		$gg = $g;
	}

}

$y = 0;
for ( $x = 1 ; $x < 19 ; $x++ ) {
	$y++;
	chomp $verein[$y];
	$data[$x] = $vereine[$y];
	$y++;
	chomp $verein[$y];
	$datb[$x] = $vereine[$y];

	if ( $datb[$x] eq $trainer ) {
		$isa = $gg;
		$isb = $x;
	}

	$y++;
	chomp $verein[$y];
	$datc[$x] = $vereine[$y];
}

$frei = 0;
$gh   = 0;
for ( $liga = 1 ; $liga <= 128 ; $liga++ ) {

	@vereine = split( /&/, $loos[$liga] );

	$y = 0;
	for ( $x = 1 ; $x < 19 ; $x++ ) {
		$y++;
		chomp $verein[$y];
		$data[$x] = $vereine[$y];
		$y++;
		chomp $verein[$y];
		$datb[$x] = $vereine[$y];
		if ( $datb[$x] eq "Trainerposten frei" ) {

			$frei++;
			$auswahl_verein[$frei] = $data[$x];
			$auswahl_liga[$frei]   = $liga;
			$auswahl_id[$frei]     = $x;
		}

		$y++;
		chomp $verein[$y];
		$datc[$x] = $vereine[$y];
	}
}

open( D2, "/tmdata/btm/boerse.txt" );
while (<D2>) {

	for ( $e = 1 ; $e <= $frei ; $e++ ) {

		if ( $_ =~ /$auswahl_verein[$e]/ ) { $anzahl[$e]++ }
	}
}
close(D2);

open( D2, "/tmdata/btm/boerse.txt" );
while (<D2>) {
	if ( $_ =~ /$trainer/ ) {
		for ( $x = 1 ; $x <= $frei ; $x++ ) {
			if ( $_ =~ /$auswahl_verein[$x]/ ) { $selected[$x] = 1 }
		}
	}
}
close(D2);

open( D2, "/tmdata/btm/boerse.txt" );
while (<D2>) {

	if ( $_ =~ /$trainer/ ) {
		@kol  = split( /#/, $_ );
		$zahl = $kol[1];
		$t    = 1;
		for ( $x = 1 ; $x <= $zahl ; $x++ ) {
			$t++;
			$leer = $kol[$t];

			for ( $xx = 1 ; $xx <= $frei ; $xx++ ) {
				if ( $leer eq $auswahl_verein[$xx] ) { $fid = $xx }
			}

			$t++;
			$prio[$fid] = $kol[$t];
		}
	}

}
close(D2);

print "<title>TipMaster Job - Boerse</title>\n";
print "<script language=JavaScript>\n";
print "<!--\n";
print "function targetLink(URL)\n";
print "  {\n";
print "    if(document.images)\n";
print
"      targetWin = open(URL,\"Neufenstere\",\"scrolling=auto,toolbar=no,directories=no,menubar=no,status=no,resizeable=yes,width=850,height=400\");\n";
print " }\n";
print "  //-->\n";
print "  </script>\n";

print "<html><title>Job - Boerse</title><p align=left><body bgcolor=white text=black link=darkred link=darkred>\n";

require "/tmapp/tmsrc/cgi-bin/tag.pl";
require "/tmapp/tmsrc/cgi-bin/tag_small.pl";
print "<br>\n";
require "/tmapp/tmsrc/cgi-bin/loc.pl";

open( D, "</tmdata/btm/boerse_aktiv.txt" );
$aktiv = <D>;
chomp $aktiv;
close(D);

if ( $aktiv == 1 ) {
	print "<br>";
	print "<table border=0  cellpadding=0 cellspacing=0 bgcolor=black>\n";
	print "<tr><td>\n";
	print "<table border=0 cellpadding=10 cellspacing=1>\n";
	print
	  "<tr bgcolor=#eeeeff><td align=center><font face=verdana size=1>Bundesliga - TipMaster Job Boerse<br></td></tr>";
	print "<tr bgcolor=#eeeeee><td align=center><font face=verdana size=2><br><br><b>
 &nbsp; &nbsp; &nbsp; Im Moment laeuft die Auswertung der Jobvergaberunde &nbsp; &nbsp; &nbsp; <br>
und die freien Posten werden entsprechend den<br>
Bewerbungsrankings an die Trainer vergeben .<br><br>
In wenigen Minuten sind Bewerbungen fuer die<br>
neuen freien Vereinsposten wieder moeglich .<br><br>
</table></td></tr></table>";
	exit;

}

open( D2, "/tmdata/btm/heer.txt" );
while (<D2>) {

	@all = split( /&/, $_ );
	$platz{ $all[5] } = $all[0];

}
close(D2);

print "<form action=/cgi-bin/btm/boerse_mail.pl method=post>\n";

print "<table border=0  cellpadding=0 cellspacing=0 bgcolor=black>\n";
print "<tr><td>\n";
print "<table border=0 cellpadding=2 cellspacing=1>\n";
print
"<tr><td colspan=7 align=center bgcolor=#f6f4f4><font size=2>&nbsp; <font face=verdana size=1>Bundesliga - TipMaster Job - Boerse [ freie Vereine der 1.Bundesliga bis Bezirksliga]<br></td></tr>";

if ($inactive) {
	print
"<tr><td colspan=7 align=center><font face=verdana size=2 color=red>Wegen einer Fehlfunktion ist die Jobb&ouml;rse diese Woche leider ausser Betrieb. <br>Die ausgeschriebenen Vereine werden n&auml;chste Woche vergeben!</font></td></tr>\n";
}

if ( $frei > 0 ) {
	for ( $x = 1 ; $x <= $frei ; $x++ ) {

		$tt = "";
		if ( $selected[$x] == 1 ) { $tt = " checked" }

		$ein = 0;

		#changed by bodo 03-08-2011: weniger in der boerse.
		#if ( ( $platz < 19 ) and ( $auswahl_liga[$x] >32 ) ) { $ein = 1 }
		if ( $auswahl_liga[$x] < 65 ) { $ein = 1 }

		if ( $ein == 1 ) {

			print "<tr>";

			if ( $login == 0 ) {

				print
"<td align=left bgcolor=#cbccff><font face=verdana size=1>&nbsp;<input type=checkbox name=\"$auswahl_verein[$x]\" value=yes$tt>&nbsp;</td>\n";
			}

# print "<form action=//verein.pl method=post name=x$x><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=password value=\"$pass\"><input type=hidden name=ident value=\"$auswahl_verein[$x]\"></form>\n";
# print "<td align=left bgcolor=#eeeeff><font face=verdana size=1>&nbsp; <a href=javascript:document.x$x.submit()><img src=/img/h1.jpg border=0 alt=\"Vereinsstatistik $auswahl_verein[$x]\"></a> &nbsp;$auswahl_verein[$x]&nbsp;&nbsp;&nbsp;&nbsp; </td> \n";
			print
"<td align=left bgcolor=#eeeeff><font face=verdana size=1>&nbsp; &nbsp;$auswahl_verein[$x]&nbsp;&nbsp;&nbsp;&nbsp; </td> \n";

			print
"<td align=center bgcolor=#cbccff><font face=verdana size=1>&nbsp; $liga_kuerzel[$auswahl_liga[$x]] &nbsp;</td>\n";

			print
"<td align=right bgcolor=#cbccff><font face=verdana size=1>&nbsp;&nbsp;$platz{$auswahl_verein[$x]} .Platz&nbsp;&nbsp;</td>\n";

			$anzahl[$x] = $anzahl[$x] * 1;
			print "<td align=right bgcolor=#eeeeff><font face=verdana size=1>&nbsp;&nbsp; $anzahl[$x] Bew. &nbsp;</td>";

			if ( $login == 0 ) {

				@mo  = ();
				$ein = 0;

				if ( $prio[$x] == 1 ) { ( $ein = 1 ) and ( $mo[1] = " checked" ) }
				if ( $prio[$x] == 2 ) { ( $ein = 1 ) and ( $mo[2] = " checked" ) }
				if ( $prio[$x] == 3 ) { ( $ein = 1 ) and ( $mo[3] = " checked" ) }
				if ( $prio[$x] == 4 ) { ( $ein = 1 ) and ( $mo[4] = " checked" ) }
				if ( $prio[$x] == 5 ) { ( $ein = 1 ) and ( $mo[5] = " checked" ) }
				if ( $ein == 0 ) { ( $mo[3] = " checked" ) }

				print
"<td align=center bgcolor=#eeeeff> &nbsp;<input type=radio name=\"$auswahl_verein[$x]_id\" value=1$mo[1]>\n";
				print "<input type=radio name=\"$auswahl_verein[$x]_id\" value=2$mo[2]>\n";
				print "<input type=radio name=\"$auswahl_verein[$x]_id\" value=3$mo[3]>\n";
				print "<input type=radio name=\"$auswahl_verein[$x]_id\" value=4$mo[4]>\n";
				print "<input type=radio name=\"$auswahl_verein[$x]_id\" value=5$mo[5]> &nbsp;</td>\n";
			}

			print
"<td align=center bgcolor=#cbccff> &nbsp;&nbsp;<a href=/cgi-bin/btm/boerse_rank.pl?li=$auswahl_liga[$x]&ve=$auswahl_id[$x]&isa=$isa&isb=$isb target\"_blank\" onClick=\"targetLink('/cgi-bin/btm/boerse_rank.pl?li=$auswahl_liga[$x]&ve=$auswahl_id[$x]&isa=$isa&isb=$isb');return false\"><img src=/img/job.gif border=0></a>&nbsp;&nbsp;</td>\n";

		}

		print "</tr>\n";
	}
}
print "</table>\n";
print "</td></tr></table>\n";

print "<font face=verdana size=1><br>\n";
print
"-> &nbsp; <a href=javascript:document.wechsel.submit()>Bisherige Vereinswechsel / Vereinstaeusche dieser Saison</a><br><br><br>";

if ( $login == 0 ) {
	print
"<font size=1 face=verdana>Mit dem Markieren der Radiobuttons ( Kreise ) k&ouml;nnen Sie von<br>links nach rechts die Priorit&auml;t Ihrer Bewerbung steigern.<br><br>Die Vergabe der Trainerposten nach den pers&ouml;nlichen<br>Priorit&auml;ten kann jedoch nicht garantiert werden .

<br><br><font color=darkred>
Sie wollen Berwerbungen wieder ruckg&auml;ngig machen ? Versenden<br>
Sie einfach das Formular ohne markierte
Checkboxes und alle<br>Ihre Bewerbungen werden storniert.<br><br>
<font color=red>W&ouml;chentliche Vergaberunde : <font color=black><br>Immer Dienstags 12.oo Uhr und Donnerstags 16.oo Uhr<br>
[ keine Vergaberunde zu Saisonbeginn: Do. bevor Sp.1 bis 4 und am Saisonende: Di nach Sp.33 bis 34  ]<br><br>\n";

	if ( $trainer ne "Gast Zugang" ) {

		if ( $boerse_open == 1 ) {
			print
"&nbsp;<input style=\"font family:verdana;font-size:11px;\" type=submit value=\"Bewerbungen abschicken\">";
		}
		if ( $boerse_open == 0 ) {
			print "&nbsp;<br>&nbsp;<font face=verdana size=2 color=darkred>Die Job - Boerse ist derzeit geschlossen !";
		}

	}
	else {
		print "&nbsp;Das Sie als Gast eingeloggt sind koennen Sie Bewerbungen nicht versenden .</form>";
	}

}

print "</form>";

print
"<br><form name=wechsel method=post action=/cgi-bin/btm/boerse_wechsel.pl target=_top><input type=hidden name=loss value=\"$ligo\"></form>\n";

