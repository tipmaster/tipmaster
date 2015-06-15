#!/usr/bin/perl

=head1 NAME
	tmi_ligen_old.pl

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
my $session = TMSession::getSession( btm_login => 1 );
my $trainer = $session->getUser();
my $leut    = $trainer;

use CGI;

@liga_namen = (
	"spacer",
	"Italien Serie A",
	"Italien Serie B",
	"England Premier League",
	"England 1.Division",
	"Spanien Primera Division",
	"Spanien Segunda Division",
	"Frankreich Premiere Division",
	"Frankreich 1.Division",
	"Niederlande Ehrendivision",
	"Niederlande 1.Division",
	"Portugal 1.Divisao",
	"Portugal 2.Divisao",
	"Belgien 1.Division",
	"Belgien 2.Division",
	"Schweiz Nationalliga A",
	"Schweiz Nationalliga B",
	"Oesterreich Bundesliga",
	"Oesterreich 1.Division",
	"Schottland 1.Liga",
	"Schottland 2.Liga",
	"Tuerkei 1.Liga",
	"Tuerkei 2.Liga",
	"Irland 1.Liga",
	"Nord Irland 1.Liga",
	"Wales 1.Liga",
	"Daenemark 1.Liga",
	"Norwegen 1.Liga",
	"Schweden 1.Liga",
	"Finnland 1.Liga",
	"Island 1.Liga",
	"Faeroer Inseln 1.Liga",
	"Polen 1.Liga",
	"Tschechien 1.Liga",
	"Slowakei 1.Liga",
	"Ungarn 1.Liga",
	"Rumaenien 1.Liga",
	"Slowenien 1.Liga",
	"Kroatien 1.Liga",
	"Jugoslawien 1.Liga",
	"Bosnien-Herz. 1.Liga",
	"Mazedonien 1.Liga",
	"Albanien 1.Liga",
	"Bulgarien 1.Liga",
	"Griechenland 1.Liga",
	"Russland 1.Liga",
	"Estland 1.Liga",
	"Litauen 1.Liga",
	"Lettland 1.Liga",
	"Weissrussland 1.Liga",
	"Ukraine 1.Liga",
	"Moldawien 1.Liga",
	"Georgien 1.Liga",
	"Armenien 1.Liga",
	"Aserbaidschan 1.Liga",
	"Israel 1.Liga",
	"Andorra 1.Liga",
	"Luxemburg 1.Liga",
	"Malta 1.Liga",
	"San Marino 1.Liga",
	"Zypern 1.Liga"
);

@liga_kuerzel = (
	"spacer", "ITA I", "ITA II", "ENG I", "ENG II", "SPA I", "SPA II", "FRA I", "FRA II", "NED I", "NED II", "POR I",
	"POR II", "BEL I", "BEL II", "SUI I", "SUI II", "AUT I", "AUT II", "SCO I", "SCO II", "TUR I", "TUR II", "IRL I",
	"NIR I",  "WAL I", "DEN I",  "NOR I", "SWE I",  "FIN I", "ISL I",  "FAE I", "POL I",  "TCH I", "SLK I",  "UNG I",
	"RUM I",  "SLO I", "KRO I",  "JUG I", "BoH I",  "MAZ I", "ALB I",  "BUL I", "GRI I",  "RUS I", "EST I",  "LIT I",
	"LET I",  "WRU I", "UKR I",  "MOL I", "GEO I",  "ARM",   "ASE I",  "ISR I", "AND I",  "LUX I", "MAL I",  "SaM I",
	"ZYP I"
);

@liga_kat = (
	0, 1, 3, 1, 3, 1, 3, 1, 3, 2, 4, 2, 4, 2, 4, 2, 4, 2, 4, 2, 4, 2, 4, 4, 4, 4, 3, 3, 3, 4, 5, 5,
	4, 3, 4, 4, 3, 4, 3, 3, 4, 5, 5, 4, 3, 3, 4, 4, 4, 4, 3, 5, 4, 5, 5, 4, 5, 5, 5, 5, 5
);

