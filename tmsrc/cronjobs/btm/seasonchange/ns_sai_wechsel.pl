#!/usr/bin/perl




$rr = 0;
$li=0;
$liga=0;
open(D2,"/tmdata/btm/history.txt");
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
$trainer{$data[$x]} = $datb[$x] ;
$y++;
chomp $verein[$y];
$datc[$x] = $vereine[$y];
}

}

close(D2);










srand();
$r=0;
open(U,"/tmdata/btm/heer.txt");
while (<U>) {
$r++;

$xx = $_ ;
chomp $xx;
@lolo = split (/&/ , $xx ) ;
$team[$r] = $lolo[5] ;

#print "$team[$r]\n";

}
close (U);

#print $r ;
#$d = <stdin> ;


for ($x=1 ; $x<=$r ; $x++ ) {
$verein[$x] = $team[$x] ;
}


open(U,"xx1.txt");
while (<U>) {
$r++;
$xx = $_ ;
chomp $xx;
( $ch1 , $ch2 ) = split (/,/ , $xx ) ;
$ch1 = $ch1 * 1;
$ch2 = $ch2 * 1;

$verein[$ch1] = $team[$ch2] ;
$verein[$ch2] = $team[$ch1] ;


}
close (U);















open(U,">/tmapp/tmsrc/cronjobs/btm/seasonchange/history.txt");
for ($x=1 ; $x<=384;$x++){

$xa=(($x-1) * 18 ) + 1;
$xb=$xa+17;

if ( $x<10 ) {
print U "x0$x&";
} else {
print U "x$x&";
}

for ($y=$xa ; $y<=$xb;$y++){
print U "$verein[$y]&$trainer{$verein[$y]}&&";
}
print U "\n";


}
close (U);

print "Neue history.txt unter /tmapp/tmsrc/cronjobs/btm/seasonchange/history.txt abgelegt \n";
