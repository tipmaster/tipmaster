#!/usr/bin/perl

=head1 NAME
	druck_tip.pl

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
use CGI;
my $session = TMSession::getSession();
my $coach = $query->param('coach');


$mailprog = '/usr/sbin/sendmail';
require "/tmapp/tmsrc/cgi-bin/runde.pl";
$spielrunde_ersatz = ( $rrunde * 4 ) - 3;

print "Content-type:text/html\n\n";
print "<title>Tippuebersicht $coach der $rrunde. Tipprunde</title><center>";
print "<form action=druck_tip.pl method=post>
<input type=text style=\"font-family:verdana;font-size=11px\" size=20 value=\"$coach\" name=coach>
<input type=submit value=\"Tipps laden\"  style=\"font-family:verdana;font-size=11px\">";

&daten_btm;
end2:
&daten_tmi;

sub daten_btm {
	require "/tmapp/tmsrc/cgi-bin//btm_ligen.pl";

	$rf = "0";
	$rx = "x";
	if ( $liga > 9 ) { $rf = "" }
	$liga  = 0;
	$suche = '&' . $coach. '&';
	$s     = 0;
	open( D2, "/tmdata/btm/history.txt" );
	while (<D2>) {
		$s++;
		if ( $_ =~ /$suche/ ) {
			@lor = split( /&/, $_ );
			$liga = $s;
		}

	}
	close(D2);
	if ( $liga == 0 ) { goto end2; }

	$y = 0;
	for ( $x = 1 ; $x < 19 ; $x++ ) {
		$y++;
		chomp $lor[$y];
		$data[$x] = $lor[$y];
		$y++;
		chomp $lor[$y];
		$datb[$x] = $lor[$y];
		if ( $datb[$x] eq $coach) { $id    = $x }
		if ( $datb[$x] eq $coach ) { $team = $data[$x] }
		$y++;
		chomp $lor[$y];
		$datc[$x] = $lor[$y];
		if ( $datb[$x] eq $coach ) { $recipient = $datc[$x] }
	}
	$verein = $id;

	open( D7, "/tmdata/btm/tip_status.txt" );
	$tip_status = <D7>;
	chomp $tip_status;
	close(D7);

	$bx = "formular";
	$by = $rrunde;

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
		$datum[$y]    = $ega[7];
		$uhr[$y]      = $ega[8];
		$datum[$y] =~ s/200[2-9]//;
	}
	open( D2, "/tmdata/btm/heer.txt" );
	while (<D2>) {
		@go                     = ();
		@go                     = split( /&/, $_ );
		$verein_platz{ $go[5] } = $go[0];
	}
	close(D2);
	open( D9, "/tmdata/btm/spieltag.txt" );
	while (<D9>) {
		@ego = <D9>;
	}
	close(D9);

	$fa = 0;

	for ( $spieltag = 0 ; $spieltag < 34 ; $spieltag++ ) {

		@ega = split( /&/, $ego[$spieltag] );
		for ( $x = 0 ; $x < 18 ; $x = $x + 2 ) {

			$gc = ( $spieltag % 4 ) * 18;

			$tora = 0;

			$torb = 0;
			$y    = $x + 1;
			$wa   = $x - 1;
			$wb   = $y - 1;
			if ( $ega[$x] == $id ) {
				$verein1[$spieltag] = $ega[$x];
				$verein2[$spieltag] = $ega[$y];

				$ort[$spieltag] = "H";
				$tip[$spieltag] = $gc + $x + 1;
			}

			if ( $ega[$y] == $id ) {
				$verein1[$spieltag] = $ega[$x];
				$verein2[$spieltag] = $ega[$y];

				$ort[$spieltag] = "A";
				$tip[$spieltag] = $gc + $x + 1;
			}

		}
	}

	if ( $liga < 10 ) { $liga = '0' . $liga }
	$rr    = $rrunde;
	$line  = 0;
	$datei = "/tmdata/btm/tipos/QU" . $liga . "S" . $rr . ".TXT";

	open( D, "<$datei" );
	while (<D>) {
		$line++;
		$tip_line[$line] = $_;
		chomp $tip_line[$line];
	}
	close(D);

	$rg = 0;
	for ( $spieltag = $spielrunde_ersatz + 3 ; $spieltag < $spielrunde_ersatz + 7 ; $spieltag++ ) {
		$rg++;
		$hier_gegner[$rg] = $data[ $gegner[$spieltag] ];
		$hier_ort[$rg]    = $ort[$spieltag];
		$hier_platz[$rg]  = $verein_platz{ $data[ $gegner[$spieltag] ] };
	}

	$rr = $spielrunde_ersatz + 2;
	if ( $rr > 33 ) { $rr = 33 }

	print
