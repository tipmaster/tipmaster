#!/usr/bin/perl

=head1 NAME
	TMI tipabgabe_ls.pl

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
$mailprog = '/usr/sbin/sendmail';

print "Content-type: text/html\n\n";



$query = new CGI;
$method = $query->param('method');
$extra = $query->param('extra');
$ausnahme = $query->param('ausnahme');


require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl" ;
require "/tmapp/tmsrc/cgi-bin/runde.pl" ;

$rf ="0";
$rx = "x" ;
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


open(D7,"/tmdata/tmi/tip_datum.txt");
$spielrunde_ersatz = <D7> ;

chomp $spielrunde_ersatz;
close(D7);

$bx = "formular";
$by = int(( $spielrunde_ersatz + 3 ) / 4 );

$bv = ".txt";
$fg = "/tmdata/tmi/";
$datei_hiero = $fg . $bx . $by . $bv ;




open(DO,$datei_hiero);
while(<DO>) {
@ver = <DO>;
}
close(DO);

$y = 0;
for ( $x = 0; $x < 25;$x++ )
{
$y++;
chomp $ver[$y];
@ega = split (/&/, $ver[$y]);	
$flagge[$y] = $ega[0] ;
$paarung[$y] = $ega[1];
$qu_1[$y] = $ega[2];
$qu_0[$y] = $ega[3];
$qu_2[$y] = $ega[4];
$ergebnis[$y] = $ega[5];
}

($land,$rest) = split (/ /,$liga_namen[$liga]);

($sek, $min, $std, $tag, $mon, $jahr ,$ww) =  localtime(time+0);

$einsicht=0;
#print "$std:$min:$sek Uhr";
if (( $ww >5 )or($ww==0)) { $einsicht=1 }
if (( $ww == 5 )and($std>17)and($min>1)) { $einsicht=1 }

if ( $method eq "hps" ) { &homepages }

