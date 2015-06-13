#!/usr/bin/perl

=head1 NAME
	list.pl

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
require "/tmapp/tmsrc/cgi-bin/runde.pl";
require "/tmapp/tmsrc/utility/content/lib.pl";


$query = new CGI;

$id = $query->param('id');

#id mapping
if ($id eq "links")	{$id=1}
if ($id eq "faq")	{$id=3}

#variablen
@global = split(/\|/,$verwaltung[$id]);
$datei = $global[8];


# print header
print "Content-type: text/html\n\n";
print "<title>$name[$id]</title>";
$nr=0;
open(A,"$datei");
while(<A>){
$line[$nr] = $_;
$nr++;
}
close(A);


print "<center>";
print "<font face=verdana size=3><b>$name[$id]</b><br><br><br><img src=/img/tm2.gif><br><br>";


#header information
if ($id == 1)
{
print "<font size=1 face=tahoma,verdana>Zur Aufnahme Ihrer Seite senden Sie bitte eine E-Mail an info\@tipmaster.de<br><br>[ <a href=http://www.tipmaster.de/cgi-bin/tmi/tipabgabe_ls.pl?method=hps>Liste aller Nationalmannschafts Homepages</a> ]<br><br><br>";
}

if ($id == 3){
print "<font size=1 face=tahoma,verdana>[ <a href=http://www.tipmaster.de/>TipMaster Homepage</a> ]<br><br><br>";

}


print "<br><br>";

@cats = split(/\|/,$categories[$id]);

if ($id == 1) {
foreach $t(@cats)
{

print "<font face=verdana size=2> &nbsp; &nbsp; <b>.: $t</b><br><br>";

print "<table border=0>";
foreach $s (@line)
{
@data = split(/\|/,$s);

if ($data[0] eq $t)
{

#printout


#links
if ($id==1){
print "<tr><td width=40></td>
<td valign=top><img src=/img/yel.gif> &nbsp; </td>
<td align=left><font size=2 face=tahoma,verdana><b><a href=$data[1]>$data[3]</a></b> <font size=1>[Verantwortlicher: $data[2]]<br><font size=1 face=tahoma,verdana color=darkblue> &nbsp; &nbsp; &nbsp; $data[5]<br><br></td></tr>";
}

if ($id ==3)
{



print "<tr><td width=40></td>
<td valign=top><img src=/img/yel.gif> &nbsp; </td>
<td align=left><font size=2 face=tahoma,verdana><b><a href=$data[1]>$data[0]</a></b> <br><br></td></tr>";

}



}

}

print "</table><br><br>";


}


}



#FAQ Display
if ($id==3){

print "<table border=0>";
foreach $s (@line)
{
@data = split(/\|/,$s);




print "<tr><td width=40></td>
<td valign=top><img src=/img/yel.gif> &nbsp; </td>
<td colspan=2 align=left><font size=2 face=tahoma,verdana><b>$data[0]</b> <br></td></tr>
<tr><td width=80 colspan=2></td><td width=40></td><td align=left width=500 wrap=wrap><font size=1 face=tahoma,verdana>$data[1]<br><br></td></tr>
";

}



}
