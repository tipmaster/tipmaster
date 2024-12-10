#!/usr/bin/perl

=head1 NAME
	BTM anmeldung.pl

=head1 SYNOPSIS
	TBD
	


=head1 CHANGELOG
	2015-06-09 Thomas: Added Session Management


	Created 2015-06-09

=cut

use lib '/tmapp/tmsrc/cgi-bin/';
use TMSession;
use TMAuthenticationController;
use HTML::Entities;
use TMDao;
use URI::Encode;
use TMLogger;

my $session = TMSession::getSession();
my $trainer = $session->getUser();
my $leut    = $trainer;

use CGI;
$query    = new CGI;
$vorname  = $query->param('vorname');
$nachname = $query->param('nachname');
$verein   = $query->param('frei');
$mail     = $query->param('adresse');
$link     = $query->param('link');
$pass     = $query->param('newpass');
$inactiveUser     = $query->param('inactiveUser');
$email     = $query->param('email');




$send   = $query->param('send');
$method = $query->param('m');
$tt     = $query->param('t');
$nr     = $query->param('nr');
$landid = $query->param('landid');

require "/tmapp/tmsrc/cgi-bin/btm_ligen.pl";

if ( $method eq "f" ) { &freischalten }

&get_date;
&check_url;
&return_html;
&send_mail;
exit;

