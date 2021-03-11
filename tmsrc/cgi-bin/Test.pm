package Test;

sub new {
	my $self = {};
	bless($self);
	return $self;
}

sub location {
	my $location = "
<table border=0 cellspacing=0><tr>
<td><a href=/cgi-mod/btm/login.pl><img src=/img/b01.JPG border=0></a></td>
<td><a href=/cgi-mod/btm/spiel.pl><img src=/img/b03.JPG border=0></a></td>
<td><a href=/cgi-mod/btm/tab.pl><img src=/img/b02.JPG border=0></a></td>
<td><a href=/cgi-bin/btm/boerse.pl><img src=/img/b05.JPG border=0></a></td>
<td><a href=/cgi-bin/btm/mail/mail_inbox.pl><img src=/img/b08.JPG border=0></a></td>
<td><a href=http://community.tipmaster.de><img src=/img/b06.JPG border=0></a></td>
<td><a href=/><img src=/img/b07.JPG border=0></a></td>
</tr></table>
";
	return $location;
}

sub location_tmi {
	my $location = "
<table border=0 cellspacing=0><tr>
<td><a href=/cgi-mod/tmi/login.pl><img src=/img/b01.JPG border=0></a></td>
<td><a href=/cgi-mod/tmi/spiel.pl><img src=/img/b03.JPG border=0></a></td>
<td><a href=/cgi-mod/tmi/tab.pl><img src=/img/b02.JPG border=0></a></td>
<td><a href=/cgi-bin/tmi/boerse.pl><img src=/img/b05.JPG border=0></a></td>
<td><a href=http://community.tipmaster.de><img src=/img/b13.jpeg border=0></a></td>
<td><a href=/cgi-bin/tmi/mail/mail_inbox.pl><img src=/img/b08.JPG border=0></a></td>
<td><a href=http://community.tipmaster.de><img src=/img/b06.JPG border=0></a></td>
<td><a href=/tmi/><img src=/img/b07.JPG border=0></a></td>
</tr></table>
";
	return $location;
}

sub flag_hash {
	my %flag_hash = (
		"Albanien"      => "AL",
		"Andorra"       => "AD",
		"Armenien"      => "AM",
		"Aserbaidschan" => "AZ",
		"Belgien"       => "BE",
		"Bosnien-Herz." => "BA",
		"Bulgarien"     => "BG",
		"Daenemark"     => "DK",
		"England"       => "UK",
		"Estland"       => "EE",
		"Faeroer"       => "FO",
		"Finnland"      => "FI",
		"Frankreich"    => "FR",
		"Georgien"      => "GE",
		"Griechenland"  => "GR",
		"Irland"        => "IE",
		"Island"        => "IS",
		"Israel"        => "IL",
		"Italien"       => "IT",
		"Jugoslawien"   => "",
		"Kroatien"      => "HR",
		"Lettland"      => "LV",
		"Litauen"       => "LT",
		"Luxemburg"     => "LI",
		"Malta"         => "MT",
		"Mazedonien"    => "MK",
		"Moldawien"     => "MD",
		"Niederlande"   => "NL",
		"Nord Irland"   => "IE",
		"Norwegen"      => "NO",
		"Oesterreich"   => "AT",
		"Polen"         => "PL",
		"Portugal"      => "PT",
		"Rumaenien"     => "RO",
		"Russland"      => "RU",
		"San Marino"    => "SM",
		"Schottland"    => "UK",
		"Schweden"      => "SE",
		"Schweiz"       => "CH",
		"Slowakei"      => "SK",
		"Slowenien"     => "SI",
		"Spanien"       => "ES",
		"Tschechien"    => "CZ",
		"Tuerkei"       => "TR",
		"Ukraine"       => "UA",
		"Ungarn"        => "HU",
		"Wales"         => "UK",
		"Weissrussland" => "BY",
		"Zypern"        => "CY"
	);

	return ($flag_hash);
}

