#!/usr/bin/perl

=head1 NAME
	TMI boerse.pl

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



#print "Content-type:text/html\n\nJob - Boerse ab Sonntag abend wieder offen ...";
#exit;

# Zum Einblenden von "Geschlossen..." auf 1 setzen
my $inactive = 0;



require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl";
require "/tmapp/tmsrc/cgi-bin/runde.pl";
$g=0;
open(D2,"/tmdata/tmi/history.txt");
while(<D2>) {
$g++;
$loos[$g]=$_;
if ($_ =~ /$trainer/) {
@vereine = split (/&/, $_);	
$gg=$g;
}

}

$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
$y++;
chomp $verein[$y];
$data[$x] = $vereine[$y];
$y++;
chomp $verein[$y];
$datb[$x] = $vereine[$y];

if ( $datb[$x] eq $trainer ) { 
$isa = $gg ;
$isb = $x;
$liga_id = $gg ;
}

$y++;
chomp $verein[$y];
$datc[$x] = $vereine[$y];
}








$frei = 0;
$gh = 0;
for ( $liga = 1 ; $liga <= $rr_ligen ; $liga++ ) {

$liga_aktuell = $liga ;

@vereine = split (/&/, $loos[$liga]);	

$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
$y++;
chomp $verein[$y];
$data[$x] = $vereine[$y];
$y++;
chomp $verein[$y];
$datb[$x] = $vereine[$y];
if ( $liga_kat[$liga] < 8 ) {
if ( $datb[$x] eq "Trainerposten frei" ) { 
$frei++;
$auswahl_verein[$frei] = $data[$x] ;
$auswahl_liga[$frei] = $liga ;
$auswahl_id[$frei] = $x ;
}
}




$y++;
chomp $verein[$y];
$datc[$x] = $vereine[$y];
}
}
print "Content-Type: text/html \n\n";

open(D2,"/tmdata/tmi/boerse.txt");
while(<D2>) {

for ( $e=1 ; $e<=$frei;$e++){

if ($_ =~ /$auswahl_verein[$e]/) { $anzahl[$e]++ }
}
}
close (D2);


open(D2,"/tmdata/tmi/boerse.txt");
while(<D2>) {
if ($_ =~ /$trainer/) {
for ($x=1;$x<=$frei;$x++) {
if ($_ =~ /$auswahl_verein[$x]/) { $selected[$x] = 1 }
}
}
}
close (D2);


