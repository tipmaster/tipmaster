#!/usr/bin/perl

require "/tmapp/tmsrc/cgi-bin/runde.pl";
require "/tmapp/tmsrc/cgi-bin/btm/saison.pl";

$sssa = $main_nr - 5;

$his = "history";
$run = $rrunde;     # TIPRUNDE

$start = ( ( $run - 1 ) * 4 ) + 1;

#print "Alles geaendert ?\n";
#$a = <stdin>;
$letzer_verein  = 0;
$letzer_trainer = 0;

open( DO, "</tmdata/btm/db/vereine.txt" );
while (<DO>) {
	$t++;
	( $nummer, $ve ) = split( /&/, $_ );
	chomp $ve;
	$team_id[$nummer] = $ve;
	$verein_ex{$ve}   = 1;
	$verein_nr{$ve}   = $nummer;
	if ( $nummer > $letzer_verein ) { $letzer_verein = $nummer }
}
close(DO);

print "OK1\n";

open( DO, "</tmdata/btm/db/trainer.txt" );
while (<DO>) {
	$t++;
	( $nummer, $ve ) = split( /&/, $_ );
	chomp $ve;
	$coach_id[$nummer] = $ve;
	$trainer_ex{$ve}   = 1;
	$trainer_nr{$ve}   = $nummer;
	if ( $nummer > $letzer_trainer ) { $letzer_trainer = $nummer }
}
close(DO);

print "OK2\n";

#print "$letzer_trainer  $letzer_verein\n";

$rr      = 0;
$li      = 0;
$liga    = 0;
$history = "/tmdata/btm/" . $his . ".txt";
open( D2, "$history" );
while (<D2>) {

	$li++;
	@vereine = split( /&/, $_ );

	$y = 0;
	for ( $x = 1 ; $x < 19 ; $x++ ) {
		$rr++;
		$y++;
		chomp $verein[$y];
		$data[$rr] = $vereine[$y];
		$y++;
		chomp $verein[$y];
		$datb[$rr] = $vereine[$y];

		#print "$rr / $datb[$rr]\n";
		if ( $verein_ex{ $data[$rr] } != 1 ) {
			open( DO, ">>/tmdata/btm/db/vereine.txt" );
			$letzer_verein++;
			print DO "$letzer_verein&$data[$rr]&\n";
			close(DO);
		}

		if ( $trainer_ex{ $datb[$rr] } != 1 ) {
			if ( $datb[$rr] ne "Trainerposten frei" ) {
				open( DO, ">>/tmdata/btm/db/trainer.txt" );
				$letzer_trainer++;
				print DO "$letzer_trainer&$datb[$rr]\n";
				close(DO);
			}
		}

		$y++;

	}

}

close(D2);

print "OK3\n";

open( DO, "/tmdata/btm/spieltag.txt" );
while (<DO>) {
	@ego = <DO>;
}
close(DO);

for ( $liga = 1 ; $liga <= 384 ; $liga++ ) {

	#print "Liga $liga\n";

	$hg    = "/tmdata/btm/DAT";
	$anton = "0";
	if ( $liga > 9 ) { $anton = "" }
	$beta = ".TXT";

	$datei_data = $hg . $anton . $liga . $beta;
	@quoten_row = ();

	open( DO, $datei_data );
	while (<DO>) {
		@quoten_row = <DO>;
	}
	close(DO);

	$aa = $start - 1;
	$ab = $start + 2;

	if ( $ab == 35 ) { $ab = 33 }

	for ( $spieltag = $aa ; $spieltag <= $ab ; $spieltag++ ) {
		@ega = split( /&/, $ego[$spieltag] );

		chop $quoten_row[$spieltag];
		@quoten_zahl = split( /&/, $quoten_row[$spieltag] );

		for ( $x = 0 ; $x < 18 ; $x = $x + 2 ) {

			$tora = 0;
			$torb = 0;
			$y    = $x + 1;
			$wa   = $x - 1;
			$wb   = $y - 1;

			# print "$liga\n";

			$id = ( ( $liga - 1 ) * 18 ) + $ega[$x];
			$line[$id] =
			    $line[$id] . '&'
			  . $verein_nr{ $data[$id] } . '#'
			  . $quoten_zahl[ $ega[$x] - 1 ] . '#'
			  . $quoten_zahl[ $ega[$y] - 1 ] . '#H';

			$id = ( ( $liga - 1 ) * 18 ) + $ega[$y];
			$line[$id] =
			    $line[$id] . '&'
			  . $verein_nr{ $data[$id] } . '#'
			  . $quoten_zahl[ $ega[$y] - 1 ] . '#'
			  . $quoten_zahl[ $ega[$x] - 1 ] . '#A';

		}
	}

}

