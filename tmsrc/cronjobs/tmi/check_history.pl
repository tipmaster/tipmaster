

open(X2,"/home/tipmaster/save/pass_tmi_26.txt");
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
open(X2,"/tmdata/tmi/history.txt");
while(<X2>) {

$li++;
@vereine = split (/&/, $_);

$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
$y++;
chomp $verein[$y];
$data[$x] = $vereine[$y];
if ( $data[$x] eq "" ) { 

   $mailprog = '/usr/sbin/sendmail';
   open(MAIL,"|$mailprog -t");
   print MAIL "To: alarm\@tipmaster.net\n";
   print MAIL "From: TipMaster Routineuntersuchung\n";
   print MAIL "Subject: TMI history.txt fehlerhaft \n" ;
   print MAIL "Zeile / Liga # $li der Datei /tmi/history.txt defekt\nM�glichst Zeile durch BAckup der history.txt ersetzen";
   close(MAIL);

print "ZEILE KAPUTT # $li \n" }
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
print "Zweimal $datb[$x]\n";
}
}

$aktiv{"$datb[$x]"} = 1;
$y++;
chomp $verein[$y];
$datc[$x] = $vereine[$y];
}
}
close(X2);


