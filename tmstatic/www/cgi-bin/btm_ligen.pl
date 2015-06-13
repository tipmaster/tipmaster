#!/usr/bin/perl

=head1 NAME
	BTM btm_ligen.pl

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
my $leut = $trainer;

use CGI;

$rr_ligen=384;
@liga_namen = ( "---" , "1.Bundesliga" , "2.Bundesliga" ,"Regionalliga A" ,"Regionalliga B" ,"Oberliga A" ,"Oberliga B" ,"Oberliga C" ,"Oberliga D" ,
"Verbandsliga A" ,"Verbandsliga B" ,"Verbandsliga C" ,"Verbandsliga D" ,"Verbandsliga E" ,"Verbandsliga F" ,"Verbandsliga G" ,"Verbandsliga H" ,
"Landesliga A" ,"Landesliga B" ,"Landesliga C" ,"Landesliga D" ,"Landesliga E" ,"Landesliga F" ,"Landesliga G" ,"Landesliga H" ,
"Landesliga I" ,"Landesliga K" ,"Landesliga L" ,"Landesliga M" ,"Landesliga N" ,"Landesliga O" ,"Landesliga P" ,"Landesliga R" ,
"Bezirksliga 01" ,"Bezirksliga 02" ,"Bezirksliga 03" ,"Bezirksliga 04" ,"Bezirksliga 05" ,"Bezirksliga 06" ,"Bezirksliga 07" ,"Bezirksliga 08" ,
"Bezirksliga 09" ,"Bezirksliga 10" ,"Bezirksliga 11" ,"Bezirksliga 12" ,"Bezirksliga 13" ,"Bezirksliga 14" ,"Bezirksliga 15" ,"Bezirksliga 16" ,
"Bezirksliga 17" ,"Bezirksliga 18" ,"Bezirksliga 19" ,"Bezirksliga 20" ,"Bezirksliga 21" ,"Bezirksliga 22" ,"Bezirksliga 23" ,"Bezirksliga 24" ,
"Bezirksliga 25" ,"Bezirksliga 26" ,"Bezirksliga 27" ,"Bezirksliga 28" ,"Bezirksliga 29" ,"Bezirksliga 30" ,"Bezirksliga 31" ,"Bezirksliga 32" ,
"Kreisliga 01" ,"Kreisliga 02" ,"Kreisliga 03" ,"Kreisliga 04" ,"Kreisliga 05" ,"Kreisliga 06" ,"Kreisliga 07" ,"Kreisliga 08" ,
"Kreisliga 09" ,"Kreisliga 10" ,"Kreisliga 11" ,"Kreisliga 12" ,"Kreisliga 13" ,"Kreisliga 14" ,"Kreisliga 15" ,"Kreisliga 16" ,
"Kreisliga 17" ,"Kreisliga 18" ,"Kreisliga 19" ,"Kreisliga 20" ,"Kreisliga 21" ,"Kreisliga 22" ,"Kreisliga 23" ,"Kreisliga 24" ,
"Kreisliga 25" ,"Kreisliga 26" ,"Kreisliga 27" ,"Kreisliga 28" ,"Kreisliga 29" ,"Kreisliga 30" ,"Kreisliga 31" ,"Kreisliga 32" ,
"Kreisliga 33" ,"Kreisliga 34" ,"Kreisliga 35" ,"Kreisliga 36" ,"Kreisliga 37" ,"Kreisliga 38" ,"Kreisliga 39" ,"Kreisliga 40" ,
"Kreisliga 41" ,"Kreisliga 42" ,"Kreisliga 43" ,"Kreisliga 44" ,"Kreisliga 45" ,"Kreisliga 46" ,"Kreisliga 47" ,"Kreisliga 48" ,
"Kreisliga 49" ,"Kreisliga 50" ,"Kreisliga 51" ,"Kreisliga 52" ,"Kreisliga 53" ,"Kreisliga 54" ,"Kreisliga 55" ,"Kreisliga 56" ,
"Kreisliga 57" ,"Kreisliga 58" ,"Kreisliga 59" ,"Kreisliga 60" ,"Kreisliga 61" ,"Kreisliga 62" ,"Kreisliga 63" ,"Kreisliga 64" ,
"Kreisklasse 1" , "Kreisklasse 2" , "Kreisklasse 3" , "Kreisklasse 4" , "Kreisklasse 5" , "Kreisklasse 6" , "Kreisklasse 7" , "Kreisklasse 8" ,
"Kreisklasse 9" , "Kreisklasse 10" , "Kreisklasse 11" , "Kreisklasse 12" , "Kreisklasse 13" , "Kreisklasse 14" , "Kreisklasse 15" , "Kreisklasse 16" ,
"Kreisklasse 17" , "Kreisklasse 18" , "Kreisklasse 19" , "Kreisklasse 20" , "Kreisklasse 21" , "Kreisklasse 22" , "Kreisklasse 23" , "Kreisklasse 24" ,
"Kreisklasse 25" , "Kreisklasse 26" , "Kreisklasse 27" , "Kreisklasse 28" , "Kreisklasse 29" , "Kreisklasse 30" , "Kreisklasse 31" , "Kreisklasse 32" ,
"Kreisklasse 33" , "Kreisklasse 34" , "Kreisklasse 35" , "Kreisklasse 36" , "Kreisklasse 37" , "Kreisklasse 38" , "Kreisklasse 39" , "Kreisklasse 40" ,
"Kreisklasse 41" , "Kreisklasse 42" , "Kreisklasse 43" , "Kreisklasse 44" , "Kreisklasse 45" , "Kreisklasse 46" , "Kreisklasse 47" , "Kreisklasse 48" ,
"Kreisklasse 49" , "Kreisklasse 50" , "Kreisklasse 51" , "Kreisklasse 52" , "Kreisklasse 53" , "Kreisklasse 54" , "Kreisklasse 55" , "Kreisklasse 56" ,
"Kreisklasse 57" , "Kreisklasse 58" , "Kreisklasse 59" , "Kreisklasse 60" , "Kreisklasse 61" , "Kreisklasse 62" , "Kreisklasse 63" , "Kreisklasse 64" ,
"Kreisklasse 65" , "Kreisklasse 66" , "Kreisklasse 67" , "Kreisklasse 68" , "Kreisklasse 69" , "Kreisklasse 70" , "Kreisklasse 71" , "Kreisklasse 72" ,
"Kreisklasse 73" , "Kreisklasse 74" , "Kreisklasse 75" , "Kreisklasse 76" , "Kreisklasse 77" , "Kreisklasse 78" , "Kreisklasse 79" , "Kreisklasse 80" ,
"Kreisklasse 81" , "Kreisklasse 82" , "Kreisklasse 83" , "Kreisklasse 84" , "Kreisklasse 85" , "Kreisklasse 86" , "Kreisklasse 87" , "Kreisklasse 88" ,
"Kreisklasse 89" , "Kreisklasse 90" , "Kreisklasse 91" , "Kreisklasse 92" , "Kreisklasse 93" , "Kreisklasse 94" , "Kreisklasse 95" , "Kreisklasse 96" ,
"Kreisklasse 97" , "Kreisklasse 98" , "Kreisklasse 99" , "Kreisklasse 100" , "Kreisklasse 101" , "Kreisklasse 102" , "Kreisklasse 103" , "Kreisklasse 104" ,
"Kreisklasse 105" , "Kreisklasse 106" , "Kreisklasse 107" , "Kreisklasse 108" , "Kreisklasse 109" , "Kreisklasse 110" , "Kreisklasse 111" , "Kreisklasse 112" ,
"Kreisklasse 113" , "Kreisklasse 114" , "Kreisklasse 115" , "Kreisklasse 116" , "Kreisklasse 117" , "Kreisklasse 118" , "Kreisklasse 119" , "Kreisklasse 120" ,
"Kreisklasse 121" , "Kreisklasse 122" , "Kreisklasse 123" , "Kreisklasse 124" , "Kreisklasse 125" , "Kreisklasse 126" , "Kreisklasse 127" , "Kreisklasse 128" ,
"Kreisklasse 1" , "Kreisklasse 2" , "Kreisklasse 3" , "Kreisklasse 4" , "Kreisklasse 5" , "Kreisklasse 6" , "Kreisklasse 7" , "Kreisklasse 8" ,
"Kreisklasse 9" , "Kreisklasse 10" , "Kreisklasse 11" , "Kreisklasse 12" , "Kreisklasse 13" , "Kreisklasse 14" , "Kreisklasse 15" , "Kreisklasse 16" ,
"Kreisklasse 17" , "Kreisklasse 18" , "Kreisklasse 19" , "Kreisklasse 20" , "Kreisklasse 21" , "Kreisklasse 22" , "Kreisklasse 23" , "Kreisklasse 24" ,
"Kreisklasse 25" , "Kreisklasse 26" , "Kreisklasse 27" , "Kreisklasse 28" , "Kreisklasse 29" , "Kreisklasse 30" , "Kreisklasse 31" , "Kreisklasse 32" ,
"Kreisklasse 33" , "Kreisklasse 34" , "Kreisklasse 35" , "Kreisklasse 36" , "Kreisklasse 37" , "Kreisklasse 38" , "Kreisklasse 39" , "Kreisklasse 40" ,
"Kreisklasse 41" , "Kreisklasse 42" , "Kreisklasse 43" , "Kreisklasse 44" , "Kreisklasse 45" , "Kreisklasse 46" , "Kreisklasse 47" , "Kreisklasse 48" ,
"Kreisklasse 49" , "Kreisklasse 50" , "Kreisklasse 51" , "Kreisklasse 52" , "Kreisklasse 53" , "Kreisklasse 54" , "Kreisklasse 55" , "Kreisklasse 56" ,
"Kreisklasse 57" , "Kreisklasse 58" , "Kreisklasse 59" , "Kreisklasse 60" , "Kreisklasse 61" , "Kreisklasse 62" , "Kreisklasse 63" , "Kreisklasse 64" ,
"Kreisklasse 65" , "Kreisklasse 66" , "Kreisklasse 67" , "Kreisklasse 68" , "Kreisklasse 69" , "Kreisklasse 70" , "Kreisklasse 71" , "Kreisklasse 72" ,
"Kreisklasse 73" , "Kreisklasse 74" , "Kreisklasse 75" , "Kreisklasse 76" , "Kreisklasse 77" , "Kreisklasse 78" , "Kreisklasse 79" , "Kreisklasse 80" ,
"Kreisklasse 81" , "Kreisklasse 82" , "Kreisklasse 83" , "Kreisklasse 84" , "Kreisklasse 85" , "Kreisklasse 86" , "Kreisklasse 87" , "Kreisklasse 88" ,
"Kreisklasse 89" , "Kreisklasse 90" , "Kreisklasse 91" , "Kreisklasse 92" , "Kreisklasse 93" , "Kreisklasse 94" , "Kreisklasse 95" , "Kreisklasse 96" ,
"Kreisklasse 97" , "Kreisklasse 98" , "Kreisklasse 99" , "Kreisklasse 100" , "Kreisklasse 101" , "Kreisklasse 102" , "Kreisklasse 103" , "Kreisklasse 104" ,
"Kreisklasse 105" , "Kreisklasse 106" , "Kreisklasse 107" , "Kreisklasse 108" , "Kreisklasse 109" , "Kreisklasse 110" , "Kreisklasse 111" , "Kreisklasse 112" ,
"Kreisklasse 113" , "Kreisklasse 114" , "Kreisklasse 115" , "Kreisklasse 116" , "Kreisklasse 117" , "Kreisklasse 118" , "Kreisklasse 119" , "Kreisklasse 120" ,
"Kreisklasse 121" , "Kreisklasse 122" , "Kreisklasse 123" , "Kreisklasse 124" , "Kreisklasse 125" , "Kreisklasse 126" , "Kreisklasse 127" , "Kreisklasse 128" ,
);

