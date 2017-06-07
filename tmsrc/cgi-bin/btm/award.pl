#!/usr/bin/perl

=head1 NAME
	BTM award.pl

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

require "/tmapp/tmsrc/cgi-bin/btm_ligen.pl";
require "/tmapp/tmsrc/cgi-bin/runde.pl";

require "/tmapp/tmsrc/cgi-bin/btm/saison.pl";
require "/tmapp/tmsrc/cgi-bin/btm/mail/MLib.pl";
use DBI;

$akt_saison = $main_nr - 5;

open( D1, "/tmdata/btm/datum.txt" );
$leer    = <D1>;
$sp_ende = <D1>;
chomp $sp_ende;
close(D1);

open( D2, "/tmdata/btm/heer.txt" );
while (<D2>) {

	@all = split( /&/, $_ );
	$platz{ $all[5] } = $all[0];

}
close(D2);

print "Content-Type: text/html \n\n";

$query    = new CGI;
$me       = $query->param('me');
$loss     = $query->param('loss');
$top      = $query->param('top');
$sp_start = $query->param('sp_start');

#$sp_ende = $query->param('sp_ende');
$into = $query->param('into');
$sai  = $query->param('sai');

$liga = 1;

$ein = 0;
for ( $x = 1 ; $x <= 6 ; $x++ ) {
	if ( $x == $me ) { $ein = 1 }
}
if ( $ein == 0 ) { $me = 3 }

$ein = 0;
for ( $x = 1 ; $x < 4 ; $x++ ) {
	if ( $x == $loss ) { $ein = 1 }
}
if ( $ein == 0 ) { $loss = 1 }

$ein = 0;
for ( $x = 1 ; $x <= $akt_saison + 1 ; $x++ ) {
	if ( $x == $sai ) { $ein = 1 }
}
if ( $ein == 0 ) { $sai = $akt_saison }

$ein = 0;
for ( $x = 1 ; $x <= 4 ; $x++ ) {
	if ( $x == $top ) { $ein = 1 }
}
if ( $ein == 0 ) { $top = 2 }

$ein = 0;
for ( $x = 1 ; $x <= 5 ; $x++ ) {
	if ( $x == $into ) { $ein = 1 }
}
if ( $ein == 0 ) { $into = 4 }

open( D2, "/tmdata/btm/history.txt" );
while (<D2>) {

	$li++;
	@vereine = split( /&/, $_ );

	$y = 0;
	for ( $x = 1 ; $x < 19 ; $x++ ) {
		$y++;
		chomp $verein[$y];
		$data[$x] = $vereine[$y];
		$y++;
		chomp $verein[$y];
		$datb[$x]            = $vereine[$y];
		$verein{"$datb[$x]"} = $data[$x];
		$liga{"$datb[$x]"}   = $li;
		$y++;
		chomp $verein[$y];
		$datc[$x] = $vereine[$y];
	}
}
close(D2);

print "<head>\n";
print "<style type=\"text/css\">";
print "TD.ve { font-family:Verdana; font-size:8pt; color:black; }\n";

print "</style>\n";
print "<meta name=\"robots\" content=\"noindex\"/>\n";
print "</head>\n";

print "<html><title>TipMaster Trainer Saison Awards</title><p align=left><body bgcolor=white text=black>\n";

require "/tmapp/tmsrc/cgi-bin/tag.pl";
require "/tmapp/tmsrc/cgi-bin/tag_small.pl";

print "<br>\n";
print "<font face=verdana size=1>";
$trainer = $leut;

require "/tmapp/tmsrc/cgi-bin/loc.pl";
print "<br><font face=verdana size=2>&nbsp;<b>BTM - Trainer Saison Awards</b><br><br>";
print "<form method=post action=/cgi-bin/btm/award.pl target=_top>\n";
print "<font face=verdana size=1>";

@saison = @main_saison;

