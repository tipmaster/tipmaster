#!/usr/bin/perl

require "/tmapp/tmsrc/cgi-bin/runde.pl";

if ( $cup_tmi_aktiv != 1 ) { exit }

srand();

print "Content-type:text/html\n\n";
print "<font face=verdana size=1>";
require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl";

open( D, "/tmdata/blanko.txt" );
while (<D>) {
	( $tr, $dat1, $pro ) = split( /&/, $_ );
	chomp $pro;
	$blanko{$tr} = $pro;
}
close(D);

$y    = 0;
$rr   = 0;
$li   = 0;
$liga = 0;
open( D2, "/tmdata/tmi/history.txt" );
while (<D2>) {

	$li++;
	@vereine = split( /&/, $_ );

	$y = 0;
	for ( $x = 1 ; $x < 19 ; $x++ ) {

		$rr++;
		$y++;
		chomp $verein[$y];
		$team[$rr] = $vereine[$y];

		$y++;
		chomp $verein[$y];
		$verein_trainer[$rr] = $vereine[$y];

		if ( $verein_trainer[$rr] eq $trainer ) {
			$trainer_verein = $team[$rr];
			$trainer_id = ( ( $li - 1 ) * 18 ) + $x;
		}

		$coach{ $team[$rr] } = $verein_trainer[$rr];
		$verein_liga[$rr]    = $li;
		$verein_nr[$rr]      = $x;
		$y++;
	}

}
close(D2);

$pokal_id  = 0;
$pokal_dfb = 0;

$runde = $cup_tmi;

