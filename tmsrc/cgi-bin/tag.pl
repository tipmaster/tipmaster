#!/usr/bin/perl

=head1 NAME
	tag.pl

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

print "<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-53T3SLD');</script>
<!-- End Google Tag Manager -->
<!-- POSTHOG START -->
<script>
    !(function (t, e) {
      var o, n, p, r;
      e.__SV ||
        ((window.posthog = e),
        (e._i = []),
        (e.init = function (i, s, a) {
          function g(t, e) {
            var o = e.split(\".\");
            2 == o.length && ((t = t[o[0]]), (e = o[1])),
              (t[e] = function () {
                t.push([e].concat(Array.prototype.slice.call(arguments, 0)));
              });
          }
          ((p = t.createElement(\"script\")).type = \"text/javascript\"),
            (p.async = !0),
            (p.src =
              s.api_host.replace(\".i.posthog.com\", \"-assets.i.posthog.com\") +
              \"/static/array.js\"),
            (r = t.getElementsByTagName(\"script\")[0]).parentNode.insertBefore(
              p,
              r
            );
          var u = e;
          for (
            void 0 !== a ? (u = e[a] = []) : (a = \"posthog\"),
              u.people = u.people || [],
              u.toString = function (t) {
                var e = \"posthog\";
                return (
                  \"posthog\" !== a && (e += \".\" + a), t || (e += \" (stub)\"), e
                );
              },
              u.people.toString = function () {
                return u.toString(1) + \".people (stub)\";
              },
              o =
                \"capture identify alias people.set people.set_once set_config register register_once unregister opt_out_capturing has_opted_out_capturing opt_in_capturing reset isFeatureEnabled onFeatureFlags getFeatureFlag getFeatureFlagPayload reloadFeatureFlags group updateEarlyAccessFeatureEnrollment getEarlyAccessFeatures getActiveMatchingSurveys getSurveys getNextSurveyStep onSessionId setPersonProperties\".split(
                  \" \"
                ),
              n = 0;
            n < o.length;
            n++
          )
            g(u, o[n]);
          e._i.push([i, s, a]);
        }),
        (e.__SV = 1));
    })(document, window.posthog || []);
    posthog.init(\"phc_iJKj0EowViIqaA6qV2nD6gv8sDIN4DcflJOIWGEQROj\", {
      api_host: \"https://us.i.posthog.com\",
      person_profiles: \"always\",
      autocapture: {
        dom_event_allowlist: [\"click\"]
      },
    });
</script>
<!-- POSTHOG END -->
";


my $cachebuster = int(100000*rand());

print "
<script async src=\"https://securepubads.g.doubleclick.net/tag/js/gpt.js\"></script>
<script>
  window.googletag = window.googletag || {cmd: []};
  googletag.cmd.push(function() {
    googletag.defineSlot('/22495599872/DE-TM-970x250-SUBPAGE', [970, 250], 'div-gpt-ad-1631234964627-0').addService(googletag.pubads());
    googletag.pubads().enableSingleRequest();
	googletag.pubads().setTargeting('sitelanguage', ['de']);
    googletag.pubads().setTargeting('platform', ['tm']);
    googletag.pubads().setTargeting('page', ['TM_PAGE']);
    googletag.pubads().setTargeting('approval', ['1']);
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



&createUserLogEntry();

sub createUserLogEntry {

	$xa = "";
	$xb = "";
	$xc = "";
	$xd = "";
	$xe = "";
	$xf = "";
	$xg = "";

	if ( $trainer eq "" ) { $trainer = $leut }
	if ( ( $trainer ne "unknown" ) and ( $trainer ne "" ) ) {

		( $sek, $min, $std, $tag, $mon, $jahr ) = localtime(time);
		$mon++;
		if ( $sek < 10 )        { $xa = "0" }
		if ( $min < 10 )        { $xb = "0" }
		if ( $std < 10 )        { $xc = "0" }
		if ( $tag < 10 )        { $xd = "0" }
		if ( $mon < 10 )        { $xe = "0" }
		if ( $liga < 10 )       { $xf = "0" }
		if ( $spielrunde < 10 ) { $xg = "0" }
		$jahr = $jahr + 1900;

		$datei = "/tmdata/btm/logs/" . $trainer . '.txt';

		if ( -e "$datei" ) { $ex_ex = 1 }
		$gross = -s $datei;
		$datum = $xd . $tag . '.' . $xe . $mon . '.' . $jahr;
		$datum_voll =
		  $xc . $std . ':' . $xb . $min . ':' . $xa . $sek . ' ' . $xd . $tag . '.' . $xe . $mon . '.' . $jahr;

		if ( -e "$datei" ) { $ex_ex = 1 }

		$ein = 0;
		open( D1, "$datei" );
		while (<D1>) {
			$zei++;

			if ( $zei == 2 ) {
				$datum_ever = $_;
				chomp $datum_ever;
			}

			if ( $zei == 1 ) {

				$vis = 1;

				$datum_old = $_;
				chomp $datum_old;
				( $jj, $datum_old ) = split( / /, $datum_old );
				$datum_old =~ s/&//;

				if ( $datum_old eq $datum ) {
					$jj =~ s/&//;
					( $ia, $ib, $ic ) = split( /:/, $jj );
					$mmsek_2 = $ic +  ( $ib * 60 ) +  ( $ia * 60 * 60 );
					$mmsek_1 = $sek + ( $min * 60 ) + ( $std * 60 * 60 );
					$mmsek_3 = $mmsek_1 - $mmsek_2;
					$vis     = 0;

				}
			}

			if ( $zei > 2 ) {
				$zeil[$zei] = $_;
				chomp $zeil[$zei];
				if ( $_ =~ /$datum/ ) {
					$ein = 1;
					( $leer, $dat, $visits, $hits, $ip ) = split( /&/, $_ );
					if ( $mmsek_3 > 8 ) { $hits++ }
					if ( ( $mmsek_3 > 1200 ) or ( $vis == 1 ) ) { $visits++ }

					$zeil[$zei] = '&' . $datum . '&' . $visits . '&' . $hits . '&' . $ip . '&';
				}
			}
		}
		close(D1);

		if ( $ein == 0 ) {
			$zei++;
			$zeil[$zei] = '&' . $datum . "&1&1&$ENV{REMOTE_ADDR}&";
		}

		if ( $zei > 1 ) {
			open( D1, ">$datei" );
			flock( D1, 2 );
			print D1 "&$datum_voll&\n";
			print D1 "$datum_ever\n";
			print D1 "$ENV{REMOTE_ADDR}\n";

			for ( $xx = 4 ; $xx <= $zei ; $xx++ ) {
				print D1 "$zeil[$xx]\n";
			}
			flock( D1, 8 );
			close(D1);
		}

		if ( -e "$datei" ) { $ex_ex = 1 }

		if ( $ex_ex != 1 ) {
			if ( $zei == 1 ) {
				open( D1, ">$datei" );
				flock( D1, 2 );
				print D1 "&$datum_voll&\n";
				print D1 "&$datum_voll&\n\n\n";
				print D1 "&$datum&1&1&$ENV{REMOTE_ADDR}&\n";
				flock( D1, 8 );
				close(D1);
			}
		}

	}

	return;

}

1;
