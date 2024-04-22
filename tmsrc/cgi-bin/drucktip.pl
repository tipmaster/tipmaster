#!/usr/bin/perl

=head1 NAME
	drucktip.pl

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

$query = new CGI;
$tm    = $query->param(tm);
my $test = 0;
if ( $tm eq "test" ) {
	$test = 1;
}
if ( $tm ne "tmi" ) {
	$tm = "btm";
}

$base = "/tmdata/$tm";

#$base = "/home/bpf/TM";
if ($test) {
	$base       = "/tmdata";
	$filename   = "$base/formular_tmp.txt";
	$formularnr = 0;
}
else {
## ermitteln, welches Tipformular:

	open( G, "<$base/tip_datum.txt" );
	$formularnr = <G>;
	close(G);

	if ( $formularnr =~ /(\d*)/ ) {
		$formularnr = ( $1 + 3 ) / 4;
	}
	else {
		&error("Spielrunde konnte nicht ermittelt werden");
	}

	if ( $formularnr < 1 or $formularnr > 9 ) {
		&error("Spielrunde $formularnr im ungueltigen Bereich");
	}

	$filename = "$base/formular${formularnr}.txt";
}

## Tipformular einlesen und umwandeln:

open( H, "<$filename" ) or &error("Testformular nicht auffindbar!");
while (<H>) {
	chomp;
	@fields = split( /&/, $_ );

	#print "Analyzing $_\n";
	if ( $fields[4] ) {
		$ctr++;
		$lfd = $ctr;
		if ( $lfd < 10 ) { $lfd = "0" . $lfd; }

		#print "Fields: @fields\n";
		$fields[1] =~ s/\(.*?\)//;
		$match{"$lfd"} = $fields[1];
		for ( 1 .. 3 ) {
			$quote{"$lfd"}[$_] = $fields[ $_ + 1 ];
		}
	}
}
close(H);

## Ausgabe am Schirm
$start = $formularnr * 4 - 3;
$stop  = $formularnr * 4;
if ( $stop > 34 ) { $stop = 34; }
if ($test) {
	$start = "TEST";
	$stop  = "TEST";
}
print $query->header;
print "<pre>\n";
print "\nTipformular $tm fuer die Spieltage $start - $stop\n\n";

foreach $a_match ( sort keys %quote ) {
	if ( $a_match <= 25 ) {
		print "$a_match:\t__-__-__\t", $quote{"$a_match"}[1], "-", $quote{"$a_match"}[2];
		print "-", $quote{"$a_match"}[3], "\t $match{\"$a_match\"}\n";
	}
}

print "\nEin Service Ihres Tipmaster Teams - Viel Glueck beim Tippen\n";
print "</pre>\n";
exit 0;

sub error {
	$line = shift;
	print "<HTML><BODY>Leider ist der folgende Fehler aufgetreten:<br>\n";
	print $line, "<br>\n";
	print "</BODY></HTML>\n";
	exit 1;
}

