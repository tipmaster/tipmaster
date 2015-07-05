#!/usr/bin/perl

=head1 NAME
	TMI pokal_tip.pl

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
require "/tmapp/tmsrc/cgi-bin/runde.pl";
use CGI;
$query = new CGI;

$pokal = $query->param('pokal');







open(D2,"/tmdata/tmi/heer.txt");
while(<D2>) {
@go = split (/&/ , $_);
$liga{$go[5]} = $go[2] ;
$basis{$go[5]} = $go[2] ;
}
close (d2);










&daten_lesen;

# Return HTML Page or Redirect User
&return_html;





sub daten_lesen {

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



$teams[9999] = "Freilos" ;



$data[9999] = "Freilos" ;

open(D7,"/tmdata/tmi/pokal/tip_status.txt");
$tip_status = <D7> ;
chomp $tip_status;
close(D7);

if ( $tip_status == 4 ) {
print "1.Pokalrunde auf naechstes Wochenede verschoben wegen technischer Probleme ...";
exit;
}

open(D7,"/tmdata/tmi/pokal/pokal_datum.txt");
$spielrunde_ersatz = <D7> ;
chomp $spielrunde_ersatz;
close(D7);

$runde = $spielrunde_ersatz; 
$bx = "formular";
$by = $cup_tmi_tf[$cup_tmi];
$bv = ".txt";
$fg = "/tmdata/tmi/";
$datei_hiero = $fg . $bx . $by . $bv ;

print "<!-- Hiero is :$datei_hiero -->\n";
open(DO,$datei_hiero);
while(<DO>) {
@ver = <DO>;
}
close(DO);

$y = 0;
for ( $x = 0; $x < 10;$x++ )
{
$y++;
chomp $ver[$y];
@ela = split (/&/, $ver[$y]);	
$flagge[$y] = $ela[0] ;
$paarung[$y] = $ela[1];
$qu_1[$y] = $ela[2];
$qu_0[$y] = $ela[3];
$qu_2[$y] = $ela[4];
$ergebnis[$y] = $ela[5];
}


$url = "/tmdata/tmi/pokal/tips/" ;

if ( $id_verein<10 ) { $url = $url . '0' }
if ( $id_verein<100 ) { $url = $url . '0' }
if ( $id_verein<1000 ) { $url = $url . '0' }

$url=$url.$id_verein. '-' . $pokal . '-' . $runde . '.txt' ;




open(D2,"/tmdata/tmi/pokal/pokal_id.txt");


$rsuche = '&' . $trainer_id . '&' ;
while(<D2>) {
if ($_ =~ /$rsuche/) {
$pokal_dfb = 1 ;
}


}
close(D2);




if ( $runde == 1 ) {

$suche = '#' . $pokal . '-' . $runde . '&' ;

open(D2,"/tmdata/tmi/pokal/pokal.txt");
while(<D2>) {


if ($_ =~ /$suche/) {
@ega = split (/&/ , $_ ) ;
}


$rsuche = '&' . $trainer_id . '&' ;

if ($_ =~ /$rsuche/) {
( $pokal_id , $rest ) = split (/&/ , $_ ) ;
}


}
close(D2);

open(D2,"/tmdata/tmi/pokal/pokal_quote.txt");
while(<D2>) {


if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);

}


open(D2,"/tmdata/tmi/heer.txt");
while(<D2>) {
@egx = split (/&/ , $_ ) ;
$plazierung{"$egx[5]"} = $egx[0] ;
$liga{"$egx[5]"} = $egx[2] ;
}
close(D2);





if ( $runde > 1 ) {



$suche = '#' . $pokal . '-1&' ;

open(D2,"/tmdata/tmi/pokal/pokal.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@egb = split (/&/ , $_ ) ;
}
}
close(D2);



open(D2,"/tmdata/tmi/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote1 = split (/&/ , $_ ) ;
}
}
close(D2);

$c=0;
for ($a=1 ; $a<=32 ; $a = $a+2) {
$b=$a+1;
$c++;

if ( $quote1[$a] ==  $quote1[$b] ) { $egy[$c] = $egb[$b] }
if ( $quote1[$a] >  $quote1[$b] ) { $egy[$c] = $egb[$a] }
if ( $quote1[$a] <  $quote1[$b] ) { $egy[$c] = $egb[$b] }


if ( $egb[$b] == 9999 ) { $egy[$c] = $egb[$a] }

}