$datei = ">/tmdata/btm/db/saison-$sssa-" . $run . ".txt";

open( DO, "$datei" );
for ( $x = 1 ; $x <= 6912 ; $x++ ) {
	if ( $datb[$x] ne "Trainerposten frei" ) {
		print DO "$trainer_nr{$datb[$x]}!$line[$x]\n";

	}
}
close(DO);
$datei = ">/tmdata/btm/db/saison-$sssa-" . $run . "-res.txt";

open( DO, "$datei" );
for ( $x = 1 ; $x <= 6912 ; $x++ ) {
	if ( $datb[$x] ne "Trainerposten frei" ) {
		print DO "$trainer_nr{$datb[$x]}!$line[$x]\n";

	}
}
close(DO);

for ( $a = 1 ; $a <= $letzer_trainer ; $a++ ) {
	$this_season[$a] = 0;
	$row_1[$a]       = "&-#-#-#-&-#-#-#-&-#-#-#-&-#-#-#-";
	$row_2[$a]       = "&-#-#-#-&-#-#-#-&-#-#-#-&-#-#-#-";
	$row_3[$a]       = "&-#-#-#-&-#-#-#-&-#-#-#-&-#-#-#-";
	$row_4[$a]       = "&-#-#-#-&-#-#-#-&-#-#-#-&-#-#-#-";
	$row_5[$a]       = "&-#-#-#-&-#-#-#-&-#-#-#-&-#-#-#-";
	$row_6[$a]       = "&-#-#-#-&-#-#-#-&-#-#-#-&-#-#-#-";
	$row_7[$a]       = "&-#-#-#-&-#-#-#-&-#-#-#-&-#-#-#-";
	$row_8[$a]       = "&-#-#-#-&-#-#-#-&-#-#-#-&-#-#-#-";
	$row_9[$a]       = "&-#-#-#-&-#-#-#-";
}

open( DO, "/tmdata/btm/db/saison-$sssa-1.txt" );
while (<DO>) {
	( $number, $line ) = split( /!/, $_ );
	$xx = $_;
	chomp $line;
	$row_1[$number]       = $line;
	$this_season[$number] = 1;
}
close(DO);

if ( $run == 1 ) { goto hgf; }

open( DO, "/tmdata/btm/db/saison-$sssa-2.txt" );
while (<DO>) {
	( $number, $line ) = split( /!/, $_ );
	$xx = $_;
	chomp $line;
	$row_2[$number]       = $line;
	$this_season[$number] = 1;
}
close(DO);
if ( $run == 2 ) { goto hgf; }

open( DO, "/tmdata/btm/db/saison-$sssa-3.txt" );
while (<DO>) {
	( $number, $line ) = split( /!/, $_ );
	$xx = $_;
	chomp $line;
	$row_3[$number]       = $line;
	$this_season[$number] = 1;
}
close(DO);
if ( $run == 3 ) { goto hgf; }

open( DO, "/tmdata/btm/db/saison-$sssa-4.txt" );
while (<DO>) {
	( $number, $line ) = split( /!/, $_ );
	$xx = $_;
	chomp $line;
	$row_4[$number]       = $line;
	$this_season[$number] = 1;
}
close(DO);
if ( $run == 4 ) { goto hgf; }

