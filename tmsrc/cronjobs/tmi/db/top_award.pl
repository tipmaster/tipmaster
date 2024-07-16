#!/usr/bin/perl

$grenze = 9999;
require "/tmapp/tmsrc/cgi-bin/tmi/saison.pl";
$akt_saison = $main_nr - 5;

$rrunde = 1;
require "/tmapp/tmsrc/cgi-bin/runde.pl";

$line = -1;
for ( $d = 1 ; $d <= $akt_saison ; $d++ ) {
	open( D, "</tmdata/tmi/stat_s$d.txt" );
	while (<D>) {
		$string = $_;
		chomp $string;
		$string = $d . '#' . $string;
		$line++;
		$box[$line] = $string;
	}
	close(D);
}

$line = -1;
foreach $g (@box) {
	@all = split( /&/, $g );
	$line++;
	$aw1[$line] = $all[2] . "!" . $g;
}
@aw1 = sort @aw1;
@aw1 = reverse @aw1;
open( D, ">/tmdata/tmi/stat_at_aw1.txt" );
for ( $x = 0 ; $x <= $grenze ; $x++ ) {
	( $aa1, $aa2 ) = split( /#/,  $aw1[$x] );
	( $aa3, $aa4 ) = split( /\!/, $aa1 );
	print D "$aa2&$aa4\n";
}
close(D);

$line = -1;
@aw1  = ();

foreach $g (@box) {
	@all = split( /&/, $g );
	$line++;
	$aw1[$line] = $all[6] . "!" . $g;
}
@aw1 = sort @aw1;
@aw1 = reverse @aw1;
open( D, ">/tmdata/tmi/stat_at_aw3.txt" );
for ( $x = 0 ; $x <= $grenze ; $x++ ) {
	( $aa1, $aa2 ) = split( /#/,  $aw1[$x] );
	( $aa3, $aa4 ) = split( /\!/, $aa1 );
	print D "$aa2&$aa4\n";
}
close(D);

$line = -1;
@aw1  = ();

foreach $g (@box) {
	@all = split( /&/, $g );
	if ( $all[1] == 34 ) {

		$line++;
		$aw1[$line] = $all[8] . "!" . $g;
	}
}
@aw1 = sort @aw1;
@aw1 = reverse @aw1;
open( D, ">/tmdata/tmi/stat_at_aw2.txt" );
for ( $x = 0 ; $x <= $grenze ; $x++ ) {
	( $aa1, $aa2 ) = split( /#/,  $aw1[$x] );
	( $aa3, $aa4 ) = split( /\!/, $aa1 );
	print D "$aa2&$aa4\n";

}
close(D);

$line = -1;
@aw1  = ();
foreach $g (@box) {
	@all = split( /&/, $g );
	if ( $all[1] == 34 ) {
		$line++;
		$aw1[$line] = $all[10] . "!" . $g;
	}
}
@aw1 = sort @aw1;
open( D, ">/tmdata/tmi/stat_at_aw4.txt" );
for ( $x = 0 ; $x <= $grenze ; $x++ ) {
	( $aa1, $aa2 ) = split( /#/,  $aw1[$x] );
	( $aa3, $aa4 ) = split( /\!/, $aa1 );
	print D "$aa2&$aa4\n";

}
close(D);

$line = -1;
@aw1  = ();

foreach $g (@box) {
	@all = split( /&/, $g );
	$line++;
	$aw1[$line] = $all[7] . "!" . $g;
}
@aw1 = sort @aw1;
@aw1 = reverse @aw1;
open( D, ">/tmdata/tmi/stat_at_aw5.txt" );
for ( $x = 0 ; $x <= $grenze ; $x++ ) {
	( $aa1, $aa2 ) = split( /#/,  $aw1[$x] );
	( $aa3, $aa4 ) = split( /\!/, $aa1 );
	print D "$aa2&$aa4\n";
}
close(D);
