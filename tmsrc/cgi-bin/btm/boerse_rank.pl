#!/usr/bin/perl

=head1 NAME
	BTM boerse_rank.pl

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
$query      = new CGI;
$verein     = $query->param('ve');
$liga       = $query->param('li');
$own_verein = $query->param('isb');
$own_liga   = $query->param('isa');

print "Content-Type: text/html \n\n";
print "<body bgcolor=#eeeeee>\n";

require "/tmapp/tmsrc/cgi-bin/btm_ligen.pl";
require "/tmapp/tmsrc/cgi-bin/btm/saison.pl";

$l_s[1] = $main_saison[ $main_nr - 1 ];
$l_s[2] = $main_saison[ $main_nr - 2 ];
$l_s[3] = $main_saison[ $main_nr - 3 ];

for ( $x = 1 ; $x <= 3 ; $x++ ) {
	$l_s[$x] =~ s/Saison 20//g;
}

$li = 0;

open( D2, "/tmdata/btm/history.txt" );
while (<D2>) {
	$li++;
	@vereine = split( /&/, $_ );

	$y = 0;
	for ( $x = 1 ; $x < 19 ; $x++ ) {
		$y++;
		chomp $vereine[$y];
		$data[$x] = $vereine[$y];
		$y++;
		chomp $vereine[$y];
		$datb[$x] = $vereine[$y];

		if ( ( $li == $liga ) and ( $x == $verein ) ) {
			$auswahl_verein = $data[$x];
			$auswahl_liga   = $liga;
			$auswahl_id     = $x;
		}
		if ( ( $own_liga == $li ) and ( $own_verein == $x ) ) {
			$trainer = $datb[$x];
		}

		$y++;
		chomp $vereine[$y];
		$datc[$x] = $vereine[$y];
		$verein_tr{ $datb[$x] } = $data[$x];

		#print "$datb[$x]<br>";
	}
}
close(D2);