for ( $pokal = 1 ; $pokal <= 49 ; $pokal++ ) {

	if ( $runde == 1 ) {

		$suche = '#' . $pokal . '-' . $runde . '&';

		open( D2, "/tmdata/tmi/pokal/pokal.txt" );
		while (<D2>) {

			if ( $_ =~ /$suche/ ) {
				@ega = split( /&/, $_ );
			}

			$rsuche = '&' . $trainer_id . '&';

			if ( $_ =~ /$rsuche/ ) {
				( $pokal_id, $rest ) = split( /&/, $_ );
			}

		}
		close(D2);

		open( D2, "/tmdata/tmi/pokal/pokal_quote.txt" );
		while (<D2>) {

			if ( $_ =~ /$suche/ ) {
				@quote = split( /&/, $_ );
			}
		}
		close(D2);

	}

	open( D2, "/tmdata/tmi/heer.txt" );
	while (<D2>) {
		@egx = split( /&/, $_ );
		$plazierung{"$egx[5]"} = $egx[0];
		$liga{"$egx[5]"}       = $egx[2];
	}
	close(D2);

	if ( $runde > 1 ) {

		$suche = '#' . $pokal . '-1&';

		open( D2, "/tmdata/tmi/pokal/pokal.txt" );
		while (<D2>) {
			if ( $_ =~ /$suche/ ) {
				@egb = split( /&/, $_ );
			}
		}
		close(D2);

		open( D2, "/tmdata/tmi/pokal/pokal_quote.txt" );
		while (<D2>) {
			if ( $_ =~ /$suche/ ) {
				@quote1 = split( /&/, $_ );
			}
		}
		close(D2);

		$c = 0;
		for ( $a = 1 ; $a <= 32 ; $a = $a + 2 ) {
			$b = $a + 1;
			$c++;

			if ( $quote1[$a] == $quote1[$b] ) { $egy[$c] = $egb[$b] }
			if ( $quote1[$a] > $quote1[$b] )  { $egy[$c] = $egb[$a] }
			if ( $quote1[$a] < $quote1[$b] )  { $egy[$c] = $egb[$b] }

			if ( $egb[$b] == 9999 ) { $egy[$c] = $egb[$a] }

		}

		if ( $runde == 2 ) {

			$suche = '#' . $pokal . '-2&';
			open( D2, "/tmdata/tmi/pokal/pokal_quote.txt" );
			while (<D2>) {
				if ( $_ =~ /$suche/ ) {
					@quote = split( /&/, $_ );
				}
			}
			close(D2);
			@ega = @egy;
		}

		if ( $runde > 2 ) {

			$suche = '#' . $pokal . '-2&';
			open( D2, "/tmdata/tmi/pokal/pokal_quote.txt" );
			while (<D2>) {
				if ( $_ =~ /$suche/ ) {
					@quote2 = split( /&/, $_ );
				}
			}
			close(D2);

			$c = 0;
			for ( $a = 1 ; $a <= 16 ; $a = $a + 2 ) {
				$b = $a + 1;
				$c++;

				if ( $quote2[$a] == $quote2[$b] ) { $egx[$c] = $egy[$b] }
				if ( $quote2[$a] > $quote2[$b] )  { $egx[$c] = $egy[$a] }
				if ( $quote2[$a] < $quote2[$b] )  { $egx[$c] = $egy[$b] }

			}

		}

		if ( $runde == 3 ) {

			$suche = '#' . $pokal . '-3&';
			open( D2, "/tmdata/tmi/pokal/pokal_quote.txt" );
			while (<D2>) {
				if ( $_ =~ /$suche/ ) {
					@quote = split( /&/, $_ );
				}
			}
			close(D2);
			@ega = @egx;
		}

		if ( $runde > 3 ) {

			$suche = '#' . $pokal . '-3&';
			open( D2, "/tmdata/tmi/pokal/pokal_quote.txt" );
			while (<D2>) {
				if ( $_ =~ /$suche/ ) {
					@quote3 = split( /&/, $_ );
				}
			}
			close(D2);

			$c = 0;
			for ( $a = 1 ; $a <= 8 ; $a = $a + 2 ) {
				$b = $a + 1;
				$c++;

				if ( $quote3[$a] == $quote3[$b] ) { $egw[$c] = $egx[$b] }
				if ( $quote3[$a] > $quote3[$b] )  { $egw[$c] = $egx[$a] }
				if ( $quote3[$a] < $quote3[$b] )  { $egw[$c] = $egx[$b] }
			}

		}

		if ( $runde == 4 ) {

			$suche = '#' . $pokal . '-4&';
			open( D2, "/tmdata/tmi/pokal/pokal_quote.txt" );
			while (<D2>) {
				if ( $_ =~ /$suche/ ) {
					@quote = split( /&/, $_ );
				}
			}
			close(D2);
			@ega = @egw;
		}

		if ( $runde > 4 ) {

			$suche = '#' . $pokal . '-4&';
			open( D2, "/tmdata/tmi/pokal/pokal_quote.txt" );
			while (<D2>) {
				if ( $_ =~ /$suche/ ) {
					@quote4 = split( /&/, $_ );
				}
			}
			close(D2);

			$c = 0;
			for ( $a = 1 ; $a <= 4 ; $a = $a + 2 ) {
				$b = $a + 1;
				$c++;

				if ( $quote4[$a] == $quote4[$b] ) { $egv[$c] = $egw[$b] }
				if ( $quote4[$a] > $quote4[$b] )  { $egv[$c] = $egw[$a] }
				if ( $quote4[$a] < $quote4[$b] )  { $egv[$c] = $egw[$b] }
			}

		}

		if ( $runde == 5 ) {

			$suche = '#' . $pokal . '-5&';
			open( D2, "/tmdata/tmi/pokal/pokal_quote.txt" );
			while (<D2>) {
				if ( $_ =~ /$suche/ ) {
					@quote = split( /&/, $_ );
				}
			}
			close(D2);
			@ega = @egv;
		}

	}

	if ( $runde == 1 ) { $aa = 32 }
	if ( $runde == 2 ) { $aa = 16 }
	if ( $runde == 3 ) { $aa = 8 }
	if ( $runde == 4 ) { $aa = 4 }
	if ( $runde == 5 ) { $aa = 2 }

	$d = 0;
	for ( $y = 1 ; $y <= $aa ; $y++ ) {
		$d++;
		if ( $d == 3 ) { $d = 1 }

		if ( $d == 1 )     { $gegner_if = $ega[ $y + 1 ] }
		if ( $d == 2 )     { $gegner_if = $ega[ $y - 1 ] }
		if ( $d == 1 )     { $ort       = "Heimspiel" }
		if ( $d == 2 )     { $ort       = "Auswaertsspiel" }
		if ( $runde == 5 ) { $ort       = "neutraler Platz" }

		$xx = "";
		if ( $ega[$y] < 1000 ) { $xx = "0" }
		if ( $ega[$y] < 100 )  { $xx = "00" }
		if ( $ega[$y] < 10 )   { $xx = "000" }

		$tip_datei = $xx . $ega[$y] . '-' . $pokal . '-' . $runde . '.txt';
		$tip_datei = '/tmdata/tmi/pokal/tips/' . $tip_datei;

		for ( $r = 0 ; $r <= 9 ; $r++ ) {
			$tips[$r] = "0&0";
		}

		@teams = @team;

		$verein = $team[ $ega[$y] ];

		if ( ( $liga{$verein} == 1 ) and ( $liga{ $teams[$gegner_if] } == 1 ) and ( $ort eq "Heimspiel" ) ) {
			( $tips = 5 ) and ( $tips_g = 4 );
		}
		if ( ( $liga{$verein} == 1 ) and ( $liga{ $teams[$gegner_if] } == 1 ) and ( $ort eq "Auswaertsspiel" ) ) {
			( $tips = 4 ) and ( $tips_g = 5 );
		}
		if ( ( $liga{$verein} == 1 ) and ( $liga{ $teams[$gegner_if] } == 1 ) and ( $ort eq "neutraler Platz" ) ) {
			( $tips = 5 ) and ( $tips_g = 5 );
		}

		if ( ( $liga{$verein} == 2 ) and ( $liga{ $teams[$gegner_if] } == 2 ) and ( $ort eq "Heimspiel" ) ) {
			( $tips = 5 ) and ( $tips_g = 4 );
		}
		if ( ( $liga{$verein} == 2 ) and ( $liga{ $teams[$gegner_if] } == 2 ) and ( $ort eq "Auswaertsspiel" ) ) {
			( $tips = 4 ) and ( $tips_g = 5 );
		}
		if ( ( $liga{$verein} == 2 ) and ( $liga{ $teams[$gegner_if] } == 2 ) and ( $ort eq "neutraler Platz" ) ) {
			( $tips = 5 ) and ( $tips_g = 5 );
		}

		if ( ( $liga{$verein} == 3 ) and ( $liga{ $teams[$gegner_if] } == 3 ) and ( $ort eq "Heimspiel" ) ) {
			( $tips = 5 ) and ( $tips_g = 4 );
		}
		if ( ( $liga{$verein} == 3 ) and ( $liga{ $teams[$gegner_if] } == 3 ) and ( $ort eq "Auswaertsspiel" ) ) {
			( $tips = 4 ) and ( $tips_g = 5 );
		}
		if ( ( $liga{$verein} == 3 ) and ( $liga{ $teams[$gegner_if] } == 3 ) and ( $ort eq "neutraler Platz" ) ) {
			( $tips = 5 ) and ( $tips_g = 5 );
		}

		if ( ( $liga{$verein} == 1 ) and ( $liga{ $teams[$gegner_if] } == 3 ) and ( $ort eq "Heimspiel" ) ) {
			( $tips = 5 ) and ( $tips_g = 3 );
		}
		if ( ( $liga{$verein} == 1 ) and ( $liga{ $teams[$gegner_if] } == 3 ) and ( $ort eq "Auswaertsspiel" ) ) {
			( $tips = 5 ) and ( $tips_g = 3 );
		}
		if ( ( $liga{$verein} == 1 ) and ( $liga{ $teams[$gegner_if] } == 3 ) and ( $ort eq "neutraler Platz" ) ) {
			( $tips = 5 ) and ( $tips_g = 3 );
		}

		if ( ( $liga{$verein} == 3 ) and ( $liga{ $teams[$gegner_if] } == 1 ) and ( $ort eq "Heimspiel" ) ) {
			( $tips = 3 ) and ( $tips_g = 5 );
		}
		if ( ( $liga{$verein} == 3 ) and ( $liga{ $teams[$gegner_if] } == 1 ) and ( $ort eq "Auswaertsspiel" ) ) {
			( $tips = 3 ) and ( $tips_g = 5 );
		}
		if ( ( $liga{$verein} == 3 ) and ( $liga{ $teams[$gegner_if] } == 1 ) and ( $ort eq "neutraler Platz" ) ) {
			( $tips = 3 ) and ( $tips_g = 5 );
		}

		if ( ( $liga{$verein} == 1 ) and ( $liga{ $teams[$gegner_if] } == 2 ) and ( $ort eq "Heimspiel" ) ) {
			( $tips = 5 ) and ( $tips_g = 3 );
		}
		if ( ( $liga{$verein} == 1 ) and ( $liga{ $teams[$gegner_if] } == 2 ) and ( $ort eq "Auswaertsspiel" ) ) {
			( $tips = 5 ) and ( $tips_g = 4 );
		}
		if ( ( $liga{$verein} == 1 ) and ( $liga{ $teams[$gegner_if] } == 2 ) and ( $ort eq "neutraler Platz" ) ) {
			( $tips = 5 ) and ( $tips_g = 4 );
		}

		if ( ( $liga{$verein} == 2 ) and ( $liga{ $teams[$gegner_if] } == 1 ) and ( $ort eq "Heimspiel" ) ) {
			( $tips = 4 ) and ( $tips_g = 5 );
		}
		if ( ( $liga{$verein} == 2 ) and ( $liga{ $teams[$gegner_if] } == 1 ) and ( $ort eq "Auswaertsspiel" ) ) {
			( $tips = 3 ) and ( $tips_g = 5 );
		}
		if ( ( $liga{$verein} == 2 ) and ( $liga{ $teams[$gegner_if] } == 1 ) and ( $ort eq "neutraler Platz" ) ) {
			( $tips = 4 ) and ( $tips_g = 5 );
		}

		if ( ( $liga{$verein} == 2 ) and ( $liga{ $teams[$gegner_if] } == 3 ) and ( $ort eq "Heimspiel" ) ) {
			( $tips = 5 ) and ( $tips_g = 3 );
		}
		if ( ( $liga{$verein} == 2 ) and ( $liga{ $teams[$gegner_if] } == 3 ) and ( $ort eq "Auswaertsspiel" ) ) {
			( $tips = 5 ) and ( $tips_g = 4 );
		}
		if ( ( $liga{$verein} == 2 ) and ( $liga{ $teams[$gegner_if] } == 3 ) and ( $ort eq "neutraler Platz" ) ) {
			( $tips = 5 ) and ( $tips_g = 4 );
		}

		if ( ( $liga{$verein} == 3 ) and ( $liga{ $teams[$gegner_if] } == 2 ) and ( $ort eq "Heimspiel" ) ) {
			( $tips = 4 ) and ( $tips_g = 5 );
		}
		if ( ( $liga{$verein} == 3 ) and ( $liga{ $teams[$gegner_if] } == 2 ) and ( $ort eq "Auswaertsspiel" ) ) {
			( $tips = 3 ) and ( $tips_g = 5 );
		}
		if ( ( $liga{$verein} == 3 ) and ( $liga{ $teams[$gegner_if] } == 2 ) and ( $ort eq "neutraler Platz" ) ) {
			( $tips = 4 ) and ( $tips_g = 5 );
		}

		$ole = $tips;

		$ein = 1;
		if ( -e "$tip_datei" ) { $ein = 1 }

		print "$tip_datei $ein $ole $liga{$teams[$gegner_if]}  ";

		if ( $verein_trainer[ $ega[$y] ] eq "Trainerposten frei" ) {
			#deactivate tipps for free teams 
			if (0) {
				if ( $ein == 0 ) {

					for ( $r = 0 ; $r <= $ole - 1 ; $r++ ) {
						$ac = int( 3 * rand ) + 1;
						$tips[$r] = "1&" . $ac;
					}

					open( FF, ">$tip_datei" );
					for ( $r = 0 ; $r <= 9 ; $r++ ) {
						print FF "$tips[$r].";
					}
					print FF "\n";
					close(FF);

				}
			}
		}

		if ( $ein == 0 ) {

			if ( $blanko{ $verein_trainer[ $ega[$y] ] } > 0 ) {

				print " BLANKO ";

				for ( $r = 0 ; $r <= $ole - 1 ; $r++ ) {
					$zpro = int( 3 * rand ) + 1;
					$tips[$r] = "1&" . $zpro;
				}

				open( FF, ">$tip_datei" );
				for ( $r = 0 ; $r <= 9 ; $r++ ) {
					print FF "$tips[$r].";
				}
				print FF "\n";
				close(FF);
			}
		}

		#print "$tip_datei $ein ";
		open( D, "$tip_datei" );
		while (<D>) {
			@tips = split( /\./, $_ );
		}
		close(D);

		for ( $r = 0 ; $r <= 9 ; $r++ ) {
			print "$tips[$r]  ";
		}
		print "$team[$ega[$y]] / $verein_trainer[$ega[$y]]<br>\n";

	}

}

exit;

