#!/usr/bin/perl

print "Content-Type: text/html \n\n";
use lib qw{/tmapp/tmsrc/cgi-bin};
use Test;
use CGI qw/:standard/;
use CGI::Cookie;
my $mlib = new Test;
my @liga_namen = $mlib->tmi_liga_namen();
my @main_saison = $mlib->tmi_saison_namen();
my @main_kuerzel = $mlib->tmi_saison_kuerzel();
my $main_nr = $main_saison[0];

my $rr_ligen=203;
@old2new=( 0 ,1 ,2 ,3 ,4 ,9 ,10 ,11 ,12 ,17 ,18 ,19 ,20 ,25 ,26 ,27 ,28 ,33 ,34 ,35 ,36 ,39 ,40 ,41 ,
42 ,45 ,46 ,47 ,48 ,51 ,52 ,53 ,54 ,57 ,58 ,59 ,60 ,63 ,64 ,65 ,66 ,69 ,70 ,71 ,72 ,75 ,76 ,79 ,80 ,83 ,
84 ,87 ,88 ,91 ,92 ,95 ,96 ,99 ,100 ,103 ,104 ,107 ,108 ,111 ,112 ,171 ,172 ,115 ,116 ,119 ,120 ,
123 ,124 ,127 ,128 ,131 ,132 ,135 ,136 ,174 ,175 ,192 ,193 ,139 ,140 ,143 ,144 ,147 ,148 ,151 ,
152 ,177 ,178 ,180 ,181 ,183 ,184 ,155 ,156 ,159 ,160 ,
194 ,195 ,196 ,197 ,198 ,199 ,163 ,164 ,200 ,201 ,167 ,168 ,186 ,187 ,189 ,190 ,202 ,203 );

$saison_aktuell=$main_nr-1;
my $li=0;
my $datei = "/tmdata/tmi/history.txt";
open(D2,"$datei");
while(<D2>) {
$li++;
@tmp = split (/&/, $_);
my $nr=-2;
foreach(@tmp)
{
        $nr++;
        if ($nr==3) {$nr=0}
        if ($nr==0 && length($_) > 1) { push(@vereine,$_); $league{$_} = $li; };

}}
close(D2);



open(D5,"/tmdata/tmi/geschichte.txt");
while(<D5>) {
@tmp=split(/&/,$_);
$line{$tmp[0]} = $_;
}
close(D5);




