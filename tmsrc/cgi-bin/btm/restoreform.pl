#!/usr/bin/perl

=head1 NAME
	BTM restoreform.pl

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

require "/tmapp/tmsrc/cgi-bin/runde.pl";

use File::Copy;
$query = new CGI;

$method = $query->param('method');

@accept = (
	"Werner Stengl",
	"Wally Dresel",
	"Bodo Pfannenschwarz",
	"Thomas Schnaedelbach",
	"Walter Eschbaumer",
	"Manfred Kiesel",
	"Calvin Gross",
	"Roberto Maisl",
	"Stefan Imhoff",
	"Rainer Mueller",
	"Markus Reiss",
	"Martin Ziegler",
	"Sascha Lobers",
	"Martin Forster",
	"Thomas Sassmannshausen"
);

print "<HTML><HEAD>\n";
print "<title>TipMaster online - Tipformular</title>";
print "</HEAD>\n";
print "<body background=/img/karo.gif><center><font face=verdana size=1>";
print "Eingeloggter Trainer : $trainer<br><hr>";

$exit = 0;
foreach $t (@accept) {
	if ( $trainer eq $t ) { $exit = 1; }
}
if ( $exit == 0 ) {
	print "Kein Zugriff !";
	exit;
}

## here only authorized guys come in.

if ( !$method ) {
	print "	<form method=post action=\"/cgi-bin/btm/restoreform.pl\">
	<input type=\"hidden\" name=\"method\" value=\"display\">
	Anzeigen Formular <select name=\"btmortmi\"><option>btm</option><option>tmi</option></select>
	Runde <input type=text size=1 name=\"runde\"><input type=\"submit\"> ";
}

if ( $method eq "display" ) {
	&loadAndDisplay;
}
if ( $method eq "copyover" ) {
	&copyOver;
}

print "</BODY></HTML>\n";
exit 0;

sub loadAndDisplay {
	$runde    = $query->param('runde');
	$btmortmi = $query->param('btmortmi');
	$name1    = "/tmdata/" . $btmortmi . "/formular" . $runde . ".txt";
	$name2    = "/tmdata/" . $btmortmi . "/formular" . $runde . "_backup.txt";
	$f1       = &loadForm($name1);
	$f2       = &loadForm($name2);
	print "<b>Derzeitiges Formular: $name1 </b><br> $f1 <br>";
	print "<b>Ersetzen durch Backup: $name2 </b><br> $f2 <br>";
	print "	<form method=post action=\"/cgi-bin/btm/restoreform.pl\"> 
	<input type=\"hidden\" name=\"runde\" value=\"$runde\">
	<input type=\"hidden\" name=\"btmortmi\" value=\"$btmortmi\">
	<input type=\"hidden\" name=\"method\" value=\"copyover\"><input type=\"submit\" value=\"Backup wiederherstellen\">
	</form>\n";
}

sub loadForm {
	$filename = shift;
	open( $k, "<$filename" );
	my $arr = "<table>";
	while (<$k>) {
		@line = split( /&/, $_ );
		$arr = "$arr<tr>";
		foreach $fld (@line) {
			$arr = "$arr<td>$fld</td>";
		}
		$arr .= "</tr>";
	}
	$arr .= "</table>";
	close($k);
	return $arr;
}

sub copyOver {
	$runde    = $query->param('runde');
	$btmortmi = $query->param('btmortmi');
	$name1    = "/tmdata/" . $btmortmi . "/formular" . $runde . ".txt";
	$name2    = "/tmdata/" . $btmortmi . "/formular" . $runde . "_backup.txt";
	$fail     = 0;
	copy( $name2, $name1 ) or $fail = 1;
	if ($fail) {
		print "Restore gescheitert. Bitte pruefen!";
	}
	else {
		print "Formular durch Backup ersetzt. Bitte pruefen! <a href=\"/cgi-bin/btm/scout.pl\">Scoutseite</a>";
	}
}