print "<select style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=sai>";
for ( $x = 1 ; $x <= $akt_saison + 1 ; $x++ ) {
	$saison[ $akt_saison + 6 ] = "Ranking ueber alle Saisons";
	$gh = "";
	if ( $x == $sai ) { $gh = "selected" }
	print "<option value=$x $gh>$saison[$x+5] \n";
}

print "</select> &nbsp; ";

print "<select style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=me>";

$gh = "";
if ( $me == 1 ) { $gh = "selected" }
print "<option value=1 $gh>Die Top - League Players \n";
$gh = "";
if ( $me == 2 ) { $gh = "selected" }
print "<option value=2 $gh>Die Quotenkoenige \n";

$gh = "";
if ( $me == 3 ) { $gh = "selected" }
print "<option value=3 $gh>Die Torschuetzenkoenige \n";
$gh = "";
if ( $me == 4 ) { $gh = "selected" }
print "<option value=4 $gh>Die Top - Optimizers \n";
$gh = "";
if ( $me == 5 ) { $gh = "selected" }
print "<option value=5 $gh>Die groessten Schiessbuden \n";
print "</select> &nbsp; &nbsp; ";

if ( $trainer ne "unknown" ) {
	print "<select style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=loss>";
	$gh = "";
	if ( $loss == 1 ) { $gh = "selected" }
	print "<option value=1 $gh>Alle Trainer \n";
	$gh = "";
	if ( $loss == 2 ) { $gh = "selected" }
	print "<option value=2 $gh>Nur Ligakonkurenten \n";
	$gh = "";
	if ( $loss == 3 ) { $gh = "selected" }
	print "<option value=3 $gh>Nur Adressbuch-Trainer \n";

	print "</select>&nbsp;&nbsp;\n";
}

print
"&nbsp;&nbsp<input type=hidden name=password value=\"$pass\"><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=id value=\"$id\"><input type=submit style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" value=\"Tabelle laden\"></form>";

print "<br>";
print
"<font face=verdana size=1>Die drei bestplazierten Trainer am Ende jeder Saison erhalten einen  offiziellen Traineraward<br>der entspr. Kategorie in Gold , Silber und Bronze welcher auch im Trainerprofil gelistet wird .<br><br>\n";

#if ( $me==1 ) { print "In dieser Tabelle werden alle Ergebnisse eines Trainers seit der Saison 1999'1 addiert .<br>Die Tabelle wird sortiert nach der Anzahl der erreichten Punkte .<br><br>" }
#if ( $me==2 ) { print "In dieser Tabelle werden alle erzielten Tipergebnisse seit der Saison 1999'1 gewertet .<br>Die Tabelle wird sortiert nach der bisherigen durchschnittlichen Tipquote des Trainers.<br><br>" }
#if ( $me==3 ) { print "In dieser Tabelle werden alle ueberfluessigen Tipergebnisse ueber die Torgrenzen hinaus seit der Saison 1999'1 gewertet .<br>Die Tabelle wird sortiert nach den durchschnittlich niedrigsten ueberfluessigen Tipresten des Trainers.<br><br>" }
#if ( $me==4 ) { print "In dieser Tabelle werden alle erzielten Tipergebnisse der Gegner eines Trainers seit der Saison 1999'1 gewertet .<br>Die Tabelle wird sortiert nach der bisherigen niedrigsten durchschnittlichen Tipquote der Gegner des Trainers.<br><br>" }
#if ( $me==5 ) { print "Diese Tabelle ist fuer die Vergabe von Trainerposten ueber die Jobboerse ausschlaggebend .<br>Fuer die Punktezahl eines Trainers sind zum einen die Tipquoten der letzten drei Saisons<br>eines Trainers sowie die aktuelle Vereinsplazierung des Trainers relevant .<br><br>" }

