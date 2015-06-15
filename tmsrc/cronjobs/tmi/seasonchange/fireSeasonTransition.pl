require "/tmapp/tmsrc/cgi-bin/tmi/saison.pl";

if (0) {
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
	print "Sichere Saisondaten in /tmdata/tmi/archiv/$old/\n";
	print "Setze Softlink /tmdata/tmi/archiv/$new/ -> /tmi\n";

	`rm /tmdata/tmi/archiv/$old`;
	`mkdir /tmdata/tmi/archiv/$old/`;
	`mkdir /tmdata/tmi/archiv/$old/pokal/`;
	`ln -s /tmdata/tmi /tmdata/tmi/archiv/$new`;

	`cp /tmdata/tmi/DAT*.TXT /tmdata/tmi/archiv/$old/`;
	`mv /tmdata/tmi/formular*.t* /tmdata/tmi/archiv/$old/`;
	`cp /tmdata/tmi/spieltag.txt /tmdata/tmi/archiv/$old/`;
	`cp /tmdata/tmi/history.txt /tmdata/tmi/archiv/$old/`;
	`cp /tmdata/tmi/heer.txt /tmdata/tmi/archiv/$old/`;
	`cp /tmdata/tmi/final.txt /tmdata/tmi/archiv/$old/`;
	`cp /tmdata/tmi/archiv/022/datum.txt /tmdata/tmi/archiv/$old/`;
	`cp /tmdata/tmi/pokal/*.* /tmdata/tmi/archiv/$old/pokal/`;
	`cp /tmdata/tmi/nm/*-[1-9].txt /tmdata/tmi/archiv/$old/`;
	`cp /tmdata/tmi/zat*.txt /tmdata/tmi/archiv/$old/`;

	print "... beendet.";

	print "Loesche temporaere Save Dateien + Neuaufsetzung Freundschaftspiele und Job Boerse Wechselliste\n";
	`rm /tmdata/tmi/boerse_[0-9].txt`;
	`rm /tmdata/tmi/error_tips_*.txt`;
	`rm /tmdata/tmi/history_s*_*.txt`;
	`rm /tmdata/tmi/zat*.txt`;
	`rm /tmdata/tmi/exdat/*.*`;
	`rm /tmdata/tmi/nm/*-[1-9].txt`;
	`mv /tmdata/tmi/friendly/friendly.txt /tmdata/tmi/friendly/friendly$old.txt`;
	`cp /tmdata/tmi/friendly/nummer_init.txt /tmdata/tmi/friendly/nummer.txt`;
	`mv /tmdata/tmi/wechsel.txt /tmdata/tmi/wechsel$old.txt`;
	`rm /tmdata/tmi/lm-tips*`;
	print "... beendet.";

	print "Zippe Tipdaten Dateien aus /tmdata/tmi/tipos nach /tmdata/tmi/tipos$old.zip \n";
	`zip /tmdata/tmi/tipos$old.zip /tmdata/tmi/tipos/*.TXT`;
	print "... beendet.";

	print "Loesche Dateien aus /tmdata/tmi/tipos und Tipfiles aus /tmdata/tmi/tips/*/ [ dauert ne Weile :-) ]  \n";
	`rm /tmdata/tmi/tipos/*.*`;
	`rm /tmdata/tmi/tips/1/*.*`;
	print "Sp.1 geloescht ...\n";
	`rm /tmdata/tmi/tips/5/*.*`;
	print "Sp.5 geloescht ...\n";
	`rm /tmdata/tmi/tips/9/*.*`;
	print "Sp.9 geloescht ...\n";
	`rm /tmdata/tmi/tips/13/*.*`;
	print "Sp.13 geloescht ...\n";
	`rm /tmdata/tmi/tips/17/*.*`;
	print "Sp.17 geloescht ...\n";
	`rm /tmdata/tmi/tips/21/*.*`;
	print "Sp.21 geloescht ...\n";
	`rm /tmdata/tmi/tips/25/*.*`;
	print "Sp.25 geloescht ...\n";
	`rm /tmdata/tmi/tips/29/*.*`;
	print "Sp.29 geloescht ...\n";
	`rm /tmdata/tmi/tips/33/*.*`;
	print "Sp.33 geloescht ...\n";
	`rm -r /tmdata/tmi/pokal/tips/`;
	print "Loesche Pokaltips ...\n";
	`rm /tmdata/tmi/pokal/pokal_qu[1-5].txt`;
	print "Loesche Pokalquoten ...\n";

	`mkdir -p /tmdata/tmi/pokal/tips/`;
	`chown lighttpd /tmdata/tmi/pokal/tips/`;
	`chgrp lighttpd /tmdata/tmi/pokal/tips/`;

	print "... beendet.";

	print "Verschiebe Aktionen der 'Big Mama' /tmdata/tmi/db/spiele.txt\n";

	`mv /tmdata/tmi/db/spiele_old.txt /tmdata/tmi/db/spiele_old_$vold.txt`;
	`mv /tmdata/tmi/db/spiele.txt /tmdata/tmi/db/spiele_old.txt`;
	print "... beendet.";
}
print "Schreibe Vereinshistorien\n";
require "/tmapp/tmsrc/cronjobs/tmi/seasonchange/ns_sai_history.pl";
print "Erstelle neue history.txt und lege Sie ab in /tmdata/tmi/swechsel\n";
require "/tmapp/tmsrc/cronjobs/tmi/seasonchange/ns_sai_wechsel.pl";

print "Setze die /tmdata/tmi/DAT*.TXT Dateien auf Saisonbeginn \n";
require "/tmapp/tmsrc/cronjobs/tmi/seasonchange/sai_neudat.pl";

print
  "Setze Saisonvariablen auf Saisonstart ( Spielrunde = 1 , Tipabgabe ab Sp.1 , Saisonnr ++ , Pokalrunde =1 etc. ) \n";
open( D1, ">/tmdata/tmi/tip_datum.txt" );
print D1 "1";
close(D1);
open( D1, ">/tmdata/tmi/datum.txt" );
print D1 "1\n1\n";
close(D1);
open( D1, ">/tmdata/tmi/pokal/pokal_datum.txt" );
print D1 "1";
close(D1);

require "/tmapp/tmsrc/cgi-bin/tmi/saison.pl";
$sai_new = $main_nr + 1;
open( D1, ">/tmdata/tmi/main_nr.txt" );
print D1 "$sai_new\n";
close(D1);
print "... beendet.";

`cp /tmdata/tmi/swechsel/history.txt /tmdata/tmi/history.txt`;

`perl /tmapp/tmsrc/cronjobs/tmi/heer.pl &`;    # berechnet Tabellenplazierung fuer Job-Boerse etc.
`perl /tmapp/tmsrc/cronjobs/tmi/seasonchange/erfolge_readout.pl &`;                   # bisherige deutsche meister werden ausgelesen
`perl /tmapp/tmsrc/cronjobs/tmi/seasonchange/cup_winner_readout.pl &`;                # bisherige dfb pokalsieger werden ausgelesen
`nice -15 perl /tmapp/tmsrc/cronjobs/tmi/db/stats_ns.pl &`;
`nice -15 perl /tmapp/tmsrc/cronjobs/tmi/db/top_award.pl &`;

exit;

sub break {
	print "\n[ Fortfahren ? Weiter mit Enter ]\n\n";
	$a = <stdin>;
	print "<br><br>";

}
