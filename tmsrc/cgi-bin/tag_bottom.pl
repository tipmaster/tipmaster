#!/usr/bin/perl

=head1 NAME
	tag.pl

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

print "
<script async src=\"https://securepubads.g.doubleclick.net/tag/js/gpt.js\"></script>
<script>
  window.googletag = window.googletag || {cmd: []};
  googletag.cmd.push(function() {
 googletag.defineSlot('/22495599872/DE-TM-970x250-SUBPAGE', [970, 250], 'div-gpt-ad-1631234964627-0').addService(googletag.pubads());
    googletag.pubads().enableSingleRequest();
    googletag.enableServices();
  });
</script>
<!-- /22495599872/DE-TM-970x250-SUBPAGE -->
<div id='div-gpt-ad-1631234964627-0' style='min-width: 970px; min-height: 250px;'>
  <script>
    googletag.cmd.push(function() { googletag.display('div-gpt-ad-1631234964627-0'); });
  </script>
</div>
";

1;
