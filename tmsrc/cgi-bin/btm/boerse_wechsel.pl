#!/usr/bin/perl

=head1 NAME
	BTM boerse_wechsel.pl

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

require "/tmapp/tmsrc/cgi-bin/btm_ligen.pl";

open( D2, "/tmdata/btm/heer.txt" );
while (<D2>) {

	@data = split( /&/, $_ );
	$liga{ $data[5] } = $data[1];

}
close(D2);

$wechsel = 0;
open( D2, "/tmdata/btm/wechsel.txt" );
while (<D2>) {

	$wechsel++;
	(
		$leer,               $wechsel0[$wechsel], $wechsel1[$wechsel], $wechsel2[$wechsel],
		$wechsel3[$wechsel], $wechsel5[$wechsel], $wechsel4[$wechsel]
	) = split( /&/, $_ );

}
close(D2);

print "Content-Type: text/html \n\n";

print "<title>TipMaster Job - Boerse / Vergangene Wechsel</title>\n";

print "<html><title>Job - Boerse</title><p align=left><body bgcolor=white text=black>\n";

require "/tmapp/tmsrc/cgi-bin/tag.pl";
require "/tmapp/tmsrc/cgi-bin/tag_small.pl";
print "<br>\n";
print "<table border=0 cellpadding=0 cellspacing=0><tr>";

require "/tmapp/tmsrc/cgi-bin/loc.pl";

print "<br><font face=verdana size=2>&nbsp;<b>Die letzten 80 vollzogenen Vereinswechsel :</b><br><br>\n";

print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black>\n";
print "<tr><td>\n";
print "<table border=0 cellpadding=1 cellspacing=1>\n";

for ( $x = $wechsel ; $x >= ( $wechsel - 80 ) ; $x-- ) {

	print "<tr>";

	print "<td align=left bgcolor=#eeeeff><font face=verdana size=1>&nbsp;&nbsp;$wechsel0[$x]&nbsp;&nbsp;</td> \n";
	print
"<td align=left bgcolor=#eeeeff><font face=verdana size=1>&nbsp; <img src=/img/h1.jpg> &nbsp;$wechsel2[$x]&nbsp;&nbsp; </td> \n";
	print "<td align=left bgcolor=#cbccff><font face=verdana size=1>&nbsp;Zum $wechsel1[$x] &nbsp;&nbsp;</td>\n";
	print
"<td align=center bgcolor=#cbccff><font face=verdana size=1>&nbsp;$liga_kuerzel[$liga{$wechsel1[$x]}]&nbsp;</td>\n";

	print "<td align=left bgcolor=#eeeeee><font face=verdana size=1>&nbsp;Von $wechsel3[$x] &nbsp;&nbsp;</td>\n";
	print
"<td align=center bgcolor=#eeeeee><font face=verdana size=1>&nbsp;$liga_kuerzel[$liga{$wechsel3[$x]}]&nbsp;</td>\n";

	if ( $wechsel4[$x] eq "" ) {
		print "<td align=right bgcolor=#eeeeff><font face=verdana size=1>&nbsp; Direkt &nbsp;</td>\n";

	}
	else {
		print "<td align=right bgcolor=#eeeeff><font face=verdana size=1>&nbsp; $wechsel4[$x] Bew.&nbsp;</td>\n";
	}
	print "</tr>\n";

}

print "</table>\n";
print "</td></tr></table>\n";
print "<br><br>";
$wechsel  = 0;
@wechsel1 = ();
@wechsel2 = ();
@wechsel3 = ();
@wechsel4 = ();
@wechsel5 = ();
open( D2, "/tmdata/btm/tausch_liste.txt" );

while (<D2>) {

	$wechsel++;
	(
		$leer,               $wechsel0[$wechsel], $wechsel1[$wechsel], $wechsel2[$wechsel],
		$wechsel3[$wechsel], $wechsel5[$wechsel], $wechsel4[$wechsel]
	) = split( /&/, $_ );

}
close(D2);
print "<font face=verdana size=2>&nbsp;<b>Die letzten 80 vollzogenen Vereinstaeusche :</b><br><br>\n";
print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black>\n";
print "<tr><td>\n";
print "<table border=0 cellpadding=1 cellspacing=1>\n";

for ( $x = $wechsel ; $x >= ( $wechsel - 80 ) ; $x-- ) {

	print "<tr>";

	print "<td align=left bgcolor=#eeeeff><font face=verdana size=1>&nbsp;&nbsp;$wechsel0[$x]&nbsp;&nbsp;</td> \n";
	print "<td align=center bgcolor=#cbccff><font face=verdana size=1>&nbsp;&nbsp;
$wechsel2[$x] [ jetzt $wechsel1[$x] $liga_kuerzel[$liga{$wechsel1[$x]}] ]&nbsp;&nbsp;</td>
 \n";
	print "<td align=center bgcolor=#eeeeee><font face=verdana size=1>&nbsp;&nbsp;
$wechsel4[$x] [ jetzt $wechsel3[$x] $liga_kuerzel[$liga{$wechsel3[$x]}] ]&nbsp;&nbsp;
</td>
 \n";

#print "<td align=left bgcolor=#cbccff><font face=verdana size=1>&nbsp;Zum $wechsel1[$x] &nbsp;&nbsp;</td>\n";
#print "<td align=center bgcolor=#cbccff><font face=verdana size=1>&nbsp;$liga_kuerzel[$liga{$wechsel1[$x]}]&nbsp;</td>\n";

#print "<td align=left bgcolor=#eeeeee><font face=verdana size=1>&nbsp;Von $wechsel3[$x] &nbsp;&nbsp;</td>\n";
#print "<td align=center bgcolor=#eeeeee><font face=verdana size=1>&nbsp;$liga_kuerzel[$liga{$wechsel3[$x]}]&nbsp;</td>\n";

	#print "<td align=right bgcolor=#eeeeff><font face=verdana size=1>&nbsp; $wechsel4[$x] Bew.&nbsp;</td>\n";

	print "</tr>\n";

}

print "</table>\n";
print "</td></tr></table>\n";

