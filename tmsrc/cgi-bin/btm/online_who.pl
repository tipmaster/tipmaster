#!/usr/bin/perl

=head1 NAME
	BTM online_who.pl

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
require "/tmapp/tmsrc/cgi-bin/btm_ligen.pl";
@liga_kurz = @liga_kuerzel;
require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl";

$t    = 0;
$rr   = 0;
$li   = 0;
$liga = 0;
open( D2, "/tmdata/btm/history.txt" );
while (<D2>) {

	$li++;
	@vereine = split( /&/, $_ );

	$y = 0;
	for ( $x = 1 ; $x < 19 ; $x++ ) {
		$y++;
		chomp $verein[$y];
		$datr[$x] = $vereine[$y];
		$y++;
		chomp $verein[$y];
		$datt[$x]           = $vereine[$y];
		$ja{ $datt[$x] }    = 1;
		$btm_l{ $datt[$x] } = $li;
		$btm{ $datt[$x] }   = $datr[$x];

		$ja{ $datt[$x] } = 1;
		$t++;
		$file[$t] = $datt[$x] . '.txt';
		$y++;
	}

}

close(D2);

$rr   = 0;
$li   = 0;
$liga = 0;
open( D2, "/tmdata/tmi/history.txt" );
while (<D2>) {

	$li++;
	@vereine = split( /&/, $_ );

	$y = 0;
	for ( $x = 1 ; $x < 19 ; $x++ ) {
		$y++;
		chomp $verein[$y];
		$datr[$x] = $vereine[$y];

		$y++;
		chomp $verein[$y];
		$datb[$x] = $vereine[$y];

		$tmi{ $datb[$x] }   = $datr[$x];
		$tmi_l{ $datb[$x] } = $li;

		if ( $ja{ $datt[$x] } != 1 ) {
			$t++;
			$file[$t] = $datt[$x] . '.txt';
		}
		$ja{ $datt[$x] } = 1;
		$y++;
	}

}

close(D2);

$gg = 0;
print "Content-type: text/html\n\n";

open( D3, "/tmdata/online_c.txt" );
$ccc = <D3>;
close(D3);

print "<title>TOP - TIP Rangliste</title>\n";
print "<body bgcolor=white text=black>\n";

print "<p align=left><body bgcolor=white text=black link=darkred link=darkred>\n";
require "/tmapp/tmsrc/cgi-bin/tag.pl";
require "/tmapp/tmsrc/cgi-bin/tag_small.pl";

print
"<br><br><font face=verdana size=2 color=darkred><b>Im Moment sind folgende $ccc Trainer beim TipMaster online :</b><br><br>\n";

print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>\n";
print "<table border=0 cellpadding=1 cellspacing=1>\n";

$liga_kuerzel[0] = "";
$liga_kurz[0]    = "";

open( D3, "/tmdata/online_who.txt" );
while (<D3>) {
	$vv = $_;
	chomp $vv;
	$x++;
	$on[$x] = $vv;
}
close(D3);

@on = sort @on;

foreach $t (@on) {
	$on[$x] = $t;
	if ( $on[$x] =~ / / ) {

		#print "$on[$x]<br>";
		print "<tr>\n";
		$rs = $on[$x];
		$rs =~ s/ /%20/g;
		$ein = 1;
		if ( $on[$x] =~ /&/ ) { $ein = 0; }
		if ( $ein == 1 ) {
			print
"<td nowrap align=left bgcolor=#eeeeff width=200><font face=verdana size=1>&nbsp;&nbsp;<a href=/cgi-bin/btm/trainer.pl?ident=$rs target=new><img src=/img/mi.gif border=0 alt=\"Message an $on[$x] senden\"></a>&nbsp;&nbsp;$on[$x] &nbsp; &nbsp; &nbsp; &nbsp;</td>\n";
			print
"<td nowrap align=left bgcolor=#eae8e8 width=170><font face=verdana size=1>&nbsp;&nbsp;$btm{$on[$x]}&nbsp; </td>\n";
			print
"<td nowrap align=center bgcolor=#eae8e8 width=60><font face=verdana size=1>&nbsp;$liga_kurz[$btm_l{$on[$x]}]&nbsp;</td>\n";

			print
"<td nowrap align=left bgcolor=#ddd9d9 width=170><font face=verdana size=1>&nbsp;&nbsp;$tmi{$on[$x]}&nbsp;&nbsp;</td>\n";
			print
"<td nowrap align=center bgcolor=#ddd9d9 width=60><font face=verdana size=1>&nbsp;$liga_kuerzel[$tmi_l{$on[$x]}]&nbsp;</td>\n";
		}
		print "</tr>\n";
	}

}
print "</table></td></tr></table>";