sub btm_liga_namen {
	my @liga_namen = (
		"---",
		"1.Bundesliga",
		"2.Bundesliga",
		"Regionalliga A",
		"Regionalliga B",
		"Oberliga A",
		"Oberliga B",
		"Oberliga C",
		"Oberliga D",
		"Verbandsliga A",
		"Verbandsliga B",
		"Verbandsliga C",
		"Verbandsliga D",
		"Verbandsliga E",
		"Verbandsliga F",
		"Verbandsliga G",
		"Verbandsliga H",
		"Landesliga A",
		"Landesliga B",
		"Landesliga C",
		"Landesliga D",
		"Landesliga E",
		"Landesliga F",
		"Landesliga G",
		"Landesliga H",
		"Landesliga I",
		"Landesliga K",
		"Landesliga L",
		"Landesliga M",
		"Landesliga N",
		"Landesliga O",
		"Landesliga P",
		"Landesliga R",
		"Bezirksliga 01",
		"Bezirksliga 02",
		"Bezirksliga 03",
		"Bezirksliga 04",
		"Bezirksliga 05",
		"Bezirksliga 06",
		"Bezirksliga 07",
		"Bezirksliga 08",
		"Bezirksliga 09",
		"Bezirksliga 10",
		"Bezirksliga 11",
		"Bezirksliga 12",
		"Bezirksliga 13",
		"Bezirksliga 14",
		"Bezirksliga 15",
		"Bezirksliga 16",
		"Bezirksliga 17",
		"Bezirksliga 18",
		"Bezirksliga 19",
		"Bezirksliga 20",
		"Bezirksliga 21",
		"Bezirksliga 22",
		"Bezirksliga 23",
		"Bezirksliga 24",
		"Bezirksliga 25",
		"Bezirksliga 26",
		"Bezirksliga 27",
		"Bezirksliga 28",
		"Bezirksliga 29",
		"Bezirksliga 30",
		"Bezirksliga 31",
		"Bezirksliga 32",
		"Kreisliga 01",
		"Kreisliga 02",
		"Kreisliga 03",
		"Kreisliga 04",
		"Kreisliga 05",
		"Kreisliga 06",
		"Kreisliga 07",
		"Kreisliga 08",
		"Kreisliga 09",
		"Kreisliga 10",
		"Kreisliga 11",
		"Kreisliga 12",
		"Kreisliga 13",
		"Kreisliga 14",
		"Kreisliga 15",
		"Kreisliga 16",
		"Kreisliga 17",
		"Kreisliga 18",
		"Kreisliga 19",
		"Kreisliga 20",
		"Kreisliga 21",
		"Kreisliga 22",
		"Kreisliga 23",
		"Kreisliga 24",
		"Kreisliga 25",
		"Kreisliga 26",
		"Kreisliga 27",
		"Kreisliga 28",
		"Kreisliga 29",
		"Kreisliga 30",
		"Kreisliga 31",
		"Kreisliga 32",
		"Kreisliga 33",
		"Kreisliga 34",
		"Kreisliga 35",
		"Kreisliga 36",
		"Kreisliga 37",
		"Kreisliga 38",
		"Kreisliga 39",
		"Kreisliga 40",
		"Kreisliga 41",
		"Kreisliga 42",
		"Kreisliga 43",
		"Kreisliga 44",
		"Kreisliga 45",
		"Kreisliga 46",
		"Kreisliga 47",
		"Kreisliga 48",
		"Kreisliga 49",
		"Kreisliga 50",
		"Kreisliga 51",
		"Kreisliga 52",
		"Kreisliga 53",
		"Kreisliga 54",
		"Kreisliga 55",
		"Kreisliga 56",
		"Kreisliga 57",
		"Kreisliga 58",
		"Kreisliga 59",
		"Kreisliga 60",
		"Kreisliga 61",
		"Kreisliga 62",
		"Kreisliga 63",
		"Kreisliga 64",
		"Kreisklasse 1",
		"Kreisklasse 2",
		"Kreisklasse 3",
		"Kreisklasse 4",
		"Kreisklasse 5",
		"Kreisklasse 6",
		"Kreisklasse 7",
		"Kreisklasse 8",
		"Kreisklasse 9",
		"Kreisklasse 10",
		"Kreisklasse 11",
		"Kreisklasse 12",
		"Kreisklasse 13",
		"Kreisklasse 14",
		"Kreisklasse 15",
		"Kreisklasse 16",
		"Kreisklasse 17",
		"Kreisklasse 18",
		"Kreisklasse 19",
		"Kreisklasse 20",
		"Kreisklasse 21",
		"Kreisklasse 22",
		"Kreisklasse 23",
		"Kreisklasse 24",
		"Kreisklasse 25",
		"Kreisklasse 26",
		"Kreisklasse 27",
		"Kreisklasse 28",
		"Kreisklasse 29",
		"Kreisklasse 30",
		"Kreisklasse 31",
		"Kreisklasse 32",
		"Kreisklasse 33",
		"Kreisklasse 34",
		"Kreisklasse 35",
		"Kreisklasse 36",
		"Kreisklasse 37",
		"Kreisklasse 38",
		"Kreisklasse 39",
		"Kreisklasse 40",
		"Kreisklasse 41",
		"Kreisklasse 42",
		"Kreisklasse 43",
		"Kreisklasse 44",
		"Kreisklasse 45",
		"Kreisklasse 46",
		"Kreisklasse 47",
		"Kreisklasse 48",
		"Kreisklasse 49",
		"Kreisklasse 50",
		"Kreisklasse 51",
		"Kreisklasse 52",
		"Kreisklasse 53",
		"Kreisklasse 54",
		"Kreisklasse 55",
		"Kreisklasse 56",
		"Kreisklasse 57",
		"Kreisklasse 58",
		"Kreisklasse 59",
		"Kreisklasse 60",
		"Kreisklasse 61",
		"Kreisklasse 62",
		"Kreisklasse 63",
		"Kreisklasse 64",
		"Kreisklasse 65",
		"Kreisklasse 66",
		"Kreisklasse 67",
		"Kreisklasse 68",
		"Kreisklasse 69",
		"Kreisklasse 70",
		"Kreisklasse 71",
		"Kreisklasse 72",
		"Kreisklasse 73",
		"Kreisklasse 74",
		"Kreisklasse 75",
		"Kreisklasse 76",
		"Kreisklasse 77",
		"Kreisklasse 78",
		"Kreisklasse 79",
		"Kreisklasse 80",
		"Kreisklasse 81",
		"Kreisklasse 82",
		"Kreisklasse 83",
		"Kreisklasse 84",
		"Kreisklasse 85",
		"Kreisklasse 86",
		"Kreisklasse 87",
		"Kreisklasse 88",
		"Kreisklasse 89",
		"Kreisklasse 90",
		"Kreisklasse 91",
		"Kreisklasse 92",
		"Kreisklasse 93",
		"Kreisklasse 94",
		"Kreisklasse 95",
		"Kreisklasse 96",
		"Kreisklasse 97",
		"Kreisklasse 98",
		"Kreisklasse 99",
		"Kreisklasse 100",
		"Kreisklasse 101",
		"Kreisklasse 102",
		"Kreisklasse 103",
		"Kreisklasse 104",
		"Kreisklasse 105",
		"Kreisklasse 106",
		"Kreisklasse 107",
		"Kreisklasse 108",
		"Kreisklasse 109",
		"Kreisklasse 110",
		"Kreisklasse 111",
		"Kreisklasse 112",
		"Kreisklasse 113",
		"Kreisklasse 114",
		"Kreisklasse 115",
		"Kreisklasse 116",
		"Kreisklasse 117",
		"Kreisklasse 118",
		"Kreisklasse 119",
		"Kreisklasse 120",
		"Kreisklasse 121",
		"Kreisklasse 122",
		"Kreisklasse 123",
		"Kreisklasse 124",
		"Kreisklasse 125",
		"Kreisklasse 126",
		"Kreisklasse 127",
		"Kreisklasse 128"
	);

	for ( my $x11 = 257 ; $x11 <= 384 ; $x11++ ) {
		my $y11 = $x11 - 256;
		$liga_namen[$x11] = "Kreisstaffel $y11";
	}
	return (@liga_namen);
}