$be = 0;
open( D2, "/tmdata/btm/boerse.txt" );
while (<D2>) {

	if ( $_ =~ /$auswahl_verein/ ) {
		$be++;
		@kohl          = ();
		@kohl          = split( /#/, $_ );
		$bewerber[$be] = $kohl[0];
		$anzahl[$be]   = $kohl[1];
		$t             = 1;
		for ( $x = 1 ; $x <= $anzahl[$be] ; $x++ ) {
			$t++;
			$leer = $kohl[$t];
			if ( $leer eq $auswahl_verein ) { $prio[$be] = $kohl[ $t + 1 ] }
			$t++;
		}
	}
}
close(D2);

for ( $xf = 1 ; $xf <= $be ; $xf++ ) {
	$bewerber_verein[$xf] = $verein_tr{ $bewerber[$xf] };
}

open( D2, "/tmdata/btm/heer.txt" );
while (<D2>) {

	@go                              = ();
	@go                              = split( /&/, $_ );
	$bewerber_verein_platz{"$go[5]"} = $go[0];
	$bewerber_verein_liga{"$go[5]"}  = $go[1];
	$bewerber_verein_basis{"$go[5]"} = $go[2];

	$cc = $auswahl_verein . '&';

	if ( $_ =~ /$cc/ ) {
		@go        = split( /&/, $_ );
		$job_platz = $go[0];
		$job_liga  = $go[1];
	}
}
close(D2);

for ( $xf = 1 ; $xf <= $be ; $xf++ ) {

	if ( $bewerber_verein_basis{ $bewerber_verein[$xf] } == 1 ) {
		$bewerber_punkte[$xf] = 300 - ( ( $bewerber_verein_platz{ $bewerber_verein[$xf] } - 1 ) * 3 );
	}
	if ( $bewerber_verein_basis{ $bewerber_verein[$xf] } == 2 ) {
		$bewerber_punkte[$xf] = 258 - ( ( $bewerber_verein_platz{ $bewerber_verein[$xf] } - 1 ) * 3 );
	}
	if ( $bewerber_verein_basis{ $bewerber_verein[$xf] } == 3 ) {
		$bewerber_punkte[$xf] = 216 - ( ( $bewerber_verein_platz{ $bewerber_verein[$xf] } - 1 ) * 3 );
	}
	if ( $bewerber_verein_basis{ $bewerber_verein[$xf] } == 4 ) {
		$bewerber_punkte[$xf] = 180 - ( ( $bewerber_verein_platz{ $bewerber_verein[$xf] } - 1 ) * 3 );
	}
	if ( $bewerber_verein_basis{ $bewerber_verein[$xf] } == 5 ) {
		$bewerber_punkte[$xf] = 150 - ( ( $bewerber_verein_platz{ $bewerber_verein[$xf] } - 1 ) * 3 );
	}
	if ( $bewerber_verein_basis{ $bewerber_verein[$xf] } == 6 ) {
		$bewerber_punkte[$xf] = 123 - ( ( $bewerber_verein_platz{ $bewerber_verein[$xf] } - 1 ) * 3 );
	}
	if ( $bewerber_verein_basis{ $bewerber_verein[$xf] } == 7 ) {
		$bewerber_punkte[$xf] = 99 - ( ( $bewerber_verein_platz{ $bewerber_verein[$xf] } - 1 ) * 3 );
	}
	if ( $bewerber_verein_basis{ $bewerber_verein[$xf] } == 8 ) {
		$bewerber_punkte[$xf] = 78 - ( ( $bewerber_verein_platz{ $bewerber_verein[$xf] } - 1 ) * 3 );
	}
	if ( $bewerber_verein_basis{ $bewerber_verein[$xf] } == 9 ) {
		$bewerber_punkte[$xf] = 60 - ( ( $bewerber_verein_platz{ $bewerber_verein[$xf] } - 1 ) * 3 );
	}
	if ( $bewerber_verein_basis{ $bewerber_verein[$xf] } == 10 ) {
		$bewerber_punkte[$xf] = 52 - ( ( $bewerber_verein_platz{ $bewerber_verein[$xf] } - 1 ) * 3 );
	}

	$pu_a[$xf] = $bewerber_punkte[$xf];
}

$r = 0;
open( D2, "/tmdata/btm/allquotes.txt" );
while (<D2>) {

	( $ff, $sp1[$xf], $qu1[$xf], $sp2[$xf], $qu2[$xf], $sp3[$xf], $qu3[$xf] ) = split( /&/, $_ );
	( $xx, $sp1{"$ff"}, $qu1{"$ff"}, $sp2{"$ff"}, $qu2{"$ff"}, $sp3{"$ff"}, $qu3{"$ff"} ) = split( /&/, $_ );

	#if ($qu1{"$ff"}<20) { $sp1{"$ff"} = "----" }
	#if ($qu2{"$ff"}<20) { $sp2{"$ff"}  = "----" }
	#if ($qu3{"$ff"}<20) { $sp3{"$ff"} = "----" }

	if ( $sp1{"$ff"} eq "" ) { $sp1{"$ff"} = "----" }
	if ( $sp2{"$ff"} eq "" ) { $sp2{"$ff"} = "----" }
	if ( $sp3{"$ff"} eq "" ) { $sp3{"$ff"} = "----" }
}
close(D2);

for ( $xf = 1 ; $xf <= $be ; $xf++ ) {
	$ff = $bewerber[$xf];

#if (($sp1{"$ff"} ne "----") and ( $sp1{"$ff"} > 30) ) { $bewerber_punkte[$xf] = int ( $bewerber_punkte[$xf] + ($sp1{"$ff"}-30)) }
#if (($sp2{"$ff"} ne "----") and ( $sp2{"$ff"} > 30) ) { $bewerber_punkte[$xf] = int ( $bewerber_punkte[$xf] + ($sp2{"$ff"}-30)) }
#if (($sp3{"$ff"} ne "----") and ( $sp3{"$ff"} > 30) ) { $bewerber_punkte[$xf] = int ( $bewerber_punkte[$xf] + ($sp3{"$ff"}-30)) }

	if ( ( $sp1{"$ff"} ne "----" ) and ( $sp1{"$ff"} > 0 ) ) {
		$bewerber_punkte[$xf] = int( $bewerber_punkte[$xf] + ( $sp1{"$ff"} - 0 ) );
	}
	if ( ( $sp2{"$ff"} ne "----" ) and ( $sp2{"$ff"} > 0 ) ) {
		$bewerber_punkte[$xf] = int( $bewerber_punkte[$xf] + ( $sp2{"$ff"} - 0 ) );
	}
	if ( ( $sp3{"$ff"} ne "----" ) and ( $sp3{"$ff"} > 0 ) ) {
		$bewerber_punkte[$xf] = int( $bewerber_punkte[$xf] + ( $sp3{"$ff"} - 0 ) );
	}

	$pu_b[$xf] = $bewerber_punkte[$xf] - $pu_a[$xf];

}

for ( $xf = 1 ; $xf <= $be ; $xf++ ) {
	$y = "";
	if ( $bewerber_punkte[$xf] < 100 ) { $y = "0" }
	if ( $bewerber_punkte[$xf] < 10 )  { $y = "00" }

	$y1 = "";
	if ( $pu_b[$xf] < 100 ) { $y1 = "0" }
	if ( $pu_b[$xf] < 10 )  { $y1 = "00" }

	$x = "00";
	if ( $xf > 9 )  { $x = "0" }
	if ( $xf > 99 ) { $x = "" }
	$rank[$xf] = $y . $bewerber_punkte[$xf] . $y1 . $pu_b[$xf] . '#' . $x . $xf;
}

@folge = sort @rank;

for ( $xf = 1 ; $xf <= $be ; $xf++ ) {
	( $egal, $place[$xf] ) = split( /#/, $folge[$xf] );
}

print "<title>Bewerbungs - Ranking $auswahl_verein</title><body bgcolor=#eeeeee>\n";
print "<center>\n";

require "/tmapp/tmsrc/cgi-bin/tag.pl";
require "/tmapp/tmsrc/cgi-bin/tag_small.pl";

print "<br><br>";
print "<table border=0  cellpadding=0 cellspacing=0 bgcolor=black>\n";
print "<tr><td>\n";
$pl = 0;
print "<table border=0 cellpadding=2 cellspacing=1>\n";

print "<tr><td colspan=4 align=center bgcolor=#d2d2d2><font face=verdana size=1>
Bewerbungs - Ranking $auswahl_verein</u>  ( $liga_kuerzel[$job_liga] / $job_platz .Platz )
</td>
<td colspan=3 bgcolor=#d2d2d2 align=center>
<font face=verdana size=1 align=center>erzielte Tore<br> &nbsp; $l_s[3] &nbsp; $l_s[2] &nbsp; $l_s[1] &nbsp; </td>
<td colspan=3 align=center bgcolor=#d2d2d2><font face=verdana size=1>
Punkte<br> &nbsp; [ Liga-Pu. + Tore ] &nbsp;  </td>
</tr>";

for ( $xf = $be ; $xf >= 1 ; $xf-- ) {
	$pl++;
	if ( ( $pl < 11 ) or ( $bewerber[ $place[$xf] ] eq $trainer ) ) {

		print "<tr>";
		print "<td bgcolor=#f5f5ff align=right><font face=verdana size=1>&nbsp;&nbsp;$pl .&nbsp;</td>\n";

		$color = black;
		if ( $bewerber[ $place[$xf] ] eq $trainer ) { $color = "red" }

		open( D2, "/tmdata/btm/wechsel.txt" );
		$xxx = '&' . $bewerber[ $place[$xf] ] . '&';
		while (<D2>) {
			if ( $_ =~ /$xxx/ ) {
				$color = "lightred";
			}
		}
		close(D2);
		print
"<form action=/cgi-mod/btm/trainer.pl method=post name=x$xf target=new><input type=hidden name=ident value=\"$bewerber[$place[$xf]]\"></form>\n";

		print
"<td bgcolor=#eeeeff align=left><font face=verdana size=1 color=$color>&nbsp;&nbsp;<a href=javascript:document.x$xf.submit()><img src=/img/h1.jpg border=0 alt=\"Trainerstatistik $bewerber[$place[$xf]]\"></a>&nbsp;&nbsp;$bewerber[$place[$xf]]&nbsp;&nbsp;&nbsp;&nbsp; </td>\n";

		print
"<td bgcolor=#e3e4ff align=left><font face=verdana size=1>&nbsp;&nbsp;$bewerber_verein[$place[$xf]]&nbsp;&nbsp;</td>\n";
		$space = "";
		if ( $bewerber_verein_platz{ $bewerber_verein[ $place[$xf] ] } < 10 ) { $space = 0 }
		print
"<td bgcolor=#e3e4ff align=right><font face=verdana size=1>&nbsp;&nbsp;$liga_kuerzel[$bewerber_verein_liga{$bewerber_verein[$place[$xf]]}] ($space$bewerber_verein_platz{$bewerber_verein[$place[$xf]]}.) &nbsp;</td>\n";

#print "<td bgcolor=#e3e4ff align=right><font face=verdana size=1>&nbsp;&nbsp;$bewerber_verein_platz{$bewerber_verein[$place[$xf]]} . Platz&nbsp;&nbsp;</td>\n";
		$ff = $bewerber[ $place[$xf] ];

		if ( $sp1{$ff} eq "" ) { $sp1{$ff} = "----" }
		if ( $sp2{$ff} eq "" ) { $sp2{$ff} = "----" }
		if ( $sp3{$ff} eq "" ) { $sp3{$ff} = "----" }

		print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;&nbsp;$sp1{$ff}&nbsp;&nbsp;</td>\n";
		print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;&nbsp;$sp2{$ff}&nbsp;&nbsp;</td>\n";
		print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;&nbsp;$sp3{$ff}&nbsp;&nbsp;</td>\n";

		print
"<td bgcolor=#e3e4ff align=center><font face=verdana size=1>&nbsp;&nbsp;$pu_a[$place[$xf]] + $pu_b[$place[$xf]]&nbsp;&nbsp;</td>\n";

		print
"<td bgcolor=#CACBF6 align=right><font face=verdana size=1>&nbsp;&nbsp;$bewerber_punkte[$place[$xf]]&nbsp;&nbsp;</td>\n";
		if ( $prio[$xf] == 5 ) { $c = "sehr hoch" }
		if ( $prio[$xf] == 4 ) { $c = "hoch" }
		if ( $prio[$xf] == 3 ) { $c = "mittel" }
		if ( $prio[$xf] == 2 ) { $c = "niedrig" }
		if ( $prio[$xf] == 1 ) { $c = "sehr niedrig" }

 #print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;&nbsp;$c&nbsp;&nbsp;</td>\n";
 #print "<td bgcolor=#eeeeff align=right><font face=verdana size=1>&nbsp;&nbsp;$anzahl[$place[$xf]]&nbsp;&nbsp;</td>\n";

		print "</tr>";
	}
}
print "</table></td></tr></table>";
print
"<br><center><font face=verdana size=1>&nbsp; Als Bewertungsgrundlage fuer die Vergabe der Trainerposten gilt zum einen der aktuelle Tabellenplatz<br>&nbsp; in der entprechenden Liga , sowie die persoenliche erzielten Tore der letzten drei Saisons .<br><br>Blau markierte Trainer haben in dieser Saison bereits einmal Ihren Verein ueber die<br>Job - Boerse gewechselt und werden daher bei der Vergabe nicht beruecksichtigt .\n";

