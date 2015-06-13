#!/usr/bin/perl

=head1 NAME
	tag_small.pl

=head1 SYNOPSIS
	TBD
	
=head1 AUTHOR
	admin@socapro.com

=head1 CHANGELOG
	2015-06-09 Thomas: Added Session Management

=head1 COPYRIGHT
	Copyright (c) 2015, SocaPro Inc.
	Created 2015-06-09

=cut

use lib '/tmapp/tmsrc/cgi-bin/'; 
use TMSession;
my $session = TMSession::getSession();
my $trainer = $session->getUser();
my $leut = $trainer;

use CGI;

print '
<iframe id=\'acae648c\' name=\'acae648c\' src=\'http://advertising.fussball-liveticker.eu/www/delivery/afr.php?zoneid=85&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;ct0=INSERT_CLICKURL_HERE\' frameborder=\'0\' scrolling=\'no\' width=\'234\' height=\'60\'><a href=\'http://advertising.fussball-liveticker.eu/www/delivery/ck.php?n=a3108930&amp;cb=INSERT_RANDOM_NUMBER_HERE\' target=\'_blank\'><img src=\'http://advertising.fussball-liveticker.eu/www/delivery/avw.php?zoneid=85&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=a3108930&amp;ct0=INSERT_CLICKURL_HERE\' border=\'0\' alt=\'\' /></a></iframe>

';

$a .= '
<iframe id=\'acae648c\' name=\'acae648c\' src=\'http://advertising.fussball-liveticker.eu/www/delivery/afr.php?zoneid=85&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;ct0=INSERT_CLICKURL_HERE\' frameborder=\'0\' scrolling=\'no\' width=\'234\' height=\'60\'><a href=\'http://advertising.fussball-liveticker.eu/www/delivery/ck.php?n=a3108930&amp;cb=INSERT_RANDOM_NUMBER_HERE\' target=\'_blank\'><img src=\'http://advertising.fussball-liveticker.eu/www/delivery/avw.php?zoneid=85&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=a3108930&amp;ct0=INSERT_CLICKURL_HERE\' border=\'0\' alt=\'\' /></a></iframe>

';


1;
