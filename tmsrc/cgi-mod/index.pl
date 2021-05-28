
=head1 NAME
	index.pl

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

use strict;
use lib '/tmapp/tmsrc/cgi-bin/';
use TMSession;
use lib qw{/tmapp/tmsrc/cgi-bin};

use CGI;
my $session = TMSession::getSession();
my $trainer = $session->getUser();
my $leut    = $trainer;

print "Content-type:text/html\n\n";

use Test;
use CGI qw/:standard/;
use CGI::Cookie;
use utf8;

my $mlib         = new Test;
my $page_footer  = $mlib->page_footer();
my @liga_namen   = $mlib->tmi_liga_namen();
my @main_saison  = $mlib->btm_saison_namen();
my @main_kuerzel = $mlib->btm_saison_kuerzel();

my %flag_hash = (
	"Albanien"      => "AL",
	"Andorra"       => "AD",
	"Armenien"      => "AM",
	"Aserbaidschan" => "AZ",
	"Belgien"       => "BE",
	"Bosnien-Herz." => "BA",
	"Bulgarien"     => "BG",
	"Daenemark"     => "DK",
	"England"       => "UK",
	"Estland"       => "EE",
	"Faeroer"       => "FO",
	"Finnland"      => "FI",
	"Frankreich"    => "FR",
	"Georgien"      => "GE",
	"Griechenland"  => "GR",
	"Irland"        => "IE",
	"Island"        => "IS",
	"Israel"        => "IL",
	"Italien"       => "IT",
	"Jugoslawien"   => "JUG",
	"Kroatien"      => "HR",
	"Lettland"      => "LV",
	"Litauen"       => "LT",
	"Luxemburg"     => "LI",
	"Malta"         => "MT",
	"Mazedonien"    => "MK",
	"Moldawien"     => "MD",
	"Niederlande"   => "NL",
	"Nord Irland"   => "IE",
	"Norwegen"      => "NO",
	"Oesterreich"   => "AT",
	"Polen"         => "PL",
	"Portugal"      => "PT",
	"Rumaenien"     => "RO",
	"Russland"      => "RU",
	"San Marino"    => "SM",
	"Schottland"    => "UK",
	"Schweden"      => "SE",
	"Schweiz"       => "CH",
	"Slowakei"      => "SK",
	"Slowenien"     => "SI",
	"Spanien"       => "ES",
	"Tschechien"    => "CZ",
	"Tuerkei"       => "TR",
	"Ukraine"       => "UA",
	"Ungarn"        => "HU",
	"Wales"         => "UK",
	"Weissrussland" => "BY",
	"Zypern"        => "CY"
);

my @cup_tmi_name = ( "---", "1.HR", "---",  "AF",   "VF", "---", "HF", "---", "FI" );
my @cup_dfb_name = ( "---", "---",  "1.HR", "2.HR", "AF", "VF",  "HF", "",    "FI" );
my @cup_btm_name = ( "",    "QR",   "1.HR", "2.HR", "AF", "VF",  "HF", "",    "FI" );
my @cup_cl_name   = ( "1.QR", "2.QR", "3.QR", "GR 1-3", "GR 4-6",, "AF", "VF", "HF", "FI" );
my @cup_uefa_name = ( "1.QR", "2.QR", "1.HR", "2.HR",   "3.HR",,   "AF", "VF", "HF", "FI" );

my @displaydata1 = ();
my @displaydata2 = ();

my @events1 = (
	"",
	"Start der Auswertung",
	"Job-Boerse Runde",
	"Vereinswechsel",
	"Job-Boerse Runde",
	"Tippabgabeschluss",
	"Start der Auswertung"
);
my @events2 =
  ( "", "Sonntag 23:45", "Dienstag 12:00", "Mittwoch 13:00", "Donnerstag 16:00", "Freitag 18:00", "Sonntag 23:45" );

@displaydata1 = ();