if ( $me == 4 ) {
	print
"<font size=1>&nbsp; Anmerkung: Der Optimizer Wert berechnet sich indem alle Quotenpunkte oberhalb einer Torgrenze,<br>
&nbsp; die zu
keinem weiteren Tor fuehrten, addiert und durch die Anzahl der absolvierten Spiele geteilt werden. <br>
&nbsp; Ein niedriger Optimizer Wert entspricht also einer effektiven und verlustarmen Umsetzung der erzielten<br>
&nbsp; eigenen Quotenpunkte in Tore durch den Trainer.<br><br>
";
}

print "Es gehen nur jene Trainer in die Wertung ein die in abgelaufenen Saisons alle 34 Spieltage <br>
absolviert haben bzw. in der aktuellen Saison alle bisher ausgetragenen Spieltage.<br><br>";

$marker = 20;
$grenze = 33;

if ( $sai == $akt_saison ) { $grenze = ($sp_ende) * 0.95 }

#if (($me==1)or($me==3)or($me==5)){$grenze=0}

$datei = "/tmdata/btm/stat_s" . $sai . ".txt";
if ( $sai == $akt_saison + 1 ) {
	$datei  = "/tmdata/btm/stat_at_aw$me.txt";
	$grenze = 0;
	$marker = 30;
}

open( D2, "<$datei" );
while (<D2>) {
	@boh = split( /&/, $_ );

	#if ($trainer =~ /$_/) { print $_ }

	if ( $boh[1] > $grenze ) {
		$rr++;
		(
			$trainer[$rr], $spiele[$rr], $pu_g[$rr], $s_g[$rr],  $u_g[$rr], $n_g[$rr], $tp_g[$rr],
			$tm_g[$rr],    $qp_g[$rr],   $qm_g[$rr], $op_g[$rr], $nix,      $sso[$rr]
		) = split( /&/, $_ );
		$sso[$rr] =~ s/Saison//g;
	}
}
close(D2);

if ( $me == 1 ) {
	for ( $ti = 1 ; $ti <= $rr ; $ti++ ) {
		$quoten[$ti] = $pu_g[$ti];
		$quoten[$ti] = $quoten[$ti] . '#';
		$xx          = 1500 + $tp_g[$ti] - $tm_g[$ti];
		$quoten[$ti] = $quoten[$ti] . $xx . '#';
		$quoten[$ti] = $quoten[$ti] . $tp_g[$ti] . '#';
		$quoten[$ti] = $quoten[$ti] . $ti;
	}
}

if ( $me == 2 ) {
	for ( $ti = 1 ; $ti <= $rr ; $ti++ ) {
		$quoten[$ti] = $qp_g[$ti];
		$quoten[$ti] = $quoten[$ti] . '#';
		$quoten[$ti] = $quoten[$ti] . $tp_g[$ti] . '#';
		$quoten[$ti] = $quoten[$ti] . $pu_g[$ti] . '#';
		$quoten[$ti] = $quoten[$ti] . $ti;
	}
}

if ( $me == 3 ) {
	for ( $ti = 1 ; $ti <= $rr ; $ti++ ) {
		$quoten[$ti] = $tp_g[$ti];
		$quoten[$ti] = $quoten[$ti] . '#';
		$quoten[$ti] = $quoten[$ti] . $qp_g[$ti] . '#';
		$quoten[$ti] = $quoten[$ti] . $pu_g[$ti] . '#';
		$quoten[$ti] = $quoten[$ti] . $ti;
	}
}

if ( $me == 4 ) {
	for ( $ti = 1 ; $ti <= $rr ; $ti++ ) {
		$xx          = 100 - $op_g[$ti];
		$quoten[$ti] = $xx;
		$quoten[$ti] = $quoten[$ti] . '#';
		$quoten[$ti] = $quoten[$ti] . $pu_g[$ti] . '#';
		$quoten[$ti] = $quoten[$ti] . $qp_g[$ti] . '#';
		$quoten[$ti] = $quoten[$ti] . $ti;
	}
}