sub tmi_liga_namen {
	@liga_namen = (
		"---",
		"Italien Serie A",
		"Italien Serie B",
		"Italien Amateurliga A",
		"Italien Amateurliga B",
		"Italien Amateurklasse A",
		"Italien Amateurklasse B",
		"Italien Amateurklasse C",
		"Italien Amateurklasse D",
		"England Premier League",
		"England 1.Division",
		"England Amateurliga A",
		"England Amateurliga B",
		"England Amateurklasse A",
		"England Amateurklasse B",
		"England Amateurklasse C",
		"England Amateurklasse D",
		"Spanien Primera Division",
		"Spanien Segunda Division",
		"Spanien Amateurliga A",
		"Spanien Amateurliga B",
		"Spanien Amateurklasse A",
		"Spanien Amateurklasse B",
		"Spanien Amateurklasse C",
		"Spanien Amateurklasse D",
		"Frankreich Ligue Une",
		"Frankreich Ligue Deux",
		"Frankreich Amateurliga A",
		"Frankreich Amateurliga B",
		"Frankreich Amateurklasse A",
		"Frankreich Amateurklasse B",
		"Frankreich Amateurklasse C",
		"Frankreich Amateurklasse D",
		"Niederlande Ehrendivision",
		"Niederlande 1.Division",
		"Niederlande Amateurliga A",
		"Niederlande Amateurliga B",
		"Niederlande Amateurklasse A",
		"Niederlande Amateurklasse B",
		"Portugal 1.Divisao",
		"Portugal 2.Divisao",
		"Portugal Amateurliga A",
		"Portugal Amateurliga B",
		"Portugal Amateurklasse A",
		"Portugal Amateurklasse B",
		"Belgien 1.Division",
		"Belgien 2.Division",
		"Belgien Amateurliga A",
		"Belgien Amateurliga B",
		"Belgien Amateurklasse A",
		"Belgien Amateurklasse B",
		"Schweiz Nationalliga A",
		"Schweiz Nationalliga B",
		"Schweiz Amateurliga A",
		"Schweiz Amateurliga B",
		"Schweiz Amateurklasse A",
		"Schweiz Amateurklasse B",
		"Oesterreich Bundesliga",
		"Oesterreich 1.Division",
		"Oesterreich Amateurliga A",
		"Oesterreich Amateurliga B",
		"Oesterreich Amateurklasse A",
		"Oesterreich Amateurklasse B",
		"Schottland 1.Liga",
		"Schottland 2.Liga",
		"Schottland Amateurliga A",
		"Schottland Amateurliga B",
		"Schottland Amateurklasse A",
		"Schottland Amateurklasse B",
		"Tuerkei 1.Liga",
		"Tuerkei 2.Liga",
		"Tuerkei Amateurliga A",
		"Tuerkei Amateurliga B",
		"Tuerkei Amateurklasse A",
		"Tuerkei Amateurklasse B",
		"Irland 1.Liga",
		"Irland 2.Liga",
		"Irland Amateurliga A",
		"Irland Amateurliga B",
		"Nord Irland 1.Liga",
		"Nord Irland 2.Liga",
		"Nord Irland Amateurliga A",
		"Nord Irland Amateurliga B",
		"Wales 1.Liga",
		"Wales 2.Liga",
		"Wales Amateurliga A",
		"Wales Amateurliga B",
		"Daenemark 1.Liga",
		"Daenemark 2.Liga",
		"Daenemark Amateurliga A",
		"Daenemark Amateurliga B",
		"Norwegen 1.Liga",
		"Norwegen 2.Liga",
		"Norwegen Amateurliga A",
		"Norwegen Amateurliga B",
		"Schweden 1.Liga",
		"Schweden 2.Liga",
		"Schweden Amateurliga A",
		"Schweden Amateurliga B",
		"Finnland 1.Liga",
		"Finnland 2.Liga",
		"Finnland Amateurliga A",
		"Finnland Amateurliga B",
		"Island 1.Liga",
		"Island 2.Liga",
		"Island Amateurliga A",
		"Island Amateurliga B",
		"Polen 1.Liga",
		"Polen 2.Liga",
		"Polen Amateurliga A",
		"Polen Amateurliga B",
		"Tschechien 1.Liga",
		"Tschechien 2.Liga",
		"Tschechien Amateurliga A",
		"Tschechien Amateurliga B",
		"Ungarn 1.Liga",
		"Ungarn 2.Liga",
		"Ungarn Amateurliga A",
		"Ungarn Amateurliga B",
		"Rumaenien 1.Liga",
		"Rumaenien 2.Liga",
		"Rumaenien Amateurliga A",
		"Rumaenien Amateurliga B",
		"Slowenien 1.Liga",
		"Slowenien 2.Liga",
		"Slowenien Amateurliga A",
		"Slowenien Amateurliga B",
		"Kroatien 1.Liga",
		"Kroatien 2.Liga",
		"Kroatien Amateurliga A",
		"Kroatien Amateurliga B",
		"Jugoslawien 1.Liga",
		"Jugoslawien 2.Liga",
		"Jugoslawien Amateurliga A",
		"Jugoslawien Amateurliga B",
		"Bosnien-Herz. 1.Liga",
		"Bosnien-Herz. 2.Liga",
		"Bosnien-Herz. Amateurliga A",
		"Bosnien-Herz. Amateurliga B",
		"Bulgarien 1.Liga",
		"Bulgarien 2.Liga",
		"Bulgarien Amateurliga A",
		"Bulgarien Amateurliga B",
		"Griechenland 1.Liga",
		"Griechenland 2.Liga",
		"Griechenland Amateurliga A",
		"Griechenland Amateurliga B",
		"Russland 1.Liga",
		"Russland 2.Liga",
		"Russland Amateurliga A",
		"Russland Amateurliga B",
		"Estland 1.Liga",
		"Estland 2.Liga",
		"Estland Amateurliga A",
		"Estland Amateurliga B",
		"Ukraine 1.Liga",
		"Ukraine 2.Liga",
		"Ukraine Amateurliga A",
		"Ukraine Amateurliga B",
		"Moldawien 1.Liga",
		"Moldawien 2.Liga",
		"Moldawien Amateurliga A",
		"Moldawien Amateurliga B",
		"Israel 1.Liga",
		"Israel 2.Liga",
		"Israel Amateurliga A",
		"Israel Amateurliga B",
		"Luxemburg 1.Liga",
		"Luxemburg 2.Liga",
		"Luxemburg Amateurliga A",
		"Luxemburg Amateurliga B",
		"Slowakei 1.Liga",
		"Slowakei 2.Liga",
		"Slowakei Amateurliga",
		"Mazedonien 1.Liga",
		"Mazedonien 2.Liga",
		"Mazedonien Amateurliga",
		"Litauen 1.Liga",
		"Litauen 2.Liga",
		"Litauen Amateurliga",
		"Lettland 1.Liga",
		"Lettland 2.Liga",
		"Lettland Amateurliga",
		"Weissrussland 1.Liga",
		"Weissrussland 2.Liga",
		"Weissrussland Amateurliga",
		"Malta 1.Liga",
		"Malta 2.Liga",
		"Malta Amateurliga",
		"Zypern 1.Liga",
		"Zypern 2.Liga",
		"Zypern Amateurliga",
		"Albanien 1.Liga",
		"Albanien 2.Liga",
		"Georgien 1.Liga",
		"Georgien 2.Liga",
		"Armenien 1.Liga",
		"Armenien 2.Liga",
		"Aserbaidschan 1.Liga",
		"Aserbaidschan 2.Liga",
		"Andorra 1.Liga",
		"Andorra 2.Liga",
		"Faeroer Inseln 1.Liga",
		"San Marino 1.Liga"
	);
	return (@liga_namen);
}