sub return_html {

	our @hinweise = ();
	if ( $send != 1 ) { &formular }
	$fehler = 0;
	TMLogger::log("main::anmeldung.pl " . $method);
	if ($method eq "replaceEmailInactiveAccount") {
		replaceEmailInactiveAccount($inactiveUser, $email);
		&formular;
	}

###### verbotene Emails ####################################
	$ban = 0;
	open( D1, "/tmdata/banmail.txt" );
	while (<D1>) {
		$rr = $_;
		chomp $rr;
		if ( $mail =~ /$rr/ ) { $ban = 1; $ban_id = $rr; }
	}
	close(D1);
	if ( $ban == 1 ) {
		$fehler++;
		$fault[$fehler] = "Betrifft E-Mail Adresse :<br>
Registrierungen mit E-Mail Adresse der<br>
Domain $ban_id koennen wir nicht akzeptieren";
	}
###########################################################

	$frei    = $verein;
	$freio   = '&' . $verein . '&';
	$adresse = $mail;
	srand();
	$aa          = " ";
	$ac          = "&";
	$voller_name = $vorname . $aa . $nachname;
	$suche       = $ac . $voller_name . $ac;

################# CHECK BTM UND TMI #########################
	$vorhanden      = 0;
	$r              = 0;
	$mail_vorhanden = 0;

	open( D2, "/tmdata/btm/history.txt" );
	while (<D2>) {
		$r++;
		$zeilen[$r] = $_;
		chomp $zeilen[$r];
		if ( $_ =~ /$suche/i ) {
			$vorhanden_btm = 1;
		}
	}
	close(D2);

	open( D2, "/tmdata/tmi/history.txt" );
	while (<D2>) {
		$r++;
		$zeilen[$r] = $_;
		chomp $zeilen[$r];
		if ( $_ =~ /$suche/i ) {
			$vorhanden_tmi = 1;
		}
	}
	close(D2);

	$ae    = "!";
	$suche = $ae . $suche;
	$r     = 0;
	open( D2, "/tmdata/hashedPasswords.txt" );
	while (<D2>) {
		$r++;
		$zeileno[$r] = $_;
		chomp $zeileno[$r];
		if ( $_ =~ /$suche/ ) {
			$vorhanden_para = 1;
			@aal            = split( /&/, $_ );
			$pass_richtig   = $aal[2];
			$mail_richtig   = $aal[3];
		}

		if ( $_ =~ /&$mail&/ ) {
			@aal  = split( /&/, $_ );
			$tmp1 = $aal[1];
			$tmp2 = $aal[3];
			if ( $tmp1 ne $voller_name ) {
				$mail_vorhanden = 1;
			}

		}

	}
	close(D2);

###################################################################

	$ein = 1;
	if ( $voller_name =~ /^[A-Z]([a-z]|-[A-Z])* [A-Z]([a-z]|-[A-Z])*$/ ) { $ein = 0; }
	if ( $voller_name =~ /Bodo/ && $voller_name =~ /Pfannen/ ) { $ein = 1; }    # Little Annoyance-Filter
	if ( $voller_name =~ /Koman/ ) { $ein = 1; }                                # Little Annoyance-Filter
	$mail_ok = 0;

	if ( $adresse !~ /^.+\@(\[?)[a-zA-Z0-9\-\.]+\.([a-zA-Z]{2,3}|[0-9]{1,3})(\]?)$/ ) { $mail_ok = 1 }
	if ( $adresse =~ / / ) { $mail_ok = 1 }

	$rr = length($voller_name);
	if ( $rr > 22 ) { $ein = 1 }
	if ( $rr < 6 )  { $ein = 1 }
	$rr = length($vorname);
	if ( $rr < 3 ) { $ein = 1 }
	$rr = length($nachname);
	if ( $rr < 3 ) { $ein = 1 }

	$rr = length($pass);
	if ( $rr < 4 || $rr > 16 || $pass =~ / / || $pass =~ /\&/ || $pass =~ /\!/ || $pass =~ /\#/ ) { $pass_ok = 1 }

	#no longer working with varnish in front, tp, 11/28/13 - shoudl pick up on forward ip
	if (0) {
		open( D, "</tmdata/check_ip_btm.txt" );
		$ips = <D>;
		@ip = split( /&/, $ips );
		close(D);
		$check_ip = 0;
		foreach $ii (@ip) {
			if ( $ENV{'REMOTE_ADDR'} eq $ii ) { $check_ip = 1 }
		}
	}

	if ( $ENV{'REMOTE_ADDR'} =~ /212\.38\.25\./ ) { $check_ip = 1 }

	if (0) {
		if ( $check_ip == 1 ) {
			$fehler++;
			$fault[$fehler] = "<font color=darkred>Betrifft eigene IP :<font color=black><br>
Unter der IP ihres Internetzugangs wurde<br>
erst vor kurzem eine Anmeldung beim BTM <br>
vorgenommen. Mehrere Anmeldungen mit der<br>
gleichen IP hintereinander sind nicht<br>
moeglich. Versuchen Sie es bitte morgen erneut.<br>
Bitte beachten Sie: jeder Mitspieler <br>
darf nur je einen Verein beim BTM und TMI betreuen.";
		}
	}

	if ( $ein == 1 ) {
		$fehler++;
		$fault[$fehler] = "<font color=darkred>Betrifft Name :<font color=black><br>
Ihr Namensangabe hat kein gueltiges Format .<br>
Bitte verzichten sie auf Umlaute und schreiben<br>
Sie nur jeweils den ersten Buchstaben im <br>
Vor- und Nachnamen gross .<br>
Evtl. ist Ihr Name auch zu lang bzw. kurz .";
	}

	if ( $mail_ok == 1 ) {
		$fehler++;
		$fault[$fehler] = "<font color=darkred>Betrifft E-Mail Adresse :<font color=black><br>
Ihr E-Mail Adresse hat kein gueltiges Format .<br>
Bitte geben Sie ihre gueltige E-Mail Adresse<br>
an, da sonst auch keine Account Freischaltung moeglich ist.";
	}

	if ( $vorhanden_btm == 1 ) {
		$fehler++;
		$fault[$fehler] = "<font color=darkred>Betrifft Trainername :<font color=black><br>
Unter dem angegebenen Trainernamen ist<br>
bereits ein Trainer beim Bundesliga - TipMaster eingetragen. <br>
Bitte modifizieren Sie Ihren Trainernamen leicht<br>
indem Sie bspw. als Vornamen Ihren Spitz/Rufnamen<br>
eintragen. Vielen Dank fuer Ihr Verstaendnis.";
	}

	#if ( $vorhanden_tmi == 1 ) {
	#$fehler++;
	#$fault[$fehler] = "<font color=darkred>Betrifft Trainername :<font color=black><br>
	#Unter dem angegebenen Trainernamen ist<br>
	#bereits ein Trainer beim TipMaster international eingetragen. <br>
	#Aufgrund der grossen Nachfrage ist es derzeit fuer Neueinsteiger<br>
	#nur gestattet einen Verein beim Bundesliga-TipMaster oder einen<br>
	#Verein beim TipMaster international zu fuehren.";
	#}

	if ( $mail_vorhanden == 1 ) {
		$fehler++;
		$fault[$fehler] = "<font color=darkred>Betrifft Mail-Adresse :<font color=black><br>
Unter der angegebenen Mail-Adresse ist bereits<br>
ein Account beim TipMaster registriert. Weitere <br>
Accounts unter dieser E-Mail Adresse sind nicht<br>
moeglich. Bitte beachten Sie: jeder Mitspieler <br>
darf nur je einen Verein beim BTM und TMI betreuen.";
	}

	if ( $pass_ok == 1 ) {
		$fehler++;
		$fault[$fehler] = "<font color=darkred>Betrifft Passwort :<font color=black><br>
Ihr gewuenschtes Passwort hat kein gueltiges<br>
Format. Entweder es ist zu kurz bzw. zu lang<br>
oder es enthaelt nicht erlaubte Sonder- bzw.<br>
Leerzeichen.";
	}
	if ( $vorhanden_para == 1 && ( ( $pass_richtig ne TMAuthenticationController::hashPassword( $pass, $voller_name ) ) || ( $mail_richtig ne $mail ) ) ) {
		$fehler++;
		
		my $replaceEmailUrl = "/cgi-bin/btm/anmeldung.pl?send=1&m=replaceEmailInactiveAccount&inactiveUser=" . URI::Encode::uri_encode($voller_name) . "&email=". URI::Encode::uri_encode($mail);
		
		
		$fault[$fehler] = "<font color=darkred>Betrifft Trainername + Passwort + E-Mail:<font color=black><br>
Unter diesem Trainername wurde<br>
in der Vergangenheit bereits ein<br>
Account beim TipMaster registriert.<br><br>
Um fuer diesen Account (Neu)Anmeldungen<br>
zu taetigen, muessen Sie sich mit dem identischen<br>
Passwort und identischer E-Mail mit der<br>
dieser Account beim ersten Mal registriert wurde<br>
anmelden. Dies ist aktuell noch nicht der Fall.<br><br>
Der Account wurde mit der E-Mail Adresse <br>
$mail_richtig eroeffnet.<br><br>
<b>L&ouml;sung 1:</b><br>
Sie waeren in der Vergangenheit nicht beim TipMaster<br>
angemeldet? Waehlen Sie bitte Ihren Nicknamen<br>
als Vornamen und versuchen Sie es erneut.<br><br>
<b>L&ouml;sung 2:</b><br>
Passwort vergessen? Wenn Sie weiterhin Zugriff<br> 
zu der obigen Email haben aber das Passwort vergessen<br>
haben koennen Sie sich <a href=\"/url.shtml\">hier</a> ein neues<br>
Passwort zuschicken lassen und die Wiederanmeldung<br> 
dann neu probieren.<br><br>
<b>L&ouml;sung 3:</b><br>
Neue E-Mail? Sollten Sie keinen Zugriff mehr<br>
auf die obige E-Mail haben koennen Sie <a href=\"$replaceEmailUrl\">hier klicken</a><br>
um die E-Mail Adresse fuer den inaktiven Account<br>
fuer $voller_name auf $mail<br>
zu aendern.<br><br>

";

	}

	if ( $method ne "W" ) {
		$r = 0;
		open( D2, "/tmdata/btm/history.txt" );
		while (<D2>) {
			$r++;
			$zeilen[$r] = $_;
			chomp $zeilen[$r];
			if ( $_ =~ /$freio/i ) {
				@vereind = split( /&/, $_ );
				$linie = $r;
			}
		}
		close(D2);
		$lor[0] = $vereind[0];
		$y = 0;
		for ( $x = 1 ; $x < 19 ; $x++ ) {
			$y++;
			chomp $vereind[$y];
			$data[$x] = $vereind[$y];
			$y++;
			chomp $vereind[$y];
			$datb[$x] = $vereind[$y];
			$y++;
		}
		
		TMLogger::log("main::anmeldung.pl " . $voller_name);
		TMLogger::log("main::anmeldung.pl " . $adresse);
		
		
		
		for ( $x = 1 ; $x < 19 ; $x++ ) {
			if ( $data[$x] eq $verein ) {
				if ( $datb[$x] ne "Trainerposten frei" ) {
					$fehler++;
					$fault[$fehler] = "<font color=darkred>Betrifft Vereinswahl :<font color=black><br>
Der gewuenschte Verein ist mittlerweile<br>
bereits wieder vergeben. Bitte einen<br>
anderen Verein waehlen.";
				}
				TMLogger::log("main::anmeldung.pl klappt auch" . $variable);
				$datb[$x] = $voller_name;
				$datc[$x] = $adresse;
			}
		}
	}


	if ( $fehler == 0 && $send == 1 ) { &anmelden }

	if ( $fehler > 0 || $send != 1 ) {
		&formular;
	}
}

#-------------------------------------------------------------------------------------------#

sub anmelden {

	$c = time();
	

	my $hashedPassword = TMAuthenticationController::hashPassword( $pass, $voller_name );

	$aa = "&";
	$zeilen[$linie] = $lor[0] . $aa;
	for ( $x = 1 ; $x < 19 ; $x++ ) {
		$zeilen[$linie] = $zeilen[$linie] . $data[$x] . $aa . $datb[$x] . $aa . $aa;
	}

	if ( $vorhanden_para != 1 ) {
		open( D2, ">>/tmdata/hashedPasswords.txt" );
		flock( D2, 2 );
		print D2 "!&$voller_name&$hashedPassword&$adresse&\n";
		flock( D2, 8 );
		close(D2);

		open( D2, ">>/tmdata/shadow.txt" );
		flock( D2, 2 );
		print D2 "!&$voller_name&$hashedPassword&$voller_name&$adresse&$landid&1&\n";
		flock( D2, 8 );
		close(D2);

	}

	open( A2, ">/tmdata/btm/history.txt" );
	flock( A2, 2 );
	for ( $x = 1 ; $x <= $rr_ligen ; $x++ ) { print A2 "$zeilen[$x]\n"; }
	flock( A2, 8 );
	close(A2);

	open( A2, ">>/tmdata/btm/link.txt" );
	print A2 "&$voller_name&$link&\n";
	close(A2);
	open( A2, ">>/tmdata/btm/anmeldung.txt" );
	flock( A2, 2 );
	print A2 "&$date&$time&$ENV{'REMOTE_ADDR'}&$voller_name&$adresse&$linko&\n";
	flock( A2, 8 );
	close(A2);

### LAENDERCOE CODE#####
	( $sek, $min, $std, $tag, $mon, $jahr ) = localtime( time + 0 );
	$mon++;
	if ( $sek < 10 )        { $xa = "0" }
	if ( $min < 10 )        { $xb = "0" }
	if ( $std < 10 )        { $xc = "0" }
	if ( $tag < 10 )        { $xd = "0" }
	if ( $mon < 10 )        { $xe = "0" }
	if ( $liga < 10 )       { $xf = "0" }
	if ( $spielrunde < 10 ) { $xg = "0" }
	$jahr = $jahr + 1900;
	open( A2, ">>/tmdata/frontdata/anmeldung.txt" );
	flock( A2, 2 );
	print A2 "&$xd$tag.$xe$mon&$xc$std:$xb$min&$ENV{'REMOTE_ADDR'}&$voller_name&$landid&$link&$linko&\n";
	flock( A2, 8 );

	#PROFIL anlegen
	$aa     = "&";
	$zeilen = "!&" . $voller_name . $aa . $aa . $landid . $aa . $aa . $aa . $aa . $aa . $aa . $aa;
	$datei  = "/tmdata/btm/db/profile/" . $voller_name . ".txt";
	open( D8, ">$datei" );
	print D8 $zeilen;
	close(D8);
#######

	open( D, "</tmdata/check_ip_btm.txt" );
	$ips = <D>;
	@ip = split( /&/, $ips );
	close(D);
	open( D, ">/tmdata/check_ip_btm.txt" );
	print D "$ENV{'REMOTE_ADDR'}&$ip[0]&$ip[1]&$ip[2]&$ip[3]&";
	close(D);

	print "Content-type: text/html \n\n";
	print "<title>TipMaster - Anmeldung erfolgreich</title>";
	print "<body bgcolor=#ffffff><img src=/img/trail.gif>\n";

	print "<br><table border=0><tr>\n";
	print "<td colspan=10></td><td valign=top>\n";
	print "\n";
	print
"<br><font face=verdana size=2 color=darkred><b>Ihre Anmeldung war erfolgreich !<font color=black></b><br><br><font face=verdana size=1>Vielen Dank fuer Ihre<br>Anmeldung , $voller_name .<br><br>\n";
	print "Sie sind ab sofort als neuer Trainer bei<br>". encode_entities($verein) ." eigetragen .<br><br>\n";
	print
"Der Link zum Freischalten Ihres Accounts<br>sowie weitere Instruktionen werden in diesem<br>Moment an $adresse<br>gemailt .<br><br><br>
<font face=verdana size=2><b>Trainer - LogIn</b><form action=/cgi-mod/btm/login.pl method=post>
<br><br><font color=black><br>
<font face=verdana size=1>Trainername :<br><input type=text lenght=25 name=email value=\"$voller_name\"><br><br>Passwort :<br><input type=password lenght=25 name=password><br><font size=1><br><input type=hidden name=first value=1><input type=image src=/img/log_in.jpg border=0></form><br>";
	print "</td><td><br><font color=#eeeeee face=verdana size=1>";
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
	&send_mail;

}

exit;

sub check_url {

	# CHECK AUF ANFRAGEQUELLE #################################
	$referer = "tipmaster.de";
	if ( $ENV{'HTTP_REFERER'} =~ m|https?://([^/]*)$referer|i ) { $check = 1; }
	$check = 1;
	if ( $check != 1 ) {
		print "Content-type: text/html \n\n";
		print "<font face=verdana size=2><b>";
		print "<br>Der Request wurde nicht ueber den tipmaster Server aufgerufen .<br>";
		exit;
	}
###########################################################
}

sub send_mail {

	$tmp = $voller_name;
	$tmp =~ s/ /%20/g;
	srand();
	for ( $x = 1 ; $x <= 9 ; $x++ ) {
		$nn = int( rand(9) ) + 1;
		$nr = $nr . $nn;
	}

	open( AA, ">/tmdata/btm/free/$trainer" );
	print AA $nr;
	close(AA);

	$mail{Message} .= "Bundesliga - TipMaster\nhttp://www.tipmaster.de/btm/\n\n\n ";
	$mail{Message} .= "             *** Einstellungsschreiben ***\n\n";
	$mail{Message} .= "Sehr geehrte(r) $voller_name ,\n\n";
	$mail{Message} .= "herzlichen Glueckwunsch . Sie sind ab sofort neue(r) Trainer(in)\n";
	$mail{Message} .= "bei $frei in der $liga_namen[$linie] .\n\n";
	$mail{Message} .= "Ihre Zugansdaten fuer den TipMaster LogIn :\n\n";
	$mail{Message} .= "Trainername  : $voller_name\n";
	$mail{Message} .= "Passwort     : (Wie angegeben waehrend der Anmeldung)\n\n

Bitte aktivieren Sie zum Freischalten Ihres Accounts folgenden Link :\n
http://www.tipmaster.de/cgi-bin/btm/anmeldung.pl?m=f&t=$tmp&nr=$nr\n\n";

	$mail{Message} .=
"Bei Fragen zum Spielsystem lesen Sie bitte das Regelbuch sowie die FAQ zum TipMaster .\nWir wuenschen Ihnen viel Spass und Erfolg beim TipMaster .\n\n";
	$mail{Message} .= "Mit freundlichen Gruessen\nIhr TipMaster - Team\n";

	$mailprog = '/usr/sbin/sendmail';
	open( MAIL, "|$mailprog -t" );
	print MAIL "To: $adresse\n";
	print MAIL "From: service\@tipmaster.net ( TipMaster online )\n";
	print MAIL "Subject: Bundesliga - TipMaster Anmeldung\n\n";
	print MAIL "$mail{Message}";
	close(MAIL);
}

sub formular {
	$frei = 0;
	$liga = 0;


	open( D2, "/tmdata/btm/history.txt" );
	while (<D2>) {
		$liga++;
		@vereine = split( /&/, $_ );

		if ( $liga > 128 ) {
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
				}
				$y++;
				chomp $verein[$y];
				$datc[$x] = $vereine[$y];
			}
		}
	}

	open( D2, "/tmdata/btm/heer.txt" );
	while (<D2>) {
		@lok = split( /&/, $_ );
		$rang{ $lok[5] } = $lok[0];
	}
	close(D2);

	print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>Anmeldung</title>
 </head>

<body bgcolor=#ffffff>
<font color=#eeeeee face=verdana size=1>
(END ERROR HTML)
	require "/tmapp/tmsrc/cgi-bin/tag.pl";
	require "/tmapp/tmsrc/cgi-bin/tag_small.pl";

	print <<"(END ERROR HTML)";
<br>
<table border=0><tr>
<td colspan=10></td><td valign=top>


<font face=verdana size=1>
<br>
<font face=verdana size=2><b>Bundesliga - TipMaster Anmeldung</b><br><br>

<font face=verdana size=1>
(END ERROR HTML)

	if ( $frei != 0 ) { }
	else {
		print "
<font color=darkred><br>
Leider sind im Moment alle Vereine vergeben und Sie muessen<br>
sich in die Warteliste eintragen. Sobald neue Vereine frei<br>
werden und Ihre Wartelistenposition ausreichend ist, wird<br>
Ihnen ein freier Verein zugeordnet und Sie werden<br>
per E-Mail informiert ! [ -> <a href=/cgi-bin/btm/warte.pl>BTM Warteliste - Refresh Account</a> ]

<br><br>
<font color=black>
Info: Jeder Mitspsieler darf <u>je einen</u> Verein beim<br>
Bundesliga-TipMaster und TipMaster international <br>
fuehren. [ -> <a href=/cgi-bin/tmi/anmeldung.pl>Anmeldung TipMaster international</a> ]
<font color=black><br><br>

";
	}

	if ( $fehler > 0 ) {
		print "
<font color=green size=2><b>Bei Ihrer Anmeldung ist / sind<br>
leider $fehler Fehler aufgetreten :</b><br><br><font color=black size=1>";
		for ( $f = 1 ; $f <= $fehler ; $f++ ) {
			print "$fault[$f]<br><br>\n";
		}
		print "";
	}
	
	if ( scalar(@hinweise) > 0 ) {
		print "
<br><br><font color=black size=1>";
		for ( $f = 1 ; $f <= scalar(@hinweise) ; $f++ ) {
			print "$hinweise[$f]<br><br>\n";
		}
		
	}
	

	print "
<form action=/cgi-bin/btm/anmeldung.pl method=post>



<font face=verdana size=2><div style=\"width:120px;float:left\">Vorname</div> <input type=text lenght=25 name=vorname value=\"$vorname\"><br><br>

<font face=verdana size=2><div style=\"width:120px;float:left\">Nachname</div> <input type=text lenght=25 name=nachname value=\"$nachname\"><br>
<font color=green><br><font face=verdana size=1>
Bei erkennbaren Phantasie- / Prominentennamen<br>
wird Ihre Anmeldung storniert.<br>
<font color=black>
<br><font face=verdana size=2><div style=\"width:120px;float:left\">E-Mail Adresse</div> <input type=text lenght=25 name=adresse value=\"$mail\"><br><br>

<font color=black>
";

#if ( $frei == 0 ) {
#print "<br>Falls Sie international nocht nicht als TipMaster - Trainer taetig sind,<br>besuchen Sie die <a href=/cgi-bin/tmi/anmeldung.pl>TMI - Anmeldungsseite</a> um dies zu aendern ...<br>";
#print "</td><td><br><br><br><font color=#eeeeee face=verdana size=1>\n";
#print "<img src=/img/header.gif valign=top></form></td></tr></table>\n";
#exit ;}

	print "
<div style=\"width:120px;float:left\">Passwort</div> <input type=password lenght=25 name=newpass><br><br>
<font color=black>
";

	if ( $frei == 0 ) {
		print "

<input type=hidden name=m value=\"W\">
<input type=hidden name=send value=1><br>

<br><input type=submit value=\"In die Warteliste eintragen\"></form>
<font color=darkred size=2 face=verdana><b>ACHTUNG: Sollten Sie schon in der TMI Warteliste<br>
registriert sein bitte exakt identisches Passwort,<br>
E-Mail Adresse und Trainernamen bei dieser<br> Anmeldung verwenden !
</td><td><br>
<br><br><font color=#eeeeee face=verdana size=1>
</form></td></tr></table>
</body>
</html>";
		exit;
	}

	print '
<font color=black>
Gewuenschter verfuegbarer Verein<br>
<select style="font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;" name=frei>
';

	for ( $x = 1 ; $x <= $frei ; $x++ ) {
		if ( $auswahl_liga[$x] > 128 && $auswahl_liga[$x] < ( 256 + 128 ) ) {
			$sel = "";
			if ( $auswahl_verein[$x] eq $verein ) { $sel = " selected" }
			print
"<option value=\"$auswahl_verein[$x]\"$sel> $auswahl_verein[$x] ( $liga_namen[$auswahl_liga[$x]] / $rang{$auswahl_verein[$x]}. Platz )\n";
		}

	}

	print <<"(END ERROR HTML)";
</select><br>
<font color=black>
(END ERROR HTML)

	print "
<input type=hidden name=send value=1><br>
<input type=submit value=\"Jetzt anmelden\" style=\"font-size:2em\"></form><br>
<br/>

<br/><br/><br/><br/><br/><br/>
<div style=\"background-color:white;padding:15px;border:1px solid black;\"><b>Anmerkung TipMaster International</b></br>
<font face=verdana size=1>Fuer internationale Vereine kann man sich <a href=\"/cgi-bin/tmi/anmeldung.pl\">hier</a> anmelden.</font>
</div><br/><br/>

</td><td><br>
<br><br><font color=#eeeeee face=verdana size=1>
</form></td></tr></table>

 </body>
</html>
";

	exit;

}

