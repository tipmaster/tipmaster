#!/usr/bin/perl




require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl";


$rr = 0;
$li=0;
$liga=0;
open(D2,"/tmdata/tmi/history.txt");
while(<D2>) {

$la++;
@vereine = split (/&/, $_);	

$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
$rr++;
$y++;
chomp $vereine[$y];
$data[$rr] = $vereine[$y];
$li{$data[$rr]} = $la;


$y++;
chomp $vereine[$y];
$datb[$rr] = $vereine[$y];
if ( $datb[$rr] eq $trainer ) { 
$isa = $gg ;
$isb = $x;
$team = $data[$rr];
}

$tr{$data[$rr]} = $datb[$rr];
$y++;
chomp $verein[$y];
$datc[$x] = $vereine[$y];
}

}

close(D2);


open (D1,"/tmdata/tmi/history.txt");
flock (D1,2) ;
while (<D1>) {
$a = $_ ;
$inhalt .= $a;
}
flock (D1,8) ;
close (D1);

open (D1,"/tmdata/tmi/tausch.txt");
while (<D1>) {
@data = split (/&/,$_) ;
if ($tr{$data[3]} eq $data[2] ) {
$w++;
$x1[$w] = $data[1];
$x2[$w] = $data[2];
$x3[$w] = $data[3];



}


}

close (D1);

for ($x=1;$x<=$w;$x++){
for ($y=1;$y<=$w;$y++){
if ( $x != $y ) {

if ( $x1[$x] eq $x3[$y] ) {
print "$x1[$x] $x3[$x]\n";
if ( $x3[$x] eq $x1[$y] ) {
$aa = "";
$ab ="";
$ac="";
$ad="";


$aa= "&" . $x3[$x] . "&" . $x2[$x] . "&" ;
$ab= "&" . $x3[$x] . "&" . $x2[$y] . "&" ;
$ac= "&" . $x3[$y] . "&" . $x2[$y] . "&" ;
$ad= "&" . $x3[$y] . "&" . $x2[$x] . "&" ;

print $aa;
if ( ( $inhalt =~ /$aa/ ) and  ( $inhalt =~ /$ac/ )) {
print "$x1[$x] $x2[$x] $x3[$x] $aa / $ab<br>";
print "$x1[$y] $x2[$y] $x3[$y] $ac / $ad<br><br>";
$inhalt =~ s/$aa/$ab/;
$inhalt =~ s/$ac/$ad/;
($sek, $min, $std, $tag, $mon, $jahr) =  localtime(time+0);
$mon++ ;
if ( $sek <10 ) { $xa = "0" }
if ( $min <10 ) { $xb = "0" }
if ( $std <10 ) { $xc = "0" }
if ( $tag <10 ) { $xd = "0" }
if ( $mon <10 ) { $xe = "0" }
if ( $liga <10 ) { $xf = "0" }
if ( $spielrunde <10 ) { $xg = "0" }
$jahr = $jahr + 1900 ;
open(D21,">>/tmdata/tmi/tausch_liste.txt");
print D21 "&$xd$tag.$xe$mon.$jahr&$x1[$x]&$x2[$x]&$x3[$x]&$x1[$y]&$x2[$y]&$x3[$y]&\n";
close (D21);
}
}
}
}
}
}

#print "<br>$inhalt";


open(D2,">/tmdata/tmi/history.txt");
flock (D2,2);
print D2 $inhalt;
flock (D2,2);
close (D2);