sub tmi_liga_kat {
	my @liga_kat = ( 0, 1, 3, 5, 5, 1, 3, 5, 5, 1, 3, 5, 5, 1, 3, 5, 5, 2, 4, 6, 6, 2, 4, 6, 6, 2, 4, 6, 6, 2, 4, 6, 6, 2, 4, 6, 6, 2, 4, 6, 6, 2, 4, 6, 6, 4, 6, 4, 6, 4, 6, 3, 5, 3, 5, 3, 5, 4, 6, 5, 7, 4, 6, 3, 5, 4, 6, 4, 6, 3, 5, 4, 6, 3, 5, 3, 5, 4, 6, 5, 7, 5, 7, 4, 6, 3, 5, 3, 5, 4, 6, 4, 6, 4, 6, 4, 6, 3, 5, 5, 7, 4, 6, 5, 7, 5, 7, 4, 6, 5, 7, 5, 7, 5, 7, 5, 7, 5, 5 );
	return (@liga_kat);
}

sub tmi_liga_kuerzel {

	@liga_kuerzel = (
		"---",
		"ITA I",
		"ITA II",
		"ITA III/A",
		"ITA III/B",
		"ITA IV/A",
		"ITA IV/B",
		"ITA IV/C",
		"ITA IV/D",
		"ENG I",
		"ENG II",
		"ENG III/A",
		"ENG III/B",
		"ENG IV/A",
		"ENG IV/B",
		"ENG IV/C",
		"ENG IV/D",
		"SPA I",
		"SPA II",
		"SPA III/A",
		"SPA III/B",
		"SPA IV/A",
		"SPA IV/B",
		"SPA IV/C",
		"SPA IV/D",
		"FRA I",
		"FRA II",
		"FRA III/A",
		"FRA III/B",
		"FRA IV/A",
		"FRA IV/B",
		"FRA IV/C",
		"FRA IV/D",
		"NED I",
		"NED II",
		"NED III/A",
		"NED III/B",
		"NED IV/A",
		"NED IV/B",
		"POR I",
		"POR II",
		"POR III/A",
		"POR III/B",
		"POR IV/A",
		"POR IV/B",
		"BEL I",
		"BEL II",
		"BEL III/A",
		"BEL III/B",
		"BEL IV/A",
		"BEL IV/B",
		"SUI I",
		"SUI II",
		"SUI III/A",
		"SUI III/B",
		"SUI IV/A",
		"SUI IV/B",
		"AUT I",
		"AUT II",
		"AUT III/A",
		"AUT III/B",
		"AUT IV/A",
		"AUT IV/B",
		"SCO I",
		"SCO II",
		"SCO III/A",
		"SCO III/B",
		"SCO IV/A",
		"SCO IV/B",
		"TUR I",
		"TUR II",
		"TUR III/A",
		"TUR III/B",
		"TUR IV/A",
		"TUR IV/B",
		"IRL I",
		"IRL II",
		"IRL III/A",
		"IRL III/B",
		"NIR I",
		"NIR II",
		"NIR III/A",
		"NIR III/B",
		"WAL I",
		"WAL II",
		"WAL III/A",
		"WAL III/B",
		"DEN I",
		"DEN II",
		"DEN III/A",
		"DEN III/B",
		"NOR I",
		"NOR II",
		"NOR III/A",
		"NOR III/B",
		"SWE I",
		"SWE II",
		"SWE III/A",
		"SWE III/B",
		"FIN I",
		"FIN II",
		"FIN III/A",
		"FIN III/B",
		"ISL I",
		"ISL II",
		"ISL III/A",
		"ISL III/B",
		"POL I",
		"POL II",
		"POL III/A",
		"POL III/B",
		"TCH I",
		"TCH II",
		"TCH III/A",
		"TCH III/B",
		"UNG I",
		"UNG II",
		"UNG III/A",
		"UNG III/B",
		"RUM I",
		"RUM II",
		"RUM III/A",
		"RUM III/B",
		"SLO I",
		"SLO II",
		"SLO III/A",
		"SLO III/B",
		"KRO I",
		"KRO II",
		"KRO III/A",
		"KRO III/B",
		"JUG I",
		"JUG II",
		"JUG III/A",
		"JUG III/B",
		"BoH I",
		"BoH II",
		"BoH III/A",
		"BoH III/B",
		"BUL I",
		"BUL II",
		"BUL III/A",
		"BUL III/B",
		"GRI I",
		"GRI II",
		"GRI III/A",
		"GRI III/B",
		"RUS I",
		"RUS II",
		"RUS III/A",
		"RUS III/B",
		"EST I",
		"EST II",
		"EST III/A",
		"EST III/B",
		"UKR I",
		"UKR II",
		"UKR III/A",
		"UKR III/B",
		"MOL I",
		"MOL II",
		"MOL III/A",
		"MOL III/B",
		"ISR I",
		"ISR II",
		"ISR III/A",
		"ISR III/B",
		"LUX I",
		"LUX II",
		"LUX III/A",
		"LUX III/B",
		"SLK I",
		"SLK II",
		"SLK III",
		"MAZ I",
		"MAZ II",
		"MAZ III",
		"LIT I",
		"LIT II",
		"LIT III",
		"LET I",
		"LET II",
		"LET III",
		"WRU I",
		"WRU II",
		"WRU III",
		"MAL I",
		"MAL II",
		"MAL III",
		"ZYP I",
		"ZYP II",
		"ZYP III",
		"ALB I",
		"ALB II",
		"GEO I",
		"GEO II",
		"ARM I",
		"ARM II",
		"ASE I",
		"ASE II",
		"AND I",
		"AND II",
		"FAE I",
		"SaM I"
	);

	return (@liga_kuerzel);
}

