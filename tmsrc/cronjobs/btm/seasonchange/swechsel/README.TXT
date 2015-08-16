# SCHRITTE UM DIE NEUE SAISON VORZUBEREITEN 

0.) unter http://www.tipmaster.de/cgi-bin/btm/create_tip.pl kurz die aktuellen Saisonnr. notieren
1.) in Ordner /btm/swechsel wechseln

2.) Skript verwaltung_step1.pl starten
    am besten in den breaks ( eingabeaufforderung ) immer kurz
    prüfen ob die beschriebene aktion korrekt durchgeführt wurde

    -> Skript führt folgende Aktionen Step by Step durch :

       - erstellt softlink für die neue Saison unter /btm/archiv/ auf /btm
         und sichert alle wichtigen Dateien im entsprechenden saisondirectory unter /btm/archiv
         ( DAT*.TXT history.txt heer.txt spieltag.txt datum.txt finals.txt formular*.txt pass.txt + pokaldaten )

	`rm /btm/archiv/$old`;
	`mkdir /btm/archiv/$old/`;
	`mkdir /btm/archiv/$old/pokal/`;
	`ln -s /btm /btm/archiv/$new`;

	`cp /btm/DAT*.TXT /btm/archiv/$old/`;
	`mv /btm/formular*.t* /btm/archiv/$old/`;
	`cp /btm/spieltag.txt /btm/archiv/$old/`;
	`cp /btm/history.txt /btm/archiv/$old/`;
	`cp /btm/heer.txt /btm/archiv/$old/`;
	`cp /btm/pass.txt /btm/archiv/$old/`;
	`cp /btm/finals.txt /btm/archiv/$old/`;
	`cp /btm/archiv/022/datum.txt /btm/archiv/$old/`;
	`cp /btm/pokal/*.* /btm/archiv/$old/pokal/`;


       - löscht temporäre - nun nicht weiter verwertbare - Dateien unter /btm
       
	 `rm /btm/boerse_*.txt`;
       	 `rm /btm/error_tips_*.txt`;
         `rm /btm/history_s*_*.txt`;
         `rm /btm/zat*.txt`;
         `rm /btm/exdat/*.*`; 

       - setzt Freundschaftsspiele wieder auf null

         `mv /btm/friendly/friendly.txt /btm/friendly/friendly$old.txt`;
         `mv /btm/friendly/nummer_init.txt /btm/friendly/nummer.txt`;
         `mv /btm/wechsel.txt /btm/wechsel$old.txt`;

       - verschiebt wechsel.txt nach wechsel[saisonnr].txt / Wechsel über Job Börse wieder für alle möglich beim BTM

         `mv /btm/wechsel.txt /btm/wechsel$old.txt`;
       
       - Zippe Tipdaten Dateien aus /btm/tipos nach /btm/tipos$old.zip 

	 `zip /btm/tipos$old.zip /btm/tipos/*.TXT`;

       - Lösche Dateien aus /btm/tipos und Tipfiles aus /btm/tips/*/ [ dauert ne Weile :-) ]  

	`rm /btm/tipos/*.*`;
	`rm /btm/tips/1/`;print "Sp.1 gelöscht ...\n";
	`rm /btm/tips/5/`;print "Sp.5 gelöscht ...\n";
	`rm /btm/tips/9/`;print "Sp.9 gelöscht ...\n";
	`rm /btm/tips/13/`;print "Sp.13 gelöscht ...\n";
	`rm /btm/tips/17/`;print "Sp.17 gelöscht ...\n";
	`rm /btm/tips/21/`;print "Sp.21 gelöscht ...\n";
	`rm /btm/tips/25/`;print "Sp.25 gelöscht ...\n";
	`rm /btm/tips/29/`;print "Sp.29 gelöscht ...\n";
	`rm /btm/tips/33/`;print "Sp.33 gelöscht ...\n";
	`rm -r /btm/pokal/tips/`;print "Lösche Pokaltips ...\n";
	`mkdir /btm/pokal/tips/`;

	Verschiebe Aktionen der 'Big Statistik Mama' /btm/db/spiele.txt

	`mv /btm/db/spiele_old.txt /btm/db/spiele_old_$vold.txt`;
	`mv /btm/db/spiele.txt /btm/db/spiele_old.txt`;

	Schreibe Vereinshistorien für die Vereinsseiten via
	require "ns_sai_history.pl";

	Erstelle neue history.txt und lege Sie ab in /btm/swechsel via
	( kurz reinschauen und dann einfach ins /btm Verezichnis kopieren )
	require "ns_sai_wechsel.pl";

	Setze die /btm/DAT*.TXT Dateien auf Saisonbeginn 
	( sind die alten DAT* auch wirklich unter /btm/archiv/saisonnummer gespeichert ? )
	require "sai_neudat.pl";

	Variablen auf Spieltag 1 setzen bzw. Saisonvariable wird erhöht
	
	Skript endet hier .

#3)	Die neu angelegte history.txt unter /btm/swechsel kurz checken und bei Gefallen ins /btm Verzeichnis kopieren
#	Saisonvariablenerhöhung geklappt ? sonst unter http://www.tipmaster.de/cgi-bin/btm/create_tip.pl hochdrehen
#
#	dann noch folgende Programme via Shell direkt in den Hintergund starten
#	
#	-> perl /pl/btm/heer.pl &                   # berechnet Tabellenplazierung für Job-Börse etc.
#	-> perl /btm/swechsel/erfolge_readout.pl &  # bisherige deutsche meister werden ausgelesen
#	-> perl /btm/swechsel/dfb_winner_readout.pl &    # bisherige dfb pokalsieger werden ausgelesen
#	-> nice -15 perl /btm/db/stats_ns.pl &  # berechnet die statistiken ( trainerranking - quoten für die job-börse etc.)
						# dauert mit nice -15 wohl fast ne stunde

4) in Ordner /tmi/swechsel wechseln

5) Skript verwaltung_step1.pl starten ( gleiche Prozedur wie Punkt 2 nur für tmi )

6)      Die neu angelegte history.txt unter /tmi/swechsel kurz checken und bei Gefallen ins /tmi Verzeichnis kopieren
        Saisonvariablenerhöhung geklappt ? sonst unter http://www.tipmaster.de/cgi-bin/btm/create_tip.pl hochdrehen
        dann noch folgende Programme via Shell direkt in den Hintergund starten

#        -> perl /pl/tmi/heer.pl &                   # berechnet Tabellenplazierung für Job-Börse etc.
#        -> perl /tmi/swechsel/erfolge_readout.pl &  # bisherige int. meister werden ausgelesen
#        -> perl /tmi/swechsel/cup_winner_readout.pl &    # bisherige landes pokalsieger werden ausgelesen
#	-> nice -15 perl /tmi/db/stats_ns.pl &  # berechnet die statistiken ( trainerranking - quoten für die job-börse etc.)
                                                # dauert mit nice -15 wohl fast ne stunde

#7) 	in Ordner /btm/swechsel/pokal wechseln
#	Pokalwettbewerbe neu aufsetzen # Pokaldaten im Archiv wirklich gesichert
#	-> perl /btm/pokal/pokal_setup.pl

8)	in der /mod/tmi/spiel.pl /mod/tmi/tab.pl müssen die arrays @uef und @off entsprechend
	den Plazierungen in der UEFA / OFF 5 Jahres liste aktualisiert werden


#       automatisiert ...
#
#9)      am nächsten tag bzw. wenn /tmi|btm/db/stats_ns.pl durchgelaufen sind
#
#	-> perl /btm/swechsel/award_readout.pl &    # vergibt Saison Awards Gold Silber Bronze
#	-> perl /tmi/swechsel/award_readout.pl &    # vergibt Saison Awards Gold Silber Bronze

10)	sobald /tmi|btm/swechsel/award_readout.pl durchgelaufen sind

	-> perl /btm/db/chart.pl                   # erstellt die Chartgifs auf den Statistikseiten für btm und tmi (ca. 60 min)
						    # die beiden award_readout.pl skripte müssen durchgelaufen sein !
						   # ACHTUNG : anscheinend lassen sich die chart.pl zwar in den hintergrund
						     mit beendigung der session wird aber auch das skript abgeschossen	
	-> perl /tmi/db/chart.pl 

11) 	Kopiere EC DAten in archiv Verzeichnis und starte /tmi/swechsel/ec_erfolge_readout.pl
