#!/usr/bin/perl

require "/tmapp/tmsrc/cgi-bin/tmi/saison.pl";
require "/tmapp/tmsrc/cgi-bin/runde.pl";
$border=(($main_nr-6)*34)+(($rrunde)*4);
@opt=(0,15,40,60,80,105,130,155);

open (AAA,">/tmdata/tmi/db/wranking.txt");
require "/tmapp/tmsrc/cgi-bin/runde.pl";

open(D2,"/tmdata/tmi/history.txt");
while(<D2>) {
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
$aktiv{"$datb[$x]"} = 1;
$y++;
chomp $verein[$y];
$datc[$x] = $vereine[$y];
}
}
close(D2);


open(D,"</tmdata/tmi/db/trainer.txt");
while(<D>){
($nummer , $ve ) = split (/&/ , $_);
chomp $ve ;
$trainer[$nummer] = $ve ;
$grep[$nummer]=1;
$t=$nummer;
}
close(D);

open(SP,"</tmdata/tmi/db/spiele.txt");
while(<SP>) {
$zeile++;
if (($zeile%1000) == 0 ) { print "Read-In Spiele.txt # $zeile\n"; }
@a1 = split (/#/ , $_);
@a2 = split (/&/ , $_);
@a3 = split (/#/ , $a2[0]);

$id=$a1[0]*1;
$basis=($a3[1]-1)*34;

if ($grep[$id]==1 && $a3[1] > 40){
for($x=1;$x<=34;$x++){
$sp_nr=$basis+$x;
@a4 = split(/#/ , $a2[$x]);
if ($a4[0] ne "-" && $a4[0] ne "") {
chomp $a4[3];
$catch[$id][$sp_nr] ="$id#$sp_nr#$a4[3]#$a4[1]#$a4[2]#\n";
}
}}
}
close(SP);

iu:
close(AAA);

for ($g1=$border-4;$g1<=$border;$g1+=2){
@string=();@data1=();@data2=();@data3=();@data4=();
#if ( (($g1)%32) != 0){$g1+=2}
$g0=$g1-99;
$rr=0;
open(AAA,">/tmdata/tmi/db/wranking/stat_$g1");
for ($y=1;$y<=$t;$y++){
$pu=0;$to1=0;$to2=0;$qu1=0;$qu2=0;$s=0;$u=0;$n=0;$op=0;
$sp=0;$to1_def=0;$to2_def=0;$s_def=0;$u_def=0;$n_def=0;$op_def=0;
for ($x=$g0;$x<=$g1;$x++){
if ($catch[$y][$x] eq "" ) { 
break;}else {
$sp++;
@d=split(/#/,$catch[$y][$x]);

$to1+=tore($d[3]);
$to2+=tore($d[4]);
$t1=tore($d[3]);
$t2=tore($d[4]);
$qu1+=$d[3];
$qu2+=$d[4];
$op+=$d[3]-$opt[$t1];

if ($t1>$t2){$s++}
if ($t1==$t2){$u++}
if ($t1<$t2){$n++}

# Points to defend
if ( $sp<5) {

$to1_def+=tore($d[3]);
$to2_def+=tore($d[4]);
$qu1_def+=$d[3];
$qu2_def+=$d[4];
$op_def+=$d[3]-$opt[$t1];
if ($t1>$t2){$s_def++}
if ($t1==$t2){$u_def++}
if ($t1<$t2){$n_def++}
$pu_def=($s_def*3)+$u_def;

}

if ($sp==100){
$pu=($s*3)+$u;

$op=$op/100;
$oo=0;$qp = $op ;
$xx="11"; ( $yy , $xx ) = split (/\./ , $qp ) ; $oo = length($xx) ;
if ($oo==1 ) { $qp = $qp . '0' }
if ($oo==0 ) { $qp = $qp . '.00' }

$op_def=$op_def/4;
$oo=0;$qp_def = $op_def ;
$xx="11"; ( $yy , $xx ) = split (/\./ , $qp_def ) ; $oo = length($xx) ;
if ($oo==1 ) { $qp_def = $qp_def . '0' }
if ($oo==0 ) { $qp_def = $qp_def . '.00' }


$rr++;
#print $rr;
$string[$rr]=  "$trainer[$y]&$pu&$s&$u&$n&$to1&$to2&$qu1&$qu2&$qp&$to1_def&$to2_def&$pu_def&$qp_def";
$dif=$to1-$to2;
$dif+=15000;
$pu+=10000;
$to1+=10000;
$to2+=10000;
$to3=$to1-$to2+15000;
$op=15000-$op;

$data1[$rr]=$pu.'#'.$dif.'#'.$trainer[$y];
$data2[$rr]=$to1.'#'.$dif.'#'.$trainer[$y];
$data3[$rr]=$op.'#'.$to1.'#'.$trainer[$y];
$data4[$rr]=$to2.'#'.$dif.'#'.$trainer[$y];
}
}
}

}

@da1 = sort @data1;
@da2 = sort @data2;
@da3 = sort @data3;
@da4 = sort @data4;
@da1 = reverse @da1;
@da2 = reverse @da2;
@da3 = reverse @da3;
@da4 = reverse @da4;


print "$da2[0] - $da2[1] -$da2[-1]";

$pos=0;
for ($xx=0;$xx<=$rr;$xx++){
$pos++;
@a=split(/#/,$da1[$xx]);
$r1{$a[2]}=$pos;
@a=split(/#/,$da2[$xx]);
$r2{$a[2]}=$pos;
@a=split(/#/,$da3[$xx]);
$r3{$a[2]}=$pos;
@a=split(/#/,$da4[$xx]);
$r4{$a[2]}=$pos;
}

for($xx=1;$xx<=$rr;$xx++){
@a=split(/&/,$string[$xx]);
print AAA $string[$xx];
print AAA "&$r1{$a[0]}&$r2{$a[0]}&$r3{$a[0]}&$r4{$a[0]}&\n"
}
close(AAA);
print "\nRanking $g1 complete $rr entries -> \n";
}






sub tore{
$xx=shift;$tor=0;
if($xx>14){$tor=1}
if($xx>39){$tor=2}
if($xx>59){$tor=3}
if($xx>79){$tor=4}
if($xx>104){$tor=5}
if($xx>129){$tor=6}
if($xx>154){$tor=7}
return $tor;}