my $i = 0;
open( A, "</tmdata/frontdata/anmeldung_s.txt" );
while (<A>) {
	my @data = split( /&/, $_ );
	$displaydata1[$i][0] = $data[1];
	$displaydata1[$i][1] = $data[2];
	$displaydata1[$i][2] = "<img src=/img/flags/" . lc( $data[5] ) . ".gif  height=12 width=18>";
	$displaydata1[$i][3] = $data[4];
	$i++;
}
close(A);

my $LABEL_AKT1 = "";
my $LABEL_AKT2 = "";
my $LABEL_AKT3 = "";

my $LABEL_AKT1 = &getTableHtml( "Neuste Anmeldungen", \@displaydata1 );

#my $LABEL_AKT2 = &getTableHtml("Neuste Foreneintraege",\@displaydata2);

my @displaydata2 = ();
my $system       = "btm";
my $i            = 0;
open( A, "</tmdata/frontdata/best_$system.txt" );
while (<A>) {
	if ( $i < 5 ) {
		my @data = split( /#/, $_ );
		$displaydata2[$i][0] = ( $i + 1 ) . '.';
		if ( $system eq "btm" ) {
			$displaydata2[$i][1] = "<img src=/img/flags/de.gif  height=12 width=18>";
		}
		else {
			my $flag = &getFlagToLiga("$liga_namen[$data[1]]");
			$displaydata2[$i][1] = "<img src=/img/flags/" . lc($flag) . ".gif height=12 width=18>";
		}

		my $t = $data[0];
		$t =~ s/ /%20/g;
		$displaydata2[$i][2] =
		  "<a href=/cgi-mod/$system/trainer.pl?ident=$t style=\"text-decoration: none\">$data[0]</a> &nbsp; ";
		$displaydata2[$i][3] = "&nbsp;" . $data[2] . " Tore";
		if ( $data[0] ne "" ) { $i++; }
	}
}
close(A);

my @displaydata3 = ();
my $system       = "tmi";
if ( $$ % 2 == 0 ) { $system = "tmi" }
my $i = 0;
open( A, "</tmdata/frontdata/best_$system.txt" );
while (<A>) {
	if ( $i < 5 ) {
		my @data = split( /#/, $_ );
		$displaydata3[$i][0] = ( $i + 1 ) . '.';
		if ( $system eq "btm" ) {
			$displaydata3[$i][1] = "<img src=/img/flags/de.gif  height=12 width=18>";
		}
		else {
			my $flag = &getFlagToLiga("$liga_namen[$data[1]]");
			$displaydata3[$i][1] = "<img src=/img/flags/" . lc($flag) . ".gif height=12 width=18>";
		}

		my $t = $data[0];
		$t =~ s/ /%20/g;
		$displaydata3[$i][2] =
		  "<a href=/cgi-mod/$system/trainer.pl?ident=$t style=\"text-decoration: none\">$data[0]</a> &nbsp; ";
		$displaydata3[$i][3] = "&nbsp;" . $data[2] . " Tore";
		if ( $data[0] ne "" ) { $i++; }
	}
}
close(A);

my $LABEL_AKT2 = &getTableHtml( "Die besten BTM Trainer", \@displaydata2 );

my $LABEL_AKT3 = &getTableHtml( "Die besten TMI Trainer", \@displaydata3 );

my @linksoben = (
	"Regelbuch",          "https://github.com/tipmaster/tipmaster/wiki/Regelbuch",
	"FAQ",                "https://github.com/tipmaster/tipmaster/wiki/FAQs",
	"Passwort vergessen", "/url.shtml",
	"Anmelden",           "/cgi-bin/btm/anmeldung.pl",
	"Kontakt",            "mailto:info\@tipmaster.de"
);

my @linksunten = (
	"Fußball Heute Ergebnisse",        "https://www.fussball-liveticker.eu/fussball-ergebnisse-heute",
	"TipMaster Forum",      "http://community.tipmaster.de",
	"Werben auf Tipmaster", "/marketing/index.shtml",
	"Impressum",            "/Impressum.shtml"
);

my $LABLE_LINKSOBEN;

for ( my $i = 0 ; $i <= $#linksoben ; $i += 2 ) {
	$LABLE_LINKSOBEN .= "<td bgcolor=white width=1></td>";
	$LABLE_LINKSOBEN .=
"<td class=boxlink> &nbsp; <a href=$linksoben[$i+1] style=\"text-decoration: none\">$linksoben[$i]</a> &nbsp; </td>";
}
$LABLE_LINKSOBEN .= "<td bgcolor=white width=1></td>";

my $LABLE_LINKSUNTEN;

for ( my $i = 0 ; $i <= $#linksunten ; $i += 2 ) {
	$LABLE_LINKSUNTEN .=
"<td class=boxlink> &nbsp; <a href=$linksunten[$i+1] style=\"text-decoration: none\">$linksunten[$i]</a> &nbsp; </td>";
	$LABLE_LINKSUNTEN .= "<td bgcolor=white width=1></td>";

}

#saison titel
open( A, "/tmdata/btm/main_nr.txt" );
my $saison_nr = <A>;
chomp $saison_nr;
close(A);
my $saison_title = $main_saison[$saison_nr];

#$saison_title =~s/Saison 20//g;

open( A, "/tmdata/rrunde.txt" );
my $rrunde = <A>;
chomp $rrunde;
close(A);

#tipabgabe
my $status;
open( A, "/tmdata/btm/tip_status.txt" );
my $tip = <A>;
chomp $tip;
close(A);
if   ( $tip == 1 ) { $status = "geoeffnet" }
else               { $status = "geschlossen" }

#wochende
open( A, "/tmdata/btm/tip_datum.txt" );
my $we = <A>;
chomp $we;
close(A);
my $en = $we + 3;
if ( $en > 34 ) { $en = 34 }
open( A, "/tmdata/btm/datum.txt" );
my $we1 = <A>;
my $we2 = <A>;
chomp $we2;
close(A);

my @schedule = ( 0, 24, 59, 84, 111, 137 );

#saisonuebergang
if ( $we2 == 34 ) {
	@events1 = ( "", "Start der Auswertung", "Saisonwechsel",  "Tippabgabeschluss", "Start der Auswertung" );
	@events2 = ( "", "Sonntag 23:45",        "Dienstag abend", "Freitag 18:00",     "Sonntag 23:45" );
}

( my $sec, my $min, my $stunde, my $mday, my $mon, my $jahr, my $wday, my $yday, my $isdst ) = localtime();
my @heute = ( "Sonntag", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag" );
$mon++;
$jahr += 1900;
if ( $mon < 10 )    { $mon    = '0' . $mon }
if ( $mday < 10 )   { $mday   = '0' . $mday }
if ( $min < 10 )    { $min    = '0' . $min }
if ( $stunde < 10 ) { $stunde = '0' . $stunde }

my $LABEL_DATE = "";
my $LABEL_DATE = "$heute[$wday], $mday.$mon.$jahr<br>$stunde:$min Uhr";

#next event

my $exact = ( $wday * 24 ) + $stunde;
my $nr    = 0;
foreach my $t (@schedule) {
	if ( $exact > $t ) { $nr++; }
}
my $nevent = $nr;

#accounts
open( A, "/tmdata/accounts.txt" );
my $acc = <A>;
chomp $acc;
my $acg = <A>;
chomp $acg;
close(A);
open( A, "/tmdata/online_c.txt" );
my $onl = <A>;
chomp $onl;
close(A);

my $LABEL_BOX1 = "Spieltag $we-$en<br>$saison_title<br>Tippabgabe $status";
my $LABEL_BOX2 = "<br>Trainer online: $onl<br>Trainer bisher: $acg";
my $LABEL_BOX3 = "$events1[$nevent]<br>$events2[$nevent]<br>";
my $LABEL_BOX4 =
"DFB-Pokal: $cup_dfb_name[$rrunde-1]<br>Amateur-Pokal: $cup_btm_name[$rrunde-1]<br>TMI Pokal: $cup_tmi_name[$rrunde-1]";
my $LABEL_BOX5 = "Champ. League: $cup_cl_name[$rrunde-1]<br>UEFA Cup: $cup_uefa_name[$rrunde-1]<br><br>";
my $LABEL_BOX6 = "Jetzt <a href=https://fussballheuteimtv.de>Fussball Heute <br>im TV</a> schauen<br><br>";

#my $LABEL_BOX6 = "<span style=\"color:red\">Derzeit gibt es Login-Probleme. Wir arbeiten dran!</span><br><br>";
#my $LABEL_BOX6 = "Winterpause bis 6.1.12<br><br>";
#my $LABEL_BOX6 = "Tipabgabe EC wg. <br>Winterzeit bis<br><b>21 Uhr</b> verl&auml;ngert<br><br>";

print '
<HTML>

<head>
<TITLE>Das Kostenlose Kult Fu&szlig;ball Tippspiel: Der TipMaster</TITLE>


<link rel="stylesheet" type="text/css" href="/css/tm.css" media="all">


<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta http-equiv="expires" content="-1">


<META name="AUTHOR" content="info@tipmaster.de">
<META name="COPYRIGHT" content="TipMaster online 1998-2021">
<META NAME="description" CONTENT="&Uuml;bernehmen Sie Ihren eigenen Fu&szlig;ball Verein in diesem Tippspiel und f&uuml;hren Sie Ihn durch Ihren Tipp Verstand zur Meisterschaft">
<META NAME="page-topic" content="Tippspiel">
<META NAME="Title" CONTENT="TipMaster - das etwas andere Fu&szlig;ball Tippspiel">
<META NAME="description" CONTENT="Das etwas andere Fu&szlig;ball Tippspiel">
<META NAME="keywords" CONTENT="Fussball, Fu&szlig;ball, Tippspiel, Bundesliga, Tipspiel, Wetten, kostenlos, Fussalltippspiel, Weltmeisterschaft, WM">
<META HTTP-EQUIV="Content-language" CONTENT="de">
<meta http-equiv="content-type" content="text/html;charset=iso-8859-1">

<META NAME="Language" CONTENT="de">
<META NAME="Publisher" CONTENT="info@tipmaster.de">
<META NAME="DC.Creator" CONTENT="info@tipmaster.de">
<META NAME="Robots" CONTENT="INDEX,FOLLOW">

<style type="text/css" media="all">
.btn {
  background: #ffcc33;
  background-image: -webkit-linear-gradient(top, #ffcc33, #ffcc33);
  background-image: -moz-linear-gradient(top, #ffcc33, #ffcc33);
  background-image: -ms-linear-gradient(top, #ffcc33, #ffcc33);
  background-image: -o-linear-gradient(top, #ffcc33, #ffcc33);
  background-image: linear-gradient(to bottom, #ffcc33, #ffcc33);
  -webkit-border-radius: 3;
  -moz-border-radius: 3;
  border-radius: 3px;
  -webkit-box-shadow: 0px 1px 3px #666666;
  -moz-box-shadow: 0px 1px 3px #666666;
  box-shadow: 0px 1px 3px #666666;
  font-family: Verdana;
  color: #000000;
  font-size: 12px;
  padding: 10px 20px 10px 20px;
  border: solid #000000 1px;
  text-decoration: none;
}

.btn:hover {
  background: #ffffff;
  text-decoration: none;
}
</style>

<!--script type="text/javascript" src="//services.vlitag.com/adv1/?q=b4ec91b2a704e5df94c61d878f983522" defer="" async=""></script><script> var vitag = vitag || {};</script-->
<!--script type="text/javascript">
vitag.outStreamConfig = { disableAdToHead: true,}
</script-->

</head>
';

print '
<body bgcolor=white><table border=0 cellpadding=0 cellspacing=0><tr><td valign=top><tr><td valign=top>
<table cellspacing="0" cellpadding="0" border="0" width="670" >
	<tr><td valign=top>

		<table cellspacing="0" cellpadding="0" border="0" height="83">
		<tr><td valign=top>


			<!--TABLE  LOGO-->
			<table cellspacing="0" cellpadding="0" border="0">
			<tr><td bgcolor=white valign=top><img src=/img/full_design_01.gif></td>
			</tr></table>
			<!--END TABLE  LOGO-->	
			
		</td>



		<td valign=top>

			<!--TABLE LINKS-->
				<table cellspacing="0" cellpadding="0" border="0" width=435 height=83 background=/img/full_design_02.gif><tr>
				<td align=right valign=top>

					<table cellspacing="0" cellpadding="0" border="0">
					<tr>
					<td>

		
						<table cellspacing="0" cellpadding="0" border="0" bgcolor=white><tr>

				' . $LABLE_LINKSOBEN . '
						
						</tr>

						</tr></table> 
					
					</td></tr></table>

				</td></tr>
				<!--END LINKS-->		

				<!--START TABLE LOGIN-->
				<tr>			
				<td valign=top align=left style="padding-top: 0px;">


					<table width=100 border=0><tr><td><tr><td>
						';

if ( $session->isUserAuthenticated() ) {
	print '
								<table cellspacing="0" cellpadding="0" border="0">				
								<tr> 
									

									
									<td style="margin-left: 100px;padding:5px;width:200px;font-size:11px;background-color:white;border:1px solid #fc3;color:black;" nowrap="nowrap">
									
									<b>' . $session->getUser() . '</b><br/>
									&nbsp;<a href="/cgi-mod/btm/login.pl">Hauptmen&uuml;</a>  &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;(<a href="/?logout=1">Logout</a>)
									
									</td></tr>		
							
						
						</table>	';

}
else {
	print '
						<table cellspacing="0" cellpadding="0" border="0">				
							
								<tr> 
									

									<form action=/cgi-mod/btm/login.pl method="post">
									<td style="padding-left: 100px;" nowrap="nowrap">
									<input class=top style="background-image: url(/img/trainer.gif);" type=text name="email" size=32 value="'
	  . $trainer
	  . '"/> &nbsp; </td>
								</tr>

								<tr>
									<td style="padding-left: 100px;" nowrap="nowrap">
									<input class=top style="background-image: url(/img/pass.gif);" type=password name="password" size=22 nowrap="nowrap"> <input class=send type=submit value="Login"/> &nbsp;
								
									</td>
									</form>
								</tr>
						
						</table>	';
}

print '

					</td>
					
					<td nowrap="nowrap" style="padding-left:30px;"><font face=verdana size=1 color=#ffb300> ' . $LABEL_DATE . '
				
					
					
					</tr></table>
		
					
		
					
				</td></tr></table>		
			
			<!--</td></tr></table>-->

		<!--END LOGIN Table-->

		



			</td></tr></table>
	
	
		</tr>


	



		<tr><td>



			<table cellspacing="0" cellpadding="0" border="0" height="180" width="100%">
			<tr><td valign=top colspan=2>

				<table cellspacing="0" cellpadding="0" border="0" height=180 width=360>

				<tr><td class=verysmall align=left valign=top style="padding:0px;margin:0px;"><font color=#ffb300>

				<font color=black>
				<div style="float:left;width:670px;padding:0px;margin:0px;">
				<div style="font-size:11px;float:left;width:362px;padding:15px;">

				
				<b><span style="font-size:16px">TipMaster</span></b> &nbsp; <i>Das spannendste Fussball Tippspiel im Netz seit 1997</i><br/><br/>
				Der TipMaster ist ein <b>kostenloses Fussball Tippspiel</b> bei dem jeder Mittipper die Trainerfunktion seines eigenen Fussballvereins &uuml;bernimmt. <br/><br/>Die Anzahl der Tore eines Vereins pro Spiel wird dabei live durch die w&ouml;chentlichen Tipps des Trainers bestimmt. 
				<a href=https://github.com/tipmaster/tipmaster/wiki/Regelbuch target=_top style="text-decoration:none; color:darkred">Weiteres zum Spielsystem.</a><br/><br/><br/>
				
				<a href="/cgi-bin/btm/anmeldung.pl" class="btn">Jetzt <b>Kostenlos</b> Anmelden und <b>Sofort</b> Mittippen!</a>
				
				</div>
				<div style="float:left;width:100px;">
				<a href="/cgi-bin/btm/anmeldung.pl"><img src="/img/full_design_04.gif" border="0"></a>
				</div>
				
				</div>
				
				
				 </td></tr>

				</table>

					

			</td></tr></table>

		</td></tr>

		<tr bgcolor=black><td></td></tr>	

	
	
		<tr><td>	
	
			<table cellspacing="0" cellpadding="5" border="0" width=100% height=100>

			<tr>
			<td bgcolor=#eeeeee>


				<table border=0 cellpadding=5 cellspacing=0 width=203>
					<tr>
					<td><img class=box src=/img/box1.gif width=70 height=70 border=1></td>
					<td class=small>


						
						
						
						<table class=infoinner width=100><tr><td class=infoinner><b><img src=/img/3.gif> Aktuelles</b></td></tr></table>
									<br>
									<font color=black>
									' . $LABEL_BOX1 . '
						</td>
						</tr>
						</table>



					</td>

					<td bgcolor=#eeeeee>

						<table border=0 cellpadding=5 cellspacing=0 width=203>
						<tr>
						<td><img class=box src=/img/box2.gif width=70 height=70 border=1></td>
						<td class=small>

								
							<table class=infoinner width=100><tr><td class=infoinner><b><img src=/img/3.gif> Aktivitaet</b></td></tr></table>

						<br>
								' . $LABEL_BOX2 . '

						</td>
						</tr>
						</table>
					</td>

					<td bgcolor=#eeeeee>

						<table border=0 cellpadding=5 cellspacing=0 width=203>
						<tr>
						<td><img class=box src=/img/box6.gif width=70 height=70 border=1></td>
						<td class=small>

													<table class=infoinner width=100><tr><td class=infoinner><b><img src=/img/3.gif> Coming up</b></td></tr></table>



								<br>
								' . $LABEL_BOX3 . '<br>
								</td>
								</tr>
								</table>

						</td></tr></table>


					</td>
					</tr>
				
				
			
		
					
		<!--<tr bgcolor=black><td></td></tr>	-->

	
	
		<tr><td>	
	
			<table cellspacing="0" cellpadding="5" border="0" width=100% height=100>

			<tr>
			<td bgcolor=#eeeeee>


				<table border=0 cellpadding=5 cellspacing=0 width=203>
					<tr>
					
					<td class=small>


						
						
						
						<table class=infoinner width=100><tr><td class=infoinner><b><img src=/img/3.gif> Pokal</b></td></tr></table>
									<br>
									<font color=black>
									' . $LABEL_BOX4 . '
						</td>
						<td><img class=box src=/img/box5.gif width=70 height=70 border=1></td>
						</tr>
						</table>



					</td>

					<td bgcolor=#eeeeee>

						<table border=0 cellpadding=5 cellspacing=0 width=203>
						<tr>
						
						<td class=small>

													<table class=infoinner width=100><tr><td class=infoinner><b><img src=/img/3.gif> Europa-Cup</b></td></tr></table>



						<br>
						' . $LABEL_BOX5 . '</td>
						<td><img class=box src=/img/box3.gif width=70 height=70 border=1></td>
						</tr>
						</table>
					</td>

					<td bgcolor=#eeeeee>

						<table border=0 cellpadding=5 cellspacing=0 width=203>
						<tr>
						
						<td class=small>

													<table class=infoinner width=100><tr><td class=infoinner><b><img src=/img/3.gif>Meldungen</b></td></tr></table>

						<br>
								' . $LABEL_BOX6 . '


								</td>
								
								<td><img class=box src=/img/box4.gif width=70 height=70 border=1></td>
								
								</tr>
								</table>
								
								

						</td></tr></table>


					</td>
					</tr>
		
				<tr bgcolor=black><td></td></tr>	

				<tr><td>	
	
					<table cellspacing="0" cellpadding="5" border="0" width=100% height=137>

						<tr>
						<td bgcolor=#dcdcdc valign=top>


							<table border=0 cellpadding=5 cellspacing=0 width=203>
								<tr>
								<td class=small>
									
' . $LABEL_AKT1 . '
									
								</td></tr></table>	

								</td>

								<td bgcolor=#dcdcdc valign=top>

										<table border=0 cellpadding=5 cellspacing=0 width=203>
										<tr>
										
										<td class=small>

										
' . $LABEL_AKT2 . '
									
								</td></tr></table>	

								</td>

								<td bgcolor=#dcdcdc valign=top>

							<table border=0 cellpadding=5 cellspacing=0 width=203>
								<tr>
								<td class=small>
									
				' . $LABEL_AKT3 . '					
								</td></tr></table>	

								</td></tr></table>


				

							</td>
							</tr>
						
							

				</td></tr>
										
						
						
								
				
			
		
				
		
					
					
	<!--
	<tr>	<td>


 
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
			<tr><td valign=top colspan=2>
					
			
					<table cellspacing="0" cellpadding="0" border="0" height=210 width=100%>
					<tr><td width=20></td><td>


						<table cellspacing=0 cellpadding=5 width=250 bgcolor=white><tr><td align=left  style="font-size:17px;">
						<font color=gray> <img src=3.gif> Neu auf der Trainerbank
						</td></tr></table>

						<table class=info cellspacing=0 cellpadding=5 width=250 bgcolor=#f2f2f2>

						<tr><td class=infotext>  

						
						
							<table class=infoinner width=170><tr><td class=infoinner><b><img src=3.gif> Neu auf der Trainerbank</b></td></tr></table>



					
						 </td></tr>


					</table>
					

					




						

 					</td></tr>

					</table>

					

			</td></tr></table>



	</td>
	</tr>




	<tr><td>


</td></tr>


	



	-->
	

	</table>
	
	</td>


	<td bgcolor=white>

<div style="width:160px">


<!-- tipmaster.de_300x600: Begin -->
<!--div class="adsbyvli" data-ad-slot="vi_1335352009"></div> <script>(vitag.Init = window.vitag.Init || []).push(function () { viAPItag.display("vi_1335352009") })</script--><!-- tipmaster.de_300x600 End -->

<ins class=\'dcmads\' style=\'display:inline-block;width:160px;height:600px\'

    data-dcm-placement=\'N1390738.284374FUSSBALL-LIVETICK/B25798206.301718141\'

    data-dcm-rendering-mode=\'script\'

    data-dcm-https-only

    data-dcm-gdpr-applies=\'gdpr=${GDPR}\'

    data-dcm-gdpr-consent=\'gdpr_consent=${GDPR_CONSENT_755}\'

    data-dcm-addtl-consent=\'addtl_consent=${ADDTL_CONSENT}\'

    data-dcm-ltd=\'false\'

    data-dcm-resettable-device-id=\'\'

    data-dcm-app-id=\'\'>

  <script src=\'https://www.googletagservices.com/dcm/dcmads.js\'></script>

</ins>



</div>

</td>
<td bgcolor=black width=1>
</td>
<td style="vertical-align:top">
<ul>
<b>Deutsch</b>
<li><a href="https://www.fussball-liveticker.eu">fussball-liveticker.eu</a></li>
<li><a href="https://fussballlivestreams.de">fussballlivestreams.de</a></li>
<li><a href="https://fussballheuteimtv.de">fussballheuteimtv.de</a></li>

</ul><ul>
<b>English</b>
<li><a href="https://soccergames-today.com">soccergames-today.com</a></li>
<li><a href="https://reddit.soccerstreaming100.com">soccerstreaming100.com</a></li>
<li><a href="https://soccer-tv.live">soccer-tv.live</a></li>


</ul><ul>
<b>Dutch</b>
<li><a href="https://voetbal-vandaag.com">voetbal-vandaag.com</a></li>
<li><a href="https://www.voetballivestream.tv/pro-league">voetballivestream.tv</a></li>
<li><a href="https://voetbal-op-tv.nl">voetbal-op-tv.nl</a></li>

</ul><ul>
<b>Espa&ntilde;ol</b>
<li><a href="https://partidosfutbolhoy.es">partidosfutbolhoy.es</a></li>
<li><a href="https://rojadirecta-tv.es/futbol-en-la-tele">rojadirecta-tv.es</a></li>
<li><a href="https://futbolenlatele.tv">futbolenlatele.tv</a></li>

</ul>

</ul><ul>
<b>Français</b>
<li><a href="https://foot.streamonsport.fr">foot.streamonsport.fr</a></li>
<li><a href="https://footstreaming24.fr"footstreaming24.fr</a></li>
<li><a href="https://programmetvfoot24.fr">programmetvfoot24.fr</a></li>

</ul>


</td>
</tr>
	<tr><td bgcolor=black colspan=3></td></tr>
	
	<tr>
	<td valign=bottom colspan=2 align=left bgcolor=#333333 >
		
			<table border=0 cellspacing=0 cellpadding=0><tr><td>
						<table cellspacing="0" cellpadding="0" border="0" bgcolor=white><tr>


						' . $LABLE_LINKSUNTEN . '
						
						
						</tr></table> 
						
						</td><td class=impressum align=center>
						&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  Copyright 1998-2021 - <a style="color:white" href="http://www.socapro.com" rel="nofollow">SocaPro Inc.</a> </b>
			
			
						
						
					
			</td></tr></table>
	<td bgcolor=black width=1></td>
		
	
	
	</tr>
	
	</tr>

<tr><td bgcolor=black colspan=3></td></tr>



</tr></td>




<td>

<div style="width:200px;padding:10px;">




</div>


</td>


</table>


<p style="font-face:tahoma,verdana;font-size:10px;color:darkgrey;padding-top:-10px;text-align:center;width:800px;">

<a href="https://socagol.tv/de/bundesliga-live-stream">SocaGol</a> | <a style="color:darkgrey" href="https://fussballlivestreams.de">fussballlivestreams.de</a> | <a href="https://bundesligalivestreamkostenlos.com">Bundesliga Live Streams</a> | <a style="color:darkgrey" href="https://www.voetballivestream.tv/champions-league">Champions League</a> | <a style="color:darkgrey" href="https://rojadirecta-tv.es">Rojadirecta-tv.es</a> | <a style="color:darkgrey" href="https://www.fussball-liveticker.eu/fussball-ergebnisse-gestern">Fussball Ergebnisse Gestern</a> | <a style="color:darkgrey" href="https://www.footballcapper.org/">football betting prediction</a></p>


' . $page_footer . '

';
exit;

sub getTableHtml {
	my $text;
	my $name  = shift;
	my $array = shift;

	my @array = @{$array};
	$text = "
<table class=infoinner width=190><tr><td class=infoinner><b>";

	$text .= "<img src=/img/3.gif>";

	$text .= " $name</b></td></tr></table><br><table border=0 cellpadding=0 cellspacing=0>";

	for ( my $i = 0 ; $i <= $#array ; $i++ ) {
		$text .= "<tr><td width=3/>";
		my @tmp = @{ $array[$i] };

		for ( my $j = 0 ; $j <= $#tmp ; $j++ ) {

			next if ( $name eq "Neuste Anmeldungen" && $j == 2 );
			$text .=
" <td nowrap=nowrap height=12><span style=\"line-height:16px;\"><font size=1 face=tahoma> $array[$i][$j] &nbsp;</span> </td>";

		}
		$text .= "</tr>";
	}
	$text .= "</tr></table></body></html>";
	return $text;
}

sub getFlagToLiga() {
	my $liga = shift;

	( my $rr, my $joke ) = split( / /, $liga );
	if ( $rr eq "San" )  { $rr = "San Marino" }
	if ( $rr eq "Nord" ) { $rr = "Nord Irland" }

	my $flag = $flag_hash{$rr};
	if ( $flag eq "" ) { $flag = "de" }
	return $flag;

}
