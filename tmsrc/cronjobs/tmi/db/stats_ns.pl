#!/usr/bin/perl

require "/tmapp/tmsrc/cgi-bin/tmi/saison.pl";
$akt_saison = $main_nr - 5;

require "/tmapp/tmsrc/cgi-bin/runde.pl";
$ac1 = ( $rrunde - 1 );

if ( $ac1 == 0 ) { $ac1 == 9 }
$ab1 = ( $ac1 * 4 ) - 3;
$ab2 = ( $ab1 + 3 );

$datei = 'stats.txt';
open( ALL, ">/tmdata/tmi/$datei" );
open( DLL, ">/tmdata/tmi/allquotes.txt" );
open( S1,  ">/tmdata/tmi/stat1.txt" );
open( S2,  ">/tmdata/tmi/stat2.txt" );
open( S3,  ">/tmdata/tmi/stat3.txt" );
open( S4,  ">/tmdata/tmi/stat4.txt" );
open( S5,  ">/tmdata/tmi/stat5.txt" );
open( S6,  ">/tmdata/tmi/stat6.txt" );

for ( $d = 1 ; $d <= $akt_saison ; $d++ ) {
	$dd = "D" . $d;
	open( $dd, ">/tmdata/tmi/stat_s$d.txt" );
}

$rr   = 0;
$li   = 0;
$liga = 0;
open( DQ2, "/tmdata/tmi/history.txt" );
while (<DQ2>) {

	$li++;
	@vereine = split( /&/, $_ );

	$y = 0;
	for ( $x = 1 ; $x < 19 ; $x++ ) {
		$y++;
		chomp $verein[$y];
		$data[$x] = $vereine[$y];
		$y++;
		chomp $verein[$y];
		$datb[$x] = $vereine[$y];
		$aktiv{"$datb[$x]"} = 1;
		$y++;
		chomp $verein[$y];
		$datc[$x] = $vereine[$y];
	}
}
close(DQ2);

open( DO, "</tmdata/tmi/db/trainer.txt" );
while (<DO>) {
	$nummer = 0;
	( $nummer, $ve ) = split( /&/, $_ );
	chomp $ve;
	if ( $nummer != 0 ) {
		$tx++;
		$trainer[$nummer] = $ve;

		if ( $trainer[$nummer] eq "" ) {

		}
	}
}
close(DO);

