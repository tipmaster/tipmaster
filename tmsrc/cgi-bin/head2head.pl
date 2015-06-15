#!/usr/bin/perl

=head1 NAME
	head2head.pl

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
$query    = new CGI;
$id1      = $query->param('id1');
$id2      = $query->param('id2');
$location = $query->param('loc');

require "/tmapp/tmsrc/cgi-bin/lib.pl";
$tmp = "/tmapp/tmsrc/cgi-bin/" . $location . "/saison.pl";
require "$tmp";
$tmp = "/tmapp/tmsrc/cgi-bin/" . $location . "_ligen.pl";
require "$tmp";

&readin_vereinsid($location);
print "Content-Type: text/html \n\n";
print "<html><title>Bilanz $gl_vereinsname[$id1] - $gl_vereinsname[$id2]</title>
<body bgcolor=white text=black vlink=blue link=blue><font face=verdana size=1><center>\n";

require "/tmapp/tmsrc/cgi-bin/tag.pl";
require "/tmapp/tmsrc/cgi-bin/tag_small.pl";
print "<br><br>\n";

$h2h    = &get_head2head( $location, $id1, $id2 );
@bilanz = &get_balance($h2h);
@games  = &head2head_games($h2h);
print
"<br><font face=verdana size=2><b>Bilanz $gl_vereinsname[$id1] - $gl_vereinsname[$id2] <font color=darkred> &nbsp; &nbsp; $bilanz[0] - $bilanz[1] - $bilanz[2]</b><br><br>";

$file = "/tmdata/" . $location . "/db/head2head/" . $id1 . ".txt";

#print $file;
open( A, "$file" );

while (<A>) {
	@tmp = split( /\!/, $_ );
	@bilanz = &get_balance( &get_head2head( $location, $id1, $tmp[0] ) );
	$pkt = ( ( ( ( $bilanz[0] * 3 ) + $bilanz[1] ) ) / ( $bilanz[0] + $bilanz[1] + $bilanz[2] ) ) + 1000;
	$sp = $bilanz[1] + $bilanz[0] + $bilanz[2] + 1000;
	$string =
	    $gl_vereinsname[ $tmp[0] ] . '#'
	  . $bilanz[0] . ' - '
	  . $bilanz[1] . ' - '
	  . $bilanz[2] . '#'
	  . $gl_vereinsname[ $tmp[0] ] . '#'
	  . $tmp[0] . '#'
	  . ( $sp - 1000 );
	push( @array, $string );
}
close(A);

@arrays = ( sort @array );
print
"<form action=head2head.pl method=post><input type=hidden name=id1 value=$id1><input type=hidden name=loc value=$location>";
print "<select name=id2 $gl_{style}>";
foreach (@arrays) {
	@tmp = split( /#/, $_ );

	$g = "";
	if ( $id2 == $tmp[3] ) { $g = " selected" }
	print "<option value=$tmp[3]$g>$tmp[2] [ $tmp[4] Sp. | $tmp[1] ] \n";

}
print "</select> &nbsp; &nbsp; <input type=submit $gl_{style} value=\"Anzeigen\"></form><br>";

print "<TABLE CELLSPACING=0 CELLPADDING=2 BORDER=0>";

$nr = 0;
foreach (@games) {
	@tmp     = split( /#/, $_ );
	$this    = 100000 + $tmp[0];
	$gg[$nr] = $this . '#' . $_;

	$nr++;
}

@gg = reverse( sort @gg );

foreach (@gg) {
	$t++;
	$color = "#eeeeee";
	if ( $t % 2 == 0 ) { $color = "white" }
	@tmp = split( /#/, $_ );

	$sp = ( ( $tmp[1] - 1 ) % 34 ) + 1;

	$saison = int( $tmp[1] / 34 ) + 4;

	if ( $sp < 10 ) { $sp = '0' . $sp }
	print "<TR BGCOLOR=$color>

<td align=center><font face=verdana size=1>
&nbsp; $main_saison[$saison]  &nbsp; &nbsp;
</td>

<td align=center><font face=verdana size=1>
Sp. $sp &nbsp; &nbsp; 
</td>

<td align=center><font face=verdana size=1>
[$liga_kuerzel[$tmp[2]]] *&nbsp; &nbsp;
</td>


";

	$f1 = "";
	$f2 = "";
	if ( $tmp[3] eq "H" ) {
		if ( $tmp[6] > $tmp[7] ) { $f1 = "<b>" }
		if ( $tmp[7] > $tmp[6] ) { $f2 = "<b>" }

		print "<td align=left><font face=verdana size=1>
 $f1$gl_vereinsname[$id1]</b> - $f2$gl_vereinsname[$id2]</b>  &nbsp; &nbsp;  </td>";

		$x1 = 6;
		$x2 = 7;

	}
	else {

		if ( $tmp[6] > $tmp[7] ) { $f2 = "<b>" }
		if ( $tmp[7] > $tmp[6] ) { $f1 = "<b>" }

		print "<td align=left><font face=verdana size=1>
 $f1$gl_vereinsname[$id2]</b> - $f2$gl_vereinsname[$id1]</b>  &nbsp; &nbsp; </td>";
		$x1 = 7;
		$x2 = 6;
	}

	print "
<td align=center><font face=verdana size=1>
&nbsp; &nbsp; $tmp[$x1] : $tmp[$x2] &nbsp; &nbsp;
</td>
<td align=center><font face=verdana size=1>	
 &nbsp; [ $tmp[$x1-2] - $tmp[$x2-2] ] &nbsp; 
</td>


";
	print "</TR>
<tr>
<td colspan=14 bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>
</TR>

";
}
print "</table><br><br><font face=verdana size=1> &nbsp; (*) = unter Vorbehalt";
exit;

