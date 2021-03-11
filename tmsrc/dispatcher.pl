#!/opt/ActivePerl-5.24/bin/perl

package Dispatcher;
use lib '/livescore/trunk/res/www/cgi-bin/';
use lib '/livescore/trunk/res/www/cgi-bin/lib';
use CGI::Fast ( -utf8 );
use utf8;

while ( my $q = new CGI::Fast ) {
	binmode( STDOUT, ":utf8" );
	require '/tipmaster/tmsrc/cgi-mod/index.pl';
}

1;
