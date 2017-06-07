#!/usr/bin/perl

=head1 NAME
	BTM mailbox.pl

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
use HTML::Entities;

my $session = TMSession::getSession(btm_login => 1);
my $trainer = $session->getUser();
my $leut = $trainer;

use CGI;
$query = new CGI;
$method= $query->param('method');
$id= $query->param('id');
$add= $query->param('add');


require "/tmapp/tmsrc/cgi-bin/btm/mail/MLib.pl";
use DBI;


require "/tmapp/tmsrc/cgi-bin/btm_ligen.pl";
print "Content-Type: text/html \n\n";
if ( $method eq "delete_inbox" ) { &delete_inbox }
if ( $method eq "delete_outbox" ) { &delete_outbox }
if ( $method eq "delete_adress" ) { &delete_adress }


if ( $method eq "show_inbox" ) { &show }
if ( $method eq "show_outbox" ) { &show }

if ( $login == 0 ) {
print "<title>Message - InBox $trainer</title>\n";

$datei = "/tmdata/btm/newmail/".$trainer;
unlink($datei);
} else {
print "<title>Message - InBox LogIn</title>\n";

}

print "<body bgcolor=white text=black><p align=left>\n";

require "/tmapp/tmsrc/cgi-bin/tag.pl" ;
require "/tmapp/tmsrc/cgi-bin/tag_small.pl" ;



print "</center>";

require "/tmapp/tmsrc/cgi-bin/loc.pl" ;







$rr = 0;
$li=0;
$liga=0;
open(D2,"/tmdata/btm/history.txt");
while(<D2>) {

$li++;
@vereine = split (/&/, $_);	

$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
$y++;

chomp $verein[$y];
$data[$x] = $vereine[$y];
$y++;
chomp $verein[$y];
$datb[$x] = $vereine[$y];
$pp{"$datb[$x]"} = $data[$x] ;
$pp_liga{"$datb[$x]"} = $li ;
$verein{$datb[$x]} = $data[$x];
$liga{$datb[$x]} = $li;

if ($datb[$x] eq $trainer ) { 
$liga = $li ;
$verein = $data[$x] ;
}
if ($datb[$x] ne "Trainerposten frei" ) {
$rr++;

$auswahl_trainer[$rr] = $datb[$x] ;
$auswahl_verein[$rr] = $data[$x] ;
$auswahl_liga[$rr] = $li ;
}
$y++;
chomp $verein[$y];
$datc[$x] = $vereine[$y];
}

}
close(D2);

if ( $method eq "add_adress" ) { &add_adress }


for ($x=1 ; $x<=$rr; $x++ ) {

if ( $liga{$trainer} == $liga{$auswahl_trainer[$x]} ) {
if ( $trainer ne $auswahl_trainer[$x] ) {
push(@ligatrainer , $auswahl_trainer[$x]) ;
}}


}




print "<br>";


############## TESTEN OB TRAINERE IN DB ERFASST ########################
&openDB(mbox);

my $sql = "SELECT trainer from trainer where trainer='$trainer'";
my $sth = $dbh->prepare($sql);
$sth->execute();
       while (@data = $sth->fetchrow_array){$query=$data[0]}
      $sth->finish();
#print "$trainer -> $query<br>";

if ( $query eq "" ) {
      $sql = "INSERT INTO trainer VALUES ('$trainer','','','','','','')";
      $sth = $dbh->prepare($sql);
      $sth->execute();
      $sth->finish();
}


########################################### INBOX ######################################



