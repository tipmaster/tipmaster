#!/usr/bin/perl

=head1 NAME
	TMI anmeldung.pl

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
my $session = TMSession::getSession();
my $trainer = $session->getUser();
my $leut = $trainer;

use CGI;

use CGI;
$query = new CGI;
$vorname = $query->param('vorname');
$nachname = $query->param('nachname');
$verein = $query->param('frei');
$mail = $query->param('adresse');
$link = $query->param('link');
$pass = $query->param('newpass');
$send = $query->param('send');
$method = $query->param('m');
$tt = $query->param('t');
$nr = $query->param('nr');
$landid = $query->param('landid');

require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl" ;

if ( $method eq "f" ) { &freischalten }

&get_date;
&check_url;
&return_html;
&send_mail;
exit ;


sub return_html {

if ( $send != 1 ) { &formular }
$fehler=0;

###### verbotene Emails ####################################
$ban=0;
open (D1,"/home/tipmaster/banmail.txt");
while(<D1>){$rr=$_;chomp $rr;
if ( $mail =~ /$rr/ ) { $ban=1;$ban_id=$rr ;}}
close(D1);
if ( $ban == 1 ){
$fehler++;
$fault[$fehler] = "Betrifft E-Mail Adresse :<br>
Registrierungen mit E-Mail Adresse der<br>
Domain $ban_id k&ouml;nnen wir nicht akzeptieren";
}
###########################################################

$frei = $verein ;$freio = '&' . $verein . '&' ;
$adresse = $mail ;srand();  
$aa = " ";$ac = "&";
$voller_name = $vorname . $aa . $nachname ;
$suche = $ac . $voller_name . $ac ;

#if ($voller_name =~ /Schreindorfer/){exit;}
if ($voller_name eq "Frank Bauer") {exit;}

################# CHECK BTM UND TMI #########################
$vorhanden = 0;$r = 0;$mail_vorhanden = 0;

#bet5.net
        open(A,"/home/bet/shadow.txt");
        while(<A>)
        {if ($_=~/^\!&$voller_name&/) {$vorhanden_btm1}}
        close(A);



open(D2,"/tmdata/btm/history.txt");
while(<D2>) {$r++;
$zeilen[$r] = $_;
chomp $zeilen[$r];
if ($_ =~ /$suche/i) {
$vorhanden_btm = 1;
}}close(D2);

open(D2,"/tmdata/tmi/history.txt");
while(<D2>) {$r++;
$zeilen[$r] = $_;
chomp $zeilen[$r];
if ($_ =~ /$suche/i) {
$vorhanden_tmi = 1;
}}close(D2);

$ae = "!" ;
$suche = $ae . $suche ;
#@todo pass
$r = 0;open(D2,"/tmdata/hashedPasswords.txt");
while(<D2>) {
$r++;
$zeileno[$r] = $_;
chomp $zeileno[$r];
if ($_ =~ /$suche/) {
$vorhanden_para = 1;
@aal=split(/&/,$_);
$pass_richtig = $aal[2];
$mail_richtig = $aal[3];
}

if ($_ =~ /&$mail&/) {
@aal=split(/&/,$_);
$tmp1 = $aal[1];
$tmp2 = $aal[3];
if ( $tmp1 ne $voller_name){
$mail_vorhanden = 1;
}

}


}
close(D2);


###################################################################


$ein = 1;
if ($voller_name =~ /^[A-Z]([a-z]|-[A-Z])* [A-Z]([a-z]|-[A-Z])*$/) { $ein = 0; }
$mail_ok = 0;

if ( $adresse !~ /^.+\@(\[?)[a-zA-Z0-9\-\.]+\.([a-zA-Z]{2,3}|[0-9]{1,3})(\]?)$/) { $mail_ok = 1 }
if ( $adresse =~ / /) { $mail_ok = 1 }


$rr = length($voller_name);
if ( $rr > 22 ) { $ein = 1 }
if ( $rr < 6 ) {$ein = 1 }
$rr = length($vorname);
if ( $rr < 3 ) {$ein = 1 }
$rr = length($nachname);
if ( $rr < 3 ) {$ein = 1 }
$rr = length($pass);
if ( $rr < 4 || $rr > 16 || $pass =~ / / || $pass =~ /\&/ || $pass=~ /\!/ || $pass =~ /\#/ ) { $pass_ok=1 }

#no longer working with varnish in front, tp, 11/28/13 - shoudl pick up on forward ip
if (0) {
open(D,"</tmdata/check_ip_tmi.txt");
$ips=<D>;@ip=split(/&/,$ips);
close(D);$check_ip=0;
foreach $ii(@ip) { if ( $ENV{'REMOTE_ADDR'} eq $ii){ $check_ip = 1}}
if ( $ENV{'REMOTE_ADDR'} =~ /212\.38\.25\./ ) { $check_ip = 1 }
}

if ( $check_ip == 1 ) { 
$fehler++;
$fault[$fehler] = "<font color=darkred>Betrifft eigene IP :<font color=black><br>
Unter der IP ihres Internetzugangs wurde<br>
erst vor kurzem eine Anmeldung beim TMI <br>
vorgenommen. Mehrere Anmeldungen mit der<br>
gleichen IP hintereinander sind nicht<br>
m&ouml;glich. Versuchen Sie es bitte morgen erneut.<br>
Bitte beachten Sie: jeder Mitspieler <br>
darf nur je einen Verein beim BTM und TMI betreuen.";
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
Bitte geben Sie ihre g&uuml;ltige E-Mail Adresse<br>
an, da sonst auch keine Account Freischaltung m&ouml;glich ist.";
}	

if ( $vorhanden_tmi == 1 ) { 
$fehler++;
$fault[$fehler] = "<font color=darkred>Betrifft Trainername :<font color=black><br>
Unter dem angegebenen Trainernamen ist<br>
bereits ein Trainer beim TipMaster international eingetragen. <br>
Bitte modifizieren Sie Ihren Trainernamen leicht<br>
indem Sie bspw. als Vornamen Ihren Spitz/Rufnamen<br>
eintragen. Vielen Dank f&uuml;r Ihr Verst&auml;ndnis.";
}	

if ( $mail_vorhanden == 1 ) { 
$fehler++;
$fault[$fehler] = "<font color=darkred>Betrifft Mail-Adresse :<font color=black><br>
Unter der angegebenen Mail-Adresse ist bereits<br>
ein Account beim TipMaster m&ouml;glich. Weitere <br>
Accounts unter dieser E-Mail Adresse sind nicht<br>
m&ouml;glich. Bitte beachten Sie: jeder Mitspieler <br>
darf nur je einen Verein beim BTM und TMI betreuen.";
}	


if ( $pass_ok == 1 ) { 
$fehler++;
$fault[$fehler] = "<font color=darkred>Betrifft Passwort :<font color=black><br>
Ihr gew&uuml;nschtes Passwort hat kein g&uuml;ltiges<br>
Format. Entweder es ist zu kurz bzw. zu lang<br>
oder es enth&auml;lt nicht erlaubte Sonder- bzw.<br>
Leerzeichen.";
}	

if ( $vorhanden_para == 1 && (($pass_richtig ne TMAuthenticationController::hashPassword( $pass, $voller_name ) ) || ($mail_richtig ne $mail))) { 
$fehler++;
$fault[$fehler] = "<font color=darkred>Betrifft Trainername + Passwort + E-Mail:<font color=black><br>
Unter diesem Trainername ist bereits ein<br>
Account beim TipMaster registriert.<br>
Um f&uuml;r diesen Account (Neu)Anmeldungen<br>
zu t&auml;tigen, m&uuml;ssen Sie sich mit dem identischen<br>
Passwort und identischer E-Mail mit der<br>
dieser Account beim ersten Mal registriert wurde<br>
anmelden. Dies ist aktuell noch nicht der Fall.<br>
Der Account wurde mit der E-Mail Adresse <br>
$mail_richtig er&ouml;ffnet.

";

}	




if ( $method ne "W" ) {

$r=0;
open(D2,"/tmdata/tmi/history.txt");
while(<D2>) {
$r++;$zeilen[$r] = $_;
chomp $zeilen[$r];
if ($_ =~ /$freio/i) {
@vereind = split (/&/, $_);	
$linie = $r ;}}
close(D2);
$lor[0] = $vereind[0] ;
$y = 0;
for ( $x = 1; $x < 19; $x++ )
{$y++;chomp $vereind[$y];
$data[$x] = $vereind[$y];
$y++;chomp $vereind[$y];
$datb[$x] = $vereind[$y];
$y++;}
for ( $x = 1; $x < 19; $x++ )
{if ( $data[$x] eq $verein ) {
if ( $datb[$x] ne "Trainerposten frei" ) { 
$fehler++;
$fault[$fehler] = "<font color=darkred>Betrifft Vereinswahl :<font color=black><br>
Der gew&uuml;schte Verein ist mittlerweile<br>
bereits wieder vergeben. Bitte einen<br>
anderen Verein w&auml;hlen.";
}
$datb[$x] = $voller_name ;
$datc[$x] = $adresse ;
}}
}

if ( $fehler == 0 && $send == 1 ) { &anmelden }

if ( $fehler > 0 || $send != 1 ) {
&formular;
}
}


#-------------------------------------------------------------------------------------------#


sub anmelden {


$c=time();
if ( $method eq "W" ) {

open(D3,"</tmdata/tmi/warte.txt");
while(<D3>){
@all=split(/&/,$_);
if ( $all[1] eq $voller_name ) { $nop=1}
if ( $all[3] eq $adresse ) { $nop = 1 }
}
close(D3);
$ok=2;
if ( $nop != 1 ) {
open(D2,">>/tmdata/tmdata/tmi/warte.txt");
flock (D2, 2);
print D2 "!&$voller_name&$pass&$adresse&$date&$time&$c&---&$c&\n";
flock (D2, 8);
close (D2) ;

   $mail{Message} .= "TipMaster international\nhttp://www.tipmaster.de/tmi/\n\n\n ";
   $mail{Message} .= "             *** Registrierung Warteliste ***\n\n";
   $mail{Message} .= "Sehr geehrte(r) $voller_name ,\n\n";
   $mail{Message} .= "vielen Dank fuer Ihre Registrierung auf der TMI - Warteliste. Sobald neue Vereine frei werden\n";
   $mail{Message} .= "und Ihre Wartelistenposition ausreichend hoch ist, wird Ihnen automatisch ein Verein zugeteilt\n";
   $mail{Message} .= "und Sie via E-Mail informiert.\n\n";
   $mail{Message} .= "Bitte beachten Sie dass Sie sich alle 72 Stunden auf der Seite der Warteliste mit Ihren\n";
   $mail{Message} .= "Zugangsdaten einloggen muessen um nicht von der Warteliste wieder geloescht zu werden.\n\n";


   $mail{Message} .= "Ihre LogIn Daten fuer die TMI Warteliste :\n\n";
   $mail{Message} .= "Trainername  : $voller_name\n";
  # $mail{Message} .= "Passwort     : $pass\n\n
  #URL Warteliste : http://www.tipmaster.de/cgi-bin/tmi/warte.pl\n\n";

   $mail{Message} .= "Bei Fragen zum Spielsystem lesen Sie bitte das Regelbuch sowie die FAQ zum TipMaster .\nWir wuenschen Ihnen viel Spass und Erfolg beim TipMaster .\n\n";
   $mail{Message} .= "Mit freundlichen Gruessen\nIhr TipMaster - Team\n";

    $mailprog = '/usr/sbin/sendmail';
    open(MAIL,"|$mailprog -t");
    print MAIL "To: $adresse\n";
    print MAIL "From: service\@tipmaster.net ( TipMaster online )\n";
    print MAIL "Subject: TipMaster international Registrierung Warteliste\n\n" ;
    print MAIL "$mail{Message}";
    close (MAIL);

$ok=1;
}










print "Location: /cgi-bin/tmi/warte.pl?ok=$ok\n\n";
exit;

exit;
}













my $hashedPassword = TMAuthenticationController::hashPassword($pass, $voller_name);


$aa = "&";
$zeilen[$linie] = $lor[0] . $aa ;
for ( $x = 1; $x < 19; $x++ )
{
$zeilen[$linie] = $zeilen[$linie] . $data[$x] . $aa . $datb[$x] . $aa . $aa ;
}

if ( $vorhanden_para != 1 ) {
open(D2,">>/tmdata/hashedPasswords.txt");
flock (D2, 2);
print D2 "!&$voller_name&$hashedPassword&$adresse&\n";
flock (D2, 8);
close (D2) ;

open(D2,">>/tmdata/shadow.txt");
flock (D2, 2);
print D2 "!&$voller_name&$hashedPassword&$voller_name&$adresse&$landid&1&\n";
flock (D2, 8);
close (D2) ;

}

open(A2,">/tmdata/tmi/history.txt");
flock (A2, 2);
for ( $x = 1; $x <=$rr_ligen; $x++ )
{
print A2 "$zeilen[$x]\n";

}
flock (A2, 8);
close(A2);

open(A2,">>/tmdata/tmi/link.txt");
print A2 "&$voller_name&$link&\n";
close (A2) ;     
open(A2,">>/tmdata/tmi/anmeldung.txt");
flock (A2 , 2);
print A2 "&$date&$time&$ENV{'REMOTE_ADDR'}&$voller_name&$adresse&$linko&\n";
flock (A2 , 8);
close (A2) ; 

### LAENDERCOE CODE#####
($sek, $min, $std, $tag, $mon, $jahr) =  localtime(time+0);
$mon++ ;
if ( $sek <10 ) { $xa = "0" }
if ( $min <10 ) { $xb = "0" }
if ( $std <10 ) { $xc = "0" }
if ( $tag <10 ) { $xd = "0" }
if ( $mon <10 ) { $xe = "0" }
if ( $liga <10 ) { $xf = "0" }
if ( $spielrunde <10 ) { $xg = "0" }
$jahr = $jahr + 1900 ;
open(A2,">>/tmdata/frontdata/anmeldung.txt");
flock (A2 , 2);
print A2 "&$xd$tag.$xe$mon&$xc$std:$xb$min&$ENV{'REMOTE_ADDR'}&$voller_name&$landid&$link&$linko&\n";
flock (A2 , 8);

#PROFIL anlegen
$aa="&";
$zeilen = "!&". $voller_name .  $aa . $aa . $landid . $aa .  $aa .  $aa .  $aa .  $aa .  $aa .  $aa ;
$datei = "/tmdata/btm/db/profile/" . $voller_name . ".txt" ;
open(D8,">$datei");
print D8 $zeilen;
close(D8);
#######




open(D,"</tmdata/check_ip_tmi.txt");
$ips=<D>;@ip=split(/&/,$ips);
close(D);
open(D,">/tmdata/check_ip_tmi.txt");
print D "$ENV{'REMOTE_ADDR'}&$ip[0]&$ip[1]&$ip[2]&$ip[3]&";
close(D);


print "Content-type: text/html \n\n";
print "<title>TipMaster - Anmeldung erfolgreich</title>";
print "<body bgcolor=#eeeeee><font color=#eeeeee face=verdana size=1>.......................<img src=/img/trail.gif>\n";

print "<br><table border=0><tr><td valign=top><img src=/img/url.gif border=0></td>\n";
print "<td colspan=10></td><td valign=top>\n";
print "\n";
print "<br><font face=verdana size=2 color=darkred><b>Ihre Anmeldung war erfolgreich !<font color=black></b><br><br><font face=verdana size=1>Vielen Dank fuer Ihre<br>Anmeldung , $voller_name .<br><br>\n";
print "Sie sind ab sofort als neuer Trainer bei<br>$verein eigetragen .<br><br>\n";
print "Der Link zum Freischalten Ihres Accounts<br>sowie weitere Instruktionen werden in diesem<br>Moment an $adresse<br>gemailt .<br><br><br>
<font face=verdana size=2><b>Trainer - LogIn</b><form action=/cgi-mod/tmi/login.pl method=post>
<br><br><font color=black><br>
<font face=verdana size=1>Trainername :<br><input type=text lenght=25 name=trainer value=\"$voller_name\"><br><br>Passwort :<br><input type=password lenght=25 name=newpass><br><font size=1><br><input type=hidden name=first value=1><input type=image src=/img/log_in.jpg border=0></form><br>";
print "</td><td><br><font color=#eeeeee face=verdana size=1>.................";
print "<img src=/img/header.gif valign=top></td></tr></table>";

print '
<!-- Google Tag Manager -->
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-KX6R92"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':
new Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=
\'//www.googletagmanager.com/gtm.js?id=\'+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,\'script\',\'dataLayer\',\'GTM-KX6R92\');</script>
<!-- End Google Tag Manager -->
';
}



















exit ;

sub check_url {
# CHECK AUF ANFRAGEQUELLE #################################
$referer = "tipmaster.de" ;
if ($ENV{'HTTP_REFERER'} =~ m|https?://([^/]*)$referer|i) {$check= 1;}$check=1;
if ( $check != 1 ) { 
print "Content-type: text/html \n\n";
print "<font face=verdana size=2><b>";
print "<br>Der Request wurde nicht &uml;ber den tipmaster Server aufgerufen .<br>";
exit ;}
###########################################################
}


sub send_mail {

$tmp = $voller_name;
$tmp =~s/ /%20/g;
srand();  
for ( $x=1 ; $x <=9 ; $x ++ ) {
$nn = int(rand(9)) + 1 ;
$nr = $nr . $nn;
}

open(AA,">/tmi/free/$trainer");
print AA $nr;
close(AA);

   $mail{Message} .= "TipMaster international\nhttp://www.tipmaster.de/tmi/\n\n\n ";
   $mail{Message} .= "             *** Einstellungsschreiben ***\n\n";
   $mail{Message} .= "Sehr geehrte(r) $voller_name ,\n\n";
   $mail{Message} .= "herzlichen Glueckwunsch . Sie sind ab sofort neue(r) Trainer(in)\n";
   $mail{Message} .= "bei $frei in der $liga_namen[$linie] .\n\n";
   $mail{Message} .= "Ihre Zugansdaten fuer den TipMaster LogIn :\n\n";
   $mail{Message} .= "Trainername  : $voller_name\n";
   $mail{Message} .= "Passwort     : (Wie angegeben bei Ihrer Anmeldung)\n\n

Bitte aktivieren Sie zum Freischalten Ihres Accounts folgenden Link :\n
http://www.tipmaster.de/cgi-bin/tmi/anmeldung.pl?m=f&t=$tmp&nr=$nr\n\n";

   $mail{Message} .= "Bei Fragen zum Spielsystem lesen Sie bitte das Regelbuch sowie die FAQ zum TipMaster .\nWir wuenschen Ihnen viel Spass und Erfolg beim TipMaster .\n\n";
   $mail{Message} .= "Mit freundlichen Gruessen\nIhr TipMaster - Team\n";

    $mailprog = '/usr/sbin/sendmail';
    open(MAIL,"|$mailprog -t");
    print MAIL "To: $adresse\n";
    print MAIL "From: service\@tipmaster.net ( TipMaster online )\n";
    print MAIL "Subject: TipMaster international Anmeldung\n\n" ;
    print MAIL "$mail{Message}";
    close (MAIL);
}







sub formular {
$frei = 0;
$liga = 0;


open(D2,"/tmdata/tmi/history.txt");
while(<D2>) {
$liga++;
@vereine = split (/&/, $_);	
print "<!-- Liga is $liga, LigaIndex is ",$liga_kat[$liga]," ListOnBoerse is ",&listOnBoerse($liga)," //-->\n";
if ( !&listOnBoerse($liga) || $liga_kat[$liga] >= 6 ) {
$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
$y++;
chomp $verein[$y];
$data[$x] = $vereine[$y];
$y++;
chomp $verein[$y];
$datb[$x] = $vereine[$y];
if ( $datb[$x] eq "Trainerposten frei"  && $liga!=187 && $liga !=188) { 
$frei++;
$auswahl_verein[$frei] = $data[$x] ;
$auswahl_liga[$frei] = $liga ;
}
$y++;
chomp $verein[$y];
$datc[$x] = $vereine[$y];
}}}

open(D2,"/tmdata/tmi/heer.txt");
while(<D2>) {
@lok = split (/&/ , $_ ) ;
$rang{$lok[5]} = $lok[0] ;
}
close (D2) ;


            print <<"(END ERROR HTML)";

<html>
 <head>
  <title>TMI - Anmeldung</title>
 </head>

<body bgcolor=#eeeeee>
<font color=#eeeeee face=verdana size=1>.......................
(END ERROR HTML)
require "/tmapp/tmsrc/cgi-bin/tag.pl" ;
require "/tmapp/tmsrc/cgi-bin/tag_small.pl" ;

            print <<"(END ERROR HTML)";
<br>
<table border=0><tr><td valign=top><img src=/img/url.gif border=0></td>
<td colspan=10></td><td valign=top>


<font face=verdana size=1>
<br>
<font face=verdana size=2><b>TipMaster international Anmeldung</b><br><br>
<font face=verdana size=1>
(END ERROR HTML)

if ( $send != 1 ) { print "
Vielen Dank fuer Ihr Interesse am TipMaster international .<br>
" }


if ( $frei != 0) { print "
Bitte fuellen Sie fuer Ihre Anmeldung folgendes kurze <br>
Anmeldeformular aus.<br><br>
Wir wuenschen Ihnen viel Spass und Erfolg beim TipMaster !<br><br>
" } else { print "
<font color=darkred><br>
Leider sind im Moment alle Vereine vergeben und Sie muessen<br>
sich in die Warteliste eintragen. Sobald neue Vereine frei<br>
werden und Ihre Wartelistenposition ausreichend ist, wird<br>
Ihnen ein freier Verein zugeordnet und Sie werden<br>
per E-Mail informiert ! [ -> <a href=/cgi-bin/tmi/warte.pl>TMI Warteliste - Refresh Account</a> ]

<br><br>
<font color=black>
Info: Jeder Mitspsieler darf <u>je einen</u> Verein beim<br>
Bundesliga-TipMaster und TipMaster international <br>
fuehren. [ -> <a href=/cgi-bin/btm/anmeldung.pl>Anmeldung Bundelsiga - TipMaster </a> ]
<font color=black><br><br>

";  }


if ( $fehler > 0 ) { print "
<font color=red size=2><b>Bei Ihrer Anmeldung ist / sind<br>
leider $fehler Fehler aufgetreten :</b><br><br><font color=black size=1>";
for ($f=1;$f<=$fehler;$f++){
print "$fault[$f]<br><br>\n";
}
print "" }


print "
<form action=/cgi-bin/tmi/anmeldung.pl method=post>
<font face=verdana size=1>Ihr Vorname :<br><input type=text lenght=25 name=vorname value=\"$vorname\"><br>
<br><font face=verdana size=1>Ihr Nachname :<br><input type=text lenght=25 name=nachname value=\"$nachname\"><br>
<font color=red><br>
Bitte geben Sie Ihren korrekten Namen an .<br> 
Bei erkennbaren Phantasie- / Prominentennamen<br>
wird Ihre Anmeldung spaeter wieder storniert .<br>
<font color=black>
<br><font face=verdana size=1>Ihre E-Mail Adresse:<br><input type=text lenght=25 name=adresse value=\"$mail\"><br><br>
<font color=red>
Die korrekte Angabe Ihrer E-Mail Adresse ist<br> 
Vorraussetzung f&uuml;r die Teilnahme am TipMaster.<br>
Nach Ihrer Anmeldung erhalten Sie eine Mail<br>
an die angegebene E-Mailadresse die einen Link<br>
zur Freischaltung Ihres Accounts enth&auml;lt.<br>
<br><br>
<font color=black>
";

#if ( $frei == 0 ) {
#print "Im Moment sind leider alle Vereine<br>beim TipMaster international besetzt.<br><br>Besuchen Sie diese Seite vor allem<br>* Dienstags kurz nach 12.oo Uhr<br>* Donnerstags kurz nach 16.oo Uhr und<br>* Freitags kurz nach 18.oo Uhr<br>um beste Chancen f&uuml;r die Anmeldung<br>f&uuml;r einen freien TMI Verein zu haben !<br>";
#print "<br>Falls Sie national nocht nicht als TipMaster - Trainer taetig sind,<br>besuchen Sie die <a href=/cgi-bin/btm/anmeldung.pl>BTM - Anmeldungsseite</a> um dies zu aendern ...<br>";
#print "</td><td><br><br><br><font color=#eeeeee face=verdana size=1>..................\n";
#print "<img src=/img/header.gif valign=top></form></td></tr></table>\n";
#exit ;}

print "

Ihr gewuenschtes Passwort :<br>
<input type=password lenght=25 name=newpass><br><br>

<br><br>
<font color=red>
Beachten Sie bitte das Ihr gewaehltes Passwort<br> 
nicht kuerzer als 4 und laenger als 16 Zeichen<br>
lang sein sowie keine Sonderzeichen und<br>
Leerzeichen enthalten darf.<br>
<br><br><font color=black>
<font color=black>
";



if ( $frei==0){
print "

<input type=hidden name=m value=\"W\">
<input type=hidden name=send value=1><br>

<br><input type=submit value=\"In die Warteliste eintragen\"></form>
<font color=darkred size=2 face=verdana><b>ACHTUNG: Sollten Sie schon in der TMI Warteliste<br>
registriert sein bitte exakt identisches Passwort,<br>
E-Mail Adresse und Trainernamen bei dieser<br> Anmeldung verwenden !

</td><td><br>
<br><br><font color=#eeeeee face=verdana size=1>..................
<img src=/img/header.gif valign=top></form></td></tr></table>
</body>
</html>";
exit;
}




print "
Ihr gewuenschter Verein :<br>
<select style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=frei>
";



for ( $x = 1; $x <= $frei; $x++ )
{
$sel="";
if ($auswahl_verein[$x] eq $verein ) { $sel = " selected" }
print "<option value=\"$auswahl_verein[$x]\"$sel> $auswahl_verein[$x] ( $liga_namen[$auswahl_liga[$x]] / Kat $liga_kat[$auswahl_liga[$x]] / $rang{$auswahl_verein[$x]}. Platz )\n";

}

            print <<"(END ERROR HTML)";
</select><br><br>
<font color=red>
Bitte beachten Sie: jeder Mitspieler darf nur jeweils <br>
<b>einen</b> Verein beim Bundesliga Tipmaster und beim <br>
Tipmaster International trainieren. Mehrfachaccounts<br>
werden komplett und ohne Vorwarnung von der<br>
Spielleitung gel&ouml;scht !
</font>
<br><br>
<font color=black>
(END ERROR HTML)

# CODE ###
print "
Ihr Herkunftsland: (Liste auf Englisch)<br>
<select name=landid style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\"
";
open(D,"</tmdata/countrylist.txt");
while(<D>){ 
$tmp="";if ($_=~/Germany/){$_=~s/\>/ selected\>/;}
print "$_\n";
}close(D);
print "</select><br><br>";
#######################


if ( $send != 1 ) {
print "
<font color=black>
Wie haben Sie vom TipMaster erfahren :<br>

<select style=\"font-family: Verdana; font-size: 11px; font-weight: normal; color: #000000;\" name=link>
<option value=\"Keine Angabe\">Keine Angabe
<option value=\"Mundpropaganda\">durch einen Mitspieler bzw. Mundpropaganda
<option value=\"Live-Resultate\">ueber Live-Resultate.net
<option value=\"ueber eine Suchmaschine\">ueber eine Suchmaschine
<option value=\"BTM\">Bundesliga - TipMaster
<option value=\"Presse\">Printmedien
<option value=\"Fansite\">durch eine private TipMaster Fanseite
</select>";
} else {
print "<input type=hidden name=link value=\"$link\">";
}

print "
<input type=hidden name=send value=1><br>
<br><input type=submit value=\"Anmeldung senden\"></form><br>

</td><td><br>
<br><br><font color=#eeeeee face=verdana size=1>..................
<img src=/img/header.gif valign=top></form></td></tr></table>

 </body>
</html>
";

exit;

}


sub freischalten {
print "Content-type:text/html\n\n";
$dit= "/tmdata/tmi/free/".$tt;
open(AA,"</tmdata/tmi/free/$tt");
$nrr=<AA>;chomp $nrr;
close(AA);

if ( $nr == $ nrr || -e $dit == 0) { 
unlink($dit) ;


print "<title>Freischaltung erfolgreich</title>";
print "<body bgcolor=#eeeeee><font color=#eeeeee face=verdana size=1>.......................<img src=/img/trail.gif>\n";

print "<br><table border=0><tr><td valign=top><img src=/img/url.gif border=0></td>\n";
print "<td colspan=10></td><td valign=top>\n";
print "\n";
print "<br><font face=verdana size=2 color=darkred><b>Freischaltung fuer Account<br>$tt war erfolgreich !<font color=black></b><br><br><font face=verdana size=1><br><br>\n
<font face=verdana size=2><b>Trainer - LogIn</b><form action=/cgi-mod/tmi/login.pl method=post>
<font color=black><br>
<font face=verdana size=1>Trainername :<br><input type=text lenght=25 name=trainer value=\"$tt\"><br><br>Passwort :<br><input type=password lenght=25 name=newpass><br><font size=1><br><input type=hidden name=first value=1><input type=image src=/img/log_in.jpg border=0></form><br>";
print "</td><td><br><font color=#eeeeee face=verdana size=1>.................";
print "<img src=/img/header.gif valign=top></td></tr></table>";


} else {
print "Die Freischaltung war leider nicht erfolgreich.<br>Bitte gehen Sie sicher das der komplette Link aus Ihrer Anmeldemail aktiviert wurde.
Bei weiteren Problemen -> Mail an info\@tipmaster.net";
}





exit;
}

sub get_date {

    @days   = ('Sunday','Monday','Tuesday','Wednesday',
               'Thursday','Friday','Saturday');
    @months = ('January','February','March','April','May','June','July',
	         'August','September','October','November','December');

    ($sec,$min,$hour,$mday,$mon,$year,$wday) = (localtime(time+0))[0,1,2,3,4,5,6];
    $time = sprintf("%02d:%02d:%02d",$hour,$min,$sec);
    $year += 1900;

    $date = "$months[$mon] $mday, $time";

}

