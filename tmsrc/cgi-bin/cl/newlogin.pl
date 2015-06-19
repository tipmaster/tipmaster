#! /usr/bin/perl

use lib '/tmapp/tmsrc/cgi-bin/';

use CGI;
use TMSession;
use CLLibrary;

$query = new CGI;
#print $query->header;
$modus = $query->param('modus');

$offen = $CLLibrary::tipabgabe_offen;

print "<HTML><HEAD></HEAD><BODY>\n";
print "Test offen: $offen\n";
my $derz_runde = CLLibrary::getCurrentCLRound();
print "Derzeitige Runde: $derz_runde <br>\n";
print "</BODY>";

# Suche nach uebergebenen Keys oder Cookies
$sessionkey = $query->param('sessionkey');
$name = $query->param('name');
$passwd = $query->param('passwd');
$id = $query->param('id');
$referrer = $query->param('referrer');
$runde = $query->param('runde');
if (!$runde) {$runde = $derzeitige_runde;}
if (!$referrer) {$referrer = "tmi";}


