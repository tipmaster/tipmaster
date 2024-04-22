#!/usr/bin/perl

=head1 NAME
	BTM suche.pl

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
$query = new CGI;
$such  = $query->param('suche');
$met   = $query->param('met');
$coach = $query->param('coach');

require "/tmapp/tmsrc/cgi-bin/btm_ligen.pl";
print "Content-Type: text/html \n\n";

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

print "<title>TipMaster Suchmaschine</title>\n";

require "/tmapp/tmsrc/cgi-bin/tag.pl";
require "/tmapp/tmsrc/cgi-bin/tag_small.pl";
print "<br><br>\n";
require "/tmapp/tmsrc/cgi-bin/loc.pl";

print "<font face=verdana size=3><br><br>\n";
print "&nbsp;<b>Willkommen bei der TipMaster.de - Suche</b><br>\n";
print "<font size=1><br>\n";
print
"&nbsp; Bei der TipMaster.net Suche koennen Sie alle <font color=deepblue>Vereinsnamen<font color=black> und <font color=deepkblue>Trainernamen<font color=black><br>\n";
print "&nbsp; <font color=black> der Trainer nach bestimmten Begriffe durchsuchen .\n";
print "<br>\n";

print "<font face=verdana size=1>\n";

print "<form action=/cgi-bin/btm/suche.pl method=post>\n";

print "&nbsp;&nbsp;<input type=text name=suche value=\"$such\" maxlength=25>\n";
print "<input type=submit value=Suchen>\n";
print "</form>\n";

if ( $met eq "FA" || $met eq "MA" ) {
	print "<br>";

	@days = ( 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday' );
	@months = (
		'January', 'February', 'March',     'April',   'May',      'June',
		'July',    'August',   'September', 'October', 'November', 'December'
	);
	$secs = localtime(time);
	( $sec, $min, $hour, $mday, $mon, $year, $wday ) = ( localtime( time + 0 ) )[ 0, 1, 2, 3, 4, 5, 6 ];
	$time = sprintf( "%02d:%02d:%02d", $hour, $min, $sec );
	$year += 1900;

	$date = "$months[$mon] $mday, $time";

	open( D, ">>/tmdata/cheaters.txt" );
	print D "$date#$met#BTM#$such#$trainer#none#\n";
	close(D);
	print
"<font color=darkred> &nbsp; Der Trainer $such wurde der Spielleitung als Fake-/Multiaccount<br> &nbsp; gemeldet und wir werden den Account umgehend ueberpruefen.<br><br><br><font color=black>";
}

print "<font face=verdana size=1>\n";

if ( ( $such eq "" ) or ( $such eq " " ) or ( $such eq "." ) ) {
	print "&nbsp; Sie haben keinen Suchbegriff angegeben ...<br><br>\n";
	exit;
}

if ( $hit > 100 ) {
	print
"&nbsp; Ihr Suchbegriff '$such' ergab mehr als 100 Treffer ...<br>&nbsp; Bitte konkretisieren Sie Ihren Begriff ...<br>\n";
	exit;
}

if ( $hit == 0 ) {
	print "&nbsp; Der Suchbegriff '$such' ergab keine Treffer ...<br><br>\n";
}
else {
	print "&nbsp; Der Suchbegriff '$such' ergab $hit Treffer ...<br><br>\n";
}

print "<table border=0>\n";

for ( $x = 1 ; $x <= $hit ; $x++ ) {

	print "<tr>\n";

	print "<form name=g$x action=/cgi-mod/btm/verein.pl method=post>\n";

	print "<input type=hidden name=li value=\"$liga[$hit_nr[$x]]\">\n";
	print "<input type=hidden name=ve value=\"$verein[$hit_nr[$x]]\">\n";

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
	  "<td align=right bgcolor=#CCCDF4><font face=verdana size=1>&nbsp;&nbsp;$platz. PLatz&nbsp;&nbsp;&nbsp;</td>\n";

	print "<form name=h$x action=/cgi-mod/btm/trainer.pl method=post>\n";

	print "<input type=hidden name=ident value=\"$datb[$hit_nr[$x]]\">\n";
	print "<input type=hidden name=liga value=\"$liga[$hit_nr[$x]]\">\n";
	print "<input type=hidden name=verein value=\"$verein[$hit_nr[$x]]\">\n";

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
	$tmp = $datb[ $hit_nr[$x] ];
	$tmp =~ s/ /%20/g;
	print
"<td align=center bgcolor=#FFCCCC><font size=1 face=verdana> &nbsp; Als <a href=suche.pl?met=FA&suche=$tmp>Fantasie-</a> /  <a href=suche.pl?met=MA&suche=$tmp>Multiaccount melden</a> &nbsp; </td>";
	print "</tr>\n";
}

print "</table>\n";
