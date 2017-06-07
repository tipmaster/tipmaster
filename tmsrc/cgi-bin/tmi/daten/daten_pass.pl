#!/usr/bin/perl

=head1 NAME
	TMI daten_pass.pl

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

$query = new CGI;
$mail = $query->param('mail');
$pass1 = $query->param('pass1');
$pass2 = $query->param('pass2');


#@needs work
if ( $pass ne $pass1 ) {
print "Content-type: text/html\n\n";
print "<body bgcolor=#eeeeee text=black><font face=verdana size=1>";
print "TipMaster international<br><br>Ihr altes Passwort ist falsch ...";
exit ;
}

if($pass2 =~ /[^a-zA-Z_0-9]/)  { 
print "Content-type: text/html\n\n";
print "<body bgcolor=#eeeeee text=black><font face=verdana size=1>";
print "TipMaster international<br><br>Ihr neues Passwort ist ungueltig .<br>Bitte verzichten Sie auf Umlaute , Sonderzeichen und Leerstellen in ihrem Passwort ...";
exit ;
}

$aa = length($pass2);
if($aa < 6 )  { 
print "Content-type: text/html\n\n";
print "<body bgcolor=#eeeeee text=black><font face=verdana size=1>";
print "TipMaster international<br><br>Ihr neues Passwort ist zu kurz.<br>Ihr Passwort muss mind. 6 Zeichen lang sein ...";
exit ;
}

$aa = "&" ;
$ae = "!" ;
$suche = $ae . $aa . $trainer . $aa ;

$r = 0;
open(D2,"/tmdata/pass.txt");
while(<D2>) {
$r++;
$zeilen[$r] = $_ ;
chomp $zeilen[$r] ;


if ($_ =~ /$suche/i) {
($leer , $leut , $richtig , $ex) = split (/&/, $_);	
$linie = $r;
}
}
close(D2);

$zeilen[$linie] = $ae . $aa . $trainer . $aa . $pass2 . $aa . $ex . $aa ;

open(D9,">/tmdata/pass.txt");
flock (D9 , 2);
for ($x =1 ; $x <= $r ; $x++ ) {
print D9 "$zeilen[$x]\n";
}
flock (D9 , 8);
close (D9);



print "Content-type: text/html\n\n";
print "<body bgcolor=#eeeeee text=black><font face=verdana size=1>";
print "TipMaster international<br><br>Ihre Passwort wurde in $pass2 geaendert ...";
print "<br>Sie werden weitergeleitet ...";
print "<form name=Testform action=/cgi-mod/tmi/login.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=password value=\"$pass\"></form>";
print "<script language=JavaScript>\n";
print"   function AbGehts()\n";
print"   {\n";
print"    document.Testform.submit();\n";
print"    }\n";
print"   window.setTimeout(\"AbGehts()\",100);\n";
print"  </script>\n";


exit ;