&getValue($trainer,btm_inbox,trainer);
@inbox = split(/#/,$query);
$in = scalar(@inbox);
if ( $in == 0 ) { $in = "keine" }

print "
<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>
<table border=0 cellpadding=3 cellspacing=1>
<form name=back action=/cgi-bin/btm/mail/mailbox.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=password value=\"$pass\"></form>

<tr><td align=left bgcolor=#DEDFEC colspan=5 width=750><font face=verdana size=1> &nbsp; Posteingang $trainer | Es befinden sich $in Message(s) in Ihrem Posteingang | &nbsp; [ <a href=javascript:document.back.submit()>Message - Box aktualisieren</a> ] &nbsp; &nbsp;</td></tr>
";

foreach $loop (@inbox) {
($id,$neu)=split(/&/,$loop);
print "<form action=/cgi-bin/btm/mail/mailbox.pl name=show",$id,"in method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=password value=\"$pass\"><input type=hidden name=id value=$id><input type=hidden name=method value=show_inbox></form>\n";
}

print "<form action=/cgi-bin/btm/mail/mailbox.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=password value=\"$pass\"><input type=hidden name=method value=\"delete_inbox\">\n";

foreach $loop (reverse @inbox) {
@go=();
($id,$neu)=split(/&/,$loop);
      $sql = "SELECT betreff,absender,datum,zeit,art FROM box WHERE id=$id";
      $sth = $dbh->prepare($sql);
      $sth->execute();
      while (@data = $sth->fetchrow_array){@go=@data}
      $sth->finish();
if ( $go[0] ne "" ) {
$r++;
print "<tr>";
#print $loop;
if ( ($r%2) == 1 ) { $color = "#DDDFFF" }
if ( ($r%2) == 0 ) { $color = "#E3E4FF" }
$img="";
if ( $neu == 1 ) { $img=" &nbsp; <img src=/img/new.gif>"}

print "<td bgcolor=$color align=left bgcolor=white><font face=verdana size=1> &nbsp;<input type=checkbox name=id$id value=1> &nbsp;&nbsp;<img src=/img/mail.gif> &nbsp;&nbsp; <a href=javascript:document.show","$id","in.submit()>$go[0]</a> &nbsp;$img &nbsp; </td>\n";
print "<td bgcolor=$color align=left bgcolor=white><font face=verdana size=1> &nbsp; Von $go[1] &nbsp; &nbsp;&nbsp;</td>\n";
$arte[1]="LM";
$arte[2]="PM";

print "<td bgcolor=$color align=center bgcolor=white><font face=verdana size=1> - $arte[$go[4]] - </td>\n";
print "<td bgcolor=$color align=center bgcolor=white><font face=verdana size=1> $go[2] </td>\n";
print "<td bgcolor=$color align=center bgcolor=white><font face=verdana size=1> $go[3] </td>\n";
print "</tr>";
}}
if ( $in eq "keine" ) {
print "<tr><td align=center bgcolor=#DDDFFF colspan=5 width=750><font face=verdana size=1><br>Es befindet sich keine Message<br>in Ihrem Posteingang<br><br></td></tr>";
}
if ( $in ne "keine" ) {
print "<tr><td align=left bgcolor=#DEDFEC colspan=5 width=750><font face=verdana size=1> &nbsp;<input type=submit style=\"font-familiy:verdana;font-size=8px;\" value=\"-> Markierte Messages l$ouml;schen\"> &nbsp; &nbsp; [ PM = Personal Message | LM = Liga Message ]</td></tr>";
}
print "
</form></table>
</td></tr></table>
<form name=old action=/cgi-bin/btm/mail/mail_inbox.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=password value=\"$pass\">
</form>
";


########################################### OUTBOX ######################################

&getValue($trainer,btm_outbox,trainer);
@outbox = split(/#/,$query);
$out = scalar(@outbox);
if ( $out == 0 ) { $out = "keine" }

print "
<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>
<table border=0 cellpadding=3 cellspacing=1>
<tr><td align=left bgcolor=#DEDFEC colspan=5 width=750><font face=verdana size=1> &nbsp; Postausgang $trainer | Es befinden sich $out Message(s) in Ihrem Postausgang</td></tr>
";

foreach $loop (@outbox) {

print "<form action=/cgi-bin/btm/mail/mailbox.pl name=show",$loop,"out method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=password value=\"$pass\"><input type=hidden name=id value=$loop><input type=hidden name=method value=show_outbox></form>\n";
}

print "<form action=/cgi-bin/btm/mail/mailbox.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=password value=\"$pass\"><input type=hidden name=method value=\"delete_outbox\">\n";

foreach $loop (reverse @outbox) {
@go=();
$id=$loop;

      
      $sql = "SELECT betreff,empfaenger,datum,zeit,art FROM box WHERE id=$id";
      $sth = $dbh->prepare($sql);
      $sth->execute();
      while (@data = $sth->fetchrow_array){@go=@data}
      $sth->finish();
if ( $go[0] ne "" ) {
print "<tr>";
$r++;
#print $loop;
if ( ($r%2) == 1 ) { $color = "#DDDFFF" }
if ( ($r%2) == 0 ) { $color = "#E3E4FF" }
$img="";

&getValue($go[1],btm_inbox,trainer);
$status="Geloescht";
if ($art==1){$status="Ligamail"}
$tausch1 = $id.'&1#';
$tausch2 = $id.'&2#';
if ( $query =~ /$tausch1/ ) { $status ="Ungelesen" }
if ( $query =~ /$tausch2/ ) { $status ="Gelesen" }

print "<td bgcolor=$color align=left bgcolor=white><font face=verdana size=1> &nbsp;<input type=checkbox name=id$id value=1> &nbsp;&nbsp;<img src=/img/mail.gif> &nbsp;&nbsp; <a href=javascript:document.show",$id,"out.submit()>$go[0]</a> &nbsp;$img &nbsp; </td>\n";
print "<td bgcolor=$color align=left bgcolor=white><font face=verdana size=1> &nbsp; An $go[1] &nbsp; &nbsp;&nbsp;</td>\n";
print "<td bgcolor=$color align=center bgcolor=white><font face=verdana size=1> - $status - </td>\n";
print "<td bgcolor=$color align=center bgcolor=white><font face=verdana size=1> $go[2] </td>\n";
print "<td bgcolor=$color align=center bgcolor=white><font face=verdana size=1> $go[3] </td>\n";
print "</tr>";
}}
if ( $out eq "keine" ) {
print "<tr><td align=center bgcolor=#DDDFFF colspan=5 width=750><font face=verdana size=1><br>Es befindet sich keine Message<br>in Ihrem Postausgang<br><br></td></tr>";
}
if ( $out ne "keine" ) {
print "<tr><td align=left bgcolor=#DEDFEC colspan=5 width=750><font face=verdana size=1> &nbsp;<input type=submit style=\"font-familiy:verdana;font-size=8px;\" value=\"-> Markierte Messages l&ouml;schen\"></td></tr>";
}
print "
</table>
</td></tr></table><br></form>";


########################################### ADDRESSBUCH ######################################

&getValue($trainer,btm_adress,trainer);
@outbox = split(/&/,$query);
$out = scalar(@outbox);
if ( $out == 0 ) { $out = "keine" }

print "
<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>
<table border=0 cellpadding=0 cellspacing=1>
<tr>
<td align=left bgcolor=#DEDFEC colspan=3 width=570><font size=3>&nbsp; <font face=verdana size=1>Adressbuch $trainer | Es befinden sich $out Trainer in Ihrem Addressbuch</td>
<td align=center bgcolor=#DEDFEC colspan=1 width=195><font face=verdana size=1> &nbsp; Zuletzt online &nbsp; </td></tr>

";

print "<form action=/cgi-bin/btm/mail/mailbox.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=password value=\"$pass\"><input type=hidden name=method value=\"delete_adress\">\n";

foreach $loop (@outbox) {
$r++;
$id=$loop;
print "<tr>";

if ( ($r%2) == 1 ) { $color = "#DDDFFF" }
if ( ($r%2) == 0 ) { $color = "#E3E4FF" }
$img="";

$datei = "/tmdata/btm/logs/" . $loop . ".txt";
open(D1,"<$datei");
$last_online=<D1>;
chomp $last_online;
$last_online=~s/&//g;
($zeit,$datum)=split(/ /,$last_online);
($std,$min,$sek)=split(/\:/,$zeit);
($tag,$mon,$jahr)=split(/\./,$datum);
$then = $min + ($std*60) + ($tag*60*24) + ($mon*60*24*31)+ ($jahr*60*24*31*12) ;


close (D1);


print "<td bgcolor=$color align=left bgcolor=white><font face=verdana size=1> &nbsp;<input type=checkbox name=\"$loop\" value=1> &nbsp;&nbsp; $loop &nbsp; &nbsp; &nbsp; </td>\n";
print "<td bgcolor=$color align=left bgcolor=white><font face=verdana size=1> &nbsp; $verein{$loop} &nbsp; &nbsp;&nbsp;</td>\n";
print "<td bgcolor=$color align=left bgcolor=white><font face=verdana size=1> &nbsp; $liga_namen[$liga{$loop}] &nbsp; &nbsp; </td>\n";

($sek, $min, $std, $tag, $mon, $jahr,$wt) =  localtime(time+0);
$mon++;$jahr=$jahr+1900;
$now = $min + ($std*60) + ($tag*60*24) + ($mon*60*24*31)+($jahr*60*24*31*12) ;

$when = $now - $then ;

if ( $when > 15 ) {
print "<td bgcolor=$color align=center bgcolor=white><font face=verdana size=1> $datum - $zeit</td>\n";
} else {
print "<td bgcolor=$color align=center bgcolor=white><font face=verdana size=1 color=darkgreen> - Trainer ist online -</td>\n";

}

print "</tr>";
}
if ( $out eq "keine" ) {
print "<tr><td align=center bgcolor=#DDDFFF colspan=4 width=750><font face=verdana size=1><br>Sie haben noch keinen Trainer<br>in Ihr Adressbuch aufgenommen<br><br></td></tr>";
}
#if ( $out ne "keine" ) {
print "<tr><td align=left bgcolor=#DEDFEC colspan=2><font face=verdana size=1> &nbsp;<input type=submit style=\"font-familiy:verdana;font-size=8px;\" value=\"-> Markierte Trainer l&ouml;schen\"></td></form>";
print "<form action=/cgi-bin/btm/mail/mailbox.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=password value=\"$pass\"><input type=hidden name=method value=\"add_adress\">\n";
print "<td align=left bgcolor=#DEDFEC colspan=2><font face=verdana size=1> &nbsp;<input type=text size=25 style=\"font-family:verdana;font-size:10px;\" name=add value=\"Trainername\"> &nbsp; <input type=submit style=\"font-familiy:verdana;font-size=8px;\" value=\"-> Tainer hinzuf&uuml;gen\">";
if ( $error_a ne "" ) {
print "<br> &nbsp;<font color=darkred>". encode_entities($error_a);
}

print "</td></tr></form>\n";
#}
print "
</table>
</td></tr></table><br>";

###########################################MESSAGE SENDEN ######################################
print "
<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>
<table border=0 cellpadding=3 cellspacing=1>
<form method=post action=/cgi-bin/btm/mail/mail_sent.pl>
<input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=password value=\"$pass\"><input type=hidden name=message value=\"konkurrenz\">
<tr>

<td align=left bgcolor=#DEDFEC colspan=2 width=450><font face=verdana size=1> &nbsp; Message versenden</td>

";
print "<tr><td align=right bgcolor=#DDDFFF colspan=1><font face=verdana size=1> &nbsp;Senden an &nbsp; </td>

<td align=left bgcolor=#DDDFFF colspan=1><font face=verdana size=1> &nbsp; <select name=auswahl_liga style=\"font-family:verdana;font-size:10px;\">
<option value=none>Empfaenger ausw&auml;hlen
<option value=none>-------------------------------------------------
";
foreach $x (@outbox) {
print "<option value=\"$x\">$x ( $verein{$x} / $liga_kuerzel[$liga{$x}] )\n";
}
if (scalar(@outbox)>0) {
print "
<option value=none>-------------------------------------------------
";

}
print "
<option value=Liga_$liga{$trainer}>An alle $liga_namen[$liga{$trainer}] Trainer senden
<option value=none>-------------------------------------------------
";
foreach $x (@ligatrainer) {
print "<option value=\"$x\">$x ( $verein{$x} / $liga_kuerzel[$liga{$x}] )\n";
}
print "</select></td>";

print "</tr>";
print "<tr>";
print "<td align=right bgcolor=#DDDFFF colspan=1><font face=verdana size=1> &nbsp; Betreff &nbsp; </td><td align=left bgcolor=#DDDFFF colspan=1><font face=verdana size=1> &nbsp; <input type=text name=subject size=40 maxlength=45 style=\"font-family:verdana;font-size:10px;\"> &nbsp;&nbsp; </td>";
print "</tr>";
print "<tr><td align=left bgcolor=#DEDFEC colspan=2><font face=verdana size=1><br>";
print "<textarea name=text rows=10 cols=60 maxrows=10 wrap=virtual maxcols=40 style=\"font-family:verdana;font-size:10px;\">
$go[6]
</textarea><br><br>
<input type=submit style=\"font-familiy:verdana;font-size=8px;\" value=\"-> Message senden\">
</td></tr>";


print "
</table>
</td></tr></table><br>";
exit ;


#_________________________________________________________________________________________
#__________________________________     ENDE HTML   __________________________________________
#_________________________________________________________________________________________










############ ROUTINE L&OUML;SCHEN POSTEINGANG MESSAGES #############
sub delete_inbox {

&openDB(mbox);
&getValue($trainer,btm_inbox,trainer);
$inbox_new=$query;

@cachen = split(/#/,$query);
$query=undef;
foreach $hier (@cachen){

($id,$neu) = split(/&/,$hier);
$del=0;
$query = new CGI;
$del = $query->param("id$id");

if ($del==1){
$inbox_new=~s/$id\&1\#//;
$inbox_new=~s/$id\&2\#//;
}
}

      $sql = "UPDATE trainer SET btm_inbox='$inbox_new' where trainer='$trainer'";
      $sth = $dbh->prepare($sql);
      $sth->execute();
      $sth->finish();

&closeDB;
}

############ ROUTINE L&OUML;SCHEN POSTAUSGANG MESSAGES #############
sub delete_outbox {

&openDB(mbox);
&getValue($trainer,btm_outbox,trainer);
$outbox_new=$query;

@cachen = split(/#/,$query);
$query=undef;
foreach $hier (@cachen){
$id=$hier;
$del=0;
$query = new CGI;
$del = $query->param("id$id");

if ($del==1){
$outbox_new=~s/$id\#//;
$outbox_new=~s/$id\#//;
}
}

      $sql = "UPDATE trainer SET btm_outbox='$outbox_new' where trainer='$trainer'";
      $sth = $dbh->prepare($sql);
      $sth->execute();
      $sth->finish();

&closeDB;
}

############ ROUTINE L&OUML;SCHEN ADDRESSBUCH TRAINER #############
sub delete_adress {

&openDB(mbox);
&getValue($trainer,btm_adress,trainer);
$outbox_new=$query;

@cachen = split(/&/,$query);
$query=undef;
foreach $hier (@cachen){
$id=$hier;
$del=0;
$query = new CGI;
$del = $query->param("$id");

if ($del==1){
$outbox_new=~s/$id&//;
}
}

      $sql = "UPDATE trainer SET btm_adress='$outbox_new' where trainer='$trainer'";
      $sth = $dbh->prepare($sql);
      $sth->execute();
      $sth->finish();

&closeDB;
}

############ ROUTINE ADD ADDRESSBUCH TRAINER #############
sub add_adress {

&openDB(mbox);
&getValue($trainer,btm_adress,trainer);
$outbox_new=$query;
@cachen = split(/&/,$query);
$ex=0;
foreach $hier (@cachen){
if ( $add eq $hier ) { $ex = 1 }
}
$error_a="";
if ( $ex==1) { $error_a="$add ist schon im Adressbuch vorhanden" }
if ( $verein{$add} eq "") { $error_a="$add ist kein aktiver BTM - Trainer" }

if ( ( $ex==0) and ($verein{$add} ne "")) {
$outbox_new=$outbox_new . $add . '&' ;
      $sql = "UPDATE trainer SET btm_adress='$outbox_new' where trainer='$trainer'";
      $sth = $dbh->prepare($sql);
      $sth->execute();
      $sth->finish();
}
&closeDB;
}

################################ SHOW ############################
sub show {
print "<body bgcolor=white text=black><p align=left>\n";

open(D2,"/tmdata/btm/history.txt");
while(<D2>) {
@vereine = ();
$e++ ;
@vereine = split (/&/, $_);	
$ya = 0;
for ( $x = 1; $x < 19; $x++ )
{
$ya++;
$y++;
chomp $vereine[$ya];
$datq[$y] = $vereine[$ya];
$ya++;
chomp $vereine[$ya];
$datb[$y] = $vereine[$ya];
$ya++;
chomp $vereine[$ya];
$datc[$y] = $vereine[$ya];
$liga{$datb[$y]} = $e ;
$verein{$datb[$y]} = $datq[$y] ;

}

}
close(D2);

require "/tmapp/tmsrc/cgi-bin/tag.pl" ;
require "/tmapp/tmsrc/cgi-bin/tag_small.pl" ;
print "<br><br>";
require "/tmapp/tmsrc/cgi-bin/loc.pl" ;
&openDB(mbox);

      $sql = "SELECT betreff,absender,empfaenger,datum,zeit,art,text FROM box WHERE id=$id";
      $sth = $dbh->prepare($sql);
      $sth->execute();
      while (@data = $sth->fetchrow_array){@go=@data}
      $sth->finish();

# GELESEN - NIX MEHR NEW ############
if ( $method eq "show_inbox" ) {
&getValue($trainer,btm_inbox,trainer);
$tausch1 = $id.'&1#';
$tausch2 = $id.'&2#';
$query=~s/$tausch1/$tausch2/;
      $sql = "UPDATE trainer SET btm_inbox='$query' WHERE trainer='$trainer'";
      $sth = $dbh->prepare($sql);
      $sth->execute();
      $sth->finish();
}
###############################

print "
<br><table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>
<table border=0 cellpadding=5 cellspacing=1>
<form name=back action=/cgi-bin/btm/mail/mailbox.pl method=post><input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=password value=\"$pass\"></form>

<tr><td align=left bgcolor=#DEDFEC colspan=3><font face=verdana size=1>&nbsp;<img src=/img/mail.gif> &nbsp; Message \"$go[0]\" vom $go[3] - $go[4] &nbsp; &nbsp; &nbsp; [ <a href=javascript:document.back.submit()>Zur&uuml;ck zur Message - Box</a> ] &nbsp; &nbsp; &nbsp;</td></tr>
<tr>
<td align=right bgcolor=#DDDFFF><font face=verdana size=1>Absender &nbsp;</td>
<td align=left bgcolor=#EDF0F6><font face=verdana size=1>&nbsp;$go[1] &nbsp; &nbsp; </td>
<td align=left bgcolor=#EDF0F6><font face=verdana size=1>&nbsp;$verein{$go[1]} | $liga_namen[$liga{$go[1]}]&nbsp;</td>
</tr>
<tr>
<td align=right bgcolor=#DDDFFF><font face=verdana size=1>Empfaenger &nbsp;</td>
<td align=left bgcolor=#EDF0F6><font face=verdana size=1>&nbsp;$go[2] &nbsp; &nbsp; </td>
<td align=left bgcolor=#EDF0F6><font face=verdana size=1>&nbsp;$verein{$go[2]} | $liga_namen[$liga{$go[2]}]&nbsp;</td>
</tr>
<tr><td align=left bgcolor=#eeeeee colspan=3><font face=verdana size=1><br>$go[6]<br><br></td></tr>
";

if ( $method eq "show_outbox" ) {
&getValue($go[2],btm_inbox,trainer);
$status="Geloescht";
if ($art==1){$status="Ligamail"}
$tausch1 = $id.'&1#';
$tausch2 = $id.'&2#';
if ( $query =~ /$tausch1/ ) { $status ="Ungelesen" }
if ( $query =~ /$tausch2/ ) { $status ="Gelesen" }
print "<tr><td align=left bgcolor=#DEDFEC colspan=3><font face=verdana size=1>Die Message hat den Status : $status<br>";
if ( $status eq "Ungelesen" ) {
$datei = "/tmdata/btm/logs/" . $go[2] . ".txt";
open(D1,"<$datei");
$last_online=<D1>;
chomp $last_online;
$last_online=~s/&//g;
($zeit,$datum)=split(/ /,$last_online);
close (D1);

print "$go[2] war zuletzt online am $datum um $zeit";
}

print "</td></tr>";
}

if ( $method eq "show_inbox" ) {
$go[6]=~s/\<br\>/\n\*\ /g;
$go[6]='* '.$go[6];
print "<form method=post action=/cgi-bin/btm/mail/mail_sent.pl>\n";
print "<input type=hidden name=auswahl_liga value=\"$go[1]\">";
print "
<tr><td align=left bgcolor=#DEDFEC colspan=3><font face=verdana size=1>Antwort verfassen<br><br>";

($re , $th ) = split (/:/ , $go[0] ) ;

print "<input type=hidden name=trainer value=\"$trainer\"><input type=hidden name=password value=\"$pass\"><input type=hidden name=message value=konkurrenz>\n";
if ($re ne "Re") { $go[0] = 'Re: ' . $go[0] }
print "<input type=text name=subject style=\"font-family:verdana;font-size:10px;\" size=35 value=\"$go[0]\"><br>";
print "<textarea name=text rows=10 cols=60 maxrows=10 wrap=virtual maxcols=40 style=\"font-family:verdana;font-size:10px;\">
$go[6]
</textarea><br>
<input type=submit style=\"font-familiy:verdana;font-size=8px;\" value=\"-> Antwort senden\">
</td></tr>";


}




print "
</table>
</td></tr></table>";


exit;
&closeDB;
}








