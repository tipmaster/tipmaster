#!/usr/bin/perl

=head1 NAME
	TMConfig.pm

=head1 SYNOPSIS
	TM Config
	
=head1 Author
	Thomas (thomas@socapro.com)

=head1 COPYRIGHT
	Copyright SocaPro Inc
	Created Jun 15, 2015
	
=cut

package TMConfig;

use lib '/tmapp/tmsrc/cgi-bin/';
use lib '/tmapp/tmsrc/cgi-mod/';

our $FILE_PATH_PASS = "/tmdata/hashedPasswords.txt";