if ( $runde == 2 ) {

$suche = '#' . $pokal . '-2&' ;
open(D2,"/tmdata/tmi/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);
@ega = @egy ;
}





if ( $runde > 2 ) {

$suche = '#' . $pokal . '-2&' ;
open(D2,"/tmdata/tmi/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote2 = split (/&/ , $_ ) ;
}
}
close(D2);

$c=0;
for ($a=1 ; $a<=16 ; $a = $a+2) {
$b=$a+1;
$c++;

if ( $quote2[$a] ==  $quote2[$b] ) { $egx[$c] = $egy[$b] }
if ( $quote2[$a] >  $quote2[$b] ) { $egx[$c] = $egy[$a] }
if ( $quote2[$a] <  $quote2[$b] ) { $egx[$c] = $egy[$b] }

}



}






if ( $runde == 3 ) {

$suche = '#' . $pokal . '-3&' ;
open(D2,"/tmdata/tmi/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);
@ega = @egx ;
}





if ( $runde > 3 ) {

$suche = '#' . $pokal . '-3&' ;
open(D2,"/tmdata/tmi/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote3 = split (/&/ , $_ ) ;
}
}
close(D2);

$c=0;
for ($a=1 ; $a<=8 ; $a = $a+2) {
$b=$a+1;
$c++;

if ( $quote3[$a] ==  $quote3[$b] ) { $egw[$c] = $egx[$b] }
if ( $quote3[$a] >  $quote3[$b] ) { $egw[$c] = $egx[$a] }
if ( $quote3[$a] <  $quote3[$b] ) { $egw[$c] = $egx[$b] }
}





}






if ( $runde == 4 ) {

$suche = '#' . $pokal . '-4&' ;
open(D2,"/tmdata/tmi/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);
@ega = @egw ;
}




if ( $runde > 4 ) {

$suche = '#' . $pokal . '-4&' ;
open(D2,"/tmdata/tmi/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote4 = split (/&/ , $_ ) ;
}
}
close(D2);

$c=0;
for ($a=1 ; $a<=4 ; $a = $a+2) {
$b=$a+1;
$c++;

if ( $quote4[$a] ==  $quote4[$b] ) { $egv[$c] = $egw[$b] }
if ( $quote4[$a] >  $quote4[$b] ) { $egv[$c] = $egw[$a] }
if ( $quote4[$a] <  $quote4[$b] ) { $egv[$c] = $egw[$b] }
}



}




if ( $runde == 5 ) {

$suche = '#' . $pokal . '-5&' ;
open(D2,"/tmdata/tmi/pokal/pokal_quote.txt");
while(<D2>) {
if ($_ =~ /$suche/) {
@quote = split (/&/ , $_ ) ;
}
}
close(D2);
@ega = @egv ;
}







}











if ( $runde == 1 ) { $aa = 32 }
if ( $runde == 2 ) { $aa = 16 }
if ( $runde == 3 ) { $aa = 8 }
if ( $runde == 4 ) { $aa = 4 }
if ( $runde == 5 ) { $aa = 2 }


@pokal_runde = ( "leer" ,  "1.Hauptrunde" , "Achtelfinale" , "Viertelfinale" , "Halbfinale" , "Finale" ) ;








}