for ($x11=1;$x11<=128;$x11++){
$liga_namen[$x11+256]="Kreisstaffel $x11";
}

@liga_kuerzel = ( "---" , 
"1.BL" , "2.BL" ,"RL A" ,"RL B" ,"OL A" ,"OL B" ,"OL C" ,"OL D" ,
"VL A" ,"VL B" ,"VL C" ,"VL D" ,"VL E" ,"VL F" ,"VL G" ,"VL H" ,
"LA A" ,"LA B" ,"LA C" ,"LA D" ,"LA E" ,"LA F" ,"LA G" ,"LA H" ,
"LA I" ,"LA K" ,"LA L" ,"LA M" ,"LA N" ,"LA O" ,"LA P" ,"LA R" ,
"BE 01" ,"BE 02" ,"BE 03" ,"BE 04" ,"BE 05" ,"BE 06" ,"BE 07" ,"BE 08" ,
"BE 09" ,"BE 10" ,"BE 11" ,"BE 12" ,"BE 13" ,"BE 14" ,"BE 15" ,"BE 16" ,
"BE 17" ,"BE 18" ,"BE 19" ,"BE 20" ,"BE 21" ,"BE 22" ,"BE 23" ,"BE 24" ,
"BE 25" ,"BE 26" ,"BE 27" ,"BE 28" ,"BE 29" ,"BE 30" ,"BE 31" ,"BE 32" ,
"KR 01" ,"KR 02" ,"KR 03" ,"KR 04" ,"KR 05" ,"KR 06" ,"KR 07" ,"KR 08" ,
"KR 09" ,"KR 10" ,"KR 11" ,"KR 12" ,"KR 13" ,"KR 14" ,"KR 15" ,"KR 16" ,
"KR 17" ,"KR 18" ,"KR 19" ,"KR 20" ,"KR 21" ,"KR 22" ,"KR 23" ,"KR 24" ,
"KR 25" ,"KR 26" ,"KR 27" ,"KR 28" ,"KR 29" ,"KR 30" ,"KR 31" ,"KR 32" ,
"KR 33" ,"KR 34" ,"KR 35" ,"KR 36" ,"KR 37" ,"KR 38" ,"KR 39" ,"KR 40" ,
"KR 41" ,"KR 42" ,"KR 43" ,"KR 44" ,"KR 45" ,"KR 46" ,"KR 47" ,"KR 48" ,
"KR 49" ,"KR 50" ,"KR 51" ,"KR 52" ,"KR 53" ,"KR 54" ,"KR 55" ,"KR 56" ,
"KR 57" ,"KR 58" ,"KR 59" ,"KR 60" ,"KR 61" ,"KR 62" ,"KR 63" ,"KR 64" ,
"KK 01" , "KK 02" , "KK 03" , "KK 04" , "KK 05" , "KK 06" , "KK 07" , "KK 08" ,
 "KK 09" , "KK 10" , "KK 11" , "KK 12" , "KK 13" , "KK 14" , "KK 15" , "KK 16" ,
 "KK 17" , "KK 18" , "KK 19" , "KK 20" , "KK 21" , "KK 22" , "KK 23" , "KK 24" ,
 "KK 25" , "KK 26" , "KK 27" , "KK 28" , "KK 29" , "KK 30" , "KK 31" , "KK 32" ,
 "KK 33" , "KK 34" , "KK 35" , "KK 36" , "KK 37" , "KK 38" , "KK 39" , "KK 40" ,
 "KK 41" , "KK 42" , "KK 43" , "KK 44" , "KK 45" , "KK 46" , "KK 47" , "KK 48" ,
 "KK 49" , "KK 50" , "KK 51" , "KK 52" , "KK 53" , "KK 54" , "KK 55" , "KK 56" ,
 "KK 57" , "KK 58" , "KK 59" , "KK 60" , "KK 61" , "KK 62" , "KK 63" , "KK 64" ,
 "KK 65" , "KK 66" , "KK 67" , "KK 68" , "KK 69" , "KK 70" , "KK 71" , "KK 72" ,
 "KK 73" , "KK 74" , "KK 75" , "KK 76" , "KK 77" , "KK 78" , "KK 79" , "KK 80" ,
 "KK 81" , "KK 82" , "KK 83" , "KK 84" , "KK 85" , "KK 86" , "KK 87" , "KK 88" ,
 "KK 89" , "KK 90" , "KK 91" , "KK 92" , "KK 93" , "KK 94" , "KK 95" , "KK 96" ,
 "KK 97" , "KK 98" , "KK 99" , "KK 100" , "KK 101" , "KK 102" , "KK 103" , "KK 104" ,
 "KK 105" , "KK 106" , "KK 107" , "KK 108" , "KK 109" , "KK 110" , "KK 111" , "KK 112" ,
 "KK 113" , "KK 114" , "KK 115" , "KK 116" , "KK 117" , "KK 118" , "KK 119" , "KK 120" ,
 "KK 121" , "KK 122" , "KK 123" , "KK 124" , "KK 125" , "KK 126" , "KK 127" , "KK 128" );
for ($x11=1;$x11<=128;$x11++){
$liga_kuerzel[$x11+256]="KS $x11";
}








return 1;