open(D2,"/tmdata/tmi/boerse.txt");
while(<D2>) {

if ($_ =~ /$trainer/) {
@kol = split (/#/ , $_);
$zahl = $kol[1];
$t = 1;
for ($x=1;$x<=$zahl;$x++) {
$t++;
$leer = $kol[$t] ;

for ($xx=1;$xx<=$frei;$xx++) {
if ($leer eq $auswahl_verein[$xx]) { $fid = $xx }
}


$t++;
$prio[$fid] = $kol[$t];
}
}


}
close (D2);



print "<title>TipMaster Job - Boerse</title>\n";
print "<script language=JavaScript>\n";
print "<!--\n";
print "function targetLink(URL)\n";
print "  {\n";
print "    if(document.images)\n";
print "      targetWin = open(URL,\"Neufenstere\",\"scrollin=auto,toolbar=no,directories=no,menubar=no,status=no,resizeable=yes,width=850,height=380\");\n";
print " }\n";
print "  //-->\n";
print "  </script>\n";


print "<html><title>Job - Boerse</title><p align=left><body bgcolor=white text=black link=darkred link=darkred>\n";

require "/tmapp/tmsrc/cgi-bin/tag.pl" ;
require "/tmapp/tmsrc/cgi-bin/tag_small.pl" ;
print "<br>\n";
require "/tmapp/tmsrc/cgi-bin/loc_tmi.pl" ;

open (D,"</tmdata/tmi/boerse_aktiv.txt");
$aktiv=<D>;chomp $aktiv;
close (D);

if ( $aktiv == 1 ) {
print "<br>";
print "<table border=0  cellpadding=0 cellspacing=0 bgcolor=black>\n";
print "<tr><td>\n";
print "<table border=0 cellpadding=10 cellspacing=1>\n";
print "<tr bgcolor=#eeeeff><td align=center><font face=verdana size=1>TipMaster international Job Boerse<br></td></tr>";
print "<tr bgcolor=#eeeeee><td align=center><font face=verdana size=2><br><br><b>
&nbsp; &nbsp; &nbsp; Im Moment laeuft die Auswertung der Jobvergaberunde &nbsp; &nbsp; &nbsp; <br>
und die freien Posten werden entsprechend den<br>
Bewerbungsrankings an die Trainer vergeben .<br><br>
In wenigen Minuten sind Bewerbungen fuer die<br>
neuen freien Vereinsposten wieder moeglich .<br><br>
</table></td></tr></table>";
exit;

}




open(D2,"/tmdata/tmi/heer.txt");
while(<D2>) {
@all = split (/&/ , $_);
$platz{$all[5]}=$all[0];

}
close (D2);




print "<form action=/cgi-bin/tmi/boerse_mail.pl method=post>\n";


print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black>\n";
print "<tr><td>\n";
print "<table border=0 cellpadding=2 cellspacing=1>\n";
print "<tr><td colspan=7 align=center bgcolor=#f6f4f4><font size=2>&nbsp; <font face=verdana size=1>TipMaster international Job - Boerse [ freie Kat 1 bis Kat  5 Vereine ]<br></td></tr>\n"; 

if ($inactive) {
print "<tr><td colspan=7 align=center><font face=verdana size=2 color=red>Wegen ei
ner Fehlfunktion ist die Jobb&ouml;rse diese Woche leider ausser Betrieb. <br>Die
ausgeschriebenen Vereine werden n&auml;chste Woche vergeben!</font></td></tr>\n";
}

if ( $frei > 0 ) {
for ( $x = 1; $x <= $frei; $x++ )
{
#liga-kat pruefung notwenidig, weil listOnBoerse nicht gleich neu laedt.
if ( &listOnBoerse($auswahl_liga[$x]) && $liga_kat[$auswahl_liga[$x]] < 6 ) {

$tt = "";
if ($selected[$x] == 1) { $tt = " checked"}

print "<tr>";

if ( $login == 0 ) {

print "<td align=left bgcolor=#cbccff><font face=verdana size=1>&nbsp;<input type=checkbox name=\"$auswahl_verein[$x]\" value=yes$tt>&nbsp;</td>\n";
}


print "<td align=left bgcolor=#eeeeff><font face=verdana size=1>&nbsp; &nbsp;$auswahl_verein[$x]&nbsp;&nbsp;&nbsp;&nbsp; </td> \n";


( my $a1,my $a2)=split(/ /,$liga_kuerzel[$auswahl_liga[$x]]);
$a1 = lc($a1);
$a1 = "/img/flags/" . $a1 . ".jpg";
print "<td align=right bgcolor=#cbccff><font face=verdana size=1> &nbsp;  $liga_kuerzel[$auswahl_liga[$x]] [ KAT $liga_kat[$auswahl_liga[$x]] ] &nbsp; <img src=$a1> &nbsp; </td>\n";

print "<td align=right bgcolor=#cbccff><font face=verdana size=1>&nbsp;&nbsp;$platz{$auswahl_verein[$x]} .Platz&nbsp;&nbsp;</td>\n";

$anzahl[$x] = $anzahl[$x] * 1;
print "<td align=right bgcolor=#eeeeff><font face=verdana size=1>&nbsp;&nbsp; $anzahl[$x] Bew. &nbsp;</td>";

if ( $login == 0 ) {


@mo=();
$ein = 0;

if ( $prio[$x] == 1 ) { ($ein=1) and ($mo[1]=" checked") }
if ( $prio[$x] == 2 ) { ($ein=1) and ($mo[2]=" checked") }
if ( $prio[$x] == 3 ) { ($ein=1) and ($mo[3]=" checked") }
if ( $prio[$x] == 4 ) { ($ein=1) and ($mo[4]=" checked") }
if ( $prio[$x] == 5 ) { ($ein=1) and ($mo[5]=" checked") }
if ( $ein == 0 ) { ($mo[3]=" checked") }



print "<td align=center bgcolor=#eeeeff> &nbsp;<input type=radio name=\"$auswahl_verein[$x]_id\" value=1$mo[1]>\n";
print "<input type=radio name=\"$auswahl_verein[$x]_id\" value=2$mo[2]>\n";
print "<input type=radio name=\"$auswahl_verein[$x]_id\" value=3$mo[3]>\n";
print "<input type=radio name=\"$auswahl_verein[$x]_id\" value=4$mo[4]>\n";
print "<input type=radio name=\"$auswahl_verein[$x]_id\" value=5$mo[5]> &nbsp;</td>\n";
}


print "<td align=center bgcolor=#cbccff> &nbsp;&nbsp;<a href=/cgi-bin/tmi/boerse_rank.pl?li=$auswahl_liga[$x]&ve=$auswahl_id[$x]&isa=$isa&isb=$isb target\"_blank\" onClick=\"targetLink('/cgi-bin/tmi/boerse_rank.pl?li=$auswahl_liga[$x]&ve=$auswahl_id[$x]&isa=$isa&isb=$isb');return false\"><img src=/img/job.gif border=0></a>&nbsp;&nbsp;</td>\n";


}

print "</tr>\n";
}
}
print "</table>\n";
print "</td></tr></table>\n";

print "<font face=verdana size=1><br>\n";
print "-> &nbsp; <a href=javascript:document.wechsel.submit()>Bisherige Vereinswechsel / Vereinstaeusche dieser Saison</a><br><br>
<br>";


if ( $login == 0 ) {

print "<font size=1 face=verdana>Mit dem Markieren der Radiobuttons ( Kreise ) k&ouml;nnen Sie von<br>links nach rechts die Priorit&auml;t Ihrer Bewerbung steigern.<br><br>Die Vergabe der Trainerposten nach den pers&ouml;nlichen<br>Priorit&auml;ten kann jedoch nicht garantiert werden .

<br><br><font color=darkred>
Sie wollen Berwerbungen wieder ruckg&auml;ngig machen ? Versenden<br>
Sie einfach das Formular ohne markierte
Checkboxes und alle<br>Ihre Bewerbungen werden storniert.<br><br>

<font color=red>Woechentliche Vergaberunde : <font color=black>Immer Dienstags 12.oo Uhr und Donnerstags 16.oo Uhr<br>
[ keine Vergaberunde zu Saisonbeginn: Do. bevor Sp.1 bis 4 und am Saisonende: Di nach Sp.33 bis 34  ]<br><br>\n";

if ( $boerse_open ==1 ) {
print "&nbsp;<input type=submit value=\"Bewerbungen abschicken\">";
}
if ( $boerse_open ==0 ) {
print "&nbsp;<br>&nbsp;<font face=verdana size=2 color=darkred>Die Job - Boerse ist derzeit geschlossen !";
}

}


print "</form>";



print "<br><form name=wechsel method=post action=/cgi-bin/tmi/boerse_wechsel.pl target=_top><input type=hidden name=loss value=\"$ligo\"></form>\n";



