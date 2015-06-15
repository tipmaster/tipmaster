use lib '/tmapp/tmsrc/cgi-bin/';

require "/tmapp/tmsrc/cgi-bin/btm/saison.pl";

$vold = $main_saison[ $main_nr - 1 ];
$vold =~ s/Saison 20//;
$vold =~ s/'//;

$old = $main_saison[$main_nr];
$old =~ s/Saison 20//;
$old =~ s/'//;

$new = $main_saison[ $main_nr + 1 ];
$new =~ s/Saison 20//;
$new =~ s/'//;

if ( $old eq "" || $new eq "" || $old eq ".." ) { exit; }
print "Content-type:text/html\n\n";
print
"\n\nSaisonumstellung von $old -> $new [ <- richtige Saisonkuerzel ? nur dann Fortfahren ] und als User tm eingeloggt ?";
&break;
print "Sichere Saisondaten in /tmdata/btm/archiv/$old/\n";
print "Setze Softlink /tmdata/btm/archiv/$new/ -> /tmdata/btm\n";

`rm /tmdata/btm/archiv/$old`;
`mkdir /tmdata/btm/archiv/$old/`;
`mkdir /tmdata/btm/archiv/$old/pokal/`;
`ln -s /tmdata/btm /tmdata/btm/archiv/$new`;

`cp /tmdata/btm/DAT*.TXT /tmdata/btm/archiv/$old/`;
`mv /tmdata/btm/formular*.t* /tmdata/btm/archiv/$old/`;
`cp /tmdata/btm/spieltag.txt /tmdata/btm/archiv/$old/`;
`cp /tmdata/btm/history.txt /tmdata/btm/archiv/$old/`;
`cp /tmdata/btm/heer.txt /tmdata/btm/archiv/$old/`;
`cp /tmdata/btm/finals.txt /tmdata/btm/archiv/$old/`;
`cp /tmdata/btm/archiv/022/datum.txt /tmdata/btm/archiv/$old/`;
`cp /tmdata/btm/pokal/*.* /tmdata/btm/archiv/$old/pokal/`;
`cp /tmdata/btm/zat*.* /tmdata/btm/archiv/$old/`;

print "... beendet.";

print "Loesche temporaere Save Dateien + Neuaufsetzung Freundschaftspiele und Job Boerse Wechselliste\n";
`rm /tmdata/btm/boerse_[0-9].txt`;
`rm /tmdata/btm/error_tips_*.txt`;
`rm /tmdata/btm/history_s*_*.txt`;
`rm /tmdata/btm/exdat/*.*`;

`mv /tmdata/btm/friendly/friendly.txt /tmdata/btm/friendly/friendly$old.txt`;
`cp /tmdata/btm/friendly/nummer_init.txt /tmdata/btm/friendly/nummer.txt`;
`mv /tmdata/btm/wechsel.txt /tmdata/btm/wechsel$old.txt`;

print "... beendet.";

print "Zippe Tipdaten Dateien aus /tmdata/btm/tipos nach /tmdata/btm/tipos$old.zip \n";
`zip /tmdata/btm/tipos$old.zip /tmdata/btm/tipos/*.TXT`;
print "... beendet.";

print "Loesche Dateien aus /tmdata/btm/tipos und Tipfiles aus /tmdata/btm/tips/*/  \n";
`rm /tmdata/btm/tipos/*.*`;
`rm /tmdata/btm/tips/1/*`;
print "Sp.1 geloescht ...\n";
`rm /tmdata/btm/tips/5/*`;
print "Sp.5 geloescht ...\n";
`rm /tmdata/btm/tips/9/*`;
print "Sp.9 geloescht ...\n";
`rm /tmdata/btm/tips/13/*`;
print "Sp.13 geloescht ...\n";
`rm /tmdata/btm/tips/17/*`;
print "Sp.17 geloescht ...\n";
`rm /tmdata/btm/tips/21/*`;
print "Sp.21 geloescht ...\n";
`rm /tmdata/btm/tips/25/*`;
print "Sp.25 geloescht ...\n";
`rm /tmdata/btm/tips/29/*`;
print "Sp.29 geloescht ...\n";
`rm /tmdata/btm/tips/33/*`;
print "Sp.33 geloescht ...\n";
`rm -r /tmdata/btm/pokal/tips/`;
print "Loesche Pokaltips ...\n";
`rm /tmdata/btm/pokal/pokal_qu[1-7].txt`;
print "Loesche Pokalquoten ...\n";
`mkdir /tmdata/btm/pokal/tips/`;
`chown lighttpd /tmdata/btm/pokal/tips/`;
`chgrp lighttpd /tmdata/btm/pokal/tips/`;

print "... beendet.";

print "Verschiebe Aktionen der 'Big Mama' /tmdata/btm/db/spiele.txt\n";

`mv /tmdata/btm/db/spiele_old.txt /tmdata/btm/db/spiele_old_$vold.txt`;
`mv /tmdata/btm/db/spiele.txt /tmdata/btm/db/spiele_old.txt`;
print "... beendet.";

print "Schreibe Vereinshistorien\n";
require "ns_sai_history.pl";

print "Erstelle neue history.txt und lege Sie ab in /tmapp/tmsrc/cronjobs/btm/seasonchange/\n";
require "ns_sai_wechsel.pl";

print "Setze die /tmdata/btm/DAT*.TXT Dateien auf Saisonbeginn \n";
require "sai_neudat.pl";

print
  "Setze Saisonvariablen auf Saisonstart ( Spielrunde = 1 , Tipabgabe ab Sp.1 , Saisonnr ++ , Pokalrunde =1 etc. ) \n";
open( D1, ">/tmdata/btm/tip_datum.txt" );
print D1 "1";
close(D1);
open( D1, ">/tmdata/rrunde.txt" );
print D1 "1";
close(D1);
open( D1, ">/tmdata/btm/datum.txt" );
print D1 "1\n1\n";
close(D1);
open( D1, ">/tmdata/btm/pokal/pokal_datum.txt" );
print D1 "1";
close(D1);

require "/tmapp/tmsrc/cgi-bin/btm/saison.pl";
$sai_new = $main_nr + 1;

open( D1, ">/tmdata/btm/main_nr.txt" );
print D1 "$sai_new\n";
close(D1);
print "... beendet.";

`mv /tmapp/tmsrc/cronjobs/btm/seasonchange/history.txt /tmdata/btm/history.txt`;

`perl /tmapp/tmsrc/cronjobs/btm/heer.pl &`;                          # berechnet Tabellenplazierung fuer Job-Boerse etc.
`perl /tmapp/tmsrc/cronjobs/btm/seasonchange/erfolge_readout.pl &`;  # bisherige deutsche meister werden ausgelesen
`perl /tmapp/tmsrc/cronjobs/btm/seasonchange/dfb_winner_readout.pl &`;    # bisherige dfb pokalsieger werden ausgelesen

`nice -15 perl /tmapp/tmsrc/cronjobs/btm/db/stats_ns.pl &`;
`nice -15 perl /tmapp/tmsrc/cronjobs/btm/db/top_award.pl &`;

exit;

sub break {
	print "\n[ Fortfahren ? Weiter mit Enter ]\n\n";
	$a = <stdin>;
	print "<br><br>";
}
