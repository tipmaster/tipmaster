#!/usr/bin/perl

=head1 NAME
	druck_tip.pl

=head1 SYNOPSIS
	TBD
	


=head1 CHANGELOG
	2015-06-09 Thomas: Added Session Management


	Created 2015-06-09

=cut

use lib '/tmapp/tmsrc/cgi-bin/';
use TMSession;
use CGI;
use HTML::Entities;
my $session = TMSession::getSession();
$query = new CGI;
my $coach = $query->param('coach');


$mailprog = '/usr/sbin/sendmail';
require "/tmapp/tmsrc/cgi-bin/runde.pl";
$spielrunde_ersatz = ( $rrunde * 4 ) - 3;

print "Content-type:text/html\n\n";
print "<html><head>
<style type=\"text/css\">
body {text-align: center;}
table {margin: 0 auto;}
td {
  font-family: verdana;
  font-size: x-small;
}
.tipOpen { color: black; }
.tipMiss { color: red; }
.tipHit { color: green; }
.tipPostp { color: blue; }
</style>
<title>Tippuebersicht ". encode_entities($coach) ." der $rrunde. Tipprunde</title>
</head>";
print "<body>";
print "<form action=druck_tip.pl method=post>
<input type=text style=\"font-family:verdana;font-size=11px\" size=20 value=\"". encode_entities($coach) ."\" name=coach>
<input type=submit value=\"Tipps laden\"  style=\"font-family:verdana;font-size=11px\">";

print "<table border=0 cellpadding=1 cellspacing=0><tr><td>";

if ( $coach eq "" ) {
	print "<span style=\"font-size: medium; font-weight: bold;\"><br><br>Bitte Trainernamen eingeben.</span>";
} else {
	&daten_btm;
	end2:
	&daten_tmi;
	end1:
}

print "</td></tr></table>";