open( DO, "/tmdata/btm/db/saison-$sssa-5.txt" );
while (<DO>) {
	( $number, $line ) = split( /!/, $_ );
	$xx = $_;
	chomp $line;
	$row_5[$number]       = $line;
	$this_season[$number] = 1;
}
close(DO);
if ( $run == 5 ) { goto hgf; }

open( DO, "/tmdata/btm/db/saison-$sssa-6.txt" );
while (<DO>) {
	( $number, $line ) = split( /!/, $_ );
	$xx = $_;
	chomp $line;
	$row_6[$number]       = $line;
	$this_season[$number] = 1;
}
close(DO);
if ( $run == 6 ) { goto hgf; }

open( DO, "/tmdata/btm/db/saison-$sssa-7.txt" );
while (<DO>) {
	( $number, $line ) = split( /!/, $_ );
	$xx = $_;
	chomp $line;
	$row_7[$number]       = $line;
	$this_season[$number] = 1;
}
close(DO);
if ( $run == 7 ) { goto hgf; }

open( DO, "/tmdata/btm/db/saison-$sssa-8.txt" );
while (<DO>) {
	( $number, $line ) = split( /!/, $_ );
	$xx = $_;
	chomp $line;
	$row_8[$number]       = $line;
	$this_season[$number] = 1;
}
close(DO);
if ( $run == 8 ) { goto hgf; }

open( DO, "/tmdata/btm/db/saison-$sssa-9.txt" );
while (<DO>) {
	( $number, $line ) = split( /!/, $_ );
	$xx = $_;
	chomp $line;
	$row_9[$number]       = $line;
	$this_season[$number] = 1;
}
close(DO);

hgf:

@all = ();

open( B, ">/tmdata/btm/db/spiele.txt" );

$am_lesen = 0;

open( A, "/tmdata/btm/db/spiele_old.txt" );
while (<A>) {

	( $number, $line ) = split( /#/, $_ );

	if ( $number != $am_lesen ) {
		$numbera = $am_lesen;

		if ( $this_season[$numbera] == 1 ) {
			print B
"$numbera#$sssa$row_1[$numbera]$row_2[$numbera]$row_3[$numbera]$row_4[$numbera]$row_5[$numbera]$row_6[$numbera]$row_7[$numbera]$row_8[$numbera]$row_9[$numbera]\n";

		}
	}

	print B "$_";

	$am_lesen = $number;
	$read[$number] = 1;

}
close(A);

for ( $x = 1 ; $x <= 6912 ; $x++ ) {
	if ( $read[ $trainer_nr{ $datb[$x] } ] != 1 ) {

		$number = $trainer_nr{ $datb[$x] };

		$cc = $number * 1;
		if ( $cc < 10 )     { $cc = '0' . $cc }
		if ( $cc < 100 )    { $cc = '0' . $cc }
		if ( $cc < 1000 )   { $cc = '0' . $cc }
		if ( $cc < 10000 )  { $cc = '0' . $cc }
		if ( $cc < 100000 ) { $cc = '0' . $cc }

		print B
"$cc#$sssa$row_1[$number]$row_2[$number]$row_3[$number]$row_4[$number]$row_5[$number]$row_6[$number]$row_7[$number]$row_8[$number]$row_9[$number]\n"

	}
}

close(B);

@zeile = ();

$t = -1;
open( ALL, "</tmdata/btm/db/spiele.txt" );
while (<ALL>) {
	$t++;
	$a = $_;
	( $c, $b ) = split( /#/, $a );

	#if ($c<10) { $a = '0' . $a }
	#if ($c<100) { $a = '0' . $a }
	#if ($c<1000) { $a = '0' . $a }

	$zeile[$t] = $a;
}
close(ALL);

@old = sort @zeile;

open( ALL, ">/tmdata/btm/db/spiele.txt" );
print ALL @old;
close(ALL);

