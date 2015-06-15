#!/usr/bin/perl

=head1 NAME
	loc.pl

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
my $leut    = $trainer;

use CGI;

print "<table border=0 cellspacing=0><tr>\n";
print "<td><a href=/cgi-mod/btm/login.pl><img src=/img/b01.JPG border=0></a></td>\n";
print "<td><a href=/cgi-mod/btm/spiel.pl><img src=/img/b03.JPG border=0></a></td>\n";
print "<td><a href=/cgi-mod/btm/tab.pl><img src=/img/b02.JPG border=0></a></td>\n";
print "<td><a href=/cgi-bin/btm/boerse.pl><img src=/img/b05.JPG border=0></a></td>\n";
print "<td><a href=/cgi-bin/btm/mail/mailbox.pl><img src=/img/b08.JPG border=0></a></td>\n";
print "<td><a href=http://community.tipmaster.de><img src=/img/b06.JPG border=0></a></td>\n";
print "<td><a href=/><img src=/img/b07.JPG border=0></a></td>\n";
print "</tr></table>\n";
