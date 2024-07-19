#!/usr/bin/perl

=head1 NAME
	tag_small.pl

=head1 SYNOPSIS
	TBD
	


=head1 CHANGELOG
	2015-06-09 Thomas: Added Session Management


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
    googletag.defineSlot('/22495599872/de-tm-300x250-hp', [300, 250], 'div-gpt-ad-1630770174437-0').addService(googletag.pubads());
    googletag.defineSlot('/22495599872/DE-TM-300x600-HP', [300, 600], 'div-gpt-ad-1631234661433-0').addService(googletag.pubads());
    googletag.pubads().enableSingleRequest();
    googletag.pubads().setTargeting('sitelanguage', ['de']);
    googletag.pubads().setTargeting('platform', ['tm']);
    googletag.pubads().setTargeting('page', ['TM_PAGE']);
    googletag.pubads().setTargeting('approval', ['1']);
    googletag.enableServices();
  });
</script>
<!-- /22495599872/de-tm-300x250-hp -->
<div id='div-gpt-ad-1630770174437-0' style='min-width: 300px; min-height: 250px;'>
  <script>
    googletag.cmd.push(function() { googletag.display('div-gpt-ad-1630770174437-0'); });
  </script>
</div>
<!-- /22495599872/DE-TM-300x600-HP -->
<div id='div-gpt-ad-1631234661433-0' style='min-width: 300px; min-height: 600px;'>
  <script>
    googletag.cmd.push(function() { googletag.display('div-gpt-ad-1631234661433-0'); });
  </script>
</div>
";
1;