sub listOnTMIJobBoerse() {
	my $ligaIndex = shift;

}

sub btm_saison_namen {
	@main_saison = (
		"0",
		"Saison 1997'1",
		"Saison 1998'1",
		"Saison 1998'2",
		"Saison 1998'3",
		"Saison 1998'4",
		"Saison 1999'1",
		"Saison 1999'2",
		"Saison 1999'3",
		"Saison 1999'4",
		"Saison 1999'5",
		"Saison 2000'1",
		"Saison 2000'2",
		"Saison 2000'3",
		"Saison 2000'4",
		"Saison 2001'1",
		"Saison 2001'2",
		"Saison 2001'3",
		"Saison 2001'4",
		"Saison 2001'5",
		"Saison 2002'1",
		"Saison 2002'2",
		"Saison 2002'3",
		"Saison 2002'4",
		"Saison 2002'5",
		"Saison 2002'6",
		"Saison 2003'1",
		"Saison 2003'2",
		"Saison 2003'3",
		"Saison 2003'4",
		"Saison 2003'5",
		"Saison 2004'1",
		"Saison 2004'2",
		"Saison 2004'3",
		"Saison 2004'4",
		"Saison 2004'5",
		"Saison 2004'6",
		"Saison 2005'1",
		"Saison 2005'2",
		"Saison 2005'3",
		"Saison 2005'4",
		"Saison 2005'5",
		"Saison 2005'6",
		"Saison 2006'1",
		"Saison 2006'2",
		"Saison 2006'3",
		"Saison 2006'4",
		"Saison 2006'5",
		"Saison 2007'1",
		"Saison 2007'2",
		"Saison 2007'3",
		"Saison 2007'4",
		"Saison 2007'5",
		"Saison 2007'6",
		"Saison 2008'1",
		"Saison 2008'2",
		"Saison 2008'3",
		"Saison 2008'4",
		"Saison 2008'5",
		"Saison 2009'1",
		"Saison 2009'2",
		"Saison 2009'3",
		"Saison 2009'4",
		"Saison 2009'5",
		"Saison 2009'6",
		"Saison 2010'1",
		"Saison 2010'2",
		"Saison 2010'3",
		"Saison 2010'4",
		"Saison 2010'5",
		"Saison 2011'1",
		"Saison 2011'2",
		"Saison 2011'3",
		"Saison 2011'4",
		"Saison 2011'5",
		"Saison 2011'6",
		"Saison 2012'1",
		"Saison 2012'2",
		"Saison 2012'3",
		"Saison 2012'4",
		"Saison 2012'5",
		"Saison 2012'6",
		"Saison 2013'1",
		"Saison 2013'2",
		"Saison 2013'3",
		"Saison 2013'4",
		"Saison 2013'5",
		"Saison 2014'1",
		"Saison 2014'2",
		"Saison 2014'3",
		"Saison 2014'4",
		"Saison 2014'5",
		"Saison 2014'6",
		"Saison 2015'1",
		"Saison 2015'2",
		"Saison 2015'3",
		"Saison 2015'4",
		"Saison 2015'5",
		"Saison 2016'1",
		"Saison 2016'2",
		"Saison 2016'3",
		"Saison 2016'4",
		"Saison 2016'5",
		"Saison 2016'6",
		"Saison 2017'1",
		"Saison 2017'2",
		"Saison 2017'3",
		"Saison 2017'4",
		"Saison 2017'5",
		"Saison 2017'6",
		"Saison 2018'1",
		"Saison 2018'2",
		"Saison 2019'1",
		"Saison 2019'2",
		"Saison 2019'3",
		"Saison 2019'4",
		"Saison 2019'5",
		"Saison 2020'1",
		"Saison 2020'2",
		"Saison 2020'3",
		"Saison 2020'4",
		"Saison 2021'1",
		"Saison 2021'2",
		"Saison 2021'3",
		"Saison 2021'4",
		"Saison 2021'5",
	);

	open( D1, "</tmdata/btm/main_nr.txt" );
	$main_saison[0] = <D1>;
	chomp $main_saison[0];
	close(D1);
	return @main_saison;
}

