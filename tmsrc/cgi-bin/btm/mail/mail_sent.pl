#!/usr/bin/perl

=head1 NAME
	BTM mail_sent.pl

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
my $session = TMSession::getSession(btm_login => 1);
my $trainer = $session->getUser();
my $leut = $trainer;

use CGI;

require "/tmapp/tmsrc/cgi-bin/btm/mail/MLib.pl";
use DBI;


#&openDB;
#&closeDB;


$query = new CGI;
$text = $query->param('text');
$subject = $query->param('subject');
$auswahl_person = $query->param('auswahl_person');
$auswahl_liga = $query->param('auswahl_liga');
$auswahl_adress = $query->param('auswahl_adress');
$link = $query->param('link');
$message = $query->param('message');

print "Content-type: text/html\n\n";


if ( $auswahl_liga=~ /Liga/ ) {
$auswahl_liga=~s/Liga_//;
$message = "liga";
}

if ( $auswahl_liga eq "none" ) {
print "Sie haben keinen Empfaenger der Message angegeben<br><br>.";
exit;
}

$aa = length($subject);
$ab = length($text);
if ( ($aa < 3 ) or ($subject eq "" ) )  { 
print "<body bgcolor=#eeeeee text=black><font face=verdana size=1 color=Red>";
print "Ihr Betreff ist entweder zu kurz oder Sie haben keinen angegeben . Ihre Message konnte nicht gesendet werden .<br><br>Sie werden weitergeleitet ...";
print "<form name=Testform action=/cgi-bin/btm/mail/mailbox.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=pass value=\"$pass\"></form>";
print "<script language=JavaScript>\n";
print"   function AbGehts()\n";
print"   {\n";
print"    document.Testform.submit();\n";
print"    }\n";
print"   window.setTimeout(\"AbGehts()\",10000);\n";
print"  </script>\n";

exit ;
}

if ( ($ab > 750 ) )  { 
print "<body bgcolor=#eeeeee text=black><font face=verdana size=1 color=Red>";
print "Der Text Ihrer Message ist leider zu lang. Ihre Message konnte nicht gesendet werden .<br>Aufgrund unserer Kapazitaten und Erfahrung aus der Vergangenheit<br>darf der Text maximal 750 Zeichen enthalten ( ihre Nachricht enthielt $ab Zeichen ).<br><br>Bitte kehren Sie ueber Ihren Browser zurueck und kuerzen Sie Ihre Message ...";

exit ;
}

if ($subject =~ /[\<\>]/) {

print "<body bgcolor=#eeeeee text=black><font face=verdana size=1 color=Red>";
print "Ihr Betreff hat ungueltige Zeichen enthalten . Ihre Message konnte nicht gesendet werden .<br>Bitte verzichten Sie auf Umlaute und weitere Sonderzeichen ...<br><br>Sie werden weitergeleitet ...";
print "<form name=Testform action=/cgi-bin/btm/mail/mailbox.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=pass value=\"$pass\"></form>";
print "<script language=JavaScript>\n";
print"   function AbGehts()\n";
print"   {\n";
print"    document.Testform.submit();\n";
print"    }\n";
print"   window.setTimeout(\"AbGehts()\",10000);\n";
print"  </script>\n";

exit ;
}

if ($text =~ /[\<\>]/) {

print "<body bgcolor=#eeeeee text=black><font face=verdana size=1 color=red>";
print "Ihr Message Text hat ungueltige Zeichen enthalten . Ihre Message konnte nicht gesendet werden .<br>Bitte verzichten Sie auf Umlaute und weitere Sonderzeichen ...<br><br>Sie werden weitergeleitet ...";
print "<form name=Testform action=/cgi-bin/btm/mail/mailbox.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=pass value=\"$pass\"></form>";
print "<script language=JavaScript>\n";
print"   function AbGehts()\n";
print"   {\n";
print"    document.Testform.submit();\n";
print"    }\n";
print"   window.setTimeout(\"AbGehts()\",10000);\n";
print"  </script>\n";

exit ;
}




($sek, $min, $std, $tag, $mon, $jahr , $wo) =  localtime(time+0);

if ($wo == 0 ) { $wt = "So." }
if ($wo == 1 ) { $wt = "Mo." }
if ($wo == 2 ) { $wt = "Di." }
if ($wo == 3 ) { $wt = "Mi." }
if ($wo == 4 ) { $wt = "Do." }
if ($wo == 5 ) { $wt = "Fr." }
if ($wo == 6 ) { $wt = "Sa." }



$mon++ ;
if ( $sek <10 ) { $xa = "0" }
if ( $min <10 ) { $xb = "0" }
if ( $std <10 ) { $xc = "0" }
if ( $tag <10 ) { $xd = "0" }
if ( $mon <10 ) { $xe = "0" }
if ( $liga <10 ) { $xf = "0" }
if ( $spielrunde <10 ) { $xg = "0" }
$jahr = $jahr + 1900 ;


$ros = '&' . $trainer . '&' ;
$li=0;
open(D2,"/tmdata/btm/history.txt");
while(<D2>) {
$li++;
if ($_ =~ /$ros/i) {
$liga = $li ;
$servus = $li ;
}

}
close (D2) ;