"<table border=0 cellpadding=1 cellspacing=0><tr><td align=center bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td><td><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td><td>";

	for ( $x = $spielrunde_ersatz - 1 ; $x <= $rr ; $x++ ) {
		$ss = $x + 1;
		print "<TABLE CELLSPACING=0 CELLPADDING=1 BORDER=0 width=100%>";
		if ( $x == $spielrunde_ersatz - 1 ) {
			print "<tr><td colspan=7 bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr>";
		}
		print "<TR BGCOLOR=white>";
		print "<td colspan=7 align=center><font face=verdana size=1>$liga_namen[$liga] - $ss. Spieltag</td></tr>";
		print "<tr><td colspan=7 bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr>";
		print "<TR BGCOLOR=#e0e0e0>";
		print "<td colspan=3 align=right><font face=verdana size=1>$data[$verein1[$x]] &nbsp; </td>";
		print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
		print "<td colspan=3 align=left height=20><font face=verdana size=1>&nbsp; $data[$verein2[$x]] </td></tr>";

		$tip1 = $tip_line[ $tip[$x] + 1 ];
		$tip2 = $tip_line[ $tip[$x] + 2 ];

		print "<tr bgcolor=#efefef>";

		@all = split( /,/, $tip1 );

		#print "<td colspan=1 align=right valign=top><font face=verdana size=1>";
		#for($a=1;$a<=5;$a++){
		#$dd=($a*2)-1;
		#print " &nbsp; &nbsp; $datum[$all[$dd]] &nbsp;$uhr[$all[$dd]] &nbsp; <br>";
		#}; print "</td>";

		print "<td colspan=1 align=right valign=top width=225><font face=verdana size=1>";
		for ( $a = 1 ; $a <= 5 ; $a++ ) {
			$dd = ( $a * 2 ) - 1;

			$tmp  = "";
			$tmp1 = "";
			if ( $ergebnis[ $all[$dd] ] != 0 && $ergebnis[ $all[$dd] ] == $all[ $dd - 1 ] ) {
				$tmp  = "<font color=green>";
				$tmp1 = "<font color=black>";
			}
			if ( $ergebnis[ $all[$dd] ] != 0 && $ergebnis[ $all[$dd] ] != $all[ $dd - 1 ] ) {
				$tmp  = "<font color=red>";
				$tmp1 = "<font color=black>";
			}
			if ( $ergebnis[ $all[$dd] ] == 4 ) { $tmp = "<font color=gray>"; $tmp1 = "<font color=black>" }

			print "&nbsp; &nbsp; $tmp $paarung[$all[$dd]] $tmp1<br>";
		}
		print "</td>\n";

		print "<td colspan=1 align=right valign=top><font face=verdana size=1>";
		for ( $a = 1 ; $a <= 5 ; $a++ ) {
			$dd = ( $a * 2 ) - 1;
			$ee = $all[ $dd - 1 ];
			if ( $all[ $dd - 1 ] == 2 ) { $ee = 0 }
			if ( $all[ $dd - 1 ] == 3 ) { $ee = 2 }

			print " &nbsp; Tip $ee<br>";
		}
		print "</td>\n";

		print "<td colspan=1 align=right valign=top><font face=verdana size=1>";
		for ( $a = 1 ; $a <= 5 ; $a++ ) {
			$dd = ( $a * 2 ) - 1;
			if ( $all[ $dd - 1 ] == 1 ) { $ee = $qu_1[ $all[$dd] ] }
			if ( $all[ $dd - 1 ] == 2 ) { $ee = $qu_0[ $all[$dd] ] }
			if ( $all[ $dd - 1 ] == 3 ) { $ee = $qu_2[ $all[$dd] ] }

			print "&nbsp; $ee &nbsp;<br>";
		}
		print "</td>\n";

		print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

################################## VEREIN 2 ######################

		@all = split( /,/, $tip2 );

		print "<td colspan=1 align=right valign=top><font face=verdana size=1>";
		for ( $a = 1 ; $a <= 4 ; $a++ ) {
			$dd = ( $a * 2 ) - 1;
			if ( $all[ $dd - 1 ] == 1 ) { $ee = $qu_1[ $all[$dd] ] }
			if ( $all[ $dd - 1 ] == 2 ) { $ee = $qu_0[ $all[$dd] ] }
			if ( $all[ $dd - 1 ] == 3 ) { $ee = $qu_2[ $all[$dd] ] }

			print "&nbsp; $ee<br>";
		}
		print "</td>\n";

		print "<td colspan=1 align=right valign=top><font face=verdana size=1>";
		for ( $a = 1 ; $a <= 4 ; $a++ ) {
			$dd = ( $a * 2 ) - 1;
			$ee = $all[ $dd - 1 ];
			if ( $all[ $dd - 1 ] == 2 ) { $ee = 0 }
			if ( $all[ $dd - 1 ] == 3 ) { $ee = 2 }

			print " &nbsp; Tip $ee &nbsp;<br>";
		}
		print "</td>\n";

		print "<td colspan=1 align=left valign=top width=225><font face=verdana size=1>";
		for ( $a = 1 ; $a <= 4 ; $a++ ) {
			$dd = ( $a * 2 ) - 1;

			$tmp  = "";
			$tmp1 = "";
			if ( $ergebnis[ $all[$dd] ] != 0 && $ergebnis[ $all[$dd] ] == $all[ $dd - 1 ] ) {
				$tmp  = "<font color=green>";
				$tmp1 = "<font color=black>";
			}
			if ( $ergebnis[ $all[$dd] ] != 0 && $ergebnis[ $all[$dd] ] != $all[ $dd - 1 ] ) {
				$tmp  = "<font color=red>";
				$tmp1 = "<font color=black>";
			}
			if ( $ergebnis[ $all[$dd] ] == 4 ) { $tmp = "<font color=gray>"; $tmp1 = "<font color=black>" }

			print "$tmp $paarung[$all[$dd]] $tmp1 &nbsp; &nbsp; <br>";
		}
		print "</td>\n";

		#print "<td colspan=1 align=center valign=top><font face=verdana size=1>";
		#for($a=1;$a<=4;$a++){
		#$dd=($a*2)-1;
		#print " &nbsp; &nbsp; $uhr[$all[$dd]] &nbsp;$datum[$all[$dd]] &nbsp; <br>";
		#}; print "</td>";

########################## ENDE #####################################

		print "</tr>";

		print "<tr><td colspan=7 bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr>";

		print "</table>\n";
	}
	print "<br>";
}

