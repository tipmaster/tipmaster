use GD::Graph::bars;
use GD::Graph::colour;
use GD::Graph::lines;

require '/tmapp/tmsrc/cronjobs/btm/seasonchange/save.pl';
require "/tmapp/tmsrc/cgi-bin/runde.pl";
require "/tmapp/tmsrc/cgi-bin/btm/saison.pl";

`rm -rf /tmapp/tmstatic/www/img/chart/`;
`mkdir -p /tmapp/tmstatic/www/img/chart/`;

open( D2, "/tmdata/btm/history.txt" );
while (<D2>) {

	$li++;
	@vereine = split( /&/, $_ );

	$y = 0;
	for ( $x = 1 ; $x < 19 ; $x++ ) {
		$y++;
		chomp $verein[$y];

		#$data[$x] = $vereine[$y];
		$y++;
		chomp $verein[$y];
		$datb[$x] = $vereine[$y];
		if ( $datb[$x] ne "Trainerposten frei" ) {
			$tr++;
			$trainer[$tr] = $datb[$x];
		}

		$aktiv{"$datb[$x]"} = 1;
		$y++;
		chomp $verein[$y];
		$datc[$x] = $vereine[$y];
	}
}
close(D2);

for ( $xf = 1 ; $xf <= $tr ; $xf++ ) {
	$trainer = $trainer[$xf];
	$trainer =~ s/ /_/g;
	$coach = $trainer[$xf];

	$line = 0;
	open( D, "</tmdata/btm/trainer_db/ligawerte.txt" );
	while (<D>) {
		$line++;
		@ok = split( /&/, $_ );
		$linedb[ $ok[0] ] = $_;
	}
	close(D);

	$line = 0;
	open( D, "</tmdata/btm/trainer_db/$coach" );
	while (<D>) {
		$line++;
		$lineup[$line] = $_;
	}
	close(D);

	if ( $line > 0 ) {
		( $vn, $nn ) = split( / /, $coach );
		$coach = $nn;

		@data = ();
		$s    = 0;
		for ( $x = 1 ; $x <= $line ; $x++ ) {
			@all = split( /&/, $lineup[$x] );
			@db  = split( /&/, $linedb[ $all[0] ] );
			$data[0][ $x - 1 ] = $main_saison[ $all[0] + 5 ];
			$data[0][ $x - 1 ] =~ s/Saison 20//;
			$data[0][ $x - 1 ] =~ s/Saison 19//;
			$s++;
			if ( $s == 2 ) { $data[0][ $x - 1 ] = ""; $s = 0 }
			$data[1][ $x - 1 ] = $all[14];
			$data[2][ $x - 1 ] = $db[3];
		}

		$my_graph = new GD::Graph::lines( 320, 170 );

		$my_graph->set(
			x_label       => 'Saison',
			y_label       => 'Tipquote',
			title         => "Tipquote $coach",
			y_max_value   => 55,
			y_min_value   => 35,
			y_tick_number => 4,
			y_label_skip  => 1,
			x_label_skip  => 2,
			line_width    => 3,
			long_ticks    => 1,
			fgclr         => 'black',
			bgclr         => white,
			transparent   => 1,
		);

		$my_graph->set_legend( "Tipquote Trainer", 'Gesamtdurchschnitt' );
		$my_graph->plot( \@data );

		save_chart( $my_graph, "/tmapp/tmstatic/www/img/chart/$trainer-qu-$main_kuerzel[$main_nr]" );

		@data = ();
		$s    = 0;
		for ( $x = 1 ; $x <= $line ; $x++ ) {
			@all = split( /&/, $lineup[$x] );
			@db  = split( /&/, $linedb[ $all[0] ] );
			$data[0][ $x - 1 ] = $main_saison[ $all[0] + 5 ];
			$data[0][ $x - 1 ] =~ s/Saison 20//;
			$data[0][ $x - 1 ] =~ s/Saison 19//;
			$s++;
			if ( $s == 2 ) { $data[0][ $x - 1 ] = ""; $s = 0 }

			$data[1][ $x - 1 ] = $all[12];
			$data[2][ $x - 1 ] = $db[2];
		}

		$my_graph = new GD::Graph::lines( 320, 170 );

		$my_graph->set(
			x_label       => 'Saison',
			y_label       => 'Tipquote',
			title         => "Erzielte Tore $coach",
			y_max_value   => 80,
			y_min_value   => 40,
			y_tick_number => 4,
			y_label_skip  => 1,
			x_label_skip  => 2,
			line_width    => 3,
			long_ticks    => 1,
			fgclr         => 'black',
			bgclr         => white,
			transparent   => 1,
		);

		$my_graph->set_legend( "Erzielte Tore Trainer", 'Gesamtdurchschnitt' );
		$my_graph->plot( \@data );

		save_chart( $my_graph, "/tmapp/tmstatic/www/img/chart/$trainer-to-$main_kuerzel[$main_nr]" );

		@data = ();
		$s    = 0;
		for ( $x = 1 ; $x <= $line ; $x++ ) {
			@all = split( /&/, $lineup[$x] );
			@db  = split( /&/, $linedb[ $all[0] ] );
			$data[0][ $x - 1 ] = $main_saison[ $all[0] + 5 ];
			$data[0][ $x - 1 ] =~ s/Saison 20//;
			$data[0][ $x - 1 ] =~ s/Saison 19//;
			$s++;
			if ( $s == 2 ) { $data[0][ $x - 1 ] = ""; $s = 0 }

			$data[1][ $x - 1 ] = $all[16];
			$data[2][ $x - 1 ] = $db[4];
		}

		$my_graph = new GD::Graph::lines( 320, 170 );

		$my_graph->set(
			x_label       => 'Saison',
			y_label       => 'Optimizer Wert',
			title         => "Optimizer $coach",
			y_max_value   => 12,
			y_min_value   => 3,
			y_tick_number => 3,
			y_label_skip  => 1,
			x_label_skip  => 2,
			line_width    => 3,
			long_ticks    => 1,
			fgclr         => 'black',
			bgclr         => white,
			transparent   => 1,
		);

		$my_graph->set_legend( "Optimizer Wert Trainer", 'Gesamtdurchschnitt' );
		$my_graph->plot( \@data );

		save_chart( $my_graph, "/tmapp/tmstatic/www/img/chart/$trainer-op-$main_kuerzel[$main_nr]" );

		@data = ();
		$s    = 0;
		for ( $x = 1 ; $x <= $line ; $x++ ) {

			@all = split( /&/, $lineup[$x] );
			@db  = split( /&/, $linedb[ $all[0] ] );
			$data[0][ $x - 1 ] = $main_saison[ $all[0] + 5 ];

			$data[0][ $x - 1 ] =~ s/Saison 20//;
			$data[0][ $x - 1 ] =~ s/Saison 19//;

			$s++;
			if ( $s == 2 ) { $data[0][ $x - 1 ] = ""; $s = 0 }

			$data[1][ $x - 1 ] = $all[8];
			$data[2][ $x - 1 ] = $db[1];
		}

		$my_graph = new GD::Graph::lines( 320, 170 );

		$my_graph->set(
			x_label       => 'Saison',
			y_label       => 'Ligapunkte',
			title         => "Ligapunkte $coach",
			y_max_value   => 65,
			y_min_value   => 35,
			y_tick_number => 3,
			y_label_skip  => 1,
			x_label_skip  => 2,
			line_width    => 3,
			long_ticks    => 1,
			fgclr         => 'black',
			bgclr         => white,
			transparent   => 1,
		);

		$my_graph->set_legend( "Ligapunkte Trainer", 'Gesamtdurchschnitt' );
		$my_graph->plot( \@data );

		save_chart( $my_graph, "/tmapp/tmstatic/www/img/chart/$trainer-lp-$main_kuerzel[$main_nr]" );
		print "$coach\n";
	}
}
