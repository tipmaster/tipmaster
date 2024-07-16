#!/usr/bin/perl

=head1 NAME
	TMLogger.pm

=head1 SYNOPSIS
	Log componente fuer den TM
	


=head1 CHANGELOG
	2015-06-09 Thomas: Added Session Management


	Created 2015-06-09

=cut

package TMLogger;

chdir("/tmdata");
use lib '/tmapp/tmsrc/cgi-bin/';
use lib '/tmapp/tmsrc/cgi-mod/';

use TMLogger;

sub log {
	my $msg = shift;
	open( A, ">>/tmdata/debug.log" );
	print A $msg . "\n";
	close(A);
	return;

}

1;
