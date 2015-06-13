#!/usr/bin/perl

=head1 NAME
	BTM pass_sent.pl

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

#script needs to be redone

use lib '/tmapp/tmsrc/cgi-bin/'; 
use TMSession;
my $session = TMSession::getSession(btm_login => 1);
my $trainer = $session->getUser();
my $leut = $trainer;

use CGI;                                            

$mailprog = '/usr/sbin/sendmail';


@liga_namen = ( "spacer" , "1.Bundesliga" , "2.Bundesliga" ,"Regionalliga A" ,"Regionalliga B" ,"Oberliga A" ,"Oberliga B" ,"Oberliga C" ,"Oberliga D" ,
"Verbandsliga A" ,"Verbandsliga B" ,"Verbandsliga C" ,"Verbandsliga D" ,"Verbandsliga E" ,"Verbandsliga F" ,"Verbandsliga G" ,"Verbandsliga H" ,
"Landesliga A" ,"Landesliga B" ,"Landesliga C" ,"Landesliga D" ,"Landesliga E" ,"Landesliga F" ,"Landesliga G" ,"Landesliga H" ,
"Landesliga I" ,"Landesliga K" ,"Landesliga L" ,"Landesliga M" ,"Landesliga N" ,"Landesliga O" ,"Landesliga P" ,"Landesliga R" ,
"Bezirksliga A" ,"Bezirksliga B" ,"Bezirksliga C" ,"Bezirksliga D" ,"Bezirksliga E" ,"Bezirksliga F" ,"Bezirksliga G" ,"Bezirksliga H" ,
"Bezirksliga I" ,"Bezirksliga K" ,"Bezirksliga L" ,"Bezirksliga M" ,"Bezirksliga N" ,"Bezirksliga O" ,"Bezirksliga P" ,"Bezirksliga R" ) ;







# Retrieve Date
&get_date;

# Parse Form Contents
&parse_form;



# Return HTML Page or Redirect User
&return_html;




sub get_date {

    # Define arrays for the day of the week and month of the year.           #
    @days   = ('Sunday','Monday','Tuesday','Wednesday',
               'Thursday','Friday','Saturday');
    @months = ('January','February','March','April','May','June','July',
	         'August','September','October','November','December');

    # Get the current time and format the hour, minutes and seconds.  Add    #
    # 1900 to the year to get the full 4 digit year.                         #
    ($sec,$min,$hour,$mday,$mon,$year,$wday) = (localtime(time+0))[0,1,2,3,4,5,6];
    $time = sprintf("%02d:%02d:%02d",$hour,$min,$sec);
    $year += 1900;

    # Format the date.                                                       #
    $date = "$days[$wday], $months[$mon] $mday, $year at $time";

}



