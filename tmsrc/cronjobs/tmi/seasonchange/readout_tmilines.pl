print "my \@off=(";
open( D, "/tmapp/tmstatic/www/offensiv_ranking.html" );
while (<D>) {
	if ( $_ =~ /\(/ ) {
		@all = split( /<b>/, $_ );
		@all = split( /</,   $all[1] );
		$pl++;
		if ( $pl < 12 ) {
			print "\"$all[0] I\", ";
		}
	}
}
close(D);

$pl = 0;
print ");\nmy \@uefa=(";
open( D, "/tmapp/tmstatic/www/uefa_ranking.html" );
while (<D>) {
	if ( $_ =~ /\(/ ) {
		@all = split( /<b>/, $_ );
		@all = split( /</,   $all[1] );
		$pl++;
		if ( $pl < 12 ) {
			print "\"$all[0] I\", ";
		}
	}
}
close(D);

print ")\n";
