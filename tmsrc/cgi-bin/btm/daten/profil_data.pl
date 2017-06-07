#!/usr/bin/perl

=head1 NAME
	BTM profil_data.pl

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
my $session = TMSession::getSession(btm_login => 1);
my $trainer = $session->getUser();
my $leut = $trainer;


use CGI;
use DB_File;
$query = new CGI;
$wohnort = $query->param('wohnort');
$land = $query->param('land');
$bundesland = $query->param('bundesland');
$beruf = $query->param('beruf');
$liebling = $query->param('liebling');
$hobby = $query->param('hobby');
$motto = $query->param('motto');
$gb1 = $query->param('gb1');
$gb2 = $query->param('gb2');
$gb3 = $query->param('gb3');
$notifval = $query->param('notifier');
$ecnotifval = $query->param('ecnotifier');

if ( $gb1 <10 ) {$ca = 0 }
if ( $gb2 <10 ) {$cb = 0 }

$cc = "." ;

$geburtstag = $ca . $gb1 .$cc. $cb . $gb2 .$cc.$gb3 ;





$aa = "&" ;
$ae = "!" ;
$suche = $ae . $aa . $trainer . $aa ;
$r = 0;


$zeilen = $suche . $wohnort . $aa . $land . $aa . $geburtstag . $aa . $bundesland . $aa . $beruf . $aa . $liebling . $aa . $hobby . $aa . $motto . $aa ;

if ($zeilen=~/javascript/) {exit;} # Blacklisting ist kein effektiver Schutz! Besser erst gar nicht mit sowas anfangen.

$rof = 0;
# Ah, ja. Whitelisting! Viel besser. Aber es muss Alles geprüft werden, auch die Felder, die sich aus Comboboxen, Radios oder Checkboxen speisen. Auch das Geb.datum mit Felder von Länge 2 kann böse sein!
if ( $wohnort =~ /[^A-Za-z_0-9\.\-,;! ]/) { $rof = 1 }
if ( $land =~ /[^A-Za-z_0-9\.\-,;! ]/) { $rof = 1 }
if ( $geburtstag =~ /[^A-Za-z_0-9\.\-,;! ]/) { $rof = 1 }
if ( $bundesland =~ /[^A-Za-z_0-9\.\-,;! ]/) { $rof = 1 }
if ( $beruf =~ /[^A-Za-z_0-9\.\-,;! ]/) { $rof = 1 }
if ( $liebling =~ /[^A-Za-z_0-9\.\-,;! ]/) { $rof = 1 }
if ( $hobby =~ /[^A-Za-z_0-9\.\-,;! ]/) { $rof = 1 }
if ( $motto =~ /[^A-Za-z_0-9\.\-,;! ]/) { $rof = 1 }

if ( $rof == 1 ) {
print "Content-type: text/html\n\n";
print "<body bgcolor=#eeeeee text=black><font face=verdana size=1>";
print "Bundesliga - TipMaster<br><br>Eine ihrer Angabe enthaelt ein nicht gueltiges Zeichen ...<br>Bitte verzichten sie auf Umlaute sowie auf Sonderzeichen !<br>";
exit ;
}

if ( $trainer ne "Gast Zugang" ) {

$datei = "/tmdata/btm/db/profile/" . $trainer . ".txt" ;
open(D8,">$datei");
flock (D8 , 2);
print D8 "$zeilen\n";
flock (D8 , 8);
close (D8) ;

if (1) {
## setzen von flag beim notifier
my $flags = O_RDWR;
my $notifierentry = 0;
if ($notifval eq "formular") {
	$notifierentry = 1;
}
my $mode = "0777";
my $db = tie %notifiers, 'DB_File', "/tmdata/btm/notifiers.dbm", $flags, $mode, $DB_HASH or print "Cannot create DB: $!";

my $fd = $db->fd;                                            # Get file descriptor
open DBM, "+<&=$fd" or die "Could not dup DBM for lock: $!"; # Get dup filehandle
flock DBM, LOCK_EX;                                          # Lock exclusively
undef $db;                                                   # Avoid untie probs
$notifiers{"$trainer"} = $notifierentry;
untie %notifiers;
flock DBM, LOCK_UN;


if (1) {
my $ecnotifierentry = 1;
if ($ecnotifval eq "ecformular") {
        $ecnotifierentry = 0;
}
my $ecdb = tie %ecnotifiers, 'DB_File', "/tmdata/cl/notifiers.dbm", $flags, $mode, $DB_HASH or print "Cannot create DB: $!";

my $fd = $ecdb->fd;                                            # Get file descriptor
open DBZ, "+<&=$fd" or die "Could not dup DBM for lock: $!"; # Get dup filehandle
flock DBZ, LOCK_EX;                                          # Lock exclusively
undef $ecdb;                                                   # Avoid untie probs
$ecnotifiers{"$trainer"} = $ecnotifierentry;
untie %ecnotifiers;
flock DBZ, LOCK_UN;
}

}


}

print "Content-type: text/html\n\n";
print "<body bgcolor=#eeeeee text=black><font face=verdana size=1>";
print "Bundesliga - TipMaster<br><br>Ihr Trainer - Profil ist aktualisiert ...<br>Sie werden weitergeleitet ...";
print "<form name=Testform action=/cgi-mod/btm/login.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=password value=\"$pass\"></form>";
print "<script language=JavaScript>\n";
print"   function AbGehts()\n";
print"   {\n";
print"    document.Testform.submit();\n";
print"    }\n";
print"   window.setTimeout(\"AbGehts()\",100);\n";
print"  </script>\n";


exit ;
