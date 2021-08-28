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
    googletag.defineSlot('/22495599872/de-tm-728x90-subpage-bottom', [728, 90], 'div-gpt-ad-1630160625050-0').addService(googletag.pubads());
    googletag.pubads().enableSingleRequest();
    googletag.enableServices();
  });
</script>
<!-- /22495599872/de-tm-728x90-subpage-bottom -->
<div id='div-gpt-ad-1630160625050-0' style='min-width: 728px; min-height: 90px;'>
  <script>
    googletag.cmd.push(function() { googletag.display('div-gpt-ad-1630160625050-0'); });
  </script>
</div>
";

1;
