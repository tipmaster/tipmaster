#!/usr/bin/perl

=head1 NAME
	BTM titel.pl

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

$liga_namen[1] = "1.Bundesliga";

require "/tmapp/tmsrc/cgi-bin/btm/saison.pl";
$saison_aktuell = $main_nr - 1;

@name_sai = @main_saison;

$query   = new CGI;
$special = $query->param('special');

open( D1, "</tmdata/btm/pokal_erfolge.txt" );

while (<D1>) {

	$a = $_;

	#print $_;
	chomp $a;
	@all = split( /&/, $a );
	$titel_po{ $all[2] }++;

	$line_cup{ $all[1] } = $line_cup{ $all[1] } . '!' . $a;
}
close(D1);

open( D1, "</tmdata/btm/erfolge.txt" );

while (<D1>) {
	$a = $_;

	#print $_;
	chomp $a;
	@all = split( /#/, $a );

	#print "$all[1]\n";
	$titel_dm{ $all[2] }++;
	$line{ $all[1] } = $line{ $all[1] } . '!' . $a;

	#print "$line{$all[1]}\n";
}
close(D1);

print "Content-type:text/html\n\n";
print "<title>BTM Titeltraeger</title>

<head>
  <style type=\"text/css\">
     <!--
   a.type1:link { color:darkred; }
   a.type2:link { color:black; }
   a.type1:active { color:red; }
   a.type2:active { color:red; }
   a.type1:visited { color:darkred; }
   a.type2:visited { color:black; }


TD.l {padding-left:15px;padding-right:15px;font-family:Verdana; font-size:7pt; color:black; background-color:white;}
TD.e {padding-left:15px;padding-right:15px;font-family:Verdana;font-size:7pt; color:black; background-color:#eeeeff;}
TD.f {padding-left:15px;padding-right:15px;font-family:Verdana;font-size:7pt; color:black; background-color:#dddeff;}
TD.r {text-align:right;padding-left:15px;padding-right:15px;font-family:Verdana;font-size:7pt; color:black; background-color:#eeeeff;}

     -->
     </style>
    </head>

<center><font size=1>
";

for ( $x = 1 ; $x <= 1 ; $x++ ) {

	#print "$x $liga_namen[$x]";
	print "<table border=0 cellpadding=5>";

	#print "$x<br>$line{$liga_namen[$x]}<br><br>";

	@so = split( /!/, $line{ $liga_namen[$x] } );
	( $land, my $a2 ) = split( / /, $liga_namen[$x] );
	@so_cup = split( /!/, $line_cup{$land} );

	( my $a1, my $a2 ) = split( / /, $liga_kuerzel[$x] );
	$a1      = lc($a1);
	$a1      = "/img/flags/ger.jpg";
	@meister = ();
	@trainer = ();
	foreach $t (@so) {
		@ss = split( /#/, $t );

		$meister[ $ss[0] ] = $ss[2];
		$trainer[ $ss[0] ] = $ss[3];
	}

	foreach $t (@so_cup) {
		@ss = split( /&/, $t );

		$cup1[ $ss[0] ] = $ss[2];
		$cup2[ $ss[0] ] = $ss[3];
		$cup3[ $ss[0] ] = $ss[4];
		$cup4[ $ss[0] ] = $ss[5];
		$cup5[ $ss[0] ] = $ss[6];
		$cup6[ $ss[0] ] = $ss[7];

	}

	$liga_kat[0]   = 2;
	$liga_kat[203] = 1;
	if ( ( $liga_kat[ $x - 1 ] > $liga_kat[$x] ) or ( $x == 203 ) ) {
		if ( $liga_namen[$x] =~ /$la/ ) {
			print "<tr align=center><td colspan=7 align=center><font face=verdana size=2><br> ";

			if ( $special ne "fuxx" ) {
				print "
<img src=$a1> &nbsp; &nbsp; <b>Bisherige Deutsche Meister / DFB - Pokal Sieger</b> &nbsp; &nbsp; <img src=$a1><br><br>
";
			}
			else {
				print "
<b>Bisherige Trainer Fuxx Gewinner</b> &nbsp; &nbsp; <br><br>
";
			}

			print "
<font size=1>
<br>[ <a href=/halloffame.html>Bisherige Europapokal Titeltraeger</a> ]<br>
<br>[ <a href=/cgi-bin/tmi/titel.pl>Bisherige TipMaster international Titeltraeger</a> ]<br>
<br>[ <a href=/cgi-bin/btm/titel.pl?special=fuxx>Bisherige Trainer - Fuxx Gewinner</a> ]<br>


<br><br></td></tr>\n";

			if ( $special eq "fuxx" ) {
				&special;
			}

			print "<tr>";
			print "<td></td><td><font face=verdana size=1 color=darkblue> &nbsp; &nbsp; &nbsp;Meisterschaft</td>";
			print "<td><font face=verdana size=1 color=darkblue>Pokalsieger</td>";
			print "<td></td><td><font face=verdana size=1 color=darkblue>Finalgegner/-ergebnis</td>";
			print "</tr>";
			$temp = 1;

			for ( $saison = $saison_aktuell ; $saison >= $temp ; $saison = $saison - 1 ) {

				print "<tr>";
				print "<td width=20><font face=verdana size=1 color=darkblue> $name_sai[$saison]</td>";
				$rr = $meister[$saison];
				$rr =~ s/ /%20/g;
				$rs = $trainer[$saison];
				$rs =~ s/ /%20/g;

				$im = "";
				if ( $titel_dm{ $meister[$saison] } > 1 ) {
					for ( $k = 1 ; $k <= $titel_dm{ $meister[$saison] } ; $k++ ) {
						$im .= " <img src=/img/star_yellow.gif> ";
					}
					$titel_dm{ $meister[$saison] } = 0;
				}

				print "<td NOWRAp=nowrap><font face=verdana size=2 color=darkred> &nbsp; &nbsp; &nbsp;
<b><a class=\"type1\" href=/cgi-mod/btm/verein.pl?ident=$rr>$meister[$saison]</a></b> $im <br><font color=black> &nbsp; &nbsp; &nbsp;<font size=1>
<a class=\"type2\" href=/cgi-mod/btm/trainer.pl?ident=$rs>$trainer[$saison]</a></td>";
				$rr = $cup1[$saison];
				$rr =~ s/ /%20/g;
				$rs = $cup2[$saison];
				$rs =~ s/ /%20/g;

				$im = "";
				if ( $titel_po{ $cup1[$saison] } > 1 ) {
					for ( $k = 1 ; $k <= $titel_po{ $cup1[$saison] } ; $k++ ) {
						$im .= " <img src=/img/star_yellow.gif> ";
					}
					$titel_po{ $cup1[$saison] } = 0;
				}

				print "<td nowrap=nowrap align=left><font face=verdana size=2 color=darkred>
 <b><a class=\"type1\" href=/cgi-mod/btm/verein.pl?ident=$rr>$cup1[$saison]</a></b> $im<br><font SIZE=1 color=black><a class=\"type2\" href=/cgi-mod/btm/trainer.pl?ident=$rs>$cup2[$saison]</a></td>";

				$tora       = 0;
				$torb       = 0;
				$xj         = 1;
				$yj         = 2;
				$kuerzel    = "";
				$quote[$xj] = $cup5[$saison];
				$quote[$yj] = $cup6[$saison];
				if ( $quote[$xj] > 14 )  { $tora = 1 }
				if ( $quote[$xj] > 39 )  { $tora = 2 }
				if ( $quote[$xj] > 59 )  { $tora = 3 }
				if ( $quote[$xj] > 79 )  { $tora = 4 }
				if ( $quote[$xj] > 104 ) { $tora = 5 }
				if ( $quote[$xj] > 129 ) { $tora = 6 }
				if ( $quote[$xj] > 154 ) { $tora = 7 }

				if ( $quote[$yj] > 14 )  { $torb = 1 }
				if ( $quote[$yj] > 39 )  { $torb = 2 }
				if ( $quote[$yj] > 59 )  { $torb = 3 }
				if ( $quote[$yj] > 79 )  { $torb = 4 }
				if ( $quote[$yj] > 104 ) { $torb = 5 }
				if ( $quote[$yj] > 129 ) { $torb = 6 }
				if ( $quote[$yj] > 154 ) { $torb = 7 }

				if ( $tora == $torb ) {

					$d = $quote[$xj] - $quote[$yj];
					if ( $d > 5 ) { $kuerzel = "n.V." }
					if ( $d > 5 ) { $tora++ }
					if ( $d > 15 ) { $tora++ }
					if ( $d < -5 ) { $kuerzel = "n.V." }
					if ( $d < -5 ) { $torb++ }
					if ( $d < -15 ) { $torb++ }

					if ( $d == 0 ) { $kuerzel = "n.E." }
					if ( $d == 0 ) { $tora    = $tora + 4 }
					if ( $d == 0 ) { $torb    = $torb + 5 }

					if ( $d == -1 ) { $kuerzel = "n.E." }
					if ( $d == -1 ) { $tora    = $tora + 4 }
					if ( $d == -1 ) { $torb    = $torb + 5 }

					if ( $d == 1 ) { $kuerzel = "n.E." }
					if ( $d == 1 ) { $tora    = $tora + 5 }
					if ( $d == 1 ) { $torb    = $torb + 4 }

					if ( ( $d > 1 ) and ( $d < 4 ) ) { $kuerzel = "n.E." }
					if ( ( $d > 1 ) and ( $d < 4 ) ) { $tora    = $tora + 5 }
					if ( ( $d > 1 ) and ( $d < 4 ) ) { $torb    = $torb + 3 }

					if ( ( $d > 3 ) and ( $d < 6 ) ) { $kuerzel = "n.E." }
					if ( ( $d > 3 ) and ( $d < 6 ) ) { $tora    = $tora + 4 }
					if ( ( $d > 3 ) and ( $d < 6 ) ) { $torb    = $torb + 2 }

					if ( ( $d > -4 ) and ( $d < -1 ) ) { $kuerzel = "n.E." }
					if ( ( $d > -4 ) and ( $d < -1 ) ) { $tora    = $tora + 3 }
					if ( ( $d > -4 ) and ( $d < -1 ) ) { $torb    = $torb + 5 }

					if ( ( $d > -6 ) and ( $d < -3 ) ) { $kuerzel = "n.E." }
					if ( ( $d > -6 ) and ( $d < -3 ) ) { $tora    = $tora + 2 }
					if ( ( $d > -6 ) and ( $d < -3 ) ) { $torb    = $torb + 4 }

				}

				if ( $cup3[$saison] ne "" ) {

					print
"<td width=90 align=right valign=top><font face=verdana size=1 color=black>$kuerzel $tora : $torb </td>";
					print "<td width=150 align=left valign=top><font face=verdana size=1 color=black>
vs. $cup3[$saison] <br><font color=black>$cup4[$saison]</td>";
				}

				print "</tr>";
			}
		}
	}

	print "</table>";
}
exit;

sub special {
	open( A, "/tmapp/appdata/fuxx.txt" );
	while (<A>) {
		@data = split( /#/, $_ );
		print "<tr>";
		print "<td></td><td><font face=verdana size=2> &nbsp; &nbsp; &nbsp; $name_sai[$data[1]+5]</td>";
		print "<td><font face=verdana size=3><b>$data[2]</td>";
		print "</tr>";
	}
	close(A);

	print "</table>";

}
