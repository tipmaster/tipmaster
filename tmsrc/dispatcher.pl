#!/opt/ActivePerl-5.24/bin/perl

package Dispatcher;
use lib '/livescore/trunk/res/www/cgi-bin/';
use lib '/livescore/trunk/res/www/cgi-bin/lib';
use CGI::Fast ( -utf8 );
use utf8;

while ( my $q = new CGI::Fast ) {

	eval {
		binmode( STDOUT, ":utf8" );

		#require '/tipmaster/tmsrc/cgi-mod/index.pl';
		print "Content-type: text/html\n\n";
		foreach ( keys %ENV ) {
			#print $_. " > " . $ENV{$_} . "<br/>";
		}
		print $$;

		require $ENV{SCRIPT_FILENAME};
	};
	if ($@) {
			print "Content-type: text/html\n\n";
			print $@;
	}
}

1;