if ( $me == 5 ) {
	for ( $ti = 1 ; $ti <= $rr ; $ti++ ) {
		$quoten[$ti] = $tm_g[$ti];
		$quoten[$ti] = $quoten[$ti] . '#';
		$quoten[$ti] = $quoten[$ti] . $qm_g[$ti] . '#';
		$quoten[$ti] = $quoten[$ti] . $pu_g[$ti] . '#';
		$quoten[$ti] = $quoten[$ti] . $ti;
	}
}
@ranks = ();
@king  = ();
@ident = ();

@ranks = sort @quoten;

@quoten = ();

$r = 0;
for ( $t = 1 ; $t <= $rr ; $t++ ) {
	$r--;
	( $leer, $leer, $leer, $ident[$t] ) = split( /#/, $ranks[$r] );
}

print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>\n";
print "<table border=0 cellpadding=1 cellspacing=1>\n";

print "<tr>\n";
print "<td class=ve bgcolor=#f5f5ff align=left>&nbsp;</td>\n";

print "<td class=ve bgcolor=#f5f5ff align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Trainer</td>\n";
if ( $sai == $akt_saison + 1 ) {
	print
"<td class=ve bgcolor=#f5f5ff align=left><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Saison</td>\n";

}
else {
	print
"<td class=ve bgcolor=#f5f5ff align=left colspan=2><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;aktueller Verein / Liga</td>\n";
}
print "<td class=ve bgcolor=#f5f5ff align=left>&nbsp;Sp.</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=center colspan=3><font face=verdana size=1>&nbsp;Bilanz&nbsp;</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=center>&nbsp;Tore&nbsp;</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=center>&nbsp;Pu.&nbsp;</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=center>&nbsp;Quote&nbsp;</td>\n";
print "<td class=ve bgcolor=#f5f5ff align=center>&nbsp;Optimizer&nbsp;</td>\n";
print "</tr>\n";

if ( $loss == 3 ) {
	&openDB(mbox);
	&getValue( $trainer, btm_adress, trainer );
	&closeDB(mbox);
	@outbox = split( /&/, $query );
	$out = scalar(@outbox);
}

for ( $t = 1 ; $t <= $rr ; $t++ ) {
	$ein = 0;

	$color = "black";
	if ( $trainer[ $ident[$t] ] eq $trainer ) { $color = "red" }
	if ( ( $t <= $marker ) or ( $trainer[ $ident[$t] ] eq $trainer ) ) { $ein = 1 }
	if ( $loss == 2 ) { $ein = 0 }
	if ( ( $liga{ $trainer[ $ident[$t] ] } == $liga{$trainer} ) and ( $loss == 2 ) ) { $ein = 1 }
	if ( $loss == 3 ) {
		$ein = 0;
		foreach $ta (@outbox) {
			if ( $trainer[ $ident[$t] ] eq $ta ) { $ein = 1 }
		}
	}

	if ( $ein == 1 ) {

		$col = "#f5f5ff";

		if ( $t < 4 ) { $col = "#e3e4ff" }
		if ( $t < 4 ) { $col = "#CACBF6" }

		$img = "";
		if ( $t == 1 ) { $img = "&nbsp;[Gold]&nbsp;" }
		if ( $t == 2 ) { $img = "&nbsp;[Silber]&nbsp;" }
		if ( $t == 3 ) { $img = "&nbsp;[Bronze]&nbsp;" }

		print "<tr>\n";
		print "<td bgcolor=$col align=right><font face=verdana size=1 color=$color>&nbsp;$img&nbsp;$t .&nbsp;</td>\n";
		$aa = $trainer[ $ident[$t] ];
		$aa =~ s/ /%20/g;
		print
"<td bgcolor=#eeeeff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;<a href=/cgi-mod/btm/trainer.pl?ident=$aa><img src=/img/h1.jpg border=0 alt=\"Trainerstatistik $trainer[$ident[$t]]\"></a>&nbsp;&nbsp;$trainer[$ident[$t]]&nbsp;&nbsp;</td>\n";
		$color = "black";
		$aa    = $verein{ $trainer[ $ident[$t] ] };
		$aa =~ s/ /%20/g;

		if ( $sai == $akt_saison + 1 ) {
			$co = "#f5f5ff";
			if ( $sso[ $ident[$t] ] == $akt_saison ) { $co = "#e3e4ff" }
			print
			  "<td bgcolor=$co align=center><font face=verdana size=1> &nbsp; $saison[$sso[$ident[$t]]+5] &nbsp; </td>";
		}
		else {

			if ( $aa eq "" ) {
				print
"<td bgcolor=#f5f5ff align=center colspan=2><font face=verdana size=1>Trainer nicht mehr beim BTM aktiv</td>";
			}
			else {
				print
"<td bgcolor=#f5f5ff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;<a href=/cgi-mod/btm/verein.pl?ident=$aa><img src=/img/h1.jpg border=0 alt=\"Vereinsstatistik $verein{$trainer[$ident[$t]]}\"></a>&nbsp;&nbsp;$verein{$trainer[$ident[$t]]}&nbsp;&nbsp;</td>\n";
				$pl = $platz{ $verein{ $trainer[ $ident[$t] ] } };
				if ( $pl < 10 ) { $pl = '0' . $pl }
				print
"<td class=ve bgcolor=#f5f5ff align=right><font color=$color>&nbsp;&nbsp;$liga_kuerzel[$liga{$trainer[$ident[$t]]}] ($pl.) &nbsp;</td>\n";
			}
		}

		print "<td class=ve bgcolor=#eeeeff align=right>&nbsp; $spiele[$ident[$t]]&nbsp;</td>\n";

		print "<td class=ve bgcolor=#e3e4ff align=right>&nbsp;$s_g[$ident[$t]]&nbsp;</td>\n";
		print "<td class=ve bgcolor=#e3e4ff align=right>&nbsp;$u_g[$ident[$t]]&nbsp;</td>\n";
		print "<td class=ve bgcolor=#e3e4ff align=right>&nbsp;$n_g[$ident[$t]]&nbsp;</td>\n";
		if   ( ( $me == 5 ) or ( $me == 3 ) ) { $color = "#CACBF6" }
		else                                  { $color = "#eeeeff" }
		print "<td class=ve bgcolor=$color align=center>&nbsp; $tp_g[$ident[$t]] : $tm_g[$ident[$t]] &nbsp;</td>\n";

		$pu_g[ $ident[$t] ] = $pu_g[ $ident[$t] ] * 1;

		if   ( $me == 1 ) { $color = "#CACBF6" }
		else              { $color = "#eeeeff" }
		print "<td class=ve bgcolor=$color align=right>&nbsp;&nbsp; $pu_g[$ident[$t]]&nbsp;&nbsp;</td>\n";

		#$qp_g[$ident[$t]]=$qp_g[$ident[$t]]*1;
		#$qm_g[$ident[$t]]=$qm_g[$ident[$t]]*1;
		#$op_g[$ident[$t]]=$op_g[$ident[$t]]*1;
		if   ( $me == 2 ) { $color = "#CACBF6" }
		else              { $color = "#eeeeff" }
		print "<td class=ve bgcolor=$color align=right>&nbsp;&nbsp;&nbsp;$qp_g[$ident[$t]]&nbsp;&nbsp;</td>\n";
		if   ( $me == 4 ) { $color = "#CACBF6" }
		else              { $color = "#eeeeff" }
		print "<td class=ve bgcolor=$color align=right>&nbsp;&nbsp;&nbsp;$op_g[$ident[$t]]&nbsp;&nbsp;</td>\n";

		print "</tr>";
	}
}

print "</table>\n";
print "</td></tr></table>\n";
print "<br><font size=1> &nbsp; => $rr Trainer in diesem Ranking gelistet <br>";
exit;

