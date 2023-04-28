#!/usr/bin/perl

=head1 NAME
	BTM tipabgabe_neu.pl

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
#

$mailprog = '/usr/sbin/sendmail';

require "/tmapp/tmsrc/cgi-bin/runde.pl";
require "/tmapp/tmsrc/cgi-bin/lib.pl";
require "/tmapp/tmsrc/cronjobs/blanko_process.pl";

# Retrieve Date
&get_date;

use CGI;
$query = new CGI;
print $query->header();
$method   = $query->param('method');
$prognose = $query->param('prognose');

&daten_lesen;

if ( $method eq "blanko" ) { &blanko; }

# Return HTML Page or Redirect User
&return_html;

sub get_date {

	# Define arrays for the day of the week and month of the year.           #
	@days = ( 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday' );
	@months = (
		'January', 'February', 'March',     'April',   'May',      'June',
		'July',    'August',   'September', 'October', 'November', 'December'
	);

	# Get the current time and format the hour, minutes and seconds.  Add    #
	# 1900 to the year to get the full 4 digit year.                         #
	( $sec, $min, $hour, $mday, $mon, $year, $wday ) = ( localtime( time + 0 ) )[ 0, 1, 2, 3, 4, 5, 6 ];
	$time = sprintf( "%02d:%02d:%02d", $hour, $min, $sec );
	$year += 1900;

	# Format the date.                                                       #
	$date = "$days[$wday], $months[$mon] $mday, $year at $time";

}

sub daten_lesen {

	$tipo[1]  = "30....";
	$tipo[2]  = "31....";
	$tipo[3]  = "32....";
	$tipo[4]  = "33....";
	$tipo[5]  = "34....";
	$tipo[6]  = "35....";
	$tipo[7]  = "36....";
	$tipo[8]  = "37....";
	$tipo[9]  = "38....";
	$tipo[10] = "39....";
	$tipo[11] = "40....";
	$tipo[12] = "41....";
	$tipo[13] = "42....";
	$tipo[14] = "43....";
	$tipo[15] = "44....";
	$tipo[16] = "45....";
	$tipo[17] = "46....";
	$tipo[18] = "47....";
	$tipo[19] = "48....";
	$tipo[20] = "49....";
	$tipo[21] = "50....";
	$tipo[22] = "51....";
	$tipo[23] = "52....";
	$tipo[24] = "53....";
	$tipo[25] = "54....";

	$rf = "0";
	$rx = "x";
	if ( $liga > 9 ) { $rf = "" }

	$suche = '&' . $trainer . '&';
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

	$y = 0;
	for ( $x = 1 ; $x < 19 ; $x++ ) {
		$y++;
		chomp $lor[$y];
		$data[$x] = $lor[$y];
		$y++;
		chomp $lor[$y];
		$datb[$x] = $lor[$y];
		if ( $datb[$x] eq $trainer ) { $id    = $x }
		if ( $datb[$x] eq $trainer ) { $coach = $data[$x] }
		$y++;
		chomp $lor[$y];
		$datc[$x] = $lor[$y];
		if ( $datb[$x] eq $trainer ) { $recipient = $datc[$x] }
	}
	$verein = $id;

	open( D7, "/tmdata/btm/tip_status.txt" );
	$tip_status = <D7>;

	chomp $tip_status;
	close(D7);

	open( D7, "/tmdata/btm/tip_datum.txt" );
	$spielrunde_ersatz = <D7>;

	chomp $spielrunde_ersatz;
	close(D7);

	$bx = "formular";
	$by = int( ( $spielrunde_ersatz + 3 ) / 4 );

	$bv          = ".txt";
	$fg          = "/tmdata/btm/";
	$datei_hiero = $fg . $bx . $by . $bv;
	binmode(STDOUT, ":unix:utf8");
use open qw(:std :encoding(utf-8));


	
	open( DO,'<:encoding(UTF-8)', $datei_hiero );
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
	}

	open( D2, "/tmdata/btm/heer.txt" );
	while (<D2>) {

		@go                     = ();
		@go                     = split( /&/, $_ );
		$verein_platz{ $go[5] } = $go[0];
	}
	close(D2);

	if ( !-e $datei_hiero ) {
		for ( $x = 0 ; $x <= 25 ; $x++ ) {
			$paarung[$x] = ".: noch kein neues Formular online :.";
			$flagge[$x]  = 9;
		}
	}

	open( D9, "/tmdata/btm/spieltag.txt" );
	while (<D9>) {
		@ego = <D9>;
	}
	close(D9);

	$fa = 0;

	for ( $spieltag = 0 ; $spieltag < 34 ; $spieltag++ ) {

		@ega = split( /&/, $ego[$spieltag] );
		for ( $x = 0 ; $x < 18 ; $x = $x + 2 ) {

			$tora = 0;
			$torb = 0;
			$y    = $x + 1;
			$wa   = $x - 1;
			$wb   = $y - 1;

			if ( $ega[$x] == $id ) {
				$gegner[$spieltag] = $ega[$y];
				$ort[$spieltag]    = "H";
				$tip[$spieltag]    = $gc + $x + 1;
			}

			if ( $ega[$y] == $id ) {
				$gegner[$spieltag] = $ega[$x];
				$ort[$spieltag]    = "A";
				$tip[$spieltag]    = $gc + $x + 1;
			}

		}
	}

	$rg = 0;
	for ( $spieltag = $spielrunde_ersatz + 3 ; $spieltag < $spielrunde_ersatz + 7 ; $spieltag++ ) {

		$rg++;

		$hier_gegner[$rg] = $data[ $gegner[$spieltag] ];
		$hier_ort[$rg]    = $ort[$spieltag];
		$hier_platz[$rg]  = $verein_platz{ $data[ $gegner[$spieltag] ] };

	}

	$aa = 0;
	$ab = 0;
	$ac = 0;
	$ad = 0;

	for ( $x = 1 ; $x < 26 ; $x++ ) {
		chomp $tipo[$x];
		( $ca[$x], $cb[$x] ) = split( /&/, $tipo[$x] );

	}

	for ( $x = 1 ; $x < 26 ; $x++ ) {
		if ( $ca[$x] == 1 ) {
			$aa++;
			$pro1[$aa] = $cb[$x];
			$sp1[$aa]  = $x;

		}
		if ( $ca[$x] == 2 ) {
			$ab++;
			$pro2[$ab] = $cb[$x];
			$sp2[$ab]  = $x;
		}
		if ( $ca[$x] == 3 ) {
			$ac++;
			$pro3[$ac] = $cb[$x];
			$sp3[$ac]  = $x;
		}
		if ( $ca[$x] == 4 ) {
			$ad++;
			$pro4[$ad] = $cb[$x];
			$sp4[$ad]  = $x;
		}

	}

	$verein = $id;

	$suche = ( ( $liga - 1 ) * 18 ) + $verein;
	$log   = ( ( $liga - 1 ) * 18 ) + $verein;

	$cc = "0";
	if ( $suche < 100 )  { $suche = $cc . $suche }
	if ( $suche < 10 )   { $suche = $cc . $suche }
	if ( $suche < 1000 ) { $suche = $cc . $suche }

	for ( $xt = $spielrunde_ersatz - 1 ; $xt <= $spielrunde_ersatz + 2 ; $xt++ ) {
		$status[ $gegner[$xt] ] = "Gegner Tip ist noch nicht eingegangen";

		$so = ( ( $liga - 1 ) * 18 ) + $gegner[$xt];
		$cc = $so;
		if ( $so < 100 )  { $cc = '0' . $cc }
		if ( $so < 10 )   { $cc = '0' . $cc }
		if ( $so < 1000 ) { $cc = '0' . $cc }

		if ( $spielrunde_ersatz < 10 ) { $xx = "0" }

		$datei = '/tmdata/btm/tips/' . $spielrunde_ersatz . '/' . $cc . '.txt';
		if ( -e "$datei" ) { $status[ $gegner[$xt] ] = "Gegner Tip ist bereits eingegangen" }
	}

	$ein = 0;

	$linie = 0;

	$count = $suche * 1;

	for ( $xi = $count ; $xi <= $count ; $xi++ ) {
		$cc = $xi;
		if ( $xi < 100 )  { $cc = '0' . $cc }
		if ( $xi < 10 )   { $cc = '0' . $cc }
		if ( $xi < 1000 ) { $cc = '0' . $cc }

		$datei = '/tmdata/btm/tips/' . $spielrunde_ersatz . '/' . $cc . '.txt';

		open( D2, "$datei" );
		while (<D2>) {

			( $nummer, $tipabgabe ) = split( /#/, $_ );

			$line[$nummer] = $_;
			chomp $line[$nummer];
			@voss = split( /\./, $tipabgabe );

			for ( $d = 0 ; $d <= 24 ; $d++ ) {
				$rx = "";
				$rr = "";
				( $rr, $rx ) = split( /&/, $voss[$d] );
				if ( $rx == 1 ) { $toto_1[ $d + 1 ]++ }
				if ( $rx == 2 ) { $toto_2[ $d + 1 ]++ }
				if ( $rx == 3 ) { $toto_3[ $d + 1 ]++ }
			}

			$count1 = $nummer * 1;

			if ( $count == $count1 ) {
				( $numero, $tipes ) = split( /#/, $_ );
				@tipos = split( /\./, $tipes );
				$ein = 1;
			}

		}
		close(D2);
	}

	$tip_eingegangen = 0;

	for ( $x = 0 ; $x <= 24 ; $x++ ) {
		if ( $tipos[$x] eq "-" ) { $tip_eingegangen = 1 }
		if ( $tipos[$x] eq "-" ) { $tipos[$x]       = "0&0" }
		if ( $tipos[$x] eq "" )  { $tipos[$x]       = "0&0" }

	}

	$datei = '/tmdata/btm/tips/' . $spielrunde_ersatz . '/bisher.txt';
	open( D2, "$datei" );
	$p = 0;
	while (<D2>) {
		$p++;

		@set = split( /&/, $_ );
		$toto_1[$p] = $set[1];
		$toto_2[$p] = $set[2];
		$toto_3[$p] = $set[3];

	}

	close(D2);

	for ( $d = 1 ; $d <= 25 ; $d++ ) {
		$toto_1[$d] = $toto_1[$d] * 1;
		$toto_2[$d] = $toto_2[$d] * 1;
		$toto_3[$d] = $toto_3[$d] * 1;

		if ( $toto_1[$d] < 100 ) { $toto_1[$d] = '0' . $toto_1[$d] }
		if ( $toto_1[$d] < 10 )  { $toto_1[$d] = '0' . $toto_1[$d] }
		if ( $toto_2[$d] < 100 ) { $toto_2[$d] = '0' . $toto_2[$d] }
		if ( $toto_2[$d] < 10 )  { $toto_2[$d] = '0' . $toto_2[$d] }
		if ( $toto_3[$d] < 100 ) { $toto_3[$d] = '0' . $toto_3[$d] }
		if ( $toto_3[$d] < 10 )  { $toto_3[$d] = '0' . $toto_3[$d] }

	}

}

sub return_html {

	&readin_vereinsid("btm");

	# Print HTTP header and opening HTML tags.                           #

	$hh = $spielrunde_ersatz + 3;
	if ( $hh > 34 ) { $hh = 34 }

	print <<END_HEAD;
<html><head>
<meta http-equiv="Content-Type" 
      content="text/html; charset=utf-8">
	<link rel="stylesheet" type="text/css" media="screen" href="/css/tipabgabe_screen.css" />
	<link rel="stylesheet" href="/js/smoothness/jquery-ui-1.8.14.custom.css" type="text/css" media="all" />
	
   <script src="//ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
   <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/jquery-ui.min.js"></script>
   
   <script type="text/javascript">
    	var IE='\\v'=='v';
    	//alert("UserAgent: "+navigator.userAgent);
    	if (/MSIE (\\d+\\.\\d+);/.test(navigator.userAgent)){ //test for MSIE x.x;
    		 var ieversion=new Number(RegExp.\$1) // capture x.x portion and store as a number
    		 if (ieversion>=9)
    		 IE=true;
    	}
    		  
    	if (IE) {
    		alert("Die neue Tipabgabe funktioniert leider nicht mit dem Internet Explorer");
    		window.location="/cgi-mod/btm/login.pl";
    	} else {
    		//alert("Alles ok.");
    	}
    </script>
    			   
   <script src="/js/tipabgabe_btm.js"></script></head>
END_HEAD

	print
"<body bgcolor=white text=black link=blue vlink=blue><title>Tippabgabe $coach  Sp. $spielrunde_ersatz bis $hh</title>";
	print "<p align=left>\n";


	$rr = $spielrunde_ersatz + 3;
	if ( $rr > 33 ) { $rr = 33 }
	$rs = $spielrunde_ersatz;
	print "<br>";

	print "<br><b>Aktuelle Tippabgabe Sp. $rs bis $hh - $data[$id] [ $datb[$id] ] <br><br></b>";

	print "
<form name=blanko1 action=tipabgabe_neu.pl method=post>
<input type=hidden name=method value=blanko><input type=hidden name=prognose value=1></form>\n";
	print "
<form name=blanko2 action=tipabgabe_neu.pl method=post>
<input type=hidden name=method value=blanko><input type=hidden name=prognose value=2></form>\n";
	print "
<form name=blanko3 action=tipabgabe_neu.pl method=post>
<input type=hidden name=method value=blanko><input type=hidden name=prognose value=3></form>\n";

	print "Vor der Tippabgabe nochmal kurz die letzten Resultate bzw. Tabellenposition der Vereine checken ?<br>
Unter <a href=https://www.fussball-liveticker.eu target=new11>fussball-liveticker.eu</a> gibts Ergebnisse ,
Tabellen und Statistiken sowie LiveScore zu den europ. und intern. Ligen !<br><br>\n";

	$gg = int( $spielrunde_ersatz / 4 ) + 1;

	$rr = $spielrunde_ersatz + 2;
	if ( $rr > 33 ) { $rr = 33 }

	for ( $x = $spielrunde_ersatz - 1 ; $x <= $rr ; $x++ ) {
		$ss = $x + 1;

		print
		  "<!-- x ist $x, gegner ist $gegner[$x]  data is $data[$gegner[$x]]] status $status[$gegner[$x]] verplatz ",
		  $verein_platz{ $data[ $gegner[$x] ] }, " //-->\n";
		print "<!-- name ist $datb[$gegner[$x]] //-->\n";

		# get head2head
		$h2h    = &get_head2head( "btm", $gl_vereinsid{ $data[$id] }, $gl_vereinsid{ $data[ $gegner[$x] ] } );
		@bilanz = ();
		@bilanz = &get_balance($h2h);

		#print "$h2h $gl_vereinsid{$data[$id]} $gl_vereinsid{$data[$gegner[$x]]}<br>";

	}
	print
"Auch keine Tippabgabe fuer relevante und anstehende Pokalrunden vergessen ? <a href=/cgi-bin/cup_time.pl target=_new>Blick auf den Rahmenterminkalender</a>";
	print &getHtmlBlankotip($trainer);
	&makeFormNew();

	print "</body></html>\n";

}

sub error {

	# Localize variables and assign subroutine input.                        #
	local ( $error, @error_fields ) = @_;
	local ( $host, $missing_field, $missing_field_list );

	if ( $error eq 'spielauswahl' ) {
		print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>TMI - Tipabgabe : Spielauswahl nicht korrekt</title>
 </head>
 <body bgcolor=#eeeeee text=#000000>
<p align=left><body bgcolor=white text=black>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br><br><p align=left>
<br><br>
<table border=0>
<tr><td p align=center>
<font face=verdana size=2><b>
<font color=red>
Bei ihrer Tipabgabe ist ein Fehler aufgetreten .<br><br><br>
<font color=black size=2>
+++ Ihre Spielauswahl ist nicht korrekt +++<br><br><br></b></b></b></b></b>
(END ERROR HTML)

		if ( ( $hier_ort[1] eq "H" ) and ( $aa != 5 ) ) {
			print "<font face=verdana size=1>";
			$ss = $spielrunde_ersatz + 4;
			print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Heimspiel gegen  $hier_gegner[1].<br>";
			print
			  "An diesem Spieltag sind Ihnen also 5 Tips anstatt denen von Ihnen gewaehlten $aa Tips gestattet<br><br>";
		}
		if ( ( $hier_ort[1] eq "A" ) and ( $aa != 4 ) ) {
			print "<font face=verdana size=1>";
			$ss = $spielrunde_ersatz + 4;
			print
			  "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Auswaertsspiel gegen  $hier_gegner[1] .<br>";
			print
"An diesem Spieltag sind Ihnen also 4 Tips anstatt denen von Ihnen gewaehlten $aa Tips gestattet .<br><br>";
		}
		if ( ( $hier_ort[2] eq "H" ) and ( $ab != 5 ) ) {
			print "<font face=verdana size=1>";
			$ss = $spielrunde_ersatz + 5;
			print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Heimspiel gegen  $hier_gegner[2].<br>";
			print
"An diesem Spieltag sind Ihnen also 5 Tips anstatt denen von Ihnen gewaehlten $ab Tips gestattet .<br><br>";
		}
		if ( ( $hier_ort[2] eq "A" ) and ( $ab != 4 ) ) {
			print "<font face=verdana size=1>";
			$ss = $spielrunde_ersatz + 5;
			print
			  "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Auswaertsspiel gegen  $hier_gegner[2]<br>";
			print
"An diesem Spieltag sind Ihnen also 4 Tips anstatt denen von Ihnen gewaehlten $ab Tips gestattet .<br><br>";
		}
		if ( ( $hier_ort[3] eq "H" ) and ( $ac != 5 ) ) {
			print "<font face=verdana size=1>";
			$ss = $spielrunde_ersatz + 6;
			print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Heimspiel gegen  $hier_gegner[3]<br>";
			print
"An diesem Spieltag sind Ihnen also 5 Tips anstatt denen von Ihnen gewaehlten $ac Tips gestattet .<br><br>";
		}
		if ( ( $hier_ort[3] eq "A" ) and ( $ac != 4 ) ) {
			print "<font face=verdana size=1>";
			$ss = $spielrunde_ersatz + 6;
			print
			  "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Auswaertsspiel gegen  $hier_gegner[3].<br>";
			print
"An diesem Spieltag sind Ihnen also 4 Tips anstatt denen von Ihnen gewaehlten $ac Tips gestattet .<br><br>";
		}
		if ( ( $hier_ort[4] eq "H" ) and ( $ad != 5 ) ) {
			print "<font face=verdana size=1>";
			$ss = $spielrunde_ersatz + 7;
			print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Heimspiel gegen  $hier_gegner[4].<br>";
			print
"An diesem Spieltag sind Ihnen also 5 Tips anstatt denen von Ihnen gewaehlten $ad Tips gestattet .<br><br>";
		}
		if ( ( $hier_ort[4] eq "A" ) and ( $ad != 4 ) ) {
			print "<font face=verdana size=1>";
			$ss = $spielrunde_ersatz + 7;
			print
			  "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Auswaertsspiel gegen  $hier_gegner[4].<br>";
			print
"An diesem Spieltag sind Ihnen also 4 Tips anstatt denen von Ihnen gewaehlten $ad Tips gestattet .<br><br>";
		}

		print <<"(END ERROR HTML)";
</b></b></b><font color=black face=verdana size=1>Bitte kehren Sie zur Tipabgabe zurueck <br>
und korrigieren Sie Ihre Spielauswahl<br>
so dass ihr Tip gewertet werden kann .
</td></tr></table>

</center>
</body>
</html>
(END ERROR HTML)
	}

	exit;
}

sub makeFormNew {
	print <<END_ONE;
		<div class="leftcontent">
	<table id="formular" class="formular">
	</table>
	</div>

	<div class="centercontent" id="tips">
END_ONE

	my $liga_id = $liga . "&" . $id;
	$sp_bis = $spielrunde_ersatz + 3;
	if ( $sp_bis > 34 ) { $sp_bis = 34 }
	my $lfd = 0;
	for ( $x = $spielrunde_ersatz ; $x <= $sp_bis ; $x++ ) {
		$lfd++;
		my $aorh    = $ort[ $x - 1 ];
		my $anztips = 5;
		if ( $aorh eq "A" ) {
			$anztips = 4;
		}
		my $gegnerplatz  = $verein_platz{ $data[ $gegner[ $x - 1 ] ] };
		my $gegnerverein = $data[ $gegner[ $x - 1 ] ];
		my $gegnername   = $datb[ $gegner[ $x - 1 ] ];
		my $gegnerstat   = $status[ $gegner[ $x - 1 ] ];
		my $imgloc       = "greenmark.jpg";
		if ( $gegnerstat =~ /nicht/ ) {
			$imgloc = "redmark.jpg";
		}

		print "<table class=\"tip\" id=\"tips_", $lfd, "\" anztips=\"", $anztips, "\">";
		print "<TR><TD colspan=4><span class=\"tipheaders\">Round $x vs. <b>", $gegnerverein, "</b> (", $gegnerplatz,
		  ".) <i>", $gegnername;
		print "</i>&nbsp;<img src=\"/img/icons/other/", $imgloc, "\"/></span>";
		print "</td></TR></table>\n";
	}

	print <<END_TWO;
	<form id="postform" action="http://www.tipmaster.de/cgi-bin/btm/formmail.pl" method=post>
	<input type=hidden name=team value="$liga_id">
	<input type=hidden name=recipient value="$mail">
END_TWO

	for ( 30 .. 54 ) {
		print "<input type=hidden name=\"", $_, "....\" value=\"", $tipos[ $_ - 30 ], "\">\n";
	}

	print <<END_THREE;
	<button id="button_for_submit">Tips abgeben</button><br><br>	
	<span><input type=checkbox name=mail_ja value=1 checked>&nbsp;Tips als Mail zuschicken</span>

	</form><br>
	<div>
	<span>
	<img id="helpbutton" class="helptext" src="/img/GreenQMark.jpg" alt="Help"/>
	Kurzanleitung: die gr&uuml;nen Boxen mit den Quoten<br>per Drag&Drop zum gew&uuml;nschten Tip ziehen.
	<br>Wahlweise: Taste 1-4 f&uuml;r Spiel 1-4 dr&uuml;cken,<br>w&auml;hrend die Maus &uuml;ber der entsprechenden gr&uuml;nen Box ist.
	</span>
	</div>
	</div>
END_THREE

}

sub makeForm {
	print "<form action=/cgi-bin/btm/formmail.pl method=post>";

	$xx = "&";
	$aa = $liga . $xx . $id;

	print "<input type=hidden name=recipient value=\"$mail\">\n";
	print "<table border=0 bgcolor=white cellpadding=0 cellspacing=0><tr>";

	print "<td align=right colspan=40>
[ <img src=/img/printer.png> <a href=/cgi-bin/drucktip.pl?tm=btm style=\"text-decoration:none\" target=new>Formular Druckansicht</a> ]
<BR>
&nbsp;
</tr><tr></tr><tr>";

	print "<td></td><td></td><td></td><td>\n";

	if ( $spielrunde_ersatz != 33 ) {
		print "<img src=/img/spacer11.gif></td><td></td><td>\n";
		print "<img src=/img/spacer11.gif></td><td></td><td>\n";
	}

	print "<img src=/img/spacer11.gif></td><td></td><td>\n";
	print "<img src=/img/spacer11.gif></td><td></td><td>\n";
	print
"<img src=/img/spacer2.gif></td><td><img src=/img/spacer4.gif><td></td><td><img src=/img/spacer3.gif></td></td></tr><tr>\n";

	for ( $x = 1 ; $x <= 16 ; $x++ ) { print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n" }
	print "</tr>\n";
	print "<tr><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
	print "<td bgcolor=#eeeeee>&nbsp;</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

	$rr = $spielrunde_ersatz + 3;
	if ( $rr > 34 ) { $rr = 34 }

	for ( $x = $spielrunde_ersatz ; $x <= $rr ; $x++ ) {
		print "<td bgcolor=#eeeeee align=middle><font face=verdana size=1>Sp. $x &nbsp;[$ort[$x-1]] </td>\n";

		print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
	}
	print
"<td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;</td><td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;Quoten</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td><td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;&nbsp;&nbsp;bisherige Tipps</td>\n";
	print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr><tr>\n";
	for ( $x = 1 ; $x <= 16 ; $x++ ) { print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n" }
	print "</tr>\n";
	print
"<tr><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td><td bgcolor=#eeeeee>&nbsp;</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

	for ( $x = 1 ; $x <= 4 ; $x++ ) {
		if ( ( $x + $spielrunde_ersatz ) < 36 ) {
			print
"<td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;2\n";
			print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
		}
	}

	print
"<td bgcolor=#eeeeee>&nbsp;</td><td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2\n";
	print
"</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td><td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr><tr>\n";
	for ( $x = 1 ; $x <= 16 ; $x++ ) { print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n" }

	print "</tr>\n";

	$tf = 0;

	for ( $x = 1 ; $x <= 25 ; $x++ ) {

		$tf++;

		$farbe = "white";
		if ( $tf == 3 ) { $tf    = 1 }
		if ( $tf == 2 ) { $farbe = "#eeeeee" }
		@selected = ();
		if ( $tipos[ $x - 1 ] eq "0&0" ) { $selected[0] = " checked" }

		if ( $tipos[ $x - 1 ] eq "1&1" ) { $selected[1]  = " checked" }
		if ( $tipos[ $x - 1 ] eq "1&2" ) { $selected[2]  = " checked" }
		if ( $tipos[ $x - 1 ] eq "1&3" ) { $selected[3]  = " checked" }
		if ( $tipos[ $x - 1 ] eq "2&1" ) { $selected[4]  = " checked" }
		if ( $tipos[ $x - 1 ] eq "2&2" ) { $selected[5]  = " checked" }
		if ( $tipos[ $x - 1 ] eq "2&3" ) { $selected[6]  = " checked" }
		if ( $tipos[ $x - 1 ] eq "3&1" ) { $selected[7]  = " checked" }
		if ( $tipos[ $x - 1 ] eq "3&2" ) { $selected[8]  = " checked" }
		if ( $tipos[ $x - 1 ] eq "3&3" ) { $selected[9]  = " checked" }
		if ( $tipos[ $x - 1 ] eq "4&1" ) { $selected[10] = " checked" }
		if ( $tipos[ $x - 1 ] eq "4&2" ) { $selected[11] = " checked" }
		if ( $tipos[ $x - 1 ] eq "4&3" ) { $selected[12] = " checked" }

		print "<tr><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
		print "<td bgcolor=$farbe>&nbsp;<input type=radio name=$tipo[$x] value=0&0$selected[0]>&nbsp;</td>\n";

		print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
		print "<td bgcolor=$farbe>&nbsp;<input type=radio name=$tipo[$x] value=1&1$selected[1]>\n";
		print "<input type=radio name=$tipo[$x] value=1&2$selected[2]>\n";
		print "<input type=radio name=$tipo[$x] value=1&3$selected[3]>&nbsp;</td>\n";

		print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
		print "<td bgcolor=$farbe>&nbsp;<input type=radio name=$tipo[$x] value=2&1$selected[4]>\n";
		print "<input type=radio name=$tipo[$x] value=2&2$selected[5]>\n";
		print "<input type=radio name=$tipo[$x] value=2&3$selected[6]>&nbsp;</td>\n";

		if ( ( $spielrunde_ersatz + 2 ) < 35 ) {
			print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
			print "<td bgcolor=$farbe>&nbsp;<input type=radio name=$tipo[$x] value=3&1$selected[7]>\n";
			print "<input type=radio name=$tipo[$x] value=3&2$selected[8]>\n";
			print "<input type=radio name=$tipo[$x] value=3&3$selected[9]>&nbsp;</td>\n";
		}

		if ( ( $spielrunde_ersatz + 3 ) < 35 ) {
			print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
			print "<td bgcolor=$farbe>&nbsp;<input type=radio name=$tipo[$x] value=4&1$selected[10]>\n";
			print "<input type=radio name=$tipo[$x] value=4&2$selected[11]>\n";
			print "<input type=radio name=$tipo[$x] value=4&3$selected[12]>&nbsp;</td>\n";
		}
		print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

		$flag = $main_flags[ $flagge[$x] ];

## Live-Resultate Syndication ##############
		@res     = split( /\-/, $paarung[$x] );
		$verein1 = $res[0];
		$verein2 = $res[1];

		#print "... $res[0] $res[1]" ;
		$r1        = "";
		$r2        = "";
		$verein_k1 = "";
		$verein_k2 = "";
		&transfer;
		if ( $t1{$verein_k1} < 10 ) { $r1 = "0" }
		if ( $t1{$verein_k2} < 10 ) { $r2 = "0" }

		if ( $t1{$verein_k1} ne "" && $t1{$verein_k2} ne "" ) {
			$paarung[$x] = "<!--a href=javascript:document.xr$x.submit()-->" . $res[0] . "  - " . $res[1] . " </a>";
		}
#############################################

		if ( $flagge[$x] < 3 && $flagge[$x] > 0 ) {
			print "<td align=left bgcolor=$farbe>&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=1>
<img HEIGHT=10 WIDTH=14 src=/img/$flag border=0>&nbsp;&nbsp;&nbsp;$paarung[$x]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";

		}
		elsif ( ( $flagge[$x] == 3 ) or ( $flagge[$x] == 4 ) or ( $flagge[$x] == 5 ) or ( $flagge[$x] == 8 ) ) {
			print "<td align=left bgcolor=$farbe nowrap>&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=1>
<img HEIGHT=10 WIDTH=14 src=/img/$flag border=0>&nbsp;&nbsp;&nbsp;$paarung[$x]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";

		}
		else {
			print "<td align=left bgcolor=$farbe nowrap>&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=1>
<img HEIGHT=10 WIDTH=14 src=/img/$flag border=0>&nbsp;&nbsp;&nbsp;$paarung[$x]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";
		}

		print
"<td bgcolor=$farbe nowrap><font face=verdana size=1> $qu_1[$x] &nbsp;&nbsp; $qu_0[$x] &nbsp;&nbsp; $qu_2[$x] &nbsp;&nbsp;</td>\n";
		print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
		print
"<td bgcolor=$farbe nowrap><font face=verdana size=1> &nbsp;&nbsp;$toto_1[$x] &nbsp; $toto_2[$x] &nbsp; $toto_3[$x] &nbsp;</td>\n";
		print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr>\n";
	}
	print "<tr>";
	for ( $x = 1 ; $x <= 16 ; $x++ ) { print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n" }

	print "</tr></table>\n";

	print
"<br>&nbsp; <input type=checkbox name=mail_ja value=1 checked> &nbsp; <font size=2><b> Bitte die Tippabgabe auch als
E-Mail an mich senden</b>
<br>";

	print
"<font face=verdana size=1 color=black><br>Beim Click auf die Laenderflaggen werden die entsprechenden realen Ligatabellen geladen .<br>Nach dem Absenden des Formulars unbedingt auf die Antwortseite warten !<br><br>Die Tipabgabe ist jeweils bis Freitags 18.oo Uhr moeglich !\n";
	if ( $tip_eingegangen == 1 ) { $ab = "Tipabgabe senden" }
	if ( $tip_eingegangen == 0 ) { $ab = "Tipabgabe senden" }

	print "<br><br>\n";
	if ( $tip_status == 1 ) { print "<input type=submit value=\"$ab\"></form></html>\n" }
	if ( $tip_status == 2 ) {
		print
"Der Tipabgabetermin ist bereits abgelaufen .<br>Es ist keine Abgabe bzw. Aenderung Ihres Tips mehr moeglich .</html>\n";
	}

}
