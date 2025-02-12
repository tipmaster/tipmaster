#!/usr/bin/perl

#print "ttrunde $tt_runde";
# Tiprunde BTM / TMI
open( D1, "<./rrunde.txt" );
$rrunde = <D1>;
chomp $rrunde;
close(D1);

# Pokalrunde TMI / Formular Nr.

open( D1, "<./tmi/pokal/pokal_datum.txt" );
$cup_tmi = <D1>;
chomp $cup_tmi;
close(D1);
@cup_tmi_tf      = ( undef, 2, 4, 5, 7, 9 );
@cup_tmi_aktiv_f = ( 0,     0, 1, 0, 1, 1, 0, 1, 0, 1 );
@cup_tmi_round   = ( 0,     1, 1, 2, 2, 3, 4, 4, 5, 5 );
$cup_tmi_aktiv   = $cup_tmi_aktiv_f[$rrunde];

# Pokalrunde BTM / Formular Nr.
open( D1, "<./btm/pokal/pokal_datum.txt" );
$cup_btm = <D1>;
chomp $cup_btm;
close(D1);
@cup_btm_tf      = ( undef, 2, 3, 4, 5, 6, 7, 9 );
@cup_btm_aktiv_f = ( 0,     0, 1, 1, 1, 1, 1, 1, 0, 1 );
@cup_btm_round   = ( 0,     1, 1, 2, 3, 4, 5, 6, 7, 7 );
$cup_btm_aktiv   = $cup_btm_aktiv_f[$rrunde];

@cup_tmi_name  = ( "TMI - Landespokal",  "",                      "1.Hauptrunde",          "",                      "Achtelfinale",           "Viertelfinale",            "",              "Halbfinale",    "",           "Finale" );
@cup_dfb_name  = ( "BTM DFB - Pokal",    "",                      "",                      "1.Hauptrunde",          "2.Hauptrunde",           "Achtelfinale",             "Viertelfinale", "Halbfinale",    "",           "Finale" );
@cup_btm_name  = ( "BTM Amateurpokal",   "",                      "Qualifikationsrunde",   "1.Hauptrunde",          "2.Hauptrunde",           "Achtelfinale",             "Viertelfinale", "Halbfinale",    "",           "Finale" );
@cup_cl_name   = ( "Champions - League", "1.Qualifikationsrunde", "2.Qualifikationsrunde", "3.Qualifikationsrunde", "Gruppenspiele Hinrunde", "Gruppenspiele Rueckrunde", "Achtelfinale",  "Viertelfinale", "Halbfinale", "Finale" );
@cup_uefa_name = ( "UEFA - Pokal",       "1.Qualifikationsrunde", "2.Qualifikationsrunde", "1.Hauptrunde",          "2.Hauptrunde",           "3.Hauptrunde",             "Achtelfinale",  "Viertelfinale", "Halbfinale", "Finale" );

#FLAGGEN - ARRAY

@main_flags = (
    "uefa.gif",    "tip_ger.gif", "tip_ger.gif", "tip_eng.gif", "tip_fra.gif", "tip_ita.gif", "tip_swi.gif", "tip_aut.gif", "tip_spa.gif", "tip_no.gif",  "tip_swe.gif", "tip_nor.gif",
    "tip_fin.gif", "tip_den.gif", "tip_ned.gif", "tip_sco.gif", "flag_wm.gif", "tip_ger.gif", "tip_rus.gif", "tip_por.gif", "tip_irl.gif", "tip_usa.gif", "tip_isl.gif", "tip_bel.gif",
    "tip_ukr.gif", "tip_tur.gif", "tip_pol.gif", "tip_gri.gif", "tip_cze.gif", "tip_bel.gif", "tip_f14.gif", "tip_bra.gif", "tip_jap.gif", "tip_em16.gif"
);

$main_flags[34] = "tip_kor.gif";
$main_flags[35] = "tip_wru.gif";

# Job - Boerse auf=1/zu=0
$boerse_open = 1;

$spielrunde = $rrunde;

