#!/usr/bin/perl

=head1 NAME
	BTM boerse_mail.pl

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

print "Content-type: text/html\n\n";
$frei = 0;
$gh   = 0;
$liga = 0;

open( D2, "/tmdata/btm/history.txt" );
while (<D2>) {
	$liga++;
	$liga_aktuell = $liga;
	@vereine = split( /&/, $_ );

	if ( $liga < 129 ) {
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
}
$bewerb = 0;
for ( $x = 1 ; $x <= $frei ; $x++ ) {
	$zwischen = $query->param( $auswahl_verein[$x] );

	$rr   = $auswahl_verein[$x] . '_id';
	$prio = $query->param($rr);

	if ( $zwischen eq "yes" ) {
		$bewerb++;
		$bewerbung           = $bewerbung . $auswahl_verein[$x] . '#' . $prio . '#';
		$bewerbos[$bewerb]   = $auswahl_verein[$x];
		$bewerbos_p[$bewerb] = $prio;
	}
}

$bewerbung = $trainer . '#' . $bewerb . '#' . $bewerbung;

$at = 0;
read1:

$ein = 0;
$s   = 0;
open( D2, "/tmdata/btm/boerse.txt" );
flock( D2, 2 );
while (<D2>) {
	$s++;
	$linos[$s] = $_;
	( $coach, $egal ) = split( /#/, $_ );
	if ( $coach eq $trainer ) {
		$ein = 1;
		$linos[$s] = $bewerbung;
	}
	chomp $linos[$s];
}
flock( D2, 2 );
close(D2);

if ( $s == 0 && $at < 10 ) { $at++; sleep 1; goto read1; }

if ( $ein == 0 ) {
	$s++;
	$linos[$s] = $bewerbung;
}

open( D2, ">/tmdata/btm/boerse.txt" );
flock( D2, 2 );
for ( $x = 1 ; $x <= $s ; $x++ ) {
	print D2 "$linos[$x]\n";
}
flock( D2, 8 );
close(D2);

print
"<form name=Testform action=/cgi-bin/btm/boerse.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=pass value=\"$pass\"></form>";
print "<script language=JavaScript>";
print "   function AbGehts()";
print "   {";
print "    document.Testform.submit();";
print "    }";
print "   window.setTimeout(\"AbGehts()\",5000);";
print "  </script>";

print "<body bgcolor=white text=black><font color=black face=verdana size=1>\n";

if ( $bewerb != 0 ) {
	print "<td valign=top align=left>\n";

	require "/tmapp/tmsrc/cgi-bin/tag.pl";
	require "/tmapp/tmsrc/cgi-bin/tag_small.pl";

	print
"<br><br><font face=verdana size=2><b>Sehr geehrte(r) $trainer ,</b><font face=verdana size=1><br><br>es wurden folgende Bewerbungen von Ihnen an diese Vereine verschickt :<br><br>\n";

	for ( $x = 1 ; $x <= $bewerb ; $x++ ) {
		if ( $bewerbos_p[$x] == 1 ) { $xc = "sehr niedrig" }
		if ( $bewerbos_p[$x] == 2 ) { $xc = "niedrig" }
		if ( $bewerbos_p[$x] == 3 ) { $xc = "mittel" }
		if ( $bewerbos_p[$x] == 4 ) { $xc = "hoch" }
		if ( $bewerbos_p[$x] == 5 ) { $xc = "sehr hoch" }

		print " &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$bewerbos[$x] &nbsp;&nbsp;&nbsp; ( Prioritaet : $xc )<br>\n";
	}
	print "<br><br>Wir wuenschen Ihnen bei Ihren Bewerbungen viel Erfolg !<br>";
	print
	  "Ihre aktuelle Bewerbungs - Plazierung koennen Sie jederzeit<br>auf der Seite der Job - Boerse abfragen .<br>";
	print
"<br><font color=darkred>Achtung: Wenn Sie den Verein ueber die Job - Boerse wechseln ist bis zum Freitag<br>bereits eine Tipabgabe fuer Ihren neuen Verein notwendig da Ihnen sonst eine<br>verpasste Tipabgabe angerechnet wird - auch wenn sie fuer ihren alten Verein<br>bereits getippt haben.<br>\n";
	print "<br><br><font color=black>Sie werden in 5 Sek. zur Job Boerse weiter geleitet ...";
}

if ( $bewerb == 0 ) {

	print "<body bgcolor=#eeeeee text=black><font face=verdana size=1>";
	print
"<br><font face=verdana size=1>Sehr geehrte(r) $trainer ,<br><br>es wurden von Ihnen keine Vereine zur Bewerbung ausgewaehlt<br>beziehungsweise alle ihre Bewerbungen wurden ruckgaengig gemacht .<br><br><br><br>Sie werden in 10 Sek. zur Menuseite weiter geleitet ...";
}
exit;