sub freischalten {
	print "Content-type:text/html\n\n";
	$dit = "/tmdata/btm/free/" . $tt;
	open( AA, "</tmdata/btm/free/$tt" );
	$nrr = <AA>;
	chomp $nrr;
	close(AA);

	if ( ( $nr == $nrr || -e $dit == 0 ) ) {
		unlink($dit);

		print "<title>Freischaltung erfolgreich</title>";
		print "<body bgcolor=#eeeeee>=\n";

		print "<br><table border=0><tr>\n";
		print "<td colspan=10></td><td valign=top>\n";
		print "\n";
		print
"<br><font face=verdana size=2 color=darkred><b>Freischaltung fuer Account<br>$tt war erfolgreich !<font color=black></b><br><br><font face=verdana size=1><br><br>\n
<font face=verdana size=2><b>Trainer - LogIn</b><form action=/cgi-mod/btm/login.pl method=post>
<font color=black><br>
<font face=verdana size=1>Trainername :<br><input type=text lenght=25 name=email value=\"$tt\"><br><br>Passwort :<br><input type=password lenght=25 name=password><br><font size=1><br><input type=hidden name=first value=1><input type=image src=/img/log_in.jpg border=0></form><br>";
		print "</td><td>";
		print "</td></tr></table>";

	}
	else {
		print
"Die Freischaltung war leider nicht erfolgreich.<br>Bitte gehen Sie sicher das der komplette Link aus Ihrer Anmeldemail aktiviert wurde.
Bei weiteren Problemen -> Mail an info\@tipmaster.net";
	}

	exit;
}

sub get_date {

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

}


sub replaceEmailInactiveAccount {
	my $inactiveUser = shift;
	my $email = shift;
	my $return = TMDao::assignNewEmailToInactiveAccount($inactiveUser, $email);
	
	TMLogger::log("came in here");
	
	if ($return != 1) {
		$fehler++;
		$fault[$fehler] = $return;	
	} else {
		push(@hinweise,'Trainer '. $inactiveUser . ' hat nun die Email<br>'.$email.' zugewiesen. Bitte fordern Sie ein<br><a href="/url.shtml">neues Passwort an<a/> falls erfoderlich.');
	}
	
	
}
