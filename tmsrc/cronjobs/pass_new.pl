#!/usr/bin/perl

($sek, $min, $std, $tag, $mon, $jahr,$wt) =  localtime(time+0);

$file_btm = "/tmdata/backup/history_btm_" . $tag . ".txt";
$file_tmi = "/tmdata/backup/history_tmi_" . $tag . ".txt";
$file_pass = "/tmdata/backup/pass_" . $tag . ".txt";
$ffile_btm = "/tmdata/backup/friendly_btm_" . $tag . ".txt";
$ffile_tmi = "/tmdata/backup/friendly_tmi_" . $tag . ".txt";



`cp /tmdata/btm/history.txt $file_btm`;
`cp /tmdata//tmi/history.txt $file_tmi`;
`cp /tmdata/pass.txt $file_pass`;
`cp /tmdata/btm/friendly/friendly.txt $ffile_btm`;
`cp /tmdata/tmi/friendly/friendly.txt $ffile_tmi`;



$x=$tag%31;
open(D3,">/tmdata/save/pass_btm_$x.txt");
open(D2,"</tmdata/pass.txt");
while (<D2>){

print D3 $_ ;
}
close(D2);
close(D3);

open(D3,">/tmdata/save/history_btm_$x.txt");
open(D2,"</tmdata/btm/history.txt");
while (<D2>){

print D3 $_ ;
}
close(D2);
close(D3);

print "Content-type:text/html\n\n<font face=verdana size=1>";
$fh= 0;
$g=0;
open(D2,"/tmdata/btm/history.txt");
while(<D2>) {
$g++;
@vereine = split (/&/, $_);	

$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
$fh++;
$y++;
chomp $verein[$y];
$data[$fh] = $vereine[$y];
$y++;
chomp $verein[$y];
$datb[$fh] = $vereine[$y];
$y++;
chomp $verein[$y];
$datc[$fh] = $vereine[$y];
$ex{$datb[$fh]}=1;
}

}
close (D2) ;

$fh= 0;
$g=0;
open(D2,"/tmdata/tmi/history.txt");
while(<D2>) {
$g++;
@vereine = split (/&/, $_);

$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
$fh++;
$y++;
chomp $verein[$y];
$data[$fh] = $vereine[$y];
$y++;
chomp $verein[$y];
$datb[$fh] = $vereine[$y];
$y++;
chomp $verein[$y];
$datc[$fh] = $vereine[$y];
$ex{$datb[$fh]}=1;
}

}
close (D2) ;


$g=0;
open(D2,"/tmdata/pass.txt");
while(<D2>) {
$g++ ;
$lock[$g] = $_ ;
chomp $lock[$g] ;
($leer , $trainer[$g] , $end) = split (/&/ , $_ ) ;
}
close (D2) ;
open(D3,">>/tmdata/pass_nonactive.txt");
open(D2,">/tmdata/pass_neu.txt");
for ( $x = 1; $x <= $g; $x++ )
{
if ( $ex{$trainer[$x]} == 1 ) { 
print D2 "$lock[$x]\n" ;
$zeilen++;

} else {
print D3 "$lock[$x]\n";


}

}
close(D2);
close(D3);

print "<br><br>";

print "$g Zeilen ...\n";

#$cc=0;
#open(D3,">/tmdata/pass.txt");
#open(D2,"</tmdata/btm/pass_neu.txt");
#while (<D2>){
#$cc++;
#print D3 $_ ;
#}
#close(D2);
#close(D3);

print "<br><br>$cc Zeilen ...\n";