print "<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-53T3SLD');</script>
<!-- End Google Tag Manager -->
<!-- POSTHOG START -->
<script>
    !(function (t, e) {
      var o, n, p, r;
      e.__SV ||
        ((window.posthog = e),
        (e._i = []),
        (e.init = function (i, s, a) {
          function g(t, e) {
            var o = e.split(\".\");
            2 == o.length && ((t = t[o[0]]), (e = o[1])),
              (t[e] = function () {
                t.push([e].concat(Array.prototype.slice.call(arguments, 0)));
              });
          }
          ((p = t.createElement(\"script\")).type = \"text/javascript\"),
            (p.async = !0),
            (p.src =
              s.api_host.replace(\".i.posthog.com\", \"-assets.i.posthog.com\") +
              \"/static/array.js\"),
            (r = t.getElementsByTagName(\"script\")[0]).parentNode.insertBefore(
              p,
              r
            );
          var u = e;
          for (
            void 0 !== a ? (u = e[a] = []) : (a = \"posthog\"),
              u.people = u.people || [],
              u.toString = function (t) {
                var e = \"posthog\";
                return (
                  \"posthog\" !== a && (e += \".\" + a), t || (e += \" (stub)\"), e
                );
              },
              u.people.toString = function () {
                return u.toString(1) + \".people (stub)\";
              },
              o =
                \"capture identify alias people.set people.set_once set_config register register_once unregister opt_out_capturing has_opted_out_capturing opt_in_capturing reset isFeatureEnabled onFeatureFlags getFeatureFlag getFeatureFlagPayload reloadFeatureFlags group updateEarlyAccessFeatureEnrollment getEarlyAccessFeatures getActiveMatchingSurveys getSurveys getNextSurveyStep onSessionId setPersonProperties\".split(
                  \" \"
                ),
              n = 0;
            n < o.length;
            n++
          )
            g(u, o[n]);
          e._i.push([i, s, a]);
        }),
        (e.__SV = 1));
    })(document, window.posthog || []);
    posthog.init(\"phc_iJKj0EowViIqaA6qV2nD6gv8sDIN4DcflJOIWGEQROj\", {
      api_host: \"https://us.i.posthog.com\",
      person_profiles: \"always\",
      autocapture: {
        dom_event_allowlist: [\"click\"]
      },
    });
</script>
<!-- POSTHOG END -->
";
print "</body></html>";

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

	for ( $x = $spielrunde_ersatz - 1 ; $x <= $rr ; $x++ ) {
		$ss = $x + 1;
		print "<TABLE CELLSPACING=0 CELLPADDING=1 BORDER=0 width=100%>";
		if ( $x == $spielrunde_ersatz - 1 ) {
			print "<tr><td colspan=7 bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr>";
		}
		print "<TR BGCOLOR=white>";
		print "<td colspan=7 align=center>$liga_namen[$liga] - $ss. Spieltag</td></tr>";
		print "<tr><td colspan=7 bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr>";
		print "<TR BGCOLOR=#e0e0e0>";
		print "<td colspan=3 align=right>$data[$verein1[$x]] &nbsp; </td>";
		print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
		print "<td colspan=3 align=left height=20>&nbsp; $data[$verein2[$x]] </td></tr>";

		$tip1 = $tip_line[ $tip[$x] + 1 ];
		$tip2 = $tip_line[ $tip[$x] + 2 ];


		@hometips = split( /,/, $tip1 );
		@awaytips = split( /,/, $tip2 );

		for ( $a = 1 ; $a <= 5 ; $a++ ) {
			$dd = ( $a * 2 ) - 1;
			print "<tr bgcolor=#efefef>"; # Dieses tr trägt EINEN Heimtipp (Paarung, Tip, Quote), Spacer, (ggf.) EINEN Auswärtstipp (Paarung, Tip, Quote)

			# Hometip
			$tipcolorclass  = "tipOpen";
			if ( $ergebnis[ $hometips[$dd] ] != 0 && $ergebnis[ $hometips[$dd] ] == $hometips[ $dd - 1 ] ) {
				$tipcolorclass  = "tipHit";
			}
			if ( $ergebnis[ $hometips[$dd] ] != 0 && $ergebnis[ $hometips[$dd] ] != $hometips[ $dd - 1 ] ) {
				$tipcolorclass  = "tipMiss";
			}
			if ( $ergebnis[ $hometips[$dd] ] == 4 ) {
				$tipcolorclass = "tipPostp";
			}

			print "<td colspan=1 align=right valign=top width=225 class='$tipcolorclass'>";
			print "&nbsp; &nbsp; $paarung[$hometips[$dd]]";
			print "</td>\n";

			print "<td colspan=1 align=right valign=top class='$tipcolorclass'>";

			$dd = ( $a * 2 ) - 1;
			$ee = $hometips[ $dd - 1 ];
			if ( $hometips[ $dd - 1 ] == 2 ) { $ee = 0 }
			if ( $hometips[ $dd - 1 ] == 3 ) { $ee = 2 }

			print " &nbsp; Tip $ee";
			print "</td>\n";

			print "<td colspan=1 align=right valign=top class='$tipcolorclass'>";

			$dd = ( $a * 2 ) - 1;
			if ( $hometips[ $dd - 1 ] == 1 ) { $ee = $qu_1[ $hometips[$dd] ] }
			if ( $hometips[ $dd - 1 ] == 2 ) { $ee = $qu_0[ $hometips[$dd] ] }
			if ( $hometips[ $dd - 1 ] == 3 ) { $ee = $qu_2[ $hometips[$dd] ] }

			print "&nbsp; $ee &nbsp;";
			print "</td>\n";
			
			# Spacer
			print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

			# Awaytip
			if ( $a == 5 ) {
				# away team only has 4 tipps. fill remaining space in tr
				print "<td colspan=3>";
			} else {
				$tipcolorclass  = "tipOpen";
				if ( $ergebnis[ $awaytips[$dd] ] != 0 && $ergebnis[ $awaytips[$dd] ] == $awaytips[ $dd - 1 ] ) {
					$tipcolorclass  = "tipHit";
				}
				if ( $ergebnis[ $awaytips[$dd] ] != 0 && $ergebnis[ $awaytips[$dd] ] != $awaytips[ $dd - 1 ] ) {
					$tipcolorclass  = "tipMiss";
				}
				if ( $ergebnis[ $awaytips[$dd] ] == 4 ) {
					$tipcolorclass = "tipPostp";
				}

				print "<td colspan=1 align=right valign=top class='$tipcolorclass'>";
				$dd = ( $a * 2 ) - 1;
				if ( $awaytips[ $dd - 1 ] == 1 ) { $ee = $qu_1[ $awaytips[$dd] ] }
				if ( $awaytips[ $dd - 1 ] == 2 ) { $ee = $qu_0[ $awaytips[$dd] ] }
				if ( $awaytips[ $dd - 1 ] == 3 ) { $ee = $qu_2[ $awaytips[$dd] ] }
				print "&nbsp; $ee";
				print "</td>\n";

				print "<td colspan=1 align=right valign=top class='$tipcolorclass'>";
				$dd = ( $a * 2 ) - 1;
				$ee = $awaytips[ $dd - 1 ];
				if ( $awaytips[ $dd - 1 ] == 2 ) { $ee = 0 }
				if ( $awaytips[ $dd - 1 ] == 3 ) { $ee = 2 }

				print " &nbsp; Tip $ee &nbsp;";
				print "</td>\n";
				print "<td colspan=1 align=left valign=top width=225 class='$tipcolorclass'>";
				$dd = ( $a * 2 ) - 1;


				print "$paarung[$awaytips[$dd]]&nbsp; &nbsp;";
				print "</td>\n";

			}
			
			print "</tr>";

		}

########################## ENDE #####################################

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
		print "<td colspan=7 align=center>$liga_namen[$liga] - $ss. Spieltag</td></tr>";
		print "<tr><td colspan=7 bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr>";
		print "<TR BGCOLOR=#e0e0e0>";
		print "<td colspan=3 align=right>$data[$verein1[$x]] &nbsp; </td>";
		print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
		print "<td colspan=3 align=left height=20>&nbsp; $data[$verein2[$x]] </td></tr>";

		$tip1 = $tip_line[ $tip[$x] + 1 ];
		$tip2 = $tip_line[ $tip[$x] + 2 ];

		@hometips = split( /,/, $tip1 );
		@awaytips = split( /,/, $tip2 );

		for ( $a = 1 ; $a <= 5 ; $a++ ) {
			$dd = ( $a * 2 ) - 1;
			print "<tr bgcolor=#efefef>"; # Dieses tr trägt EINEN Heimtipp (Paarung, Tip, Quote), Spacer, (ggf.) EINEN Auswärtstipp (Paarung, Tip, Quote)

			# Hometip
			$tipcolorclass  = "tipOpen";
			if ( $ergebnis[ $hometips[$dd] ] != 0 && $ergebnis[ $hometips[$dd] ] == $hometips[ $dd - 1 ] ) {
				$tipcolorclass  = "tipHit";
			}
			if ( $ergebnis[ $hometips[$dd] ] != 0 && $ergebnis[ $hometips[$dd] ] != $hometips[ $dd - 1 ] ) {
				$tipcolorclass  = "tipMiss";
			}
			if ( $ergebnis[ $hometips[$dd] ] == 4 ) {
				$tipcolorclass = "tipPostp";
			}

			print "<td colspan=1 align=right valign=top width=225 class='$tipcolorclass'>";
			print "&nbsp; &nbsp; $paarung[$hometips[$dd]]";
			print "</td>\n";

			print "<td colspan=1 align=right valign=top class='$tipcolorclass'>";

			$dd = ( $a * 2 ) - 1;
			$ee = $hometips[ $dd - 1 ];
			if ( $hometips[ $dd - 1 ] == 2 ) { $ee = 0 }
			if ( $hometips[ $dd - 1 ] == 3 ) { $ee = 2 }

			print " &nbsp; Tip $ee";
			print "</td>\n";

			print "<td colspan=1 align=right valign=top class='$tipcolorclass'>";

			$dd = ( $a * 2 ) - 1;
			if ( $hometips[ $dd - 1 ] == 1 ) { $ee = $qu_1[ $hometips[$dd] ] }
			if ( $hometips[ $dd - 1 ] == 2 ) { $ee = $qu_0[ $hometips[$dd] ] }
			if ( $hometips[ $dd - 1 ] == 3 ) { $ee = $qu_2[ $hometips[$dd] ] }

			print "&nbsp; $ee &nbsp;";
			print "</td>\n";
			
			# Spacer
			print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

			# Awaytip
			if ( $a == 5 ) {
				# away team only has 4 tipps. fill remaining space in tr
				print "<td colspan=3>";
			} else {
				$tipcolorclass  = "tipOpen";
				if ( $ergebnis[ $awaytips[$dd] ] != 0 && $ergebnis[ $awaytips[$dd] ] == $awaytips[ $dd - 1 ] ) {
					$tipcolorclass  = "tipHit";
				}
				if ( $ergebnis[ $awaytips[$dd] ] != 0 && $ergebnis[ $awaytips[$dd] ] != $awaytips[ $dd - 1 ] ) {
					$tipcolorclass  = "tipMiss";
				}
				if ( $ergebnis[ $awaytips[$dd] ] == 4 ) {
					$tipcolorclass = "tipPostp";
				}

				print "<td colspan=1 align=right valign=top class='$tipcolorclass'>";
				$dd = ( $a * 2 ) - 1;
				if ( $awaytips[ $dd - 1 ] == 1 ) { $ee = $qu_1[ $awaytips[$dd] ] }
				if ( $awaytips[ $dd - 1 ] == 2 ) { $ee = $qu_0[ $awaytips[$dd] ] }
				if ( $awaytips[ $dd - 1 ] == 3 ) { $ee = $qu_2[ $awaytips[$dd] ] }
				print "&nbsp; $ee";
				print "</td>\n";

				print "<td colspan=1 align=right valign=top class='$tipcolorclass'>";
				$dd = ( $a * 2 ) - 1;
				$ee = $awaytips[ $dd - 1 ];
				if ( $awaytips[ $dd - 1 ] == 2 ) { $ee = 0 }
				if ( $awaytips[ $dd - 1 ] == 3 ) { $ee = 2 }

				print " &nbsp; Tip $ee &nbsp;";
				print "</td>\n";
				print "<td colspan=1 align=left valign=top width=225 class='$tipcolorclass'>";
				$dd = ( $a * 2 ) - 1;


				print "$paarung[$awaytips[$dd]]&nbsp; &nbsp;";
				print "</td>\n";
			}
			
			print "</tr>";
		}

		print "<tr><td colspan=7 bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr>";
		print "</table>\n";
	}
}
