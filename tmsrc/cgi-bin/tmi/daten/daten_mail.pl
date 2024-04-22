#!/usr/bin/perl

=head1 NAME
	TMI daten_mail.pl

=head1 SYNOPSIS
	TBD
	


=head1 CHANGELOG
	2015-06-09 Thomas: Added Session Management


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

$ban=0;
open (D1,"/tmdata/banmail.txt");
while(<D1>){
$rr=$_;
chomp $rr;
if ( $mail =~ /$rr/ ) { 
$ban=1;$ban_id=$rr ;}}
close(D1);
if ( $ban == 1 ){
print "Content-type:text/html\n\n<font face=verdana size=1>";
print "Registrierungen mit einer E-Mail Adresse der Domain $ban_id koennen wir nicht akzeptieren ...";
exit;
}


if ( $mail !~ /^.+\@(\[?)[a-zA-Z0-9\-\.]+\.([a-zA-Z]{2,3}|[0-9]{1,3})(\]?)$/) {
print "Content-type: text/html\n\n";
print "<body bgcolor=#eeeeee text=black><font face=verdana size=1>";
print "TipMaster international<br><br>Sie haben keine geultige E-Mail Adresse angegeben ...";
exit ;
}

$aa = "&" ;
$ae = "!" ;
$suche = $ae . $aa . $trainer . $aa ;

#@todo needs update
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

$zeilen[$linie] = $ae . $aa . $trainer . $aa . $pass . $aa . $mail . $aa ;

#@todo needs update
open(D9,">/tmdata/pass.txt");
flock (D9 , 2);
for ($x =1 ; $x <= $r ; $x++ ) {
print D9 "$zeilen[$x]\n";
}
flock (D9 , 8);
close (D9);



print "Content-type: text/html\n\n";
print "<body bgcolor=#eeeeee text=black><font face=verdana size=1>";
print "TipMaster international<br><br>Ihre E-Mail Adresse wurde in $mail geandert ...<br>Sie werden weitergeleitet ...";
print "<form name=Testform action=/cgi-mod/tmi/login.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=password value=\"$pass\"></form>";
print "<script language=JavaScript>\n";
print"   function AbGehts()\n";
print"   {\n";
print"    document.Testform.submit();\n";
print"    }\n";
print"   window.setTimeout(\"AbGehts()\",100);\n";
print"  </script>\n";


exit ;