sub daten_tmi {
	require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl";

	$rf = "0";
	$rx = "x";
	if ( $liga > 9 ) { $rf = "" }

	$liga  = 0;
	$suche = '&' . $coach. '&';
	$s     = 0;
	open( D2, "/tmdata/tmi/history.txt" );
	while (<D2>) {
		$s++;
		if ( $_ =~ /$suche/ ) {
			@lor = split( /&/, $_ );
			$liga = $s;
		}

	}
	close(D2);
	if ( $liga == 0 ) { goto end1; }

	$y = 0;
	for ( $x = 1 ; $x < 19 ; $x++ ) {
		$y++;
		chomp $lor[$y];
		$data[$x] = $lor[$y];
		$y++;
		chomp $lor[$y];
		$datb[$x] = $lor[$y];
		if ( $datb[$x] eq $coach) { $id    = $x }
		if ( $datb[$x] eq $coach ) { $team= $data[$x] }
		$y++;
		chomp $lor[$y];
		$datc[$x] = $lor[$y];
		if ( $datb[$x] eq $coach) { $recipient = $datc[$x] }
	}
	$verein = $id;

	open( D7, "/tmdata/tmi/tip_status.txt" );
	$tip_status = <D7>;
	chomp $tip_status;
	close(D7);

	$bx = "formular";
	$by = $rrunde;

	$bv          = ".txt";
	$fg          = "/tmdata/tmi/";
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
		$datum[$y]    = $ega[7];
		$uhr[$y]      = $ega[8];
		$datum[$y] =~ s/200[2-9]//;
	}
	open( D2, "/tmdata/tmi/heer.txt" );
	while (<D2>) {
		@go                     = ();
		@go                     = split( /&/, $_ );
		$verein_platz{ $go[5] } = $go[0];
	}
	close(D2);
	open( D9, "/tmdata/tmi/spieltag.txt" );
	while (<D9>) {
		@ego = <D9>;
	}
	close(D9);

	$fa = 0;

	for ( $spieltag = 0 ; $spieltag < 34 ; $spieltag++ ) {

		@ega = split( /&/, $ego[$spieltag] );
		for ( $x = 0 ; $x < 18 ; $x = $x + 2 ) {

			$gc = ( $spieltag % 4 ) * 18;

			$tora = 0;

			$torb = 0;
			$y    = $x + 1;
			$wa   = $x - 1;
			$wb   = $y - 1;
			if ( $ega[$x] == $id ) {
				$verein1[$spieltag] = $ega[$x];
				$verein2[$spieltag] = $ega[$y];

				$ort[$spieltag] = "H";
				$tip[$spieltag] = $gc + $x + 1;
			}

			if ( $ega[$y] == $id ) {
				$verein1[$spieltag] = $ega[$x];
				$verein2[$spieltag] = $ega[$y];

				$ort[$spieltag] = "A";
				$tip[$spieltag] = $gc + $x + 1;
			}

		}
	}

	if ( $liga < 10 ) { $liga = '0' . $liga }
	$rr    = $rrunde;
	$line  = 0;
	$datei = "/tmdata/tmi/tipos/QU" . $liga . "S" . $rr . ".TXT";

	open( D, "<$datei" );
	while (<D>) {
		$line++;
		$tip_line[$line] = $_;
		chomp $tip_line[$line];
	}
	close(D);

	$rg = 0;
	for ( $spieltag = $spielrunde_ersatz + 3 ; $spieltag < $spielrunde_ersatz + 7 ; $spieltag++ ) {
		$rg++;
		$hier_gegner[$rg] = $data[ $gegner[$spieltag] ];
		$hier_ort[$rg]    = $ort[$spieltag];
		$hier_platz[$rg]  = $verein_platz{ $data[ $gegner[$spieltag] ] };
	}

	$rr = $spielrunde_ersatz + 2;
	if ( $rr > 33 ) { $rr = 33 }

	for ( $x = $spielrunde_ersatz - 1 ; $x <= $rr ; $x++ ) {
		$ss = $x + 1;
		print "<TABLE CELLSPACING=0 CELLPADDING=1 BORDER=0 width=100%>";
		if ( $x == $spielrunde_ersatz - 1 ) {
			print "<tr><td colspan=7 bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr>";
		}
		print "<TR BGCOLOR=white>";
		print "<td colspan=7 align=center><font face=verdana size=1>$liga_namen[$liga] - $ss. Spieltag</td></tr>";
		print "<tr><td colspan=7 bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr>";
		print "<TR BGCOLOR=#e0e0e0>";
		print "<td colspan=3 align=right><font face=verdana size=1>$data[$verein1[$x]] &nbsp; </td>";
		print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
		print "<td colspan=3 align=left height=20><font face=verdana size=1>&nbsp; $data[$verein2[$x]] </td></tr>";

		$tip1 = $tip_line[ $tip[$x] + 1 ];
		$tip2 = $tip_line[ $tip[$x] + 2 ];

		print "<tr bgcolor=#efefef>";

		@all = split( /,/, $tip1 );

		print "<td colspan=1 align=right valign=top width=225><font face=verdana size=1>";
		for ( $a = 1 ; $a <= 5 ; $a++ ) {
			$dd   = ( $a * 2 ) - 1;
			$tmp  = "";
			$tmp1 = "";
			if ( $ergebnis[ $all[$dd] ] != 0 && $ergebnis[ $all[$dd] ] == $all[ $dd - 1 ] ) {
				$tmp  = "<font color=green>";
				$tmp1 = "<font color=black>";
			}
			if ( $ergebnis[ $all[$dd] ] != 0 && $ergebnis[ $all[$dd] ] != $all[ $dd - 1 ] ) {
				$tmp  = "<font color=red>";
				$tmp1 = "<font color=black>";
			}
			if ( $ergebnis[ $all[$dd] ] == 4 ) { $tmp = "<font color=gray>"; $tmp1 = "<font color=black>" }

			print "&nbsp; &nbsp;$tmp $paarung[$all[$dd]] $tmp1<br>";
		}
		print "</td>\n";

		print "<td colspan=1 align=right valign=top><font face=verdana size=1>";
		for ( $a = 1 ; $a <= 5 ; $a++ ) {
			$dd = ( $a * 2 ) - 1;
			$ee = $all[ $dd - 1 ];
			if ( $all[ $dd - 1 ] == 2 ) { $ee = 0 }
			if ( $all[ $dd - 1 ] == 3 ) { $ee = 2 }

			print " &nbsp; Tip $ee<br>";
		}
		print "</td>\n";

		print "<td colspan=1 align=right valign=top><font face=verdana size=1>";
		for ( $a = 1 ; $a <= 5 ; $a++ ) {
			$dd = ( $a * 2 ) - 1;
			if ( $all[ $dd - 1 ] == 1 ) { $ee = $qu_1[ $all[$dd] ] }
			if ( $all[ $dd - 1 ] == 2 ) { $ee = $qu_0[ $all[$dd] ] }
			if ( $all[ $dd - 1 ] == 3 ) { $ee = $qu_2[ $all[$dd] ] }

			print "&nbsp; $ee &nbsp;<br>";
		}
		print "</td>\n";

		print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

################################## VEREIN 2 ######################

		@all = split( /,/, $tip2 );

		print "<td colspan=1 align=right valign=top><font face=verdana size=1>";
		for ( $a = 1 ; $a <= 4 ; $a++ ) {
			$dd = ( $a * 2 ) - 1;
			if ( $all[ $dd - 1 ] == 1 ) { $ee = $qu_1[ $all[$dd] ] }
			if ( $all[ $dd - 1 ] == 2 ) { $ee = $qu_0[ $all[$dd] ] }
			if ( $all[ $dd - 1 ] == 3 ) { $ee = $qu_2[ $all[$dd] ] }

			print "&nbsp; $ee<br>";
		}
		print "</td>\n";

		print "<td colspan=1 align=right valign=top><font face=verdana size=1>";
		for ( $a = 1 ; $a <= 4 ; $a++ ) {
			$dd = ( $a * 2 ) - 1;
			$ee = $all[ $dd - 1 ];
			if ( $all[ $dd - 1 ] == 2 ) { $ee = 0 }
			if ( $all[ $dd - 1 ] == 3 ) { $ee = 2 }

			print " &nbsp; Tip $ee &nbsp;<br>";
		}
		print "</td>\n";

		print "<td colspan=1 align=left valign=top width=225><font face=verdana size=1>";
		for ( $a = 1 ; $a <= 4 ; $a++ ) {
			$dd = ( $a * 2 ) - 1;

			$tmp  = "";
			$tmp1 = "";
			if ( $ergebnis[ $all[$dd] ] != 0 && $ergebnis[ $all[$dd] ] == $all[ $dd - 1 ] ) {
				$tmp  = "<font color=green>";
				$tmp1 = "<font color=black>";
			}
			if ( $ergebnis[ $all[$dd] ] != 0 && $ergebnis[ $all[$dd] ] != $all[ $dd - 1 ] ) {
				$tmp  = "<font color=red>";
				$tmp1 = "<font color=black>";
			}
			if ( $ergebnis[ $all[$dd] ] == 4 ) { $tmp = "<font color=gray>"; $tmp1 = "<font color=black>" }

			print "$tmp $paarung[$all[$dd]] $tmp1 &nbsp; &nbsp; <br>";
		}
		print "</td>\n";

		#print "<td colspan=1 align=center valign=top><font face=verdana size=1>";
		#for($a=1;$a<=4;$a++){
		#$dd=($a*2)-1;
		#print " &nbsp; &nbsp; $uhr[$all[$dd]] &nbsp;$datum[$all[$dd]] &nbsp; <br>";
		#}; print "</td>";

########################## ENDE #####################################

		print "</tr>";

		print "<tr><td colspan=7 bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr>";

		print "</table>\n";
	}
}

end1:

if ( $coach eq "" ) { print "<font face=verdana size=2><b><br><br>$coach nicht gefunden !"; exit; }

print "</td><td align=center bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr></table>";
print '
<!-- Google Tag Manager -->
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-KX6R92"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':
new Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=
\'//www.googletagmanager.com/gtm.js?id=\'+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,\'script\',\'dataLayer\',\'GTM-KX6R92\');</script>
<!-- End Google Tag Manager -->';

