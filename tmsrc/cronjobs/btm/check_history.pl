
open(AAA,">/tmdata/btm/vereine.txt");

open(X2,"/tmdata/save/pass_btm_24.txt");
while(<X2>) {
@all=split(/&/,$_);
$line{$all[1]}=$_;
chomp $line{$all[1]};
}
close(X2);

open(X2,"/tmdata/pass.txt");
while(<X2>) {
$a=$_;
@all=split(/&/,$_);
$rr++;
$ok{$all[1]}=1;
}
close(X2);

$rr = 0;
$li=0;
$liga=0;
open(X2,"/tmdata/btm/history.txt");
while(<X2>) {

$li++;
@vereine = split (/&/, $_);

$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
$y++;
chomp $verein[$y];
$data[$x] = $vereine[$y];
print AAA "$data[$x]\n";

#$xx= length($data[$x]);
#if ($xx>20 && $xx<24){print "$xx $data[$x]\n";}

if ( $data[$x] eq "aaa" ) { 

   $mailprog = '/usr/sbin/sendmail';
   open(MAIL,"|$mailprog -t");
   print MAIL "To: alarm\@tipmaster.net\n";
   print MAIL "From: TipMaster Routineuntersuchung\n";
   print MAIL "Subject: BTM history.txt fehlerhaft \n" ;
   print MAIL "Zeile / Liga # $li der Datei /btm/history.txt defekt\nMoeglichst Zeile durch BAckup der history.txt ersetzen";
   close(MAIL);

print "ZEILE KAPUTT LIGA # $li\n" }

$y++;
chomp $verein[$y];
$datb[$x] = $vereine[$y];
if ( $ok{$datb[$x]} != 1 ) {
if ( $datb[$x] ne "Trainerposten frei" ) {
print "$line{$datb[$x]}\n";
}}
$oki{$datb[$x]}++;
if ( $oki{$datb[$x]} > 1 ) {
if ( $datb[$x] ne "Trainerposten frei" ) {
print "$li $data[$x] Zweimal $datb[$x]\n";
}
}

$aktiv{"$datb[$x]"} = 1;
$y++;
chomp $verein[$y];
$datc[$x] = $vereine[$y];
}
}
close(X2);

close(AAA);

