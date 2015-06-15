#!/usr/bin/perl

for ( $liga = 1 ; $liga <= 203 ; $liga++ ) {

	$lok = $liga;
	if ( $liga < 10 ) { $lok = '0' . $liga }

	$bv  = "DAT";
	$txt = ".TXT";

	$datei_daten = '/tmdata/tmi/' . $bv . $lok . $txt;
	$t           = 0;

	open( DO, ">$datei_daten" );
	print DO "\n";
	for ( $r = 1 ; $r <= 34 ; $r++ ) {
		print DO "1&1&1&1&1&1&1&1&1&1&1&1&1&1&1&1&1&1&\n";
	}

	close(DO);
}
return 1;