if ( $message eq "liga" ) {

$rr = 0;
$li=0;

$xx = "";
if ($liga<10) { $xx = "0" }
$suche = 'x' . $xx . $liga . '&' ;
open(D2,"/tmdata/btm/history.txt");
while(<D2>) {
if ($_ =~ /$suche/i) {
@vereine = split (/&/, $_);	
}
}
close (D2);


$rr=0;
$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
$y++;

chomp $verein[$y];
$data[$x] = $vereine[$y];
$y++;
chomp $verein[$y];
$datb[$x] = $vereine[$y];
if ($datb[$x] eq $trainer ) { $liga = $li }
if ( ($datb[$x] ne "Trainerposten frei" ) and ($datb[$x] ne $trainer ) ) {
$rr++;

$auswahl_trainer[$rr] = $datb[$x] ;
}
$y++;
chomp $verein[$y];
$datc[$x] = $vereine[$y];
}

}
close(D2);




if ( $message eq "personal" ) {
$rr = 1;
$auswahl_trainer[1] = $auswahl_adress ;
}

if ( $message eq "konkurrenz" ) {
$rr = 1;
$auswahl_trainer[1] = $auswahl_liga ;
}



$versuche = 0;
herel:
$datei = '/tmdata/btm/mail/nummer_db.txt' ;
open (D1 , "$datei") ;
$zahl_db = <D1> ;
close (D1);
$versuche++;
if (( $zahl_db < 10 ) and ( $versuche <20)) { goto herel; }
if ($versuche>18) {
print "Kein Zugriff auf Message Nummer moeglich ...";
exit;}
open (D1 , ">$datei") ;
flock(D1,2);
$zahl_db++;
print D1 "$zahl_db";
$zahl_db--;
flock(D1,8);
close (D1);





if ( $message eq "liga" ) { $oo = 1 }
if ( $message eq "personal" ) { $oo = 2 }
if ( $message eq "konkurrenz" ) { $oo = 2 }


if ( $text eq "" ) {

print "Aktion abgebrochen ! Textstring ist leer !";
exit ; }


if ( $message eq "liga" ) { $xx = "$liga_namen[$servus]" }
if ( $message eq "personal" ) { $xx = "$auswahl_trainer[1]" }
if ( $message eq "konkurrenz" ) { $xx = "$auswahl_trainer[1]" }
$absender=$xx;
&openDB(mbox);

#Nachricht in DB schreiben	
$er=0;
$text_db=$text;
$text_db=~s/\n/<br>/g;
$text_db=~s/'/`/g; # FIXME: Das sieht erstmal sicher aus, ist aber nicht unüberwindlich. Besser mit placeholders arbeiten.
$subject=~s/'/`/g;

      $sql = "INSERT INTO box VALUES ($zahl_db,'BTM','$trainer','$xx','$subject','$text_db','$wt $xd$tag.$xe$mon.$jahr','$xc$std:$xb$min:$xa$sek',$oo)";
      $sth = $dbh->prepare($sql);
      $sth->execute() || ( $er=1 );

if ( $er == 1 ) {
print "Versenden der Nachricht nicht moeglich : $DBI::errstr<br>$sql";
open (D1,">>/home/tipmaster/mysql_error.txt");
print D1 "$DBI::errstr | $sql\n";
close(D1);
exit  ;
}
$sth->finish();

#PRUEFEN OB DB-Eintraege existieren
if ( $message ne "liga" ) {
&getValue($trainer,trainer,trainer);
if ( $query eq "" ) {
      $sql = "INSERT INTO trainer VALUES ('$trainer','','','','','','')";
      $sth = $dbh->prepare($sql);
      $sth->execute();
      $sth->finish();
}
&getValue($xx,trainer,trainer);
if ( $query eq "" ) {
      $sql = "INSERT INTO trainer VALUES ('$xx','','','','','','')";
      $sth = $dbh->prepare($sql);
      $sth->execute();
      $sth->finish();
}

}

#Outbox fuellen
&getValue($trainer,btm_outbox,trainer);

$query = $query . $zahl_db .  '#' ;
      $sql = "UPDATE trainer SET btm_outbox='$query' WHERE trainer='$trainer'";
      $sth = $dbh->prepare($sql);
      $sth->execute();
      $sth->finish();
#Inbox fuellen


if ( $oo == 2 ) {
&getValue($xx,btm_inbox,trainer);
$query = $query . $zahl_db . '&1#' ;
      $sql = "UPDATE trainer SET btm_inbox='$query' WHERE trainer='$xx'";
      $sth = $dbh->prepare($sql);
      $sth->execute();
      $sth->finish();
$datei="/tmdata/btm/newmail/".$xx;
open(D,">$datei");
close(D);

}
if ( $oo == 1 ) {
for ($y=1 ; $y<=$rr ; $y++) {
$xx = $auswahl_trainer[$y] ;
&getValue($xx,btm_inbox,trainer);
$query = $query . $zahl_db . '&1#' ;
      $sql = "UPDATE trainer SET btm_inbox='$query' WHERE trainer='$xx'";
      $sth = $dbh->prepare($sql);
      $sth->execute();
      $sth->finish();
$datei="/tmdata/btm/newmail/".$xx;
open(D,">$datei");
close(D);

}
}


&closeDB;







print "<html><body bgcolor=white text=black>\n";
print "<font face=verdana size=1> Ihre Nachricht wird verschickt . Sie werden weitergeleitet ...\n";

if ( $link eq "friend" ) {
print "<form name=Testform action=/cgi-bin/btm/friendly.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=pass value=\"$pass\"></form>";

} else {
print "<form name=Testform action=/cgi-bin/btm/mail/mailbox.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=pass value=\"$pass\"></form>";
}
print "<script language=JavaScript>\n";
print"   function AbGehts()\n";
print"   {\n";
print"    document.Testform.submit();\n";
print"    }\n";
print"   window.setTimeout(\"AbGehts()\",100);\n";
print"  </script>\n";
exit ;

