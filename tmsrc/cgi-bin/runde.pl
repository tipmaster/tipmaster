#!/usr/bin/perl

=head1 NAME
	runde.pl

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

# TOP - TIP Runde

#open (D1,"</home/tmdata/top_tip.txt");$tt_rrunde=<D1>;$top_tip_runde_aktiv=<D1>;chomp $tt_rrunde;chomp $top_tip_runde_aktiv;close(D1);

#print "ttrunde $tt_runde";
# Tiprunde BTM / TMI
open( D1, "</tmdata/rrunde.txt" );
$rrunde = <D1>;
chomp $rrunde;
close(D1);

# Pokalrunde TMI / Formular Nr.

open( D1, "</tmdata/tmi/pokal/pokal_datum.txt" );
$cup_tmi = <D1>;
chomp $cup_tmi;
close(D1);
@cup_tmi_tf      = ( undef, 2, 4, 5, 7, 9 );
@cup_tmi_aktiv_f = ( 0,     0, 1, 0, 1, 1, 0, 1, 0, 1 );
@cup_tmi_round   = ( 0,     1, 1, 2, 2, 3, 4, 4, 5, 5 );
$cup_tmi_aktiv = $cup_tmi_aktiv_f[$rrunde];

# Pokalrunde BTM / Formular Nr.
open( D1, "</tmdata/btm/pokal/pokal_datum.txt" );
$cup_btm = <D1>;
chomp $cup_btm;
close(D1);
@cup_btm_tf      = ( undef, 2, 3, 4, 5, 6, 7, 9 );
@cup_btm_aktiv_f = ( 0,     0, 1, 1, 1, 1, 1, 1, 0, 1 );
@cup_btm_round   = ( 0,     1, 1, 2, 3, 4, 5, 6, 7, 7 );
$cup_btm_aktiv = $cup_btm_aktiv_f[$rrunde];

@cup_tmi_name =
  ( "TMI - Landespokal", "", "1.Hauptrunde", "", "Achtelfinale", "Viertelfinale", "", "Halbfinale", "", "Finale" );
@cup_dfb_name = (
	"BTM DFB - Pokal", "",           "", "1.Hauptrunde", "2.Hauptrunde", "Achtelfinale",
	"Viertelfinale",   "Halbfinale", "", "Finale"
);
@cup_btm_name = (
	"BTM Amateurpokal", "",             "Qualifikationsrunde", "1.Hauptrunde",
	"2.Hauptrunde",     "Achtelfinale", "Viertelfinale",       "Halbfinale",
	"",                 "Finale"
);
@cup_cl_name = (
	"Champions - League",     "1.Qualifikationsrunde",     "2.Qualifikationsrunde", "3.Qualifikationsrunde",
	"Gruppenspiele Hinrunde", "Gruppenspiele Rueckrunde",, "Achtelfinale",
	"Viertelfinale",          "Halbfinale",                "Finale"
);
@cup_uefa_name = (
	"UEFA - Pokal",  "1.Qualifikationsrunde", "2.Qualifikationsrunde", "1.Hauptrunde",
	"2.Hauptrunde",  "3.Hauptrunde",,         "Achtelfinale",
	"Viertelfinale", "Halbfinale",            "Finale"
);

#FLAGGEN - ARRAY

@main_flags = (
	"uefa.gif",    "tip_ger.gif", "tip_ger.gif", "tip_eng.gif", "tip_fra.gif", "tip_ita.gif",
	"tip_swi.gif", "tip_aut.gif", "tip_spa.gif", "tip_no.gif",  "tip_swe.gif", "tip_nor.gif",
	"tip_fin.gif", "tip_den.gif", "tip_ned.gif", "tip_sco.gif", "flag_wm.gif", "tip_ger.gif",
	"tip_rus.gif", "tip_por.gif", "tip_irl.gif", "tip_usa.gif", "tip_isl.gif", "tip_bel.gif",
	"tip_ukr.gif", "tip_tur.gif", "tip_pol.gif", "tip_gri.gif", "tip_cze.gif", "tip_bel.gif",
	"tip_f14.gif", "tip_bra.gif", "tip_jap.gif", "tip_em16.gif"
);

$main_flags[34] = "tip_kor.gif";
$main_flags[35] = "tip_wru.gif";
$main_flags[35] = "tip_rom.gif";

# Job - Boerse auf=1/zu=0
$boerse_open = 1;

sub chat_user {

	#open (D1,"</home/tm/www/chat_user.htm");
	#while(<D1>){
	#$r++;$konst[1]=$_;
	#chomp $konst[1];
	#$konst[1]=~s/-//;
	#@konste = split (/ \- /,$konst[1]);
	#if (( $konste[0] ne "" )and($r >2)) {
	#$chat_user++;
	#}}
	#close(D1);
	return $chat_user;
}

1;
