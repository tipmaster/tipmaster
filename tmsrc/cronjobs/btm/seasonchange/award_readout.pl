#!/usr/bin/perl

`rm -r /tmdata/btm/trainer_db`;
`mkdir -p /tmdata/btm/trainer_db`;

require "/tmapp/tmsrc/cgi-bin/btm/saison.pl";

print "\n\nL?uft an ...\n";

open( D1, ">/tmdata/btm/awards.txt" );

for ( $sai = 1 ; $sai <= ( $main_nr - 6 ) ; $sai++ ) {

	%me1 = ();
	%me2 = ();
	%me3 = ();
	%me4 = ();
	%me5 = ();

	for ( $me = 1 ; $me <= 5 ; $me++ ) {

		$rr     = 0;
		$ar     = 0;
		$a[1]   = 0;
		$a[2]   = 0;
		$a[3]   = 0;
		$a[4]   = 0;
		$a[5]   = 0;
		$marker = 30;
		$grenze = 33;

		$datei = "/tmdata/btm/stat_s" . $sai . ".txt";

		open( D2, "<$datei" );
		while (<D2>) {
			@boh = split( /&/, $_ );

			#print "$boh[1] $boh[0]\n";

			if ( $boh[1] > $grenze ) {
				$rr++;

				(
					$trainer[$rr], $spiele[$rr], $pu_g[$rr], $s_g[$rr],  $u_g[$rr], $n_g[$rr],
					$tp_g[$rr],    $tm_g[$rr],   $qp_g[$rr], $qm_g[$rr], $op_g[$rr]
				) = split( /&/, $_ );

				if ( $boh[1] == 34 ) {
					$ar++;
					$a[1] = $a[1] + $pu_g[$rr];
					$a[2] = $a[2] + $tp_g[$rr];
					$a[3] = $a[3] + $qp_g[$rr];
					$a[4] = $a[4] + $op_g[$rr];
					$a[5] = $a[5] + $tm_g[$rr];
				}

			}
		}
		close(D2);

		@ranks  = ();
		@king   = ();
		@ident  = ();
		@quoten = ();

		if ( $me == 1 ) {
			for ( $ti = 1 ; $ti <= $rr ; $ti++ ) {
				$quoten[$ti] = $pu_g[$ti];
				$quoten[$ti] = $quoten[$ti] . '#';
				$xx          = 1500 + $tp_g[$ti] - $tm_g[$ti];
				$quoten[$ti] = $quoten[$ti] . $xx . '#';
				$quoten[$ti] = $quoten[$ti] . $tp_g[$ti] . '#';
				$quoten[$ti] = $quoten[$ti] . $ti;
			}
		}

		if ( $me == 2 ) {
			for ( $ti = 1 ; $ti <= $rr ; $ti++ ) {
				$quoten[$ti] = $qp_g[$ti];
				$quoten[$ti] = $quoten[$ti] . '#';
				$quoten[$ti] = $quoten[$ti] . $tp_g[$ti] . '#';
				$quoten[$ti] = $quoten[$ti] . $pu_g[$ti] . '#';
				$quoten[$ti] = $quoten[$ti] . $ti;
			}
		}

		if ( $me == 3 ) {
			for ( $ti = 1 ; $ti <= $rr ; $ti++ ) {
				$quoten[$ti] = $tp_g[$ti];
				$quoten[$ti] = $quoten[$ti] . '#';
				$quoten[$ti] = $quoten[$ti] . $qp_g[$ti] . '#';
				$quoten[$ti] = $quoten[$ti] . $pu_g[$ti] . '#';
				$quoten[$ti] = $quoten[$ti] . $ti;
			}
		}

		if ( $me == 4 ) {
			for ( $ti = 1 ; $ti <= $rr ; $ti++ ) {
				$xx          = 100 - $op_g[$ti];
				$quoten[$ti] = $xx;
				$quoten[$ti] = $quoten[$ti] . '#';
				$quoten[$ti] = $quoten[$ti] . $pu_g[$ti] . '#';
				$quoten[$ti] = $quoten[$ti] . $qp_g[$ti] . '#';
				$quoten[$ti] = $quoten[$ti] . $ti;
			}
		}

		if ( $me == 5 ) {
			for ( $ti = 1 ; $ti <= $rr ; $ti++ ) {
				$quoten[$ti] = $tm_g[$ti];
				$quoten[$ti] = $quoten[$ti] . '#';
				$quoten[$ti] = $quoten[$ti] . $qm_g[$ti] . '#';
				$quoten[$ti] = $quoten[$ti] . $pu_g[$ti] . '#';
				$quoten[$ti] = $quoten[$ti] . $ti;
			}
		}
		@ranks = ();
		@king  = ();
		@ident = ();

		@ranks = sort @quoten;

		@quoten = ();

		$r = 0;
		for ( $t = 1 ; $t <= $rr ; $t++ ) {
			$r--;
			( $leer, $leer, $leer, $ident[$t] ) = split( /#/, $ranks[$r] );

			if ( $me == 1 ) { $me1{ $trainer[ $ident[$t] ] } = $t }
			if ( $me == 2 ) { $me2{ $trainer[ $ident[$t] ] } = $t }
			if ( $me == 3 ) { $me3{ $trainer[ $ident[$t] ] } = $t }

			if ( $me == 4 ) { $me4{ $trainer[ $ident[$t] ] } = $t }
			if ( $me == 5 ) { $me5{ $trainer[ $ident[$t] ] } = $t }

		}

		if ( $me == 1 ) { $rr1 = $rr }
		if ( $me == 2 ) { $rr2 = $rr }
		if ( $me == 3 ) { $rr3 = $rr }
		if ( $me == 4 ) { $rr4 = $rr }
		if ( $me == 5 ) { $rr5 = $rr }

		print D1 "#$sai#$me#1#$trainer[$ident[1]]#\n";
		print D1 "#$sai#$me#2#$trainer[$ident[2]]#\n";
		print D1 "#$sai#$me#3#$trainer[$ident[3]]#\n";

	}

	$datei = "/tmdata/btm/stat_s" . $sai . ".txt";
	open( D, "<$datei" );
	while (<D>) {
		@all = split( /&/, $_ );
		if ( $all[1] > $grenze ) {
			open( T, ">>/btm/trainer_db/$all[0]" );

			#print "$all[0]\n";
			print T
			  "$sai&$me1{$all[0]}/$rr1&$me2{$all[0]}/$rr2&$me3{$all[0]}/$rr3&$me4{$all[0]}/$rr4&$me5{$all[0]}/$rr5&$_";
			close(T);
		}
	}

	close($dd);

	open( T, ">>/tmdata/btm/trainer_db/ligawerte.txt" );
	if ( $ar > 0 ) {
		print T "$sai&";
		$oo = 0;
		$qm = int( ( $a[1] / $ar ) * 10 ) / 10;
		$xx = "1";
		( $yy, $xx ) = split( /\./, $qm );
		$oo = length($xx);
		if ( $oo == 0 ) { $qm = $qm . '.0' }
		print T "$qm&";

		$oo = 0;
		$qm = int( ( $a[2] / $ar ) * 10 ) / 10;
		$xx = "1";
		( $yy, $xx ) = split( /\./, $qm );
		$oo = length($xx);
		if ( $oo == 0 ) { $qm = $qm . '.0' }
		print T "$qm&";

		$oo = 0;
		$qm = int( ( $a[3] / $ar ) * 100 ) / 100;
		$xx = "11";
		( $yy, $xx ) = split( /\./, $qm );
		$oo = length($xx);

		if ( $oo == 1 ) { $qm = $qm . '0' }
		if ( $oo == 0 ) { $qm = $qm . '.00' }
		print T "$qm&";

		$oo = 0;
		$op = int( ( $a[4] / $ar ) * 1000 ) / 1000;
		$xx = "111";
		( $yy, $xx ) = split( /\./, $op );
		$oo = length($xx);
		if ( $oo == 2 ) { $op = $op . '0' }
		if ( $oo == 1 ) { $op = $op . '00' }
		if ( $oo == 0 ) { $op = $op . '.000' }
		print T "$op&";
		$oo = 0;
		$qm = int( ( $a[5] / $ar ) * 10 ) / 10;
		$xx = "1";
		( $yy, $xx ) = split( /\./, $qm );
		$oo = length($xx);
		if ( $oo == 0 ) { $qm = $qm . '.0' }
		print T "$qm&\n";
	}
	close(T);

}

close(D1);