sub tmi_saison_namen {
	@main_saison = (
		"0",
		"Saison 1997'1",
		"Saison 1998'1",
		"Saison 1998'2",
		"Saison 1998'3",
		"Saison 1998'4",
		"Saison 1999'1",
		"Saison 1999'2",
		"Saison 1999'3",
		"Saison 1999'4",
		"Saison 1999'5",
		"Saison 2000'1",
		"Saison 2000'3",
		"Saison 2000'4",
		"Saison 2001'1",
		"Saison 2001'2",
		"Saison 2001'3",
		"Saison 2001'4",
		"Saison 2001'5",
		"Saison 2002'1",
		"Saison 2002'2",
		"Saison 2002'3",
		"Saison 2002'4",
		"Saison 2002'5",
		"Saison 2002'6",
		"Saison 2003'1",
		"Saison 2003'2",
		"Saison 2003'3",
		"Saison 2003'4",
		"Saison 2003'5",
		"Saison 2004'1",
		"Saison 2004'2",
		"Saison 2004'3",
		"Saison 2004'4",
		"Saison 2004'5",
		"Saison 2004'6",
		"Saison 2005'1",
		"Saison 2005'2",
		"Saison 2005'3",
		"Saison 2005'4",
		"Saison 2005'5",
		"Saison 2005'6",
		"Saison 2006'1",
		"Saison 2006'2",
		"Saison 2006'3",
		"Saison 2006'4",
		"Saison 2006'5",
		"Saison 2007'1",
		"Saison 2007'2",
		"Saison 2007'3",
		"Saison 2007'4",
		"Saison 2007'5",
		"Saison 2007'6",
		"Saison 2008'1",
		"Saison 2008'2",
		"Saison 2008'3",
		"Saison 2008'4",
		"Saison 2008'5",
		"Saison 2009'1",
		"Saison 2009'2",
		"Saison 2009'3",
		"Saison 2009'4",
		"Saison 2009'5",
		"Saison 2009'6",
		"Saison 2010'1",
		"Saison 2010'2",
		"Saison 2010'3",
		"Saison 2010'4",
		"Saison 2010'5",
		"Saison 2011'1",
		"Saison 2011'2",
		"Saison 2011'3",
		"Saison 2011'4",
		"Saison 2011'5",
		"Saison 2011'6",
		"Saison 2012'1",
		"Saison 2012'2",
		"Saison 2012'3",
		"Saison 2012'4",
		"Saison 2012'5",
		"Saison 2012'6",
		"Saison 2013'1",
		"Saison 2013'2",
		"Saison 2013'3",
		"Saison 2013'4",
		"Saison 2013'5",
		"Saison 2014'1",
		"Saison 2014'2",
		"Saison 2014'3",
		"Saison 2014'4",
		"Saison 2014'5",
		"Saison 2014'6",
		"Saison 2015'1",
		"Saison 2015'2",
		"Saison 2015'3",
		"Saison 2015'4",
		"Saison 2015'5",
		"Saison 2016'1",
		"Saison 2016'2",
		"Saison 2016'3",
		"Saison 2016'4",
		"Saison 2016'5",
		"Saison 2016'6",
		"Saison 2017'1",
		"Saison 2017'2",
		"Saison 2017'3",
		"Saison 2017'4",
		"Saison 2017'5",
		"Saison 2017'6",
		"Saison 2018'1",
		"Saison 2018'2",

		"Saison 2019'1",
		"Saison 2019'2",
		"Saison 2019'3",
		"Saison 2019'4",
		"Saison 2019'5",
		"Saison 2020'1",
		"Saison 2020'2",
		"Saison 2020'3",
		"Saison 2020'4",
		"Saison 2021'1",
		"Saison 2021'2",
		"Saison 2021'3",
		"Saison 2021'4",
		"Saison 2021'5",

	);

	open( D1, "</tmdata/tmi/main_nr.txt" );
	$main_saison[0] = <D1>;
	chomp $main_saison[0];
	close(D1);
	return @main_saison;
}

sub btm_saison_kuerzel {
	@main_kuerzel = (
		"leer",
		"",    "",    "982", "",    "984",
		"991", "992", "993", "994", "995",
		"001", "002", "003", "004",
		"011", "012", "013", "014", "015",
		"021", "022", "023", "024", "025", "026",
		"031", "032", "033", "034", "035",
		"041", "042", "043", "044", "045", "046",
		"051", "052", "053", "054", "055", "056",
		"061", "062", "063", "064", "065",
		"071", "072", "073", "074", "075", "076",
		"081", "082", "083", "084", "085",
		"091", "092", "093", "094", "095", "096",
		"101", "102", "103", "104", "105",
		"111", "112", "113", "114", "115", "116",
		"121", "122", "123", "124", "125", "126",
		"131", "132", "133", "134", "135",
		"141", "142", "143", "144", "145", "146",
		"151", "152", "153", "154", "155",
		"161", "162", "163", "164", "165", "166",
		"171", "172", "173", "174", "175", "176",
		"181", "182",
		"191", "192", "193", "194", "195",
		"201", "202", "203", "204",
		"211", "212", "213", "214", "215",

	);
	return @main_kuerzel;
}