sub parse_form {

    # Define the configuration associative array.                            #
 

    # Determine the form's REQUEST_METHOD (GET or POST) and split the form   #
    # fields up into their name-value pairs.  If the REQUEST_METHOD was      #
    # not GET or POST, send an error.                                        #
    if ($ENV{'REQUEST_METHOD'} eq 'GET') {
        # Split the name-value pairs
        @pairs = split(/&/, $ENV{'QUERY_STRING'});
    }
    elsif ($ENV{'REQUEST_METHOD'} eq 'POST') {
        # Get the input
        read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
 
        # Split the name-value pairs
        @pairs = split(/&/, $buffer);
    }
    else {
        &error('request_method');
    }

    # For each name-value pair:                                              #
    foreach $pair (@pairs) {

        # Split the pair up into individual variables.                       #
        local($name, $value) = split(/=/, $pair);
 
        # Decode the form encoding on the name and value variables.          #
        $name =~ tr/+/ /;
        $name =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;

        $value =~ tr/+/ /;
        $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;

     
        $value =~ s/<!--(.|\n)*-->//g;

        if (defined($Config{$name})) {
            $Config{$name} = $value;
        }
        else {
            if ($Form{$name} && $value) {
                $Form{$name} = "$Form{$name}, $value";
            }
            elsif ($value) {
                push(@Field_Order,$name);
                $Form{$name} = $value;
            }
        }
    }

   





$suche = $verein ;
$ein_trainer = 0;












if ( $ein_trainer == 0 ) { &error('kein_trainer') }



$ein = 0;$r = 0;
open(D2,"/tmdata/btm/history.txt");

while(<D2>) {
$r++;
$zeilen[$r] = $_;
chomp $zeilen[$r];
if ($_ =~ /$leut/i) {
$ein = 1;
$liga = $r;
@lor = split (/&/, $_);	
$linie = $r;
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


$y++;
chomp $lor[$y];
$datc[$x] = $lor[$y];
if ( $datb[$x] eq $leut ) {
$liga_login = $linie;
$verein_login = $data[$x] ;

}


}


}

sub check_required {

}








sub return_html {
  

#    open(MAIL,"|$mailprog -t");

$mail{Message} .= "*** Passwort Bundesliga - TipMaster ***        / \n\n\n";
$mail{Message} .= "Sehr geehrte(r) $leut ,  \n\n";
$mail{Message} .= "ihre angeforderten Zugangsdaten lauten : \n\n";
$mail{Message} .= "Trainername : $leut\n";
$mail{Message} .= "Passwort    : $richtig\n\n\n\nMit freundlichen Gruessen\nIhr TipMaster - Team\n\n";

$mailprog = '/usr/sbin/sendmail';


    open(MAIL,"|$mailprog -t");

    print MAIL "To: $adresse\n";
    print MAIL "From: info\@tipmaster.de ( TipMaster online )\n";
#    print MAIL "BCC: service\@tipmaster.net\n";
    print MAIL "Subject: Passwort Bundesliga - TipMaster\n\n" ;



print MAIL "$mail{Message}";


  close (MAIL);
      
        print "Content-type: text/html\n\n";
   print <<"(END ERROR HTML)";
<html>
 <head>
  <title>TipMaster international : Passwort wurde verschickt</title>
 </head>
<body bgcolor=#eeeeee>
<font color=#eeeeee face=verdana size=1>.......................<img src=/img/trail.gif>
<br>
<table border=0><tr><td valign=top><img src=/img/url.gif border=0></td>
<td colspan=10></td><td valign=top>

Das Passwort fuer $leut wurde an <br>
die Adresse $adresse gemailt .<br><br>
Falls dies nicht mehr ihre geultige<br>
E-Mail Adresse oder Sie diese Mail<br>
nicht erreicht ist wenden Sie sich<br> 
bitte an info\@tipmaster.de .

</td><td><br>
<br><br><font color=#eeeeee face=verdana size=1>.................
<img src=/img/header.gif valign=top></td></tr></table>



</html>
(END ERROR HTML)

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

    elsif ($error eq 'kein_trainer') {
            print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>BTM - Tipabgabe : Trainername nicht gefunden</title>
 </head>
<body bgcolor=#eeeeee>
<font color=#eeeeee face=verdana size=1>.......................<img src=/img/trail.gif>
<br>
<table border=0><tr><td valign=top><img src=/img/url.gif border=0></td>
<td colspan=10></td><td valign=top>
<form action=/cgi-mod/btm/login.pl method=post>
<br><font face=verdana size=1>Trainername :<br><input type=text lenght=25 name=trainer>
<br><br>Passwort :<br><input type=password lenght=25 name=pass>
<br><br><input type=image src=/img/log.gif border=0></form>
<br><br><br><br>
Haben Sie Ihr Passwort vergessen ?<br> 
Kein Problem ! Wir mailen es Ihnen ...
<form action=/cgi-bin/btm/pass_sent.pl method=post>
<br><font face=verdana size=1>Trainername :<br><input type=text lenght=25 name=trainer value="$trainer">
<br><br><input type=submit value="Passwort zuschicken"></form><br>
<font face=verdana size=1>Der angegebene Trainername ist nicht<br>im Trainerverzeichnis eingetragen .</td><td><br>
<br><br><font color=#eeeeee face=verdana size=1>..................
<img src=/img/header.gif valign=top></td></tr></table>

 </body>
</html>
(END ERROR HTML)
    }

    elsif ($error eq 'falsches_passwort') {
            print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>BTM - Tipabgabe : Falsches Passwort</title>
 </head>
<body bgcolor=#eeeeee>
<font color=#eeeeee face=verdana size=1>.......................<img src=/img/trail.gif>
<br>
<table border=0><tr><td valign=top><img src=/img/url.gif border=0></td>
<td colspan=10></td><td valign=top>
<form action=/cgi-mod/btm/login.pl method=post>
<br><font face=verdana size=1>Trainername :<br><input type=text lenght=25 name=trainer value="$leut">
<br><br>Passwort :<br><input type=password lenght=25 name=pass>
<br><br><input type=image src=/img/log.gif border=0></form><br><br><br>
<font face=verdana size=1>Der angegebene Trainername existiert , <br>aber das angegebene Passwort ist falsch .</td><td><br>
<br><br><font color=#eeeeee face=verdana size=1>..................
<img src=/img/header.gif valign=top></td></tr></table>

 </body>
</html>
(END ERROR HTML)
    }
 elsif ($error eq 'kein_verein') {
            print <<"(END ERROR HTML)";
Content-type: text/html

<html>
 <head>
  <title>BTM - Tipabgabe : Kein Trainername angegeben</title>
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
  <title>BTM - Tipabgabe : Kein Passwort angegeben</title>
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
  <title>BTM - Tipabgabe : Spielauswahl nicht korrekt</title>
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


