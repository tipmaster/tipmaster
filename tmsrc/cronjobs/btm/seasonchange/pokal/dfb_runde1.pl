#!/usr/bin/perl
$pp=1;
rand();

require "readout_qu_nr.pl";

open(F,">/tmdata/btm/pokal/pokal_dfb.txt");
for ($x=1;$x<=5;$x++){
print F "$x#";

$pp=$pp*2;
$ok = 64 / $pp;
@all=();

#auslosung
for ($v=1;$v<=$ok;$v++){
$aa=int(rand(1000));
$all[$v]=$aa . '#' . $v;
#print "$all[$v]\n";
}
@all1 = sort @all;
for ($v=1;$v<=$ok;$v++){
@z = split(/#/,$all1[$v]);
print F "$z[1]&";
}


print F"\n";
}
close(F);



@already = ();

@teilnehmer = ( 0 , 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 ,
10 , 11 , 12 , 13 , 14 , 15 , 16 , 17 , 18 , 19 ,
20 , 21 , 22 , 23 , 24 , 25 , 26 , 27 , 28 , 29 ,
30 , 31 , 32 , 33 , 34 , 35 , 36 , 
37 , 38 , 39 ,
40 , 41 , 42 ,
55 , 56 , 57 , 
58 , 59 , 60  

) ;

@aufruecken = ( 43 , 61 , 44 , 62 , 45 , 63 , 46 , 64 , 47 , 65 , 48 , 66 , 49 , 67 , 50 , 68 );

open(EE,"<quali_nr.txt");
$row=<EE>;
chomp $row;
close(EE);

@acup = split(/,/,$row);
$r=0;
foreach $g (@acup) {
$g=$g*1;$r++;
$teilnehmer[48+$r]=$g;
}

$r=-1;$auf=0;
foreach $g (@teilnehmer) {
$r++;
if ( $ex[$g]==1 ) { 
while ( $ex[$aufruecken[$auf]] != 0 ) { $auf++ }
$teilnehmer[$r] = $aufruecken[$auf] ; 
$auf++ }
$ex[$teilnehmer[$r]]=1;
}

$r=-1;$auf=0;
foreach $g (@teilnehmer) {
$r++;
#print "$r $g\n";
}




srand();  


$y=0;
for ($x=2 ; $x<=64;$x= $x+2){

hi:
$rr = int(rand(36))+1;
if ( $already[$rr] > 0 ) { goto hi; }
$already[$rr] = 1 ;
$loko[$x] = $teilnehmer[$rr] ;
}




for ($x=1 ; $x<=63;$x=$x+2){
hi1:
$rr = int(rand(64))+1;
if ( $already[$rr] > 0 ) { goto hi1; }
$already[$rr] = 1 ;
$loko[$x] = $teilnehmer[$rr] ;


}







open (D2,">/tmdata/btm/pokal/pokal_id.txt");
print D2 "&";
for ($x=1 ; $x<=64;$x++){
print D2 "$loko[$x]&";
}
print D2 "\n";
close (D2);

return 1;
