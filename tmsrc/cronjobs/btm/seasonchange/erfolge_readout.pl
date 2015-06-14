#!/usr/bin/perl

# nach saisonerh. ausfuehren
require "/tmapp/tmsrc/cgi-bin/btm/saison.pl";

open (D1,">/tmdata/btm/erfolge.txt");

print D1"1#1.Bundesliga#VfL Bochum#Udo Wollert#\n";
print D1"2#1.Bundesliga#Fortuna Duesseldorf#Fortuna Duesseldorf#\n";
print D1"3#1.Bundesliga#FC Bayern Muenchen#Johannes Kalwa#\n";
print D1"4#1.Bundesliga#Hamburger SV#Daniel Houghton#\n";
print D1"5#1.Bundesliga#Fortuna Duesseldorf#Matthias Schlueter#\n";

$ti=0;
for ($saison=4;$saison<=$main_nr-3;$saison++){


$url = "/archiv/$main_kuerzel[$saison+2]/";

$saison_liga=1;

$datei_quoten = '/tmdata/btm/' . $url . "history.txt";
$rr = 0;
$li=0;
$liga=0;
open(DQ2,"$datei_quoten");
while(<DQ2>) {

$li++;
@vereine = split (/&/, $_);

$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
$y++;
chomp $verein[$y];
$data[$x] = $vereine[$y];
$y++;
chomp $verein[$y];
$datb[$x] = $vereine[$y];
$aktiv{"$data[$x]"} =$datb[$x] ;
$y++;
chomp $verein[$y];
$datc[$x] = $vereine[$y];
}
}
close(DQ2);

$datei_quoten = '/tmdata/btm/' . $url . "heer.txt";
open(D2,"$datei_quoten");
for ($qq=1;$qq<=$saison_liga;$qq++){
$a=<D2>;
chomp $a;
@all=split(/&/,$a);
$ra=$saison+2;
print D1 "$ra#1.Bundesliga#$all[5]#$aktiv{$all[5]}#\n";
for ($x=1;$x<=17;$x++){
$a=<D2>;
}}
close(D2);
}
close(D1);