if ( $method eq "show" ) {

if ( $einsicht == 1 ) {

open(D7,"/tmdata/tmi/tip_datum.txt");
$spielrunde_ersatz = <D7> ;
chomp $spielrunde_ersatz;
close(D7);

$bx = "formular";
$by = int(( $spielrunde_ersatz + 3 ) / 4 );
$bv = ".txt";
$fg = "/tmdata/tmi/";
$datei_hiero = $fg . $bx . $by . $bv ;

open(DO,$datei_hiero);
while(<DO>) {
@ver = <DO>;
}
close(DO);

$y = 0;
for ( $x = 0; $x < 25;$x++ )
{
$y++;
chomp $ver[$y];
@ega = split (/&/, $ver[$y]);	
$flagge[$y] = $ega[0] ;
$paarung[$y] = $ega[1];
$qu_1[$y] = $ega[2];
$qu_0[$y] = $ega[3];
$qu_2[$y] = $ega[4];
$pro{$paarung[$y]} = $ega[5];
$ergebnis[$y] = $ega[6];
$datum{$paarung[$y]} = $ega[7];
$zeit{$paarung[$y]} = $ega[8];




$nr{$paarung[$y]} = $y;
}

$tx=0;

if ( $ausnahme == 1 ) { $rrunde = 6 }

$datei = "/tmdata/tmi/lm-tips-" . $rrunde . ".txt";
open (D1,"$datei");
while (<D1>){

@goof = split(/&/,$_);

($rr,$joke)=split(/ / , $liga_namen[$goof[1]]);
if ( $rr eq "San" ) { $rr = "San Marino" }
if ( $rr eq "Nord" ) { $rr = "Nord Irland" }
if ( $kk{$rr} != 1 ) { 
$tx++;
$land[$tx] = $rr;
$kk{$rr}=1;
}

$xc="<font color=black>";
$tip=$goof[2];
$tip=~s/Tip //;
if($tip==2){$tip=3};
if ( $tip==0){$tip=2};

if ( $pro{$goof[3]} == $tip ) { $xc ="<font color=green>" }
if ( ( $pro{$goof[3]} > 0  ) and  ( $pro{$goof[3]} != $tip )) { $xc ="<font color=darkred>" }
if ( ( $pro{$goof[3]} == 4  ) ) { $goof[4] = 10 }
$tips_land{$rr} .= "$xc $goof[0]  $goof[2]  $goof[3] [ # $nr{$goof[3]} | $datum{$goof[3]} $zeit{$goof[3]}] Quote $goof[4]  [ $goof[5] ] </font><br>\n";
$tips_landos{$rr} .= "$goof[5]!$xc $goof[0]  $goof[2]  $goof[3] [ # $nr{$goof[3]} | $datum{$goof[3]} $zeit{$goof[3]}] Quote $goof[4]  [ $goof[5] ] </font><br>";
}
close (D1);

for ($x=1;$x<=$tx;$x++){
$land=$land[$x];
if ( $land[$x] eq "San" ) { $land = "San Marino" }
if ( $land[$x] eq "Nord" ) { $land = "Nord Irland" }
$sort[$x]=$land . '#'.$x ;
}
@bongo = sort @sort ;
print "<a name=#0><font face=verdana size=1>";
foreach $c (@bongo) {
@oki=split(/#/,$c);
if ( $oki[0] ne "" ) {
print "<a href=#$oki[1]>Tipabgabe $oki[0]</a><br>";
}}
print "<br><br>";


for ($x=1;$x<=$tx;$x++){
$land=$land[$x];
if ( $land[$x] eq "San" ) { $land = "San Marino" }
if ( $land[$x] eq "Nord" ) { $land = "Nord Irland" }

if ( $land[$x] eq "San Marino" ) { $land[$x] = "San" }
if ( $land[$x] eq "Nord Irland" ) { $land[$x] = "Nord" }

if ( $ausnhame != 1 ) {
$datei = "/tmdata/tmi/nm/" . $land[$x] . '-' . $rrunde . '.txt' ;
$gegner1="";$gegner2="";
$aufst1="";$aufst2="";


my @lines=();

if (-e $datei) {
my $inputFile = IO::File->new( $datei, "r" );
binmode( $inputFile, ":encoding(UTF-8)" );
@lines = $inputFile->getlines();
$inputFile->close();

if (scalar(@lines)>3) {
$aufst1=$lines[0];
$aufst2=$lines[1];
$gegner1=$lines[2];
$gegner2=$lines[3];
chomp $gegner1;chomp $gegner2;
}
}
}
print "<a name=$x><br><font face=verdana size=2 color=darkred><b>[#$x] Tipabgaben Nationalmannschaft $land :</b> &nbsp; &nbsp; &nbsp; <font size=1>[ <a href=#0>back to top</a> ]\n";
print "<font face=verdana size=1 color=black><br>";
if ( $ausnahme != 1 ) {
print "<br>Offizielle Gegner : $gegner1 und $gegner2<br/> ";

}

#$tips_landos{$land}=~s/<br>gegen/gegen/;
#print "\n\n$tips_landos{$land}<br>";


@cool = split(/\<br\>/,$tips_landos{$land});

@kool=sort @cool;




$bd="";
foreach $y (@kool){
#print " <br/>... $y ... <br>";

($leer,$akut)=split(/\!/,$y);
($train,$fff)=split(/  Tip /,$akut);
$leer=~s/gegen //;
$aa = "[-----]";

$train=~s/<font color=.*?>/<font>/;
$train=~s/<\/font>/<\/font>/;
$train=~s/<font> //;


if ( ( $leer eq $gegner1 )) {
$man = $train . '&' ;
$man=~s/<font color=.*?>/<font>/;


$man=~s/<font> \s//;
$man=~s/\n//gs;

$man=~s/^\s//gs;
$man1="E1#".$man;
$man2="E2#".$man;
$man3="S#".$man;

my @sections = split(/&/,$aufst1);
foreach (@sections) {
	(my $a, my $b) = split(/#/, $_);	
	if ($b eq $train) {$aa = "[-". $a ."-]"}
}


}

if ( ( $leer eq $gegner2 )) {
$man = $train . '&' ;
$man=~s/<font color=.*?>/<font>/;

$man1='E1#'.$man;
$man2='E2#'.$man;
$man3='S#'.$man;

my @sections = split(/&/,$aufst2);
foreach (@sections) {
	(my $a, my $b) = split(/#/, $_);	
	if ($b eq $train) {$aa = "[-". $a ."-]"}
}
}


if ( $leer ne $bd ) { print "\n<br>\n" }
$bd=$leer;

if ($aa eq "[-S-]") {$aa = "[-ST-]"}

print "$aa $akut<br>\n";

}


print "<hr size=0 width=95%>\n";
}

exit;
}
}

if ( $method eq "save" ) {


open(D7,"/tmdata/tmi/tip_status.txt");
$tip_status = <D7> ;

chomp $tip_status;
close(D7);

if ( $tip_status == 2 ) {
print "<font face=verdana size=1>Tipabgabetermin bereits abgelaufen ...";
exit;
}

$y=0;
$tips=0;
print "<font face=verdana size=1>Bei Problemen mit der Tipabgabe die Fehlermeldung inkl.<br>der folgenden Zeile an info\@tipmaster.net mailen !<br>";


$tipo[1] = $query->param('30....');
$tipo[2] = $query->param('31....');
$tipo[3] = $query->param('32....');
$tipo[4] = $query->param('33....');
$tipo[5] = $query->param('34....');
$tipo[6] = $query->param('35....');
$tipo[7] = $query->param('36....');
$tipo[8] = $query->param('37....');
$tipo[9] = $query->param('38....');
$tipo[10] = $query->param('39....');
$tipo[11] = $query->param('40....');
$tipo[12] = $query->param('41....');
$tipo[13] = $query->param('42....');
$tipo[14] = $query->param('43....');
$tipo[15] = $query->param('44....');
$tipo[16] = $query->param('45....');
$tipo[17] = $query->param('46....');
$tipo[18] = $query->param('47....');
$tipo[19] = $query->param('48....');
$tipo[20] = $query->param('49....');
$tipo[21] = $query->param('50....');
$tipo[22] = $query->param('51....');
$tipo[23] = $query->param('52....');
$tipo[24] = $query->param('53....');
$tipo[25] = $query->param('54....');

for ($x=30;$x<=54;$x++){
$y++;



#$tipo[$y] = $query->param("$x....");





$tipx[$y] = $query->param("m$x....");

print "$tipo[$y] - ";

if ( ( $tipo[$y] eq "1&2") or( $tipo[$y] eq "1&1") or( $tipo[$y] eq "1&3")){

$tips++;
$merk[$tips]=$x-29;
($rest,$quote[$tips])= split(/&/,$tipo[$y]);
chomp $quote[$tips] ;

if ( $quote[$tips] == 2 ) { $quote[$tips] = 0 }
if ( $quote[$tips] == 3 ) { $quote[$tips] = 2 }

if ( $quote[$tips] == 1 ) { $quotex[$tips] = $qu_1[$merk[$tips]] }
if ( $quote[$tips] == 0 ) { $quotex[$tips] = $qu_0[$merk[$tips]] }
if ( $quote[$tips] == 2 ) { $quotex[$tips] = $qu_2[$merk[$tips]] }

$mest[$tips]=$tipx[$y];
}
}


print "<br><br>";

if ( $tips > 3 ) {

print "<html><body bgcolor=white text=black link=blue vlink=blue><title>Tipabgabe Nationalmannschaft $coach fuer $land</title>";
print "<p align=left>\n";

#require "/tmapp/tmsrc/cgi-bin/tag.pl" ;
#require "/tmapp/tmsrc/cgi-bin/tag_small.pl" ;
print "<br><br><font face=verdana size=2 color=darkred> &nbsp; <b>Sie haben mehr als 3 Tips abgegeben ( ihre Tipanzahl $tips ) ; dies ist bei der Nationalmannschaft Tipabgabe nicht zulaessig !<br><br> &nbsp; Bitte kehren Sie zur Tipabgabe zurueck und reduzieren Sie Ihre Tipanzahl !\n";
exit;
}

if ( $tips == 0 ) {

print "<html><body bgcolor=white text=black link=blue vlink=blue><title>Tipabgabe Nationalmannschaft $coach fuer $land</title>";
print "<p align=left>\n";

#require "/tmapp/tmsrc/cgi-bin/tag.pl" ;
#require "/tmapp/tmsrc/cgi-bin/tag_small.pl" ;
print "<br><br><font face=verdana size=2 color=darkred> &nbsp; <b>Sie haben keinen Tip abgegeben ; dies ist bei der Nationalmannschaft Tipabgabe nicht zulaessig !<br><br> &nbsp; Bitte kehren Sie zur Tipabgabe zurueck und korregieren Sie Ihren Tip !\n";
exit;
}




print "<html><body bgcolor=white text=black link=blue vlink=blue><title>Tipabgabe Nationalmannschaft $coach fuer $land</title>";
print "<p align=left>\n";

#require "/tmapp/tmsrc/cgi-bin/tag.pl" ;
#equire "/tmapp/tmsrc/cgi-bin/tag_small.pl" ;
print "<br><br><font face=verdana size=2 color=darkred> &nbsp; <b>Von Ihnen wurden folgende NM - Tips fuer Ihr Land $land registriert :</b><br><br>\n";

if ( $extra == 1 ) { $rrunde = 8 }
if ( $extra == 2 ) { $rrunde = 6 }


$datei = "/tmdata/tmi/lm-tips-" . $rrunde . ".txt";

$at=0;
read1:
$s=0;
open (D1,"$datei");
while (<D1>){
$s++;
$l=$_;
chomp $l;
@goof = split(/&/,$l);
if ( $goof[0] ne $trainer ) {
$lines++;
$liney[$lines]=$l;
}
}
close (D1);
if ( $s==0 && $at < 10 ) { $at++ ; sleep 1; goto read1; }

open (D1,">$datei");
flock (D1,2);
for ($a=1;$a<=$lines;$a++){
print D1 "$liney[$a]\n";
}
flock(D1,8);
close (D1);



for ($d=1;$d<=$tips;$d++) {
print "<font color=black><b> &nbsp; &nbsp; &nbsp; * &nbsp; &nbsp; Tip $quote[$d] $paarung[$merk[$d]] Quote $quotex[$d] &nbsp; &nbsp; ( $mest[$d] )</b></font><br>";

open (D1,">>$datei");
flock (D1,2);
print D1 "$trainer&$liga&Tip $quote[$d]&$paarung[$merk[$d]]&$quotex[$d]&$mest[$d]&\n";
flock(D1,8);
close (D1);
}



print "<br><br><font face=2 face=verdana>\n";
print " &nbsp; &nbsp;<font face=verdana size=2> &nbsp;Bitte beachten : Wenn Sie vor diesem Tip in dieser Tiprunde bereits einen Tip fuer<br>\n";
print " &nbsp; &nbsp; die Nationalmannschaft abgegeben haben , wurde dieser durch diese Tipabgabe ersetzt !\n";

print "<br><br><font color=black face=verdana> &nbsp; &nbsp; <i>Sie werden zur LogIn Seite weiter geleitet ...</i>\n";

print "<form name=Testform action=/cgi-mod/tmi/login.pl method=post></form>";
print "<script language=JavaScript>";
print"   function AbGehts()";
print"   {";
print"    document.Testform.submit();";
print"    }";
print"   window.setTimeout(\"AbGehts()\",10000);";
print"  </script>";


exit;
}





&daten_lesen;

# Return HTML Page or Redirect User
&return_html;


sub homepages {

print "<center><font face=verdana size=1><br>Homepages der TMI Nationalmannschaften<br><br><br>";
print "Die URLs koennen vom Praesidenten und Teamchef des jeweiligen Landes<br>ueber die Kaderverwaltung eingetragen/modifiziert werden<br><br><p align=left>";
print "<table border=0>";
$kk="";@kk=();%kk=();
for ($goof=1;$goof<=$rr_ligen;$goof++){

( my $a1,my $a2)=split(/ /,$liga_kuerzel[$goof]);
$a1 = lc($a1);
$a1 = "/img/flags/" . $a1 . ".jpg";

($rr,$joke)=split(/ / , $liga_namen[$goof]);
if ( $kk{$rr} != 1 ) {
$tx++;
$land[$tx] = $rr;
$kk{$rr} = 1;
$datei = "/tmdata/tmi/nm/".$rr.".txt";
open (D,"<$datei");
$a=<D>;
@all=split(/\|/,$a);
close (D);
print "<tr><td align=right><font face=verdana size=1> ";
if ( $all[3] eq "http://" ) { $all[3] = "Fehlanzeige"} 
if ( $all[3] ne "Fehlanzeige" ) {
print " &nbsp; &nbsp; &nbsp; &nbsp; $rr &nbsp;&nbsp; <img src=$a1> &nbsp;</td><td align=left><font face=verdana size=1>&nbsp;<a href=$all[3] target=new>$all[3]</a></td></tr>\n";
} else {
print " &nbsp; &nbsp; &nbsp; &nbsp; $rr &nbsp;&nbsp; <img src=$a1> &nbsp;</td><td align=left><font face=verdana size=1>&nbsp;
$all[3]</td></tr>\n";
}

}
}
print "</table>";

exit;

}



sub daten_lesen {





$rf ="0";
$rx = "x" ;
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


$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
$y++;
chomp $lor[$y];
$data[$x] = $lor[$y];
$y++;
chomp $lor[$y];
$datb[$x] = $lor[$y];
if ( $datb[$x] eq $trainer ) {$id = $x }
if ( $datb[$x] eq $trainer ) {$coach = $data[$x] }
$y++;
chomp $lor[$y];
$datc[$x] = $lor[$y];
if ( $datb[$x] eq $trainer ) {$recipient = $datc[$x] }
}
$verein = $id ;


open(D7,"/tmdata/tmi/tip_status.txt");
$tip_status = <D7> ;

chomp $tip_status;
close(D7);

open(D7,"/tmdata/tmi/tip_datum.txt");
$spielrunde_ersatz = <D7> ;

chomp $spielrunde_ersatz;
close(D7);

$bx = "formular";
$by = int(( $spielrunde_ersatz + 3 ) / 4 );

$bv = ".txt";
$fg = "/tmdata/tmi/";
$datei_hiero = $fg . $bx . $by . $bv ;




open(DO,$datei_hiero);
while(<DO>) {
@ver = <DO>;
}
close(DO);

$y = 0;
for ( $x = 0; $x < 25;$x++ )
{
$y++;
chomp $ver[$y];
@ega = split (/&/, $ver[$y]);	
$flagge[$y] = $ega[0] ;
$paarung[$y] = $ega[1];
$qu_1[$y] = $ega[2];
$qu_0[$y] = $ega[3];
$qu_2[$y] = $ega[4];
$ergebnis[$y] = $ega[5];
}

open(D9,"/tmdata/tmi/spieltag.txt");
while(<D9>) {
@ego = <D9>;
}
close(D9);



$fa = 0 ;

}



sub return_html {
  

        # Print HTTP header and opening HTML tags.                           #
       


print "<table border=0 cellpadding=0 cellspacing=0>";
$hh = $spielrunde_ersatz + 3;
print "<html><body bgcolor=white text=black link=blue vlink=blue><title>Tipabgabe Nationalmannschaft $coach fuer $land</title>";
print "<p align=left>\n";



#require "/tmapp/tmsrc/cgi-bin/tag.pl" ;
#require "/tmapp/tmsrc/cgi-bin/tag_small.pl" ;


print "";
print "<font face=verdana size=2 color=black><b>Nationalmannschaft Tipabgabe $land</b>\n";
print "<br><font face=verdana size=1 color=black>\n";
print "<br>Neben dem Ligabetrieb haben sich beim TipMaster international auf freiwilliger Basis Nationalmannschaften gegruendet<br>\n";
print "die nach dem TipMaster Modus gegeneinander Freundschaftsspiele austragen und nun auch eine Europameisterschaft veranstalten .<br>";
print "<br>Wenn du auch fuer Nationalmannschaft deines Landes tippen moechtest besuche die NM - Kaderverwaltung und wende dich an\n";
print "<br>den Teamchef oder den Praesidenten deines Landes. Falls fuer dein Land noch keine Nationalmannschaft existiert nimm<br>das Heft einfach selbst in die Hand und versuche mit den Trainerkollegen deiner Liga eine zu gruenden !\n";
print "<br><br>Aktuelle Infos zu den Nationalmannschaften findet hier auch im <a href=http://community.tipmaster.de target=new>Nationalmannschafts Forum</a>.<br><br>";
print "<form name=back action=/cgi-bin/tmi/nm_edit.pl method=post></form>\n";
print "<font face=verdana size=1>[ -> <a href=javascript:document.back.submit()>Nationalmannschafts Kaderverwaltung / Aufstellungen</a> ]<br>\n";
print "<br>[ -> <a href=http://www.bur.li/~tm-nm/>
Zu den Nationalmannschafts-Ligen</a> ]<br><br>";
print "[ -> <a href=/cgi-bin/tmi/tipabgabe_ls.pl?method=hps>Linksammlung der TMI Nationalmannschaften</a> ]
 &nbsp; <img src=/img/new.gif><br><br>";

if ( $trainer eq "Wally Dresel" ) { $einsicht = 1 }
if ( $einsicht == 1 ) {

print "<br>[ -> <a href=/cgi-bin/tmi/tipabgabe_ls.pl?method=show>Einsicht in die Nationalmannschafts Tipabgaben dieser Woche</a> ]<br><br>";
#print "<br>[ -> <a href=/cgi-bin/tmi/tipabgabe_ls.pl?method=show&ausnahme=1>Einsicht in die Nationalmannschafts Tipabgaben dieser Woche ( Sp.15+16)</a> ]<br><br>";

}

#print "<font face=verdana size=1 color=darkred><br>&nbsp;Vor der Tipabgabe nochmal kurz die letzten Resultate bzw. Tabellenposition der Vereine checken ?<br><font color=black>&nbsp;Unter <a href=http://www.live-resultate.net target=new11>http://www.live-resultate.net</a> gibts Ergebnisse , Tabellen und Statistiken sowie LiveScore zu den europ. und intern. Ligen !<br><br>\n";
#print "<font face=verdana size=1><br>\n";

print "<br><font face=verdana size=2 color=darkred><b>Achtung : Falls die Tipabgabe nicht klappt bitte die Tipabgabe<br>mit einer anderen Browsersoftware/version versuchen !</b><br>";
print "<br><form action=/cgi-bin/tmi/tipabgabe_ls.pl method=post><input type=hidden name=method value=save>";

$xx = "&";
$aa = $liga . $xx . $id ;

print "<input type=hidden name=team value=\"$aa\">\n";
print "<input type=hidden name=recipient value=\"$mail\">\n";
print "<table border=0 bgcolor=white cellpadding=0 cellspacing=0><tr>";
print "<td></td><td></td><td></td><td>\n";



print "<img src=/img/spacer11.gif></td><td></td><td>\n";
print "<img src=/img/spacer2.gif></td><td><img src=/img/spacer4.gif><td></td><td><img src=/img/spacer3.gif></td></td></tr><tr>\n";

for ($x=1 ; $x <=11 ; $x++ ){print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n"}
print "</tr>\n";
print "<tr><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
print "<td bgcolor=#eeeeee>&nbsp;</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

$rr = $spielrunde_ersatz+3 ;
if ( $rr > 34 ) { $rr = 34 }

print "<td bgcolor=#eeeeee align=middle><font face=verdana size=1>Tip</td>\n";
print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

print "<td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;</td><td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;Quoten</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td><td bgcolor=#eeeeee align=center><font face=verdana size=1>Gegner</td>\n";
print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr><tr>\n";
for ($x=1 ; $x <=11 ; $x++ ){print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n"}
print "</tr>\n";
print "<tr><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td><td bgcolor=#eeeeee>&nbsp;</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

print "<td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;2\n";
print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";



print "<td bgcolor=#eeeeee>&nbsp;</td><td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2\n";
print "</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td><td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr><tr>\n";
for ($x=1 ; $x <=11 ; $x++ ){print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n"}

print "</tr>\n";

$tf = 0;

for ($x=1 ; $x <=25 ; $x++ ){


$tf++;

$farbe = "white" ;
if ( $tf == 3 ) { $tf = 1 }
if ( $tf == 2 ) { $farbe= "#eeeeee" }
@selected = ();
$tipo[1] = "30....";
$tipo[2] = "31....";
$tipo[3] = "32....";
$tipo[4] = "33....";
$tipo[5] = "34....";
$tipo[6] = "35....";
$tipo[7] = "36....";
$tipo[8] = "37....";
$tipo[9] = "38....";
$tipo[10] = "39....";
$tipo[11] = "40....";
$tipo[12] = "41....";
$tipo[13] = "42....";
$tipo[14] = "43....";
$tipo[15] = "44....";
$tipo[16] = "45....";
$tipo[17] = "46....";
$tipo[18] = "47....";
$tipo[19] = "48....";
$tipo[20] = "49....";
$tipo[21] = "50....";
$tipo[22] = "51....";
$tipo[23] = "52....";
$tipo[24] = "53....";
$tipo[25] = "54....";


print "<tr><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
print "<td bgcolor=$farbe>&nbsp;<input type=radio name=\"$tipo[$x]\" value=0&0 checked>&nbsp;</td>\n";

print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
print "<td bgcolor=$farbe>&nbsp;<input type=radio name=\"$tipo[$x]\" value=1&1>\n";
print "<input type=radio name=\"$tipo[$x]\" value=1&2>\n";
print "<input type=radio name=\"$tipo[$x]\" value=1&3>&nbsp;</td>\n";

print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

$flag=$main_flags[$flagge[$x]];


if ( $flagge[$x] < 3 ){
print "<td align=left bgcolor=$farbe>&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=1><img src=/img/$flag HEIGHT=10 WIDTH=14 border=0>&nbsp;&nbsp;&nbsp;$paarung[$x]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";

}elsif  (( $flagge[$x] == 3 )or ( $flagge[$x] == 4 )or ( $flagge[$x] == 5 ) or ( $flagge[$x] == 8)  ){
print "<td align=left bgcolor=$farbe>&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=1><img src=/img/$flag HEIGHT=10 WIDTH=14 border=0>&nbsp;&nbsp;&nbsp;$paarung[$x]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";


}else{
print "<td align=left bgcolor=$farbe>&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=1><a href=$url target=new><img HEIGHT=10 WIDTH=14 src=/img/$flag border=0></a>&nbsp;&nbsp;&nbsp;$paarung[$x]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";
}

print "<td bgcolor=$farbe><font face=verdana size=1> $qu_1[$x] &nbsp;&nbsp; $qu_0[$x] &nbsp;&nbsp; $qu_2[$x] &nbsp;&nbsp;</td>\n";
print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
print "<td bgcolor=$farbe><font face=verdana size=1> &nbsp;&nbsp;";
print "<select style=\"font-family:verdana;font-size:10px;\" name=m$tipo[$x]><option value=\"Keine Auswahl\" selected>Gegner NM waehlen ...\n";

$kk="";@kk=();%kk=();
for ($goof=1;$goof<=$rr_ligen;$goof++){
($rr,$joke)=split(/ / , $liga_namen[$goof]);
if ( $kk{$rr} != 1 ) { 
$tx++;
$land[$tx] = $rr;
$kk{$rr} = 1;
if ( $rr eq "San" ) { $rr = "San Marino" }
if ( $rr eq "Nord" ) { $rr = "Nord Irland" }
if ( $rr eq "Faeroer" ) { $rr = "Faeroer Inseln" }
print "<option value=\"gegen $rr\">$rr\n";
}
}

print "<option value=\"gegen Deutschland\">Deutschland\n";
print "</select> &nbsp; </td>";
print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr>\n";
}

print "<tr>";

for ($yy=1 ; $yy <=11 ; $yy++ ){print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n"}

print "</tr></table>\n";
print "<font face=verdana size=1 color=black><br>Beim Click auf die Laenderflaggen werden die entsprechenden realen Ligatabellen geladen .<br>Nach dem Absenden des Formulars unbedingt auf die Antwortseite warten !<br><br>Die Tipabgabe ist jeweils bis Freitags 18.oo Uhr moeglich !\n";
if ( $tip_eingegangen == 1 ) { $ab = "Tipabgabe senden" }
if ( $tip_eingegangen == 0 ) { $ab = "Tipabgabe senden" }


print "<br><br>\n";
if ( $tip_status == 1 ) { 
#print "
#<select name=extra>
#<option value=1>Spieltag 13 + 14
#<option value=2>Spieltag 15 + 16

#</select>

print "
<input type=submit value=\"$ab\"></form></html>\n"}


if ( $tip_status == 2 ) { print "Der Tipabgabetermin ist bereits abgelaufen .<br>Es ist keine Abgabe bzw. Aenderung Ihres Tips mehr moeglich .</html>\n"}


for ($x=1 ; $x <=25 ; $x++ ){
($verein1,$verein2) = split (/ \- /,$paarung[$x]);
$verein1=~s/  //g;
$verein2=~s/  //g;
if ($flagge[$x] == 1) { $vv = "ger1" }
if ($flagge[$x] == 2) { $vv = "ger2" }
if ($flagge[$x] == 3) { $vv = "eng0" }
if ($flagge[$x] == 4) { $vv = "fre0" }
if ($flagge[$x] == 5) { $vv = "ita0" }
if ($flagge[$x] == 8) { $vv = "spa1" }

print "\n";
}


}




sub error { 
    # Localize variables and assign subroutine input.                        #
    local($error,@error_fields) = @_;
    local($host,$missing_field,$missing_field_list);

    if ($error eq 'bad_referer') {
        if ($ENV{'HTTP_REFERER'} =~ m|^https?://([\w\.]+)|i) {
            $host = $1;
            print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>Bad Referrer - Access Denied</title>
 </head>
 <body bgcolor=#FFFFFF text=#000000>
  <center>
   <table border=0 width=600 bgcolor=#9C9C9C>
    <tr><th><font size=+2>Bad Referrer - Access Denied</font></th></tr>
   </table>
   <table border=0 width=600 bgcolor=#CFCFCF>
    <tr><td>The form attempting to use
     <a href="http://www.worldwidemart.com/scripts/formmail.shtml">FormMail</a>
     resides at <tt>$ENV{'HTTP_REFERER'}</tt>, which is not allowed to access
     this cgi script.<p>

     If you are attempting to configure FormMail to run with this form, you need
     to add the following to \@referers, explained in detail in the README file.<p>

     Add <tt>'$host'</tt> to your <tt><b>\@referers</b></tt> array.<hr size=1>
     <center><font size=-1>
      <a href="http://www.worldwidemart.com/scripts/formmail.shtml">FormMail</a> V1.6 &copy; 1995 - 1997  Matt Wright<br>
      A Free Product of <a href="http://www.worldwidemart.com/scripts/">Matt's Script Archive, Inc.</a>
     </font></center>
    </td></tr>
   </table>
  </center>
 </body>
</html>
(END ERROR HTML)
        }
        else {
            print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>FormMail v1.6</title>
 </head>
 <body bgcolor=#FFFFFF text=#000000>
  <center>
   <table border=0 width=600 bgcolor=#9C9C9C>
    <tr><th><font size=+2>FormMail</font></th></tr>
   </table>
   <table border=0 width=600 bgcolor=#CFCFCF>
    <tr><th><tt><font size=+1>Copyright 1995 - 1997 Matt Wright<br>
        Version 1.6 - Released May 02, 1997<br>
        A Free Product of <a href="http://www.worldwidemart.com/scripts/">Matt's Script Archive,
        Inc.</a></font></tt></th></tr>
   </table>
  </center>
 </body>
</html>
(END ERROR HTML)
        }
    }

    elsif ($error eq 'request_method') {
            print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>Error: Request Method</title>
 </head>
 <body bgcolor=#FFFFFF text=#000000>
  <center>
   <table border=0 width=600 bgcolor=#9C9C9C>
    <tr><th><font size=+2>Error: Request Method</font></th></tr>
   </table>
   <table border=0 width=600 bgcolor=#CFCFCF>
    <tr><td>The Request Method of the Form you submitted did not match
     either <tt>GET</tt> or <tt>POST</tt>.  Please check the form and make sure the
     <tt>method=</tt> statement is in upper case and matches <tt>GET</tt> or <tt>POST</tt>.<p>

     <center><font size=-1>
      <a href="http://www.worldwidemart.com/scripts/formmail.shtml">FormMail</a> V1.6 &copy; 1995 - 1997  Matt Wright<br>
      A Free Product of <a href="http://www.worldwidemart.com/scripts/">Matt's Script Archive, Inc.</a>
     </font></center>
    </td></tr>
   </table>
  </center>
 </body>
</html>
(END ERROR HTML)
    }

    elsif ($error eq 'kein_verein') {
            print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>TMI - Tipabgabe : Kein Verein ausgewaehlt</title>
 </head>
 <body bgcolor=#eeeeee text=#000000>
<p align=left><body bgcolor=white text=black>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href=http://www.vierklee.at target=_top>
<img src=/banner/werben_tip.JPG border=0></a><br><br>
<br><br>
<table border=0>
<tr><td colspan=30></td><td p align=center>
<font face=verdana size=2><b>
<font color=red>
Bei ihrer Tipabgabe ist ein Fehler aufgetreten .<br><br><br>
<font color=black size=2>
+++ Sie haben keinen Verein ausgewaehlt +++<br><br><br>
</b></b></b><font color=black face=verdana size=1>Bitte kehren Sie zur Tipabgabe zurueck <br>
und waehlen Sie ihren aktuellen Verein , so<br>
dass Ihr Tip richtig zugewiesen werden kann .
</td></tr></table>

</center>
 </body>
</html>
(END ERROR HTML)
    }

    elsif ($error eq 'no_recipient') {
            print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>TMI - Tipabgabe : Keine E-Mail Adresse angegeben</title>
 </head>
 <body bgcolor=#eeeeee text=#000000>
<p align=left><body bgcolor=white text=black>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href=http://www.vierklee.at target=_top>
<img src=/banner/werben_tip.JPG border=0></a><br><br>
<br><br>
<table border=0>
<tr><td colspan=30></td><td p align=center>
<font face=verdana size=2><b>
<font color=red>
Bei ihrer Tipabgabe ist ein Fehler aufgetreten .<br><br><br>
<font color=black size=2>
+++ Sie haben keine E-Mail Adresse eingetragen +++<br><br><br>
</b></b></b><font color=black face=verdana size=1>Bitte kehren Sie zur Tipabgabe zurueck <br>
und tragen Sie ihre E-Mail Adresse ein<br>
so dass ihr Tip an Sie gemailt werden kann .
</td></tr></table>

</center>
 </body>
</html>
(END ERROR HTML)
    }
 elsif ($error eq 'kein_trainer') {
            print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>TMI - Tipabgabe : Kein Trainername angegeben</title>
 </head>
 <body bgcolor=#eeeeee text=#000000>
<p align=left><body bgcolor=white text=black>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href=http://www.vierklee.at target=_top>
<img src=/banner/werben_tip.JPG border=0></a><br><br>
<br><br>
<table border=0>
<tr><td colspan=30></td><td p align=center>
<font face=verdana size=2><b>
<font color=red>
Bei ihrer Tipabgabe ist ein Fehler aufgetreten .<br><br><br>
<font color=black size=2>
+++ Sie haben keinen Trainernamen eingetragen +++<br><br><br>
</b></b></b><font color=black face=verdana size=1>Bitte kehren Sie zur Tipabgabe zurueck <br>
und tragen Sie ihren Trainernamen ein<br>
so dass ihr Tip gewertet werden kann .
</td></tr></table>

</center>
 </body>
</html>
(END ERROR HTML)
    }
 

 elsif ($error eq 'kein_passwort') {
            print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>TMI - Tipabgabe : Kein Passwort angegeben</title>
 </head>
 <body bgcolor=#eeeeee text=#000000>
<p align=left><body bgcolor=white text=black>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href=http://www.vierklee.at target=_top>
<img src=/banner/werben_tip.JPG border=0></a><br><br>
<br><br>
<table border=0>
<tr><td colspan=30></td><td p align=center>
<font face=verdana size=2><b>
<font color=red>
Bei ihrer Tipabgabe ist ein Fehler aufgetreten .<br><br><br>
<font color=black size=2>
+++ Sie haben kein Passwort eingetragen +++<br><br><br>
</b></b></b><font color=black face=verdana size=1>Bitte kehren Sie zur Tipabgabe zurueck <br>
und tragen Sie ihren Trainernamen ein<br>
so dass ihr Tip gewertet werden kann .
</td></tr></table>

</center>
 </body>
</html>
(END ERROR HTML)
    }

 elsif ($error eq 'spielauswahl') {
            print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>TMI - Tipabgabe : Spielauswahl nicht korrekt</title>
 </head>
 <body bgcolor=#eeeeee text=#000000>
<p align=left><body bgcolor=white text=black>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br><br><p align=left>
<br><br>
<table border=0>
<tr><td p align=center>
<font face=verdana size=2><b>
<font color=red>
Bei ihrer Tipabgabe ist ein Fehler aufgetreten .<br><br><br>
<font color=black size=2>
+++ Ihre Spielauswahl ist nicht korrekt +++<br><br><br></b></b></b></b></b>
(END ERROR HTML)

if ( ( $hier_ort[1] eq "H" ) and ($aa != 5 ) ) { 
print "<font face=verdana size=1>";
$ss=$spielrunde_ersatz + 4;
print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Heimspiel gegen  $hier_gegner[1].<br>";
print "An diesem Spieltag sind Ihnen also 5 Tips anstatt denen von Ihnen gewaehlten $aa Tips gestattet<br><br>";
 }
if ( ( $hier_ort[1] eq "A" )and ($aa != 4 ) ) { 
print "<font face=verdana size=1>";
$ss=$spielrunde_ersatz + 4;
print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Auswaertsspiel gegen  $hier_gegner[1] .<br>";
print "An diesem Spieltag sind Ihnen also 4 Tips anstatt denen von Ihnen gewaehlten $aa Tips gestattet .<br><br>";
 }
if ( ( $hier_ort[2] eq "H" ) and ($ab != 5 ) ) { 
print "<font face=verdana size=1>";
$ss=$spielrunde_ersatz + 5;
print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Heimspiel gegen  $hier_gegner[2].<br>";
print "An diesem Spieltag sind Ihnen also 5 Tips anstatt denen von Ihnen gewaehlten $ab Tips gestattet .<br><br>";
 }
if ( ( $hier_ort[2] eq "A" ) and ($ab != 4 ) ) { 
print "<font face=verdana size=1>";
$ss=$spielrunde_ersatz + 5;
print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Auswaertsspiel gegen  $hier_gegner[2]<br>";
print "An diesem Spieltag sind Ihnen also 4 Tips anstatt denen von Ihnen gewaehlten $ab Tips gestattet .<br><br>";
 }
if ( ( $hier_ort[3] eq "H" ) and ($ac != 5 )) { 
print "<font face=verdana size=1>";
$ss=$spielrunde_ersatz + 6;
print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Heimspiel gegen  $hier_gegner[3]<br>";
print "An diesem Spieltag sind Ihnen also 5 Tips anstatt denen von Ihnen gewaehlten $ac Tips gestattet .<br><br>";
 }
if ( ( $hier_ort[3] eq "A" ) and ($ac != 4 ) ){ 
print "<font face=verdana size=1>";
$ss=$spielrunde_ersatz + 6;
print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Auswaertsspiel gegen  $hier_gegner[3].<br>";
print "An diesem Spieltag sind Ihnen also 4 Tips anstatt denen von Ihnen gewaehlten $ac Tips gestattet .<br><br>";
 }
if ( ( $hier_ort[4] eq "H" ) and ($ad != 5 ) ){ 
print "<font face=verdana size=1>";
$ss=$spielrunde_ersatz + 7;
print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Heimspiel gegen  $hier_gegner[4].<br>";
print "An diesem Spieltag sind Ihnen also 5 Tips anstatt denen von Ihnen gewaehlten $ad Tips gestattet .<br><br>";
 }
if ( ( $hier_ort[4] eq "A" ) and ($ad != 4 ) ){ 
print "<font face=verdana size=1>";
$ss=$spielrunde_ersatz + 7;
print "Am $ss .Spieltag bestreiten Sie mit dem $data[$verein] ein Auswaertsspiel gegen  $hier_gegner[4].<br>";
print "An diesem Spieltag sind Ihnen also 4 Tips anstatt denen von Ihnen gewaehlten $ad Tips gestattet .<br><br>";
 }




            print <<"(END ERROR HTML)";
</b></b></b><font color=black face=verdana size=1>Bitte kehren Sie zur Tipabgabe zurueck <br>
und korrigieren Sie Ihre Spielauswahl<br>
so dass ihr Tip gewertet werden kann .
</td></tr></table>

</center>
</body>
</html>
(END ERROR HTML)
    }


    
    exit;
}


