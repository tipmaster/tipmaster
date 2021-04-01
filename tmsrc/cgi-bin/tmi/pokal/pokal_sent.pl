#!/usr/bin/perl

=head1 NAME
	TMI pokal_sent.pl

=head1 SYNOPSIS
	TBD
	
=head1 AUTHOR
	admin@socapro.com

=head1 CHANGELOG
	2015-06-09 Thomas: Added Session Management

=head1 COPYRIGHT
	Copyright (c) 2015, SocaPro Inc.
	Created 2015-06-09

=cut

use lib '/tmapp/tmsrc/cgi-bin/'; 
use TMSession;
my $session = TMSession::getSession(tmi_login => 1);
my $trainer = $session->getUser();
my $leut = $trainer;

use CGI;
print "Content-type: text/html\n\n";

$query = new CGI;
$url = $query->param('url');
$tip[1] = $query->param('30....');
$tip[2] = $query->param('31....');
$tip[3] = $query->param('32....');
$tip[4] = $query->param('33....');
$tip[5] = $query->param('34....');
$tip[6] = $query->param('35....');
$tip[7] = $query->param('36....');
$tip[8] = $query->param('37....');
$tip[9] = $query->param('38....');
$tip[10] = $query->param('39....');
$tips = $query->param('tips');
$pokal = $query->param('pokal');

open(D7,"/tmdata/tmi/pokal/tip_status.txt");
$tip_status = <D7> ;
chomp $tip_status;
close(D7);

if ( $tip_status != 1 ) {

print "<title>Pokal Tipabgabe</title><font face=verdana size=2><br><br><br><br><br><b>Die Tipabgabefrist ist bereits abgelaufen ...\n";
exit ;
}


print "Content-type: text/html\n\n";
print "<title>Pokal Tipabgabe</title><body bgcolor=white text=black>\n";

print "<form name=Testform action=/cgi-mod/tmi/login.pl method=post></form>";
print "<script language=JavaScript>";
print"   function AbGehts()";
print"   {";
print"    document.Testform.submit();";
print"    }";
print"   window.setTimeout(\"AbGehts()\",7000);";
print"  </script>";

print "<p align=left><body bgcolor=white text=black link=darkred link=darkred>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";

require "/tmapp/tmsrc/cgi-bin/tag.pl" ;

$agb = 0;

for ($x=1 ; $x<=10 ; $x++ ) {
if ( $tip[$x] ne "0&0" ) { $abg++ }
$reihe = $reihe . $tip[$x] . '.' ;
}

if ( $abg != $tips ) {
print "<font face=verdana size=2><br><br><br><br><br><b>Die Anzahl Ihrer abgegebenen Tips ist nicht korrekt ...<br>Sie haben $abg Tips anstatt der korrekten $tips Tips abgegeben .<br>Bitte kehren Sie zur Tipabgabe zurueck und korregieren Sie Ihre Tipabgabe .\n";
exit ;
}


$rf ="0";
$rx = "x" ;
my $liga = 0;
if ( $liga > 9 ) { $rf = "" }

$suche = '&'.$trainer.'&' ;
$s = 0;
open(D2,"/tmdata/tmi/history.txt");
while(<D2>) {
$s++;
if ($_ =~ /$suche/) {
@lor = split (/&/, $_);	
$liga = $s ;
}

}
close(D2);

$id_verein = 0;

$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
$y++;
chomp $lor[$y];
$data[$x] = $lor[$y];
$teams[$x] = $lor[$y];
$team[$x] = $lor[$y];
$y++;
chomp $lor[$y];
$datb[$x] = $lor[$y];
if ( $datb[$x] eq $trainer ) {$id = $x }
if ( $datb[$x] eq $trainer ) {$id_verein = (($liga-1)*18)+ $x }

if ( $datb[$x] eq $trainer ) {$verein = $data[$x] }
$y++;
chomp $lor[$y];
$datc[$x] = $lor[$y];
if ( $datb[$x] eq $trainer ) {$recipient = $datc[$x] }
}




$rr = 0;
$li=0;
$liga=0;
open(D2,"/tmdata/tmi/history.txt");
while(<D2>) {

$li++;
@vereine = split (/&/, $_);	

$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
$rr++;
$y++;
chomp $verein[$y];
$teams[$rr] = $vereine[$y];
$team[$rr] = $vereine[$y];
$y++;
chomp $verein[$y];
$datb[$rr] = $vereine[$y];
$y++;
chomp $verein[$y];
$datc[$rr] = $vereine[$y];
}

}

close(D2);
my $url = "/tmdata/tmi/pokal/tips/" ;

if ( $id_verein<10 ) { $url = $url . '0' }
if ( $id_verein<100 ) { $url = $url . '0' }
if ( $id_verein<1000 ) { $url = $url . '0' }



open(D7,"/tmdata/tmi/pokal/pokal_datum.txt");
$spielrunde_ersatz = <D7> ;
chomp $spielrunde_ersatz;
close(D7);

$runde = $spielrunde_ersatz; 

$url=$url.$id_verein. '-' . $pokal . '-' . $runde . '.txt' ;

open(D2,">$url");
print D2 "$reihe\n";
close (D2) ;

print "<font face=verdana size=2><br><br><br><b>&nbsp;&nbsp;Ihre Tipabgabe wurde registriert .<br>&nbsp;&nbsp;Sie werden zu Ihrem LogIn Bereich weitergeleitet ...\n";



