#!/usr/bin/perl

=head1 NAME
	BTM werben_mail.pl

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
$query = new CGI;
$mail_adresse = $query->param('mail');
$name = $query->param('name');


$mailprog = '/usr/sbin/sendmail';


    open(MAIL,"|$mailprog -t");

    print MAIL "To: $mail_adresse\n";
    print MAIL "From: service\@tipmaster.net ( TipMaster online )\n";
#    print MAIL "BCC: service\@tipmaster.de\n";
    print MAIL "Subject: TipMaster online\n\n" ;

    print MAIL "*** TipMaster online ***        http://www.tipmaster.net \n\n";

    print MAIL "Guten Tag $name , \n\n";
    print MAIL "Ihr/e Bekannte/r $trainer moechte Sie mit dieser Mail \n";
    print MAIL "fuer eine Teilnahme am kostenlosen Fussball - Tippspiel\n";
    print MAIL "TipMaster online gewinnen . Er/Sie ist selbst ein begeisteter\n";
    print MAIL "Trainer und wuerde sich freuen wenn Sie Ihr Fussballwissen\n";
    print MAIL "demnaechst mit Ihm/Ihr beim TipMaster gemeinsam messen wuerden . \n\n";
    print MAIL "Besuchen Sie einfach unsere Homepage http://www.tipmaster.net \n";
    print MAIL "und informieren Sie sich ueber unser einzigartiges Spielprinzip\n";
    print MAIL "dass Spass und vor allem Spannung garantiert !\n\n";
    print MAIL "Wir wuerden uns freuen Sie demnaechst als Mitspieler begruessen zu duerfen !\n\n";
    print MAIL "Mit sportlichem Gruss\nIhr TipMaster - Team\n";
close (MAIL) ;

print "Content-type: text/html\n\n";
print "<body bgcolor=#eeeeee text=black><font face=verdana size=1>";
print "Bundesliga - TipMaster<br><br>Ihre E-Mail wurde verschickt ...<br>Sie werden weitergeleitet ...";
print "<form name=Testform action=/cgi-mod/btm/login.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=pass value=\"$pass\"></form>";

print "<script language=JavaScript>\n";
print"   function AbGehts()\n";
print"   {\n";
print"    document.Testform.submit();\n";
print"    }\n";
print"   window.setTimeout(\"AbGehts()\",100);\n";
print"  </script>\n";
