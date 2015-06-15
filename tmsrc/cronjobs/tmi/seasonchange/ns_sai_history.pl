#!/usr/bin/perl

require "/tmapp/tmsrc/cgi-bin/tmi/saison.pl";

`cp /tmdata/tmi/geschichte.txt /tmdata/save/geschichte_tmi.txt`;
`mv /tmdata/tmi/geschichte.txt /tmdata/tmi/geschichte_old.txt`;

$r = 0;
open( B, "</tmdata/tmi/heer.txt" );
while (<B>) {
	$r++;
	@go = split( /&/, $_ );
	$verein[$r]           = $go[5];
	$platz{ $verein[$r] } = $go[0];
	$liga{ $verein[$r] }  = $go[1];
}
close(B);

open( A, ">/tmdata/tmi/geschichte.txt" );
$ein = 0;

open( D5, "/tmdata/tmi/geschichte_old.txt" );
while (<D5>) {
	$zeile = $_;
	chomp $zeile;
	@lost = split( /&/, $_ );
	$zeile = $zeile . $platz{ $lost[0] } . '&' . $liga{ $lost[0] } . '&';
	print A "$zeile\n";
	if ( $platz{ $lost[0] } != 0 ) { $ex{ $lost[0] } = 1 }
	if ( $platz{ $lost[0] } == 0 ) {
		print "Noch nicht eingetragener Verein : $lost[0]\n";
	}

}
close(D5);

for ( $s = 1 ; $s <= $r ; $s++ ) {

	if ( $ex{ $verein[$s] } == 0 ) {
		print A "$verein[$s]";

		# waren 28 Nullen

		for ( $xx = 1 ; $xx <= ( $main_nr - 6 ) ; $xx++ ) {
			print A "&0&0";
		}

		print A "&$platz{$verein[$s]}&$liga{$verein[$s]}&\n";

		print "Neuer Verein : $verein[$s]\n";
	}

}

close(A);
print "Neue TMI Archivdaten abgelegt in /tmdata/tmi/geschichte.txt !\n";