for ( $spielrunde = 1; $spielrunde <= 9; $spielrunde++ ) {

    $hier = ( $spielrunde * 4 ) - 3;

    # for ($liga=1;$liga<=384;$liga++){
    # $lok = $liga;
    # if ($liga<10) {$lok = '0' . $liga}

    # $bv = "DAT";
    # $txt = ".TXT";
    # $datei1 = '/tmdata/btm/exdat/' . $bv . $lok . '-' . $spielrunde . $txt;
    # $datei2 = '/tmdata/btm/' . $bv . $lok . $txt;

    # open (D1,">$datei1");
    # open (D2,"<$datei2");
    # while (<D2>) {
    # print D1 "$_";
    # }
    # close (D2);
    # close (D1);
    # }

    #print "Ex - Dat Dateien erzeugt ...\n";

    for ( $liga = 1; $liga <= 384; $liga++ ) {

        $spielhier = ( $spielrunde * 4 ) - 3;

        $fgh = $spielrunde;

        $lok = $liga;
        if ( $liga < 10 ) { $lok = '0' . $liga }

        $lok = $liga;
        if ( $liga < 10 ) { $lok = '0' . $liga }

        $bv           = "QU";
        $txt          = ".TXT";
        $rtz          = "S";
        $datei_quoten = 'tipos/' . $bv . $lok . $lo . $rtz . $fgh . $txt;

        $bx = "formular";
        $by = int( ( $spielrunde - 1 ) / 4 );
        $by++;
        $bv         = ".txt";
        $datei_hier = './' . $bx . $spielrunde . $bv;

        open( DO, $datei_hier );
        while (<DO>) {
            @vereine = <DO>;
        }
        close(DO);

        open( DO, "./spieltag.txt" );
        while (<DO>) {
            @ego = <DO>;
        }
        close(DO);

        $y = 0;
        for ( $x = 0; $x < 25; $x++ ) {
            $y++;
            chomp $vereine[$y];
            @egx          = split( /&/, $vereine[$y] );
            $paarung[$y]  = $ega[1];
            $qu_1[$y]     = $egx[2];
            $qu_0[$y]     = $egx[3];
            $qu_2[$y]     = $egx[4];
            $ergebnis[$y] = $egx[5];

        }
        print "$datei_quoten\n";
        open( DO, $datei_quoten );
        while (<DO>) {
            print $_;
            @tips = <DO>;

        }
        close(DO);
        $paar = -2;

        for ( $sp = $spielhier; $sp <= $spielhier + 3; $sp++ ) {
            $lin[ $sp + 1 ] = "";
            @ega = split( /&/, $ego[ $sp - 1 ] );
            for ( $qq = 1; $qq <= 17; $qq = $qq + 2 ) {
                $paar = $paar + 2;
                $row1 = $tips[$paar];
                $row2 = $tips[ $paar + 1 ];

                chomp $row1;
                chomp $row2;

                @tip1 = split( /,/, $row1 );
                @tip2 = split( /,/, $row2 );
                $y    = 0;
                for ( $x = 1; $x < 11; $x = $x + 2 ) {
                    $y        = $y + 1;
                    $pro1[$y] = $tip1[ $x - 1 ];
                    $sp1[$y]  = $tip1[$x];
                    $pro2[$y] = $tip2[ $x - 1 ];
                    $sp2[$y]  = $tip2[$x];
                }

                $su_1 = 0;
                $su_2 = 0;
                for ( $x = 1; $x < 6; $x++ ) {
                    if ( ( $pro1[$x] == 1 ) and ( $ergebnis[ $sp1[$x] ] == 1 ) ) { $su_1 = $su_1 + $qu_1[ $sp1[$x] ] }
                    if ( ( $pro1[$x] == 2 ) and ( $ergebnis[ $sp1[$x] ] == 2 ) ) { $su_1 = $su_1 + $qu_0[ $sp1[$x] ] }
                    if ( ( $pro1[$x] == 3 ) and ( $ergebnis[ $sp1[$x] ] == 3 ) ) { $su_1 = $su_1 + $qu_2[ $sp1[$x] ] }
                    if ( ( $pro1[$x] == 1 ) and ( $ergebnis[ $sp1[$x] ] == 4 ) ) { $su_1 = $su_1 + 10 }
                    if ( ( $pro1[$x] == 2 ) and ( $ergebnis[ $sp1[$x] ] == 4 ) ) { $su_1 = $su_1 + 10 }
                    if ( ( $pro1[$x] == 3 ) and ( $ergebnis[ $sp1[$x] ] == 4 ) ) { $su_1 = $su_1 + 10 }

                    if ( ( $pro2[$x] == 1 ) and ( $ergebnis[ $sp2[$x] ] == 1 ) ) { $su_2 = $su_2 + $qu_1[ $sp2[$x] ] }
                    if ( ( $pro2[$x] == 2 ) and ( $ergebnis[ $sp2[$x] ] == 2 ) ) { $su_2 = $su_2 + $qu_0[ $sp2[$x] ] }
                    if ( ( $pro2[$x] == 3 ) and ( $ergebnis[ $sp2[$x] ] == 3 ) ) { $su_2 = $su_2 + $qu_2[ $sp2[$x] ] }
                    if ( ( $pro2[$x] == 1 ) and ( $ergebnis[ $sp2[$x] ] == 4 ) ) { $su_2 = $su_2 + 10 }
                    if ( ( $pro2[$x] == 2 ) and ( $ergebnis[ $sp2[$x] ] == 4 ) ) { $su_2 = $su_2 + 10 }
                    if ( ( $pro2[$x] == 3 ) and ( $ergebnis[ $sp2[$x] ] == 4 ) ) { $su_2 = $su_2 + 10 }

                }

                $sum[ $ega[ $qq - 1 ] ] = $su_1;
                $sum[ $ega[$qq] ] = $su_2;

            }

            for ( $x = 1; $x <= 18; $x++ ) {
                $lin[ $sp + 1 ] = $lin[ $sp + 1 ] . $sum[$x] . '&';
                $linxx[ $sp + 1 ][$liga] = $linxx[ $sp + 1 ][$liga] . $sum[$x] . '&';
            }

        }
    }
}
for ( $liga = 1; $liga <= 384; $liga++ ) {
    $lok = $liga;
        if ( $liga < 10 ) { $lok = '0' . $liga }

        $bv  = "DAT";
        $txt = ".TXT";

        $datei_daten = './newdat/' . $bv . $lok . $txt;
        open( D, ">$datei_daten" );

    for ( $spielrunde = 1; $spielrunde <= 35; $spielrunde++ ) {
        
        #print $liga . " > " . $spielrunde . "\n";
        print D $linxx[$spielrunde][$liga] . "\n";
    }
    close(D);
}

#         # $r = <stdin>;

#         $lok = $liga;
#         if ( $liga < 10 ) { $lok = '0' . $liga }

#         $bv  = "DAT";
#         $txt = ".TXT";

#         $datei_daten = '/tmdata/btm/' . $bv . $lok . $txt;
#         $t           = 0;

#         open( DO, ">$datei_daten" );
#         for ( $r = 1; $r <= 35; $r++ ) {
#             if ( ( $lin[$r] eq "" ) and ( $r > 1 ) ) { $lin[$r] = "1&1&1&1&1&1&1&1&1&1&1&1&1&1&1&1&1&1&" }
#             print DO "$lin[$r]\n";
#         }

#         close(DO);

# }
