#! /usr/bin/perl

require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl";
require "/tmapp/tmsrc/cgi-bin/tmi/saison.pl";

# Konfiguration (Verzeichnisse etc.)
my $verz = "/tmapp/tmsrc/cronjobs/tmi/seasonchange";
my $data = "/tmdata/cl/";

# Variablen,Konstanten etc.

# open the target file
open( KK, ">$verz/ec_erfolge_cur.txt" ) or die "Cannot write to EC data file: $!";

print "Lese aus Saison $main_kuerzel[$main_nr] ...\n";

my %uefaid2verein = ();
my %clid2verein   = ();
my %uefa_last     = ();
my %cl_last       = ();

# Erst mal die Vereinsnummern einlesen
&readIDs($saison);

# Jetzt ueber die Datenfiles loopen und den letzten Stand merken.
for ( my $rundennr = 1 ; $rundennr <= 9 ; $rundennr++ ) {
	&scrutinize( $saison, $rundennr );
}

# Ergebnisse rausschreiben
&writeResults($saison);

close(KK);

# Fertich!
exit 0;

########## Subroutines ##############

sub readIDs {
	my $saison   = shift;
	my $filename = "$data/UEFA_ID.dat";

	#  open(K,"<$filename") or die "Cannot open UEFA data file $filename: $!";
	open( K, "<$filename" );

	while (<K>) {
		chomp;
		if ( $_ =~ /^(\d*)&.*?&(.*)$/ ) {
			my $id     = $1;
			my $verein = $2;
			$uefaid2verein{"$id"} = $verein;
		}
	}
	close(K);

	my $filename = "$data/ID.dat";

	#  open(K,"<$filename") or die "Cannot open CL data file $filename: $!";
	open( K, "<$filename" );

	while (<K>) {
		chomp;
		if ( $_ =~ /^(\d*)&.*?&(.*)$/ ) {
			my $id     = $1;
			my $verein = $2;
			$clid2verein{"$id"} = $verein;
		}
	}
	close(K);
}

sub scrutinize {
	my $saison  = shift;
	my $roundnr = shift;

	# Leider war in den ersten 2 Saisons die Rundenfolge anders...
	my @ids = ( undef, "Q1", "Q2", "Q3", "G1", "G2", "AC", "VI", "HA", "FI" );

	my %runden = ( 1, "Q1", 2, "Q2", 3, "Q3", 4, "G1", 5, "G2", 6, "AC", 7, "VI", 8, "HA", 9, "FI" );
	if ( $saison == 13 ) {
		%runden = ( 1, "Q1", 2, "Q1", 3, "Q2", 4, "G1", 5, "G2", 6, "AC", 7, "VI", 8, "HA", 9, "FI" );
	}
	elsif ( $saison == 14 ) {
		%runden = ( 1, "Q1", 2, "Q2", 3, "G1", 4, "G2", 5, "G3", 6, "AC", 7, "VI", 8, "HA", 9, "FI" );
	}

	my $round = $runden{$roundnr};

	#print "Roundnr is $roundnr, Round is $round\n";
	# CL Files

	$filename = "$data/DATA_$round.DAT";

	#  open(K,"<$filename") or die "Cannot open CL data file $filename: $!";
	open( K, "<$filename" );
	while (<K>) {
		chomp;
		if ( $round =~ /G\d/ ) {

			# CL Group Phase Format
			( undef, undef, my $id1, undef ) = split( /&/, $_ );
			$cl_last{"$id1"} = "G2";
		}
		elsif ( $round eq "FI" ) {

			# Finale - Get winner
			( undef, my $id1, my $id2, my $result, undef ) = split( /&/, $_ );
			( my $p1, my $p2 ) = split( /:/, $result );

			# Quick Fix tp / see final 2005/4
			# if ($p1>$p2) {
			if ( $p1 >= $p2 ) {
				$cl_last{"$id1"} = "CH";
				$cl_last{"$id2"} = "FI";
			}
			else {
				$cl_last{"$id2"} = "CH";
				$cl_last{"$id1"} = "FI";
			}
		}
		else {
			# Standard Format
			( undef, my $id1, my $id2, undef ) = split( /&/, $_ );
			$cl_last{"$id1"} = $ids[$roundnr];
			$cl_last{"$id2"} = $ids[$roundnr];
		}
	}
	close(K);

# UEFA Files
#  open(K,"<$data/$main_kuerzel[$saison]/UEFA_$round.DAT") or die "<$data/$main_kuerzel[$saison]/UEFA_$round.DAT Cannot open UEFA data file: $!";

	open( K, "<$data/UEFA_$round.DAT" );
	while (<K>) {
		chomp;
		if ( $round eq "FI" ) {

			# Finale - Get winner
			( undef, my $id1, my $id2, my $result, undef ) = split( /&/, $_ );
			( my $p1, my $p2 ) = split( /:/, $result );
			if ( $p1 > $p2 ) {
				$uefa_last{"$id1"} = "CH";
				$uefa_last{"$id2"} = "FI";
			}
			else {
				$uefa_last{"$id2"} = "CH";
				$uefa_last{"$id1"} = "FI";
			}
		}
		else {
			# Standard Format
			( undef, my $id1, my $id2, undef ) = split( /&/, $_ );
			$uefa_last{"$id1"} = $ids[$roundnr];
			$uefa_last{"$id2"} = $ids[$roundnr];
		}
	}
	close(K);
}

sub writeResults {
	my $current_round = shift;
	foreach $a_key ( keys %clid2verein ) {
		print KK $current_round, "#", $clid2verein{"$a_key"}, "#C#", $cl_last{"$a_key"}, "#\n";
	}
	foreach $a_key ( keys %uefaid2verein ) {
		print KK $current_round, "#", $uefaid2verein{"$a_key"}, "#U#", $uefa_last{"$a_key"}, "#\n";
	}
}

