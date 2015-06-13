#!/usr/bin/perl


$mailprog = '/usr/sbin/sendmail';

$e = 0;$y = 0;

open(D2,"/tmdata/btm/history.txt");
while(<D2>) {
@vereine = ();
$e++ ;

@vereine = split (/&/, $_);	

$ya = 0;
for ( $x = 1; $x < 19; $x++ )
{
$ya++;
$y++;
chomp $vereine[$ya];
$datq[$y] = $vereine[$ya];
$ya++;
chomp $vereine[$ya];
$datb[$y] = $vereine[$ya];

if ( $datb[$y] ne "Trainerposten frei" ) { $summe++ }
if ( $datb[$y] ne "Trainerposten frei" ) { $btm++ }
$ya++;
chomp $vereine[$ya];
$datc[$y] = $vereine[$ya];
$liga[$y] = $e ;
}


}
close(D2);



open(D2,"/tmdata/tmi/history.txt");
while(<D2>) {
@vereine = ();
$e++ ;

@vereine = split (/&/, $_);	

$ya = 0;
for ( $x = 1; $x < 19; $x++ )
{
$ya++;
$y++;
chomp $vereine[$ya];
$datq[$y] = $vereine[$ya];
$ya++;
chomp $vereine[$ya];
$datb[$y] = $vereine[$ya];
if ( $datb[$y] ne "Trainerposten frei" ) { $summe++ }
if ( $datb[$y] ne "Trainerposten frei" ) { $tmi++ }
$ya++;
chomp $vereine[$ya];
$datc[$y] = $vereine[$ya];
$liga[$y] = $e ;
}


}
close(D2);



$tt=0;
print "Content-Type: text/html \n\n";
print "<font face=verdana size=1 color=black>Registrierte Accounts : $summe ( $btm / $tmi )<br><br>";

open(D2,">/tmdata/accounts.txt");
print D2 $summe;
close (D2);

$g = `tail -1 /tmdata/btm/db/trainer.txt`;
$f = `tail -1 /tmdata/tmi/db/trainer.txt`;
@all1=split(/&/,$g);
@all2=split(/&/,$f);

open(D2,">/tmdata/accounts.txt");
print D2 $summe."\n";
print D2 $all1[0]+$all2[0];
close (D2);


print $g, $f;
