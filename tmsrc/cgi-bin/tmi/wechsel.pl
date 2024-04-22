#!/usr/bin/perl

=head1 NAME
	TMI wechsel.pl

=head1 SYNOPSIS
	TBD
	


=head1 CHANGELOG
	2015-06-09 Thomas: Added Session Management


	Created 2015-06-09

=cut

use lib '/tmapp/tmsrc/cgi-bin/'; 
use TMSession;
my $session = TMSession::getSession(tmi_login => 1);
my $trainer = $session->getUser();
my $leut = $trainer;


use CGI;
$query = new CGI;
$sent = $query->param('ok');
$me = $query->param('me');

print "Content-Type: text/html \n\n";





require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl";


$rr = 0;
$li=0;
$liga=0;
open(D2,"/tmdata/tmi/history.txt");
while(<D2>) {

$la++;
@vereine = split (/&/, $_);	

$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
$rr++;
$y++;
chomp $vereine[$y];
$data[$rr] = $vereine[$y];
$li{$data[$rr]} = $la;


$y++;
chomp $vereine[$y];
$datb[$rr] = $vereine[$y];
if ( $datb[$rr] eq $trainer ) { 
$isa = $gg ;
$isb = $x;
$team = $data[$rr];
}

$tr{$data[$rr]} = $datb[$rr];
$y++;
chomp $verein[$y];
$datc[$x] = $vereine[$y];
}

}

close(D2);


if ( $me eq "sent" ) { &write; }
if ( $me eq "del" ) { &write; }


open (D1,"/tmdata/tmi/tausch.txt");
while (<D1>) {
if ($_ =~ /$team/) {
@data = split (/&/,$_) ;
if ($data[3] eq $team ) {
if ($tr{$data[3]} eq $data[2] ) {
$already = $data[1];
}
}
}
}
close (D1);





print "<title>TMI - Vereinstausch</title>\n";
print "<body bgcolor=#eeeeee text=black>\n";
require "/tmapp/tmsrc/cgi-bin/tag.pl";
print "<br><br><font face=verdana size=2><b>TipMaster international  Vereinstausch</b><br><br>";

print "<font face=verdana size=1>Guten Tag $trainer ,<br><br>sie haben die Moeglichkeit beim TipMaster Ihren Verein mit <br>einem Trainerkollegen zu tauschen . Am besten kontaktieren<br>Sie dazu den Trainerkollegen via Message - Box oder E - Mail<br>und tragen Ihren gewuenschten Tauschverein im folgenden Formular ein.<br><br>";
print "Bitte geben Sie den exakten Vereinsnamen des Vereins an<br>mit dessen Trainer Sie Ihren Verein tauschen wollen .<br><br>\n"; 
print "<form method=post action=/cgi-bin/tmi/wechsel.pl><input type=hidden name=me value=sent>\n";
print "<input type=text name=ok value=\"$already\" >\n";
print "&nbsp;&nbsp;&nbsp;<input type=submit value=\"Tauschabsicht registrieren\"></form><br>\n";

if (( $color eq "red" ) and ( $me eq "sent")) {
print "<font color=red>Ihre Eingabe $sent konnte<br>leider nicht als Vereinsname identifiziert werden .<br>Ueberpruefen Sie bitte die absolut korrekte<br>Schreibweise und Vollstaendigkeit<br>des Vereinsnamens anhand der<br>Resultatseiten des TipMasters .<br><br><font color=black>";
}

if ( $me eq "del") {
print "<font color=red>Ihre Tauschabsicht wurde rueckgaengig gemacht !<br><br><font color=black>";
}


#print "$sent $me";

$zahl=0;



open (D1,"/tmdata/tmi/tausch.txt");
while (<D1>) {
if ($_ =~ /$team/) {
@data = split (/&/,$_) ;
if ($data[1] eq $team ) {
if ($tr{$data[3]} eq $data[2] ) {

$zahl++;
if ($zahl == 1 ) {
print "Fuer Ihren Verein $team liegen<br>derzeit folgende Tauschangebote vor :<br><br>";
}

print "<font color=darkred>&nbsp;&nbsp;* &nbsp;$data[3] ( $data[2] / $liga_namen[$li{$data[3]}] )<br>";
}
}
}
}
close (D1);

if ($zahl == 0 ) {
print "Fuer Ihren Verein $team liegen<br>derzeit keine Tauschangebote vor !";
}

print "<font color=black><br>";

$zahl=0;

open (D1,"/tmdata/tmi/tausch.txt");
while (<D1>) {
if ($_ =~ /$team/) {
@data = split (/&/,$_) ;
if ($data[3] eq $team ) {
if ($tr{$data[3]} eq $data[2] ) {
$already = $data[1];

$zahl++;
if ($zahl == 1 ) {
print "<br>Von Ihnen haben wir das Tauschinteresse<br>mit folgendem Verein registriert : <br><br>";
print "<font color=darkred>&nbsp;&nbsp;* &nbsp;$data[1] ( $tr{$data[1]} / $liga_namen[$li{$data[1]}] )<br>";

print "<form method=post action=/cgi-bin/tmi/wechsel.pl>\n";
print "<input type=submit value=\"Tauschabsicht loeschen\"></form><br>\n";

}




}
}
}
}
close (D1);

if ($zahl == 0 ) {
print "<br>Von ihnen haben wir aktuell <br>kein Tauschinteresse vorliegen !<br><br>";
}

print "<font color=navy>Soweit die Tauschabsichten zweier Trainer<br>sich gegenseitig entsprechen werden<br>die Vereinstaeusche jeweils Mittwochs<br>vollzogen .<br><br>";

print "<form method=post action=/cgi-mod/tmi/login.pl>\n";
print "<input type=submit value=\"Zurueck zum Menu\"></form><br><br>\n";




exit ;



sub write {


$ole=0;
$rr = 0;
$li=0;
$liga=0;
open(D2,"/tmdata/tmi/history.txt");
while(<D2>) {
$la++;
@vereine = split (/&/, $_);	

$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
$rr++;
$y++;
chomp $vereine[$y];
$datax[$rr] = $vereine[$y];

if ( $datax[$rr] eq $sent ) { $ole=1 }

$y++;
$y++;
}

}

close(D2);


if ( ($ole == 0) and ( $me eq "sent") ) {
$color="red";
goto go;
}


$ein = 0;
$inhalt = "";
open (D1,"/tmdata/tmi/tausch.txt");
flock (D1,2) ;
while (<D1>) {
$a = $_ ;
@data = split (/&/ , $_ );


if ( $tr{$data[3]} ne $data[2] ) { $a = "" }

if ( $data[2] eq $trainer ) { 
$a = "&$sent&$trainer&$team&\n";
$ein=1;
}

if ( ( $data[2] eq $trainer ) and ( $me eq "del" )) { 
$a = "";
$ein=1;
}


$inhalt .= $a;
}
flock (D1,8) ;
close (D1);

if ( ( $ein==0 ) and ($me eq"sent")) { $inhalt .= "&$sent&$trainer&$team&\n" }

open (D1,">/tmdata/tmi/tausch.txt");
flock (D1,2) ;
print D1 "$inhalt";
flock (D1,8) ;
close (D1);

go:


}

