#!/usr/bin/perl

=head1 NAME
	BTM profile.pl

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
use HTML::Entities;
my $session = TMSession::getSession(btm_login => 1);
my $trainer = $session->getUser();
my $leut = $trainer;

use CGI;
$query = new CGI;


print "Content-type: text/html\n\n";

$aa = "&" ;
$ae = "!" ;
$suche = $ae . $aa . $trainer . $aa ;
$r = 0;
$datei = "/tmdata/btm/db/profile/" . $trainer . ".txt" ;
open(D2,"$datei");
while(<D2>) {
$r++;
($leer , $trainer , $wohnort , $land , $geburtstag , $bundesland , $beruf , $liebling , $hobby , $motto) = split (/&/, $_);	
$zeile = $r;

}
close(D2);

# retrieve notifier information
#my $notifiercheck = " ";
#my $ecnotifiercheck = " checked";
#my $flags = O_RDWR;
#my $mode = "0777";
#my $db = tie %notifiers, 'DB_FILE', "/tmdata/btm/notifiers.dbm", $flags, $mode, $DB_HASH or print "Cannot access DB: $!";
#my $val = $notifiers{"$trainer"};
#if ($val eq "1") {
#  $notifiercheck = " checked";
#}
#untie %notifiers;
#my $ecdb = tie %ecnotifiers, 'DB_FILE', "/tmdata/cl/notifiers.dbm", $flags, $mode, $DB_HASH or print "Cannot access DB: $!";
#my $ecval = $ecnotifiers{"$trainer"};
#if ($ecval eq "1") {
#  $ecnotifiercheck = " ";
#}
#untie %ecnotifiers;



($gb1 , $gb2 , $gb3) = split (/\./, $geburtstag);	

@land_join = ( "leer" , "Deutschland" , "Oesterreich" , "Schweiz" , "Niederlande" , "Tuerkei" , "United States" , "England" , "anderes Land" , "keine Angabe");

@bundesland_join = (
"leer" ,
"Baden-Wuerttemberg" ,
"Bayern" ,
"Berlin" ,
"Brandenburg" ,
"Bremen" ,
"Hamburg" ,
"Hessen" ,
"Mecklenburg-Vorpommern" ,
"Niedersachsen" ,
"Nordrhein-Westfalen" ,
"Rheinland-Pfalz" ,
"Saarland" ,
"Sachsen" ,
"Sachsen-Anhalt" ,
"Schleswig-Holstein" ,
"Thueringen" ,
"keine Angabe" );


print <<"(END ERROR HTML)";
<html>
<head>
<title>Bundesliga - TipMaster : Trainer - Profil aendern</title>
</head>
<body bgcolor=#eeeeee text=black>
<font color=#eeeeee face=verdana size=1>.......................<img src=/img/trail.gif>
<br>
<table border=0><tr><td valign=top><img src=/img/url.gif border=0></td>
<td colspan=10></td><td valign=top>
<br><font face=verdana size=2 color=darkred>
<b>Trainer Profil</b><br><font color=black><b>$trainer</b><br><br>
<form action=/cgi-bin/btm/daten/profil_data.pl  method=post target=_top>
<input type=hidden name=trainer value="$trainer">
<font face=verdana size=1>
Ihr Wohnort :<br>
<input type=text length=25 maxlength=20 name=wohnort value="$wohnort"><br><br>

(END ERROR HTML)
print "Ihr Bundesland :<br>( nur Deutschland )<br>";

print "<select name=bundesland>\n";
for ($x=1 ; $x <=17 ; $x++ ) {

if ( $bundesland_join[$x] eq $bundesland ) {
print "<option value=\"$bundesland_join[$x]\" selected>$bundesland_join[$x]\n";
} else {
print "<option value=\"$bundesland_join[$x]\">$bundesland_join[$x]\n";
}
}
print "</select><br><br>\n";
#print "Ihr Herkunftsland :<br>";

#print "<select name=land>\n";
#for ($x=1 ; $x <=9 ; $x++ ) {

if ( $land_join[$x] eq $land ) {
#print "<option value=\"$land_join[$x]\" selected>$land_join[$x]\n";
} else {
#print "<option value=\"$land_join[$x]\">$land_join[$x]\n";
}
#}
#print "</select><br><br>\n";
print "<input type=hidden name=land value=\"". encode_entities($land) ."\">";
print "Ihr Geburtstag :<br>";

print "<select name=gb1>\n";
for ($x=1 ; $x <=31 ; $x++ ) {

if ( $x == $gb1 ) {
print "<option value=\"$x\" selected>$x\n";
} else {
print "<option value=\"$x\">$x\n";
}
}
print "</select>&nbsp;.&nbsp;\n";

print "<select name=gb2>\n";
for ($x=1 ; $x <=12 ; $x++ ) {

if ( $x == $gb2 ) {
print "<option value=\"$x\" selected>$x\n";
} else {
print "<option value=\"$x\">$x\n";
}
}
print "</select>&nbsp;.&nbsp;\n";
print "<select name=gb3>\n";
for ($x=1900 ; $x <=2000 ; $x++ ) {

if ( $x == $gb3 ) {
print "<option value=\"$x\" selected>$x\n";
} else {
print "<option value=\"$x\">$x\n";
}
}
print "</select><br><br>\n";


print <<"(END ERROR HTML)";
Ihr Fussball - Lieblingsverein : <br>
<input type=text length=25 maxlength=80 name=liebling value="$liebling"><br><br>

Ihr Beruf / Taetigkeit :<br>
<input type=text length=25 maxlength=30 name=beruf value="$beruf"><br><br>
Ihre Hobbys :<br>( Hobbys bitte durch Kommata trennen )<br>
<input type=text length=25 maxlength=50 name=hobby value="$hobby"><br><br>
Ihr Statement zum TipMaster : <br>
<input type=text length=25 maxlength=80 name=motto value="$motto"><br><br>
<input type="checkbox" name="notifier" value="formular" $notifiercheck>Info-Mail, wenn Formular online geht</input><br>
<input type="checkbox" name="ecnotifier" value="ecformular" $ecnotifiercheck>Info-Mail, wenn EC-Tip ansteht</input><br>
<input type=submit value="Profil aktualisieren"></form>
<br><font color=darkred>
Alle Angaben sind absolut freiwillig<br>
und sollen nur der Kommunikation<br>
von Trainern untereinander dienen !
</td><td><br>
<br><br><font color=#eeeeee face=verdana size=1>..................
<img src=/img/header.gif valign=top></td></tr></table>



</html>
(END ERROR HTML)

exit;