sub tmi_saison_kuerzel {
	@main_kuerzel = (
		"leer", "",    "",    "982", "",    "984", "991", "992", "993", "994", "995", "001", "003", "004",
		"011",  "012", "013", "014", "015", "021", "022", "023", "024", "025", "026", "031", "032", "033",
		"034",  "035", "041", "042", "043", "044", "045", "046", "051", "052", "053", "054", "055", "056",
		"061",  "062", "063", "064", "065", "071", "072", "073", "074", "075", "076", "081", "082", "083",
		"084",  "085", "091", "092", "093", "094", "095", "096", "101", "102", "103", "104", "105", "111",
		"112",  "113", "114", "115", "116", "121", "122", "123", "124", "125", "126", "131", "132", "133",
		"134",  "135", "141", "142", "143", "144", "145", "146", "151", "152", "153", "154", "155", "161",
		"162",  "163", "164", "165", "166",
		"171", "172", "173", "174", "175", "176",
		"181", "182",
		"191", "192", "193", "194", "195",
		"201", "202", "203", "204",
		"211", "212", "213", "214", "215",
	);
	return @main_kuerzel;
}

sub btm_liga_kuerzel {

	my @liga_kuerzel = (
		"---",    "1.BL",   "2.BL",   "RL A",   "RL B",   "OL A",   "OL B",   "OL C",   "OL D",   "VL A",   "VL B",   "VL C",   "VL D",   "VL E",   "VL F",   "VL G",   "VL H",   "LA A",   "LA B",  "LA C",  "LA D",  "LA E",  "LA F",  "LA G",  "LA H",   "LA I",   "LA K",   "LA L",   "LA M",   "LA N",   "LA O",   "LA P",   "LA R",   "BE 01",
		"BE 02",  "BE 03",  "BE 04",  "BE 05",  "BE 06",  "BE 07",  "BE 08",  "BE 09",  "BE 10",  "BE 11",  "BE 12",  "BE 13",  "BE 14",  "BE 15",  "BE 16",  "BE 17",  "BE 18",  "BE 19",  "BE 20", "BE 21", "BE 22", "BE 23", "BE 24", "BE 25", "BE 26",  "BE 27",  "BE 28",  "BE 29",  "BE 30",  "BE 31",  "BE 32",  "KR 01",  "KR 02",  "KR 03",
		"KR 04",  "KR 05",  "KR 06",  "KR 07",  "KR 08",  "KR 09",  "KR 10",  "KR 11",  "KR 12",  "KR 13",  "KR 14",  "KR 15",  "KR 16",  "KR 17",  "KR 18",  "KR 19",  "KR 20",  "KR 21",  "KR 22", "KR 23", "KR 24", "KR 25", "KR 26", "KR 27", "KR 28",  "KR 29",  "KR 30",  "KR 31",  "KR 32",  "KR 33",  "KR 34",  "KR 35",  "KR 36",  "KR 37",
		"KR 38",  "KR 39",  "KR 40",  "KR 41",  "KR 42",  "KR 43",  "KR 44",  "KR 45",  "KR 46",  "KR 47",  "KR 48",  "KR 49",  "KR 50",  "KR 51",  "KR 52",  "KR 53",  "KR 54",  "KR 55",  "KR 56", "KR 57", "KR 58", "KR 59", "KR 60", "KR 61", "KR 62",  "KR 63",  "KR 64",  "KK 01",  "KK 02",  "KK 03",  "KK 04",  "KK 05",  "KK 06",  "KK 07",
		"KK 08",  "KK 09",  "KK 10",  "KK 11",  "KK 12",  "KK 13",  "KK 14",  "KK 15",  "KK 16",  "KK 17",  "KK 18",  "KK 19",  "KK 20",  "KK 21",  "KK 22",  "KK 23",  "KK 24",  "KK 25",  "KK 26", "KK 27", "KK 28", "KK 29", "KK 30", "KK 31", "KK 32",  "KK 33",  "KK 34",  "KK 35",  "KK 36",  "KK 37",  "KK 38",  "KK 39",  "KK 40",  "KK 41",
		"KK 42",  "KK 43",  "KK 44",  "KK 45",  "KK 46",  "KK 47",  "KK 48",  "KK 49",  "KK 50",  "KK 51",  "KK 52",  "KK 53",  "KK 54",  "KK 55",  "KK 56",  "KK 57",  "KK 58",  "KK 59",  "KK 60", "KK 61", "KK 62", "KK 63", "KK 64", "KK 65", "KK 66",  "KK 67",  "KK 68",  "KK 69",  "KK 70",  "KK 71",  "KK 72",  "KK 73",  "KK 74",  "KK 75",
		"KK 76",  "KK 77",  "KK 78",  "KK 79",  "KK 80",  "KK 81",  "KK 82",  "KK 83",  "KK 84",  "KK 85",  "KK 86",  "KK 87",  "KK 88",  "KK 89",  "KK 90",  "KK 91",  "KK 92",  "KK 93",  "KK 94", "KK 95", "KK 96", "KK 97", "KK 98", "KK 99", "KK 100", "KK 101", "KK 102", "KK 103", "KK 104", "KK 105", "KK 106", "KK 107", "KK 108", "KK 109",
		"KK 110", "KK 111", "KK 112", "KK 113", "KK 114", "KK 115", "KK 116", "KK 117", "KK 118", "KK 119", "KK 120", "KK 121", "KK 122", "KK 123", "KK 124", "KK 125", "KK 126", "KK 127", "KK 128"
	);
	for ( my $x11 = 257 ; $x11 <= 384 ; $x11++ ) {
		my $y11 = $x11 - 256;
		$liga_kuerzel[$x11] = "KS $y11";
	}

	return @liga_kuerzel;
}

