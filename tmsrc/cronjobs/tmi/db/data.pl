#!/usr/bin/perl

print "Generiere Trainerlaufbahn Dateien ...\n";

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

open(DO,"</tmdata/tmi/db/vereine.txt");
while(<DO>) {
$t++;
($nummer , $ve ) = split (/&/ , $_);
chomp $ve ;
$verein[$nummer] = $ve ;
}
close(DO);


open(DO,"</tmdata/tmi/db/trainer.txt");
while(<DO>) {
$t++;
($nummer , $ve ) = split (/&/ , $_);
chomp $ve ;
$trainer[$nummer] = $ve ;
}
close(DO);




for ($x=1 ; $x<=45000 ; $x++ ) {
if ( $aktiv{$trainer[$x]} == 1 ) {
$i = "D" .  $x ;
$datei = '/tmdata/tmi/db/trainer/' . $trainer[$x] . '.txt' ;
open($i,">$datei");
close($i);
}
}

open(SP,"</tmdata/tmi/db/spiele.txt");
while(<SP>) {
@alles = split (/#/ , $_);
$x = $alles[0] ;
if ( $aktiv{$trainer[$x]} == 1 ) {
$datei = '/tmdata/tmi/db/trainer/' . $trainer[$x] . '.txt' ;
open(D1,">>$datei");
print D1 "$_";
close (D1);
}

}
close(SP);