sub return_html {
  

        # Print HTTP header and opening HTML tags.                           #
       


print "<table border=0 cellpadding=0 cellspacing=0>";
print "<html><body bgcolor=white text=black link=blue vlink=blue><title>Tipabgabe $pokal_runde[$runde]</title>";
print "<p align=left><body bgcolor=white text=black link=darkred link=darkred>\n";

require "/tmapp/tmsrc/cgi-bin/tag.pl" ;
require "/tmapp/tmsrc/cgi-bin/tag_small.pl" ;

print "<font face=verdana size=1><br><table border=0 bgcolor=#eeeeee cellpadding=1>\n";


$gegner_if = 0 ;

$l = 0;
for ( $x=1 ; $x<=$aa ; $x++) {
$l++;
if ( $l == 3 ) { $l = 1 }
if ( $teams[$ega[$x]] eq $verein ) {
if ( $l == 1 ) { $gegner_if = $ega[$x+1] }
if ( $l == 2 ) { $gegner_if = $ega[$x-1] }
if ( $l == 1 ) { $ort = "Heimspiel" }
if ( $l == 2 ) { $ort = "Auswaertsspiel" }
}
}

if ($runde == 5 ) { $ort = "neutraler Platz" }

print "<tr><td align=left bgcolor=white>\n";
print "<br><font face=verdana size=2><b><font color=darkred>$pokal_runde[$runde]  &nbsp;&nbsp; ( $ort ) &nbsp;&nbsp; <font color=black>$verein  - $teams[$gegner_if]  </b></td></tr>\n";

print "</table>\n";


$tip_ein = 0;

if ( $tip_status == 3 ) {
print "<br><br><br>&nbsp;&nbsp;<font face=verdana size=2><b>In dieser Woche ist keine<br>&nbsp;&nbsp;TMI - Pokaltipabgabe notwendig .\n";
exit ;
}

if ( $gegner_if == 9999 ) {
$tip_ein = 1 ;
print "<br><br><br>&nbsp;&nbsp;<font face=verdana size=2><b>Sie haben in dieser Runde ein Freilos und<br>&nbsp;&nbsp;muessen daher keine Tipabgabe taetigen .\n";
exit ;
}


if ($gegner_if == 0 ) {
$tip_ein = 1 ;
print "<br><br><br>&nbsp;&nbsp;<font face=verdana size=2><b>Sie sind bereits ausgeschieden ...<br>&nbsp;&nbsp;Sie muessen daher keine Tipabgabe taetigen .\n";
exit ;
}





if ( $tip_ein == 0 ) {




if ( ($liga{$verein} == 1) and ($liga{$teams[$gegner_if]} == 1) and ( $ort eq "Heimspiel" ) ) { ( $tips = 5 ) and ( $tips_g = 4 ) }
if ( ($liga{$verein} == 1) and ($liga{$teams[$gegner_if]} == 1) and ( $ort eq "Auswaertsspiel" ) ) { ( $tips = 4 ) and ( $tips_g = 5 ) }
if ( ($liga{$verein} == 1) and ($liga{$teams[$gegner_if]} == 1) and ( $ort eq "neutraler Platz" ) ) { ( $tips = 5 ) and ( $tips_g = 5 ) }

if ( ($liga{$verein} == 2) and ($liga{$teams[$gegner_if]} == 2) and ( $ort eq "Heimspiel" ) ) { ( $tips = 5 ) and ( $tips_g = 4 ) }
if ( ($liga{$verein} == 2) and ($liga{$teams[$gegner_if]} == 2) and ( $ort eq "Auswaertsspiel" ) ) { ( $tips = 4 ) and ( $tips_g = 5 ) }
if ( ($liga{$verein} == 2) and ($liga{$teams[$gegner_if]} == 2) and ( $ort eq "neutraler Platz" ) ) { ( $tips = 5 ) and ( $tips_g = 5 ) }

if ( ($liga{$verein} > 2) and ($liga{$teams[$gegner_if]} > 2) and ( $ort eq "Heimspiel" ) ) { ( $tips = 5 ) and ( $tips_g = 4 ) }
if ( ($liga{$verein} > 2) and ($liga{$teams[$gegner_if]} > 2) and ( $ort eq "Auswaertsspiel" ) ) { ( $tips = 4 ) and ( $tips_g = 5 ) }
if ( ($liga{$verein} > 2) and ($liga{$teams[$gegner_if]} > 2) and ( $ort eq "neutraler Platz" ) ) { ( $tips = 5 ) and ( $tips_g = 5 ) }

if ( ($liga{$verein} == 1) and ($liga{$teams[$gegner_if]} > 2) and ( $ort eq "Heimspiel" ) ) { ( $tips = 5 ) and ( $tips_g = 3 ) }
if ( ($liga{$verein} == 1) and ($liga{$teams[$gegner_if]} > 2) and ( $ort eq "Auswaertsspiel" ) ) { ( $tips = 5 ) and ( $tips_g = 3 ) }
if ( ($liga{$verein} == 1) and ($liga{$teams[$gegner_if]} > 2) and ( $ort eq "neutraler Platz" ) ) { ( $tips = 5 ) and ( $tips_g = 3 ) }

if ( ($liga{$verein} > 2) and ($liga{$teams[$gegner_if]} == 1) and ( $ort eq "Heimspiel" ) ) { ( $tips = 3 ) and ( $tips_g = 5 ) }
if ( ($liga{$verein} > 2) and ($liga{$teams[$gegner_if]} == 1) and ( $ort eq "Auswaertsspiel" ) ) { ( $tips = 3 ) and ( $tips_g = 5 ) }
if ( ($liga{$verein} > 2) and ($liga{$teams[$gegner_if]} == 1) and ( $ort eq "neutraler Platz" ) ) { ( $tips = 3 ) and ( $tips_g = 5 ) }

if ( ($liga{$verein} == 1) and ($liga{$teams[$gegner_if]} == 2) and ( $ort eq "Heimspiel" ) ) { ( $tips = 5 ) and ( $tips_g = 3 ) }
if ( ($liga{$verein} == 1) and ($liga{$teams[$gegner_if]} == 2) and ( $ort eq "Auswaertsspiel" ) ) { ( $tips = 5 ) and ( $tips_g = 4 ) }
if ( ($liga{$verein} == 1) and ($liga{$teams[$gegner_if]} == 2) and ( $ort eq "neutraler Platz" ) ) { ( $tips = 5 ) and ( $tips_g = 4 ) }

if ( ($liga{$verein} == 2) and ($liga{$teams[$gegner_if]} == 1) and ( $ort eq "Heimspiel" ) ) { ( $tips = 4 ) and ( $tips_g = 5 ) }
if ( ($liga{$verein} == 2) and ($liga{$teams[$gegner_if]} == 1) and ( $ort eq "Auswaertsspiel" ) ) { ( $tips = 3 ) and ( $tips_g = 5 ) }
if ( ($liga{$verein} == 2) and ($liga{$teams[$gegner_if]} == 1) and ( $ort eq "neutraler Platz" ) ) { ( $tips = 4 ) and ( $tips_g = 5 ) }

if ( ($liga{$verein} == 2) and ($liga{$teams[$gegner_if]} > 2) and ( $ort eq "Heimspiel" ) ) { ( $tips = 5 ) and ( $tips_g = 3 ) }
if ( ($liga{$verein} == 2) and ($liga{$teams[$gegner_if]} > 2) and ( $ort eq "Auswaertsspiel" ) ) { ( $tips = 5 ) and ( $tips_g = 4 ) }
if ( ($liga{$verein} == 2) and ($liga{$teams[$gegner_if]} > 2) and ( $ort eq "neutraler Platz" ) ) { ( $tips = 5 ) and ( $tips_g = 4 ) }

if ( ($liga{$verein} >2 ) and ($liga{$teams[$gegner_if]} == 2) and ( $ort eq "Heimspiel" ) ) { ( $tips = 4 ) and ( $tips_g = 5 ) }
if ( ($liga{$verein} > 2 ) and ($liga{$teams[$gegner_if]} == 2) and ( $ort eq "Auswaertsspiel" ) ) { ( $tips = 3 ) and ( $tips_g = 5 ) }
if ( ($liga{$verein}> 2 ) and ($liga{$teams[$gegner_if]} == 2) and ( $ort eq "neutraler Platz" ) ) { ( $tips = 4 ) and ( $tips_g = 5 ) }

if ( ($liga{$verein} > 2 ) and ($liga{$teams[$gegner_if]} > 2) and ( $ort eq "Heimspiel" ) ) { ( $tips = 5 ) and ( $tips_g = 4 ) }
if ( ($liga{$verein} > 2 ) and ($liga{$teams[$gegner_if]} > 2) and ( $ort eq "Auswaertsspiel" ) ) { ( $tips = 4 ) and ( $tips_g = 5 ) }
if ( ($liga{$verein} > 2 ) and ($liga{$teams[$gegner_if]} > 2) and ( $ort eq "neutraler Platz" ) ) { ( $tips = 5 ) and ( $tips_g = 5 ) }

print "<font face=verdana size=1><br>&nbsp;&nbsp;Ihnen stehen $tips Tips zur Verfuegung . Ihrem Gegner stehen $tips_g Tips zur Verfuegung .\n";



print "<form action=/cgi-bin/tmi/pokal/pokal_sent.pl method=post>";
print "<input type=hidden name=trainer value=\"$trainer\">\n";
print "<input type=hidden name=pokal value=\"$pokal\">\n";
$xx = "&";
$aa = $liga . $xx . $id ;

print "<input type=hidden name=recipient value=\"$mail\">\n";
print "<input type=hidden name=url value=\"$url\">\n";
print "<input type=hidden name=tips value=\"$tips\">\n";

print "<table border=0 bgcolor=white cellpadding=0 cellspacing=0><tr>";
print "<td></td><td></td><td></td><td>\n";
print "<img src=/img/spacer11.gif></td><td></td><td>\n"; 

print "<img src=/img/spacer2.gif></td><td><img src=/img/spacer4.gif></td></tr><tr>\n";

for ($x=1 ; $x <=7 ; $x++ ){print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n"}
print "</tr>\n";
print "<tr><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
print "<td bgcolor=#eeeeee>&nbsp;</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

$rr = $spielrunde_ersatz+3 ;
if ( $rr > 34 ) { $rr = 34 }


print "<td bgcolor=#eeeeee align=middle><font face=verdana size=1>Pokal </td>\n";
print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

print "<td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;</td><td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;Quoten</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
print "</tr><tr>\n";
for ($x=1 ; $x <=7 ; $x++ ){print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n"}
print "</tr>\n";
print "<tr><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td><td bgcolor=#eeeeee>&nbsp;</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";


open (D2 , "$url" ) ;
while (<D2>) {
@tipos = split ( /\./ , $_ ) ;
}
close (D2) ;


print "<td bgcolor=#eeeeee align=center><font face=verdana size=1>1&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2\n";
print "</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td><td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;</td><td bgcolor=#eeeeee><font face=verdana size=1>&nbsp;</td><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td></tr><tr>\n";
for ($x=1 ; $x <=7 ; $x++ ){print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n"}

print "</tr>\n";

$tf = 0;

for ($x=1 ; $x <=10 ; $x++ ){


$tf++;

$farbe = "white" ;
if ( $tf == 3 ) { $tf = 1 }
if ( $tf == 2 ) { $farbe= "#eeeeee" }
@selected = ();
if ($tipos[$x-1] eq "0&0") { $selected[0] = " checked" }
if ($tipos[$x-1] eq "") { $selected[0] = " checked" }
if ($tipos[$x-1] eq "1&1") { $selected[1] = " checked" }
if ($tipos[$x-1] eq "1&2") { $selected[2] = " checked" }
if ($tipos[$x-1] eq "1&3") { $selected[3] = " checked" }


print "<tr><td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
print "<td bgcolor=$farbe>&nbsp;<input type=radio name=$tipo[$x] value=0&0$selected[0]>&nbsp;</td>\n";

print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";
print "<td bgcolor=$farbe>&nbsp;<input type=radio name=$tipo[$x] value=1&1$selected[1]>\n";
print "<input type=radio name=$tipo[$x] value=1&2$selected[2]>\n";
print "<input type=radio name=$tipo[$x] value=1&3$selected[3]>&nbsp;</td>\n";


print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

$flag = $main_flags[$flagge[$x]];



print "<td align=left bgcolor=$farbe>&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=1><img src=/img/$flag border=0 width=14 height=10>&nbsp;&nbsp;&nbsp;$paarung[$x]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\n";
print "<td bgcolor=$farbe><font face=verdana size=1> $qu_1[$x] &nbsp;&nbsp; $qu_0[$x] &nbsp;&nbsp; $qu_2[$x] &nbsp;&nbsp;</td>\n";
print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n";

}
print "<tr>";
for ($x=1 ; $x <=7 ; $x++ ){print "<td bgcolor=black><SPACER TYPE=BLOCK WIDTH=1 HEIGHT=1></td>\n"}

print "</tr></table>\n";
print "<font face=verdana size=1 color=black><br>Beim Click auf die Laenderflaggen werden die entsprechenden realen Ligatabellen geladen .<br>Nach dem Absenden des Formulars unbedingt auf die Antwortseite warten !<br><br>Die Tipabgabe ist jeweils bis Freitags 18.oo Uhr moeglich !\n";
if ( $tip_eingegangen == 1 ) { $ab = "Tipabgabe senden" }
if ( $tip_eingegangen == 0 ) { $ab = "Tipabgabe senden" }

print "<br><br>\n";
if ( $tip_status == 1 ) { print "<input type=submit value=\"$ab\"></form></html>\n"}
if ( $tip_status == 2 ) { print "Der Tipabgabetermin ist bereits abgelaufen .<br>Es ist keine Abgabe bzw. Aenderung Ihres Tips mehr moeglich .</html>\n"}


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
<a href=http://www.vierklee.at target=_top>
<img src=/banner/werben_tip.JPG border=0></a><br><br><p align=left>
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