for ($run=0;$run<=1;$run++)
{

if ($run == 0) { $file = "/tmdata/tmi/alltime_ranking.txt" } else { $file = "/tmdata/tmi/alltime_ranking_last10.txt" }

open(A,">$file");



#start iteration
foreach $verein (@vereine)
{

@cpokal=();
@upokal=();
@lpokal=();
@meister=();

@platz=();
$season=0;
$platz=0;

$auf=0;
$ab=0;
@sat=();
@sai=();
@sar=();

my @tmparray = split(/&/,$line{$verein});my $id=0;my $index=0;
foreach(@tmparray)
{
        $index=int(($id+1)/2);
        $id++;
        if ($index > 0){
        if ($id%2==0){$sat[$index]=$_};
        if ($id%2==1){$sai[$index]=$_};
	}
}


for (my $x=1;$x<=8;$x++)
{
	my $tt = $sai[$x] ;
	$sai[$x] = $sat[$x];
	$sat[$x] = $tt;
}


$suche = '#' . $verein . '#' ;
my $pokaldump;my @cl;my @uefa;


if ($run == 0) { $border_ec=0}
if ($run == 1) { $border_ec=$saison_aktuell-10}

open(D5,"/tmdata/tmi/swechsel/ec_erfolge.txt");
while(<D5>) {
if ($_ =~ /$suche/) {
@all=split(/#/,$_);

@cl_label = ("Q1","Q2","Q3","G1","G2","AC","VI","HA","FI","CH");
my $id=0;
foreach(@cl_label)
{

if ( $all[2] eq "C" && $all[3] eq $_ && $all[0] > $border_ec) { $cpokal[$id]++ }
if ( $all[2] eq "U" && $all[3] eq $_ && $all[0] > $border_ec) { $upokal[$id]++ }
$id++;
}

}
}
close(D5);


$suche = '&' . $verein. '#' ;
my $pokaldump;

open(D5,"/tmdata/tmi/swechsel/pokaldump.txt");
while(<D5>) {
if ($_ =~ /$suche/) {
$pokaldump=$_;
}
}
close(D5);
my @poki;
my $aa1;my $aa2;my @all;
@all=split(/#/,$pokaldump);
foreach $a (@all){
($aa1,$aa2)=split(/&/,$a);
$poki[$aa1]=$aa2;
}







if ($run == 0) { $border=0}
if ($run == 1) { $border=$saison_aktuell-13}


for ( $c = $saison_aktuell; $c > $border; $c = $c - 1 )
{


if ( $c < 12 ) {

@sar = ( "spacer" , "Italien Serie A" , "Italien Serie B" ,
"England Premier League" ,"England 1.Divison" ,
"Spanien Primera Division" ,"Spanien Secunda Division" ,
"Frankreich Ligue Une" ,"Frankreich 1.Division" ,
"Niederlande Ehrendivision" ,"Niederlande 1.Division" ,
"Portugal 1.Divisao" ,"Portugal 2.Divisao" ,
"Belgien 1.Division" ,"Belgien 2.Division" ,
"Schweiz Nationalliga A" ,"Schweiz Nationalliga B" ,
"Oesterreich Bundesliga" ,"Oesterreich 1.Division" ,
"Schottland 1.Liga" ,"Schottland 2.Liga" ,
"Tuerkei 1.Liga" ,"Tuerkei 2.Liga" ,
"Irland 1.Liga" ,
"Nord Irland 1.Liga" ,
"Wales 1.Liga" ,
"Daenemark 1.Liga" ,
"Norwegen 1.Liga" ,
"Schweden 1.Liga" ,
"Finnland 1.Liga" ,
"Island 1.Liga" ,
"Faeroer Inseln 1.Liga" ,
"Polen 1.Liga" ,
"Tschechien 1.Liga" ,
"Slowakei 1.Liga" ,
"Ungarn 1.Liga" ,
"Rumaenien 1.Liga" ,
"Slowenien 1.Liga" ,
"Kroatien 1.Liga" ,
"Jugoslawien 1.Liga" ,
"Bosnien-Herz. 1.Liga" ,
"Mazedonien 1.Liga" ,
"Albanien 1.Liga" ,
"Bulgarien 1.Liga" ,
"Griechenland 1.Liga" ,
"Russland 1.Liga" ,
"Estland 1.Liga" ,
"Litauen 1.Liga" ,
"Lettland 1.Liga" ,
"Weissrussland 1.Liga" ,
"Ukraine 1.Liga" ,
"Moldawien 1.Liga" ,
"Georgien 1.Liga" ,
"Armenien 1.Liga" ,
"Aserbaidschan 1.Liga" ,
"Israel 1.Liga" ,
"Andorra 1.Liga" ,
"Luxemburg 1.Liga" ,
"Malta 1.Liga" ,
"San Marino 1.Liga" ,
"Zypern 1.Liga" 
 ) ;

}

$xa = $sat[$c] ;
$xb = $sai[$c] ;
$sai[$c] = $xa ;
$sat[$c] = $xb ;

if (( $c > 11)and($c<14)) { $sat[$c]=$old2new[$sat[$c]] }

if ( ( $sai[$c] != 99 ) and ( $sai[$c] != 0 ) ) {

if ($c < 9){
@sar = ( "spacer" , "Italien Serie A" , 
"England Premier League" ,
"Spanien Primera Division" ,
"Frankreich Ligue Une" ,
"Niederlande Ehrendivision" ,
"Portugal 1.Divisao" ,
"Belgien 1.Division" ,
"Schweiz Nationalliga A" ,
"Oesterreich Bundesliga" ,
"NW-Europa 1.Liga" ,
"Nord-Europa 1.Liga" ,
"GUS 1.Liga" ,
"Sued-Europa 1.Liga" ,
"Ost-Europa 1.Liga" ,
"SO-Europa 1.Liga" ,
"Italien Serie Bi (2.Liga)" , 
"England 1.Divisioni (2.Liga)" ,
"Spanien Secunda Divisioni (2.Liga)" ,
"Frankreich Deuxieme Division (2.Liga)" ,
"Niederlande 2.Liga" ,
"Portugal 2.Divisao" ,
"Belgien 2.Division" ,
"Schweiz Nationalliga B (2.Liga)" ,
"Oesterreich 2.Liga" ,
"NW-Europa 2.Liga" ,
"Nord-Europa 2.Liga" ,
"GUS 2.Liga" ,
"Sued-Europa 2.Liga" ,
"Ost-Europa 2.Liga" ,
"SO-Europa 2.Liga" ) ;
}
if ( $c > 11 ) {
@sar = @liga_namen ;
}


if ($c == $saison_aktuell-3) { $sat[$c+1] = $league{$verein}}



my @tmp1 = split(/\s/,$sar[$sat[$c]]);
my @tmp2 = split(/\s/,$sar[$sat[$c+1]]);
my @tmp3 = split(/\s/,$sar[$sat[$c]-1]);


if (($tmp1[0] eq $tmp2[0]) && ($sat[$c] < $sat[$c+1])) {$ab++;}
if (($tmp1[0] eq $tmp2[0]) && ($sat[$c] > $sat[$c+1])) {$auf++;}
if (($tmp1[0] ne $tmp3[0]) && (!($sar[$sat[$c]] =~ /2\./)) && ($sai[$c] < 6  )) {$meister[$sai[$c]]++;}
if (($tmp1[0] ne $tmp3[0]) && (!($sar[$sat[$c]] =~ /2\./)) ) {$season++;$platz+=$sai[$c]}

if ($verein =~ "Longford T"){
####
$sat[$saison_aktuell-2] = $league{$verein};
print "$verein $c $sat[$c] $sai[$c]  ".($meister[2]*1)." $tmp1[0] $tmp3[0]\n";
###
}



$lpokal[$poki[$c+3]]++;
if ( $c < 9 ) { $poki[$c+3] = 7 }
}}

$vid++;

#if ($vid%100 == 0){ print ($vid/scalar(@vereine))." % Fortschritt ...\n\n";}


print A "$verein";
print A "#";
for ($x=9;$x>=0;$x--){print A "$cpokal[$x]&";$id++;}
print A "#";
for ($x=9;$x>=0;$x--){print A "$upokal[$x]&";$id++;}
print A "#";
for ($x=6;$x>=0;$x--){print A "$lpokal[$x]&";}
print A "#";
for ($x=1;$x<=5;$x++){print A "$meister[$x]&";}
print A "#";
print A "$auf&$ab&";
print A "#";
print A "$platz&$season&";
print A "#\n";
}

close(A);


}