open( SP, "</tmdata/tmi/db/spiele_old.txt" );
while (<SP>) {
	@alles = split( /#/, $_ );
	$zeilen[ $alles[0] ]++;
	$zeile[ $alles[0] ] = $zeile[ $alles[0] ] . '$' . $_;
	chomp $zeile[ $alles[0] ];
}
close(SP);

for ( $tr = 1 ; $tr <= $tx ; $tr++ ) {
	@lines = split( /\$/, $zeile[$tr] );

	for ( $ss = 1 ; $ss <= 9999 ; $ss++ ) {
		$sp_g[$ss]    = 0;
		$sp_tp_g[$ss] = 0;
		$sp_tm_g[$ss] = 0;
		$sp_qp_g[$ss] = 0;
		$sp_qm_g[$ss] = 0;
		$sp_s_g[$ss]  = 0;
		$sp_u_g[$ss]  = 0;
		$sp_n_g[$ss]  = 0;
		$sp_uu_g[$ss] = 0;
	}

	for ( $z = 1 ; $z <= $zeilen[$tr] ; $z++ ) {

		@comp = split( /&/, $lines[$z] );

		( $egal, $saison ) = split( /#/, $comp[0] );

		for ( $y = 1 ; $y <= 34 ; $y++ ) {
			@spiel = split( /#/, $comp[$y] );
			$ve = $spiel[0];

			if ( $ve ne "-" ) {

				$qu1 = $spiel[1];
				$qu2 = $spiel[2];

				$tora = 0;
				$torb = 0;

				if ( $qu1 > 14 )  { $tora = 1 }
				if ( $qu1 > 39 )  { $tora = 2 }
				if ( $qu1 > 59 )  { $tora = 3 }
				if ( $qu1 > 79 )  { $tora = 4 }
				if ( $qu1 > 104 ) { $tora = 5 }
				if ( $qu1 > 129 ) { $tora = 6 }
				if ( $qu1 > 154 ) { $tora = 7 }

				if ( $qu2 > 14 )  { $torb = 1 }
				if ( $qu2 > 39 )  { $torb = 2 }
				if ( $qu2 > 59 )  { $torb = 3 }
				if ( $qu2 > 79 )  { $torb = 4 }
				if ( $qu2 > 104 ) { $torb = 5 }
				if ( $qu2 > 129 ) { $torb = 6 }
				if ( $qu2 > 154 ) { $torb = 7 }

				if ( $tora == 0 ) { $grenze_a = 0 }
				if ( $tora == 1 ) { $grenze_a = 15 }
				if ( $tora == 2 ) { $grenze_a = 40 }
				if ( $tora == 3 ) { $grenze_a = 60 }
				if ( $tora == 4 ) { $grenze_a = 80 }
				if ( $tora == 5 ) { $grenze_a = 105 }
				if ( $tora == 6 ) { $grenze_a = 130 }
				if ( $tora == 7 ) { $grenze_a = 155 }

				if ( $tora > $torb )  { $sp_s_g[$saison]++ }
				if ( $tora == $torb ) { $sp_u_g[$saison]++ }
				if ( $tora < $torb )  { $sp_n_g[$saison]++ }

				if ( $saison == ($akt_saison) ) {
					if ( ( $y >= $ab1 ) and ( $y <= $ab2 ) ) {

						if ( $tora > $torb )  { $sp_s_g[9999]++ }
						if ( $tora == $torb ) { $sp_u_g[9999]++ }
						if ( $tora < $torb )  { $sp_n_g[9999]++ }

						$sp_tp_g[9999] = $sp_tp_g[9999] + $tora;
						$sp_tm_g[9999] = $sp_tm_g[9999] + $torb;

						$sp_qp_g[9999] = $sp_qp_g[9999] + $qu1;
						$sp_qm_g[9999] = $sp_qm_g[9999] + $qu2;

						$sp_uu_g[9999] = $sp_uu_g[9999] + $qu1 - $grenze_a;

						$sp_g[9999]++;

					}
				}

				$sp_tp_g[$saison] = $sp_tp_g[$saison] + $tora;
				$sp_tm_g[$saison] = $sp_tm_g[$saison] + $torb;

				$sp_qp_g[$saison] = $sp_qp_g[$saison] + $qu1;
				$sp_qm_g[$saison] = $sp_qm_g[$saison] + $qu2;

				$sp_uu_g[$saison] = $sp_uu_g[$saison] + $qu1 - $grenze_a;

				$sp_g[$saison]++;

				if ( $qu1 > $tip_g[$saison] ) { $tip_g[$saison] = $qu1 }

				chomp $spiel[3];

				if ( $spiel[3] eq "H" ) {
					$sp_h[$saison]++;

					if ( $tora > $torb )  { $sp_s_h[$saison]++ }
					if ( $tora == $torb ) { $sp_u_h[$saison]++ }
					if ( $tora < $torb )  { $sp_n_h[$saison]++ }

					$sp_tp_h[$saison] = $sp_tp_h[$saison] + $tora;
					$sp_tm_h[$saison] = $sp_tm_h[$saison] + $torb;

					$sp_qp_h[$saison] = $sp_qp_h[$saison] + $qu1;
					$sp_qm_h[$saison] = $sp_qm_h[$saison] + $qu2;

					if ( $qu1 > $tip_h[$saison] ) { $tip_h[$saison] = $qu1 }

				}

				if ( $spiel[3] eq "A" ) {
					$sp_a[$saison]++;
					if ( $tora > $torb )  { $sp_s_a[$saison]++ }
					if ( $tora == $torb ) { $sp_u_a[$saison]++ }
					if ( $tora < $torb )  { $sp_n_a[$saison]++ }

					$sp_tp_a[$saison] = $sp_tp_a[$saison] + $tora;
					$sp_tm_a[$saison] = $sp_tm_a[$saison] + $torb;

					$sp_qp_a[$saison] = $sp_qp_a[$saison] + $qu1;
					$sp_qm_a[$saison] = $sp_qm_a[$saison] + $qu2;

					if ( $qu1 > $tip_a[$saison] ) { $tip_a[$saison] = $qu1 }
				}
			}

		}

	}

	if   ( $aktiv{"$trainer[$tr]"} == 1 ) { $go = 1 }
	else                                  { $go = 0 }
	$go = 1;

	for ( $d = 1 ; $d <= $akt_saison ; $d++ ) {
		$kk = $kk + $sp_g[$d];
	}

	if ( $trainer[$tr] ne "Trainerposten frei" ) {
		if ( $go == 1 ) {
			if ( $kk > 0 ) {

				print ALL "$trainer[$tr]&$go";

				# SAISON - AWARDS ################################

				for ( $ss = 1 ; $ss <= $akt_saison ; $ss++ ) {
					if ( $sp_g[$ss] > 0 ) {

						$qq = "D" . $ss;

						$pu = 0;
						$pu = ( $sp_s_g[$ss] * 3 ) + $sp_u_g[$ss];

						$oo = 0;
						$qp = int( ( $sp_qp_g[$ss] / $sp_g[$ss] ) * 100 ) / 100;
						$xx = "11";
						( $yy, $xx ) = split( /\./, $qp );
						$oo = length($xx);
						if ( $oo == 1 ) { $qp = $qp . '0' }
						if ( $oo == 0 ) { $qp = $qp . '.00' }

						$oo = 0;
						$qm = int( ( $sp_qm_g[$ss] / $sp_g[$ss] ) * 100 ) / 100;
						$xx = "11";
						( $yy, $xx ) = split( /\./, $qm );
						$oo = length($xx);

						if ( $oo == 1 ) { $qm = $qm . '0' }
						if ( $oo == 0 ) { $qm = $qm . '.00' }

						$oo = 0;
						$op = int( ( $sp_uu_g[$ss] / $sp_g[$ss] ) * 1000 ) / 1000;
						$xx = "111";
						( $yy, $xx ) = split( /\./, $op );
						$oo = length($xx);
						if ( $oo == 2 ) { $op = $op . '0' }
						if ( $oo == 1 ) { $op = $op . '00' }
						if ( $oo == 0 ) { $op = $op . '.000' }

						if ( $pu < 10 ) { $pu = '0' . $pu }
						if ( $qp < 10 ) { $qp = '0' . $qp }

						#if ( $qp<100 ) { $qp='0'.$qp}
						if ( $qm < 10 ) { $qm = '0' . $qm }

						#if ( $qm<100 ) { $qm='0'.$qm}
						if ( $op < 10 ) { $op = '0' . $op }

						if ( $sp_tp_g[$ss] < 10 ) { $sp_tp_g[$ss] = '0' . $sp_tp_g[$ss] }
						if ( $sp_tm_g[$ss] < 10 ) { $sp_tm_g[$ss] = '0' . $sp_tm_g[$ss] }
						print $qq
"$trainer[$tr]&$sp_g[$ss]&$pu&$sp_s_g[$ss]&$sp_u_g[$ss]&$sp_n_g[$ss]&$sp_tp_g[$ss]&$sp_tm_g[$ss]&$qp&$qm&$op&\n";

					}
				}

##############################################################

				if ( $aktiv{"$trainer[$tr]"} == 1 ) {
					for ( $ss = 1 ; $ss <= $akt_saison ; $ss++ ) {
						print ALL
"&$sp_g[$ss]&$sp_s_g[$ss]&$sp_u_g[$ss]&$sp_n_g[$ss]&$sp_tp_g[$ss]&$sp_tm_g[$ss]&$sp_qp_g[$ss]&$sp_qm_g[$ss]&$sp_uu_g[$ss]";

						if ( $sp_g[$ss] > 0 ) {
							$qdp[$ss] = int( ( $sp_qp_g[$ss] / $sp_g[$ss] ) * 10 ) / 10;
						}

						$xx = "";
						$ka = int( $qdp[$ss] );
						if ( $ka == $qdp[$ss] ) { $qdp[$ss] = $qdp[$ss] . ".0" }

						$sp_g[8888]    = $sp_g[8888] + $sp_g[$ss];
						$sp_s_g[8888]  = $sp_s_g[8888] + $sp_s_g[$ss];
						$sp_u_g[8888]  = $sp_u_g[8888] + $sp_u_g[$ss];
						$sp_n_g[8888]  = $sp_n_g[8888] + $sp_n_g[$ss];
						$sp_tp_g[8888] = $sp_tp_g[8888] + $sp_tp_g[$ss];
						$sp_tm_g[8888] = $sp_tm_g[8888] + $sp_tm_g[$ss];
						$sp_qp_g[8888] = $sp_qp_g[8888] + $sp_qp_g[$ss];
						$sp_qm_g[8888] = $sp_qm_g[8888] + $sp_qm_g[$ss];
						$sp_uu_g[8888] = $sp_uu_g[8888] + $sp_uu_g[$ss];
					}

					print ALL
"&$sp_g[9999]&$sp_s_g[9999]&$sp_u_g[9999]&$sp_n_g[9999]&$sp_tp_g[9999]&$sp_tm_g[9999]&$sp_qp_g[9999]&$sp_qm_g[9999]&$sp_uu_g[9999]";

					# Gesamt - Ranking
					if ( $sp_g[8888] > 0 ) {
						$qpd = int( ( $sp_qp_g[8888] / $sp_g[8888] ) * 10 ) / 10;
						$qmd = int( ( $sp_qm_g[8888] / $sp_g[8888] ) * 10 ) / 10;
					}
					$xx = "";
					$xy = "";
					$ka = int($qpd);
					$kb = int($qmd);
					if ( $ka == $qpd ) { $xx = ".0" }
					if ( $kb == $qmd ) { $xy = ".0" }

					$pu = ( $sp_s_g[8888] * 3 ) + $sp_u_g[8888];
					$pu_old = $pu - ( ( $sp_s_g[9999] * 3 ) + $sp_u_g[9999] );
					if ( $pu < 1000 ) { $pu = '0' . $pu }

					if ( $pu < 100 )      { $pu     = '0' . $pu }
					if ( $pu < 10 )       { $pu     = '0' . $pu }
					if ( $pu_old < 1000 ) { $pu_old = '0' . $pu_old }

					if ( $pu_old < 100 ) { $pu_old = '0' . $pu_old }
					if ( $pu_old < 10 )  { $pu_old = '0' . $pu_old }

					print S1
"$trainer[$tr]&$sp_g[8888]&$sp_s_g[8888]&$sp_u_g[8888]&$sp_n_g[8888]&$sp_tp_g[8888]&$sp_tm_g[8888]&$qpd$xx&$qmd$xy&$pu&$pu_old&\n";
					print S6
"$trainer[$tr]&$sp_g[8888]&$sp_g[9999]&$sp_s_g[8888]&$sp_s_g[9999]&$sp_u_g[8888]&$sp_u_g[9999]&$sp_n_g[8888]&$sp_tp_g[8888]&$sp_tm_g[8888]&$qpd$xx&$qmd$xy&$pu&$pu_old&\n";

					# Quoten - Ranking

					$qp_old = $sp_qp_g[8888] - $sp_qp_g[9999];

					for ( $nn = 1 ; $nn <= ( $akt_saison - 1 ) ; $nn++ ) {
						if ( $sp_g[$nn] > 0 ) {
							$qqq[$nn] = int( ( $sp_qp_g[$nn] / $sp_g[$nn] ) * 10 ) / 10;
							if ( int( $qqq[$nn] ) == $qqq[$nn] ) { $qqq[$nn] = $qqq[$nn] . '.0' }
							if ( $sp_g[$nn] < 20 ) { $qqq[$nn] = "---" }
						}
						if ( $sp_g[$nn] == 0 ) { $qqq[$nn] = "---" }
					}

					print S2 "$trainer[$tr]&$sp_g[8888]&$sp_g[9999]&$sp_qp_g[8888]&$sp_qm_g[8888]&$sp_qp_g[9999]&";

					for ( $d = $akt_saison - 6 ; $d <= $akt_saison - 1 ; $d++ ) {
						print S2 "$qqq[$d]&";
					}
					print S2 "\n";

					# ?berfl?ssig - Ranking

					$qp_old = $sp_qp_g[8888] - $sp_qp_g[9999];

					for ( $nn = 1 ; $nn <= ( $akt_saison - 1 ) ; $nn++ ) {
						if ( $sp_g[$nn] > 0 ) {
							$qqm[$nn] = int( ( $sp_uu_g[$nn] / $sp_g[$nn] ) * 100 ) / 100;

							$xx = "11";

							( $yy, $xx ) = split( /\./, $qqm[$nn] );
							$oo = length($xx);
							if ( $oo == 1 ) { $qqm[$nn] = $qqm[$nn] . '0' }
							if ( $oo == 0 ) { $qqm[$nn] = $qqm[$nn] . '.00' }

							if ( $sp_g[$nn] < 20 ) { $qqm[$nn] = "---" }
						}
						if ( $sp_g[$nn] == 0 ) { $qqm[$nn] = "---" }
					}

					print S3 "$trainer[$tr]&$sp_g[8888]&$sp_g[9999]&$sp_uu_g[8888]&$sp_uu_g[9999]&";

					for ( $d = $akt_saison - 6 ; $d <= $akt_saison - 1 ; $d++ ) {
						print S3 "$qqm[$d]&";
					}
					print S3 "\n";

					# Tore pro Spiel Ranking
					$qtp_old = $sp_tp_g[8888] - $sp_tp_g[9999];
					for ( $nn = 1 ; $nn <= $akt_saison - 1 ; $nn++ ) {
						if ( $sp_tp_g[$nn] > 0 ) {
							$qtp[$nn] = $sp_tp_g[$nn];
						}
						if ( $sp_g[$nn] == 0 ) { $qtp[$nn] = "---" }
					}
					print S5 "$trainer[$tr]&$sp_g[8888]&$sp_g[9999]&$sp_tp_g[8888]&$sp_tp_g[9999]&";
					for ( $d = $akt_saison - 6 ; $d <= $akt_saison - 1 ; $d++ ) {
						print S5 "$qtp[$d]&";
					}
					print S5 "\n";

					# Gegner Quoten - Ranking

					$qm_old = $sp_qm_g[8888] - $sp_qm_g[9999];

					for ( $nn = 1 ; $nn <= ( $akt_saison - 1 ) ; $nn++ ) {
						if ( $sp_g[$nn] > 0 ) {
							$qqo[$nn] = int( ( $sp_qm_g[$nn] / $sp_g[$nn] ) * 10 ) / 10;
							if ( int( $qqo[$nn] ) == $qqo[$nn] ) { $qqo[$nn] = $qqo[$nn] . '.0' }
							if ( $sp_g[$nn] < 20 ) { $qqo[$nn] = "---" }
						}
						if ( $sp_g[$nn] == 0 ) { $qqo[$nn] = "---" }
					}

					print S4 "$trainer[$tr]&$sp_g[8888]&$sp_g[9999]&$sp_qm_g[8888]&$sp_qp_g[8888]&$sp_qm_g[9999]&";

					for ( $d = $akt_saison - 6 ; $d <= $akt_saison - 1 ; $d++ ) {
						print S4 "$qqo[$d]&";
					}
					print S4 "\n";

					print ALL "\n";
				}
			}
		}
	}

	if ( $aktiv{"$trainer[$tr]"} == 1 ) {
		if ( $kk > 0 ) {

			$ff_1 = "0.0";
			$ff_2 = "0.0";
			$ff_3 = "0.0";
			#
			#if ($sp_g[$akt_saison-3] > 0 ) {
			#$xy =  int($sp_qp_g[$akt_saison-3] /  $sp_g[$akt_saison-3]) ;
			#$ff_1 = int ( ( $sp_qp_g[$akt_saison-3] /  $sp_g[$akt_saison-3] ) * 10 ) / 10 ;
			#if ($ff_1 == $xy ) { $ff_1 = $ff_1 . '.0' }
			#}

			#if ($sp_g[$akt_saison-2] > 0 ) {
			#$xy =  int($sp_qp_g[$akt_saison-2] /  $sp_g[$akt_saison-2]) ;
			#$ff_2 = int ( ( $sp_qp_g[$akt_saison-2] /  $sp_g[$akt_saison-2] ) * 10 ) / 10 ;
			#if ($ff_2 == $xy ) { $ff_2 = $ff_2 . '.0' }
			#}

			#if ($sp_g[$akt_saison-1] > 0 ) {
			#$xy =  int($sp_qp_g[$akt_saison-1] /  $sp_g[$akt_saison-1]) ;
			#$ff_3 = int ( ( $sp_qp_g[$akt_saison-1] /  $sp_g[$akt_saison-1] ) * 10 ) / 10 ;
			#if ($ff_3 == $xy ) { $ff_3 = $ff_3 . '.0' }
			#}

			$ff_1 = $sp_tp_g[ $akt_saison - 3 ] * 1;
			$ff_2 = $sp_tp_g[ $akt_saison - 2 ] * 1;
			$ff_3 = $sp_tp_g[ $akt_saison - 1 ] * 1;

			print DLL "$trainer[$tr]&$ff_1&$sp_g[$akt_saison-3]&$ff_2&$sp_g[$akt_saison-2]&$ff_3&$sp_g[$akt_saison-1]&"
			  ;

			print DLL "\n";

		}
	}

}

close(DLL);
close(ALL);
close(S1);
close(S2);
close(S3);
close(S4);

close(S5);
close(S6);

for ( $d = 1 ; $d <= $akt_saison ; $d++ ) {
	$dd = "D" . $d;
	close($dd);
}

`perl /tmapp/tmsrc/cronjobs/tmi/seasonchange/award_readout.pl &`;
`perl /tmapp/tmsrc/cronjobs/tmi/db/chart.pl &`;