sub banner_gross {

#	$number = '
#<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
#<!-- TM 728x90 -->
#<ins class="adsbygoogle"
#     style="display:inline-block;width:728px;height:90px"
#     data-ad-client="ca-pub-7019464997176631"
#     data-ad-slot="2885553308"></ins>
#<script>
#(adsbygoogle = window.adsbygoogle || []).push({});
#</script>
#<!--
#<iframe id=\'acae648c\' name=\'acae648c\' src=\'http://advertising.fussball-liveticker.eu/www/delivery/afr.php?zoneid=84&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;ct0=INSERT_CLICKURL_HERE\' frameborder=\'0\' scrolling=\'no\' width=\'468\' height=\'60\'><a href=\'http://advertising.fussball-liveticker.eu/www/delivery/ck.php?n=a3108930&amp;cb=INSERT_RANDOM_NUMBER_HERE\' target=\'_blank\'><img src=\'http://advertising.fussball-liveticker.eu/www/delivery/avw.php?zoneid=84&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=a3108930&amp;ct0=INSERT_CLICKURL_HERE\' border=\'0\' alt=\'\' /></a></iframe>
#-->

return '';

$number = '
<!-- Paste the above code right above the closing </head> of the HTML in your tipmaster.de -->
<script type="text/javascript" src="//services.vlitag.com/adv1/?q=b4ec91b2a704e5df94c61d878f983522" defer="" async=""></script><script> var vitag = vitag || {};</script>
<!-- End Valueimpression Head Script -->
<!-- tipmaster.de_970x250: Begin -->

<div style="display:flex;justify-content:flex-start;padding-bottom:10px;width:970px;padding-left:25px;">
<div class="adsbyvli" data-ad-slot="vi_1335352012"></div><script>(vitag.Init = window.vitag.Init || []).push(function(){viAPItag.display("vi_1335352012")})</script>
<!-- tipmaster.de_970x250 End -->
</div>
';
	return $number;

	$number = '
	
	
<iframe id=\'a52022f2\' name=\'a52022f2\' src=\'https://ads.socapro.com/www/delivery/afr.php?refresh=60&amp;zoneid=367&amp;cb='
	  . $cachebuster
	  . '&amp;ct0=INSERT_ENCODED_CLICKURL_HERE\' frameborder=\'0\' scrolling=\'no\' width=\'728\' height=\'90\'><a href=\'https://ads.socapro.com/www/delivery/ck.php?n=ad110454&amp;cb='
	  . $cachebuster
	  . '\' target=\'_blank\'><img src=\'https://ads.socapro.com/www/delivery/avw.php?zoneid=367&amp;cb='
	  . $cachebuster
	  . '&amp;n=ad110454&amp;ct0=INSERT_ENCODED_CLICKURL_HERE\' border=\'0\' alt=\'\' /></a></iframe>
&nbsp;';

	return $number;
}

sub banner_bottom {

return '';

$number = '
<div id="76383-6"><script src="//ads.themoneytizer.com/s/gen.js?type=6"></script><script src="//ads.themoneytizer.com/s/requestform.js?siteId=76383&formatId=6"></script></div>
';
	return $number;

}

sub banner_klein {

	return;
	my $tag_klein = '
<iframe id=\'acae648c\' name=\'acae648c\' src=\'http://advertising.fussball-liveticker.eu/www/delivery/afr.php?zoneid=85&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;ct0=INSERT_CLICKURL_HERE\' frameborder=\'0\' scrolling=\'no\' width=\'234\' height=\'60\'><a href=\'http://advertising.fussball-liveticker.eu/www/delivery/ck.php?n=a3108930&amp;cb=INSERT_RANDOM_NUMBER_HERE\' target=\'_blank\'><img src=\'http://advertising.fussball-liveticker.eu/www/delivery/avw.php?zoneid=85&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=a3108930&amp;ct0=INSERT_CLICKURL_HERE\' border=\'0\' alt=\'\' /></a></iframe>

';

	return $tag_klein;
}

sub banner_head {

	my $sek           = "";
	my $min           = "";
	my $std           = "";
	my $tag           = "";
	my $mon           = "";
	my $jahr          = "";
	my $ww            = "";
	my $ran           = "";
	my $jja           = "";
	my $jjm           = "";
	my $jjj           = "";
	my $xx1           = "";
	my @kampagnen_id  = ();
	my @kampagnen_img = ();
	my @kampagnen_url = ();
	my $mleg          = "";
	my $go            = "";
	my $xa1           = "";
	my $xb1           = "";
	my $xc1           = "";
	my $xd1           = "";
	my $xe1           = "";
	my $xf1           = "";
	my $xg1           = "";
	my $gg1           = "";
	my $dateiname     = "";
	my $r             = "";
	my $ver           = "";
	my @banner_url    = ();
	my @sponsor_fir   = ();
	my $aaff          = "";
	my $number        = "";
	srand();
	$gg1 = int( 10 * rand ) + 44;

	$number = '
	
			<div style="
    display: inline-block;
    min-height: inherit;
   	width: 100%;
   	max-width:1024px;
    text-align:center">
		<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<!-- FLT Horizontal 2019-09-06 -->
<ins class="adsbygoogle"
     style="display:block"
     data-ad-client="ca-pub-4704356426999787"
     data-ad-slot="9746730021"
     data-ad-format="auto"
     data-full-width-responsive="true"></ins>
<script>
     (adsbygoogle = window.adsbygoogle || []).push({});
</script>
</div>
	'."
<!-- BEGIN PARTNER PROGRAM - DO NOT CHANGE THE PARAMETERS OF THE HYPERLINK -->
<A HREF=\"http://partners.webmasterplan.com/click.asp?ref=38356&site=1387&type=b$gg1&bnb=$gg1\" TARGET=\"_top\">
<IMG SRC=http://banners.webmasterplan.com/view.asp?site=1387&ref=38356&b=$gg1 BORDER=0 
ALT=\"kostenloser Vergleich privater Krankenversicherer\" WIDTH=140 HEIGHT=200></A>
<!-- END PARTNER PROGRAM -->
";

	return $number;

}

sub page_footer {

	$page_footer = '
<!-- Google Tag Manager -->
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-KX6R92"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':
new Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=
\'//www.googletagmanager.com/gtm.js?id=\'+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,\'script\',\'dataLayer\',\'GTM-KX6R92\');</script>
<!-- End Google Tag Manager -->

</body></html>
';
	return $page_footer;
}
1;
