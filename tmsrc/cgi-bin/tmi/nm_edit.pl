#!/usr/bin/perl

=head1 NAME
	TMI nm_edit.pl

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
print "Content-type: text/html\n\n";

$query = new CGI;
$method = $query->param('method');
$show = $query->param('show');
$runde = $query->param('runde');
$ligi = $query->param('ligi');

require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl" ;
require "/tmapp/tmsrc/cgi-bin/runde.pl" ;



$datei = "/tmdata/tmi/lm-tips-" . $rrunde . ".txt";
open (D1,"$datei");
while (<D1>){

@goof = split(/&/,$_);

$tip{$goof[0]}=1;
$tip_liga{$goof[0]}=$goof[1];
}

open(D2,"/tmdata/pass.txt");
while(<D2>) {
@vereine = split (/&/, $_);	
$email{$vereine[1]}=$vereine[3];
}
close(D2);

open(D2,"/tmdata/tmi/tip_status.txt");
$tip_status = <D2>;
chomp $tip_status;
close(D2);

open(D2,"/tmdata/tmi/history.txt");
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
$verein{$datb[$y]}=$datq[$y];
$liga{$datb[$y]}=$e;
$ex{$datb[$y]}=1;
#print "$datb[$y] $ex{$datb[$y]}\n";
$ya++;
chomp $vereine[$ya];
$datc[$y] = $vereine[$ya];
$liga[$y] = $e ;
}


}
close(D2);

if ( $method eq "edit" ) { &edit; }
if ( $method eq "aufst" ) { &aufst; }


if ($show eq ""){$show="Italien"}

open(D2,"/tmdata/tmi/nm/$show.txt");
$line{$show}=<D2>;
chomp $line{$show};

close (D2);




print '
<head>
<style type="text/css">TD.ve { font-family:Verdana; font-size:7pt; color:black; }
</style>
</head>
<title>TipMaster Nationalmannschaften Kaderverwaltung</title>
';

print "<center>";
print "<font face=verdana size=2><b>TipMaster Nationalmannschaften Kaderverwaltung</b><br><br>";
require "/tmapp/tmsrc/cgi-bin/tag.pl";
require "/tmapp/tmsrc/cgi-bin/tag_small.pl";

($sek, $min, $std, $tag, $mon, $jahr ,$ww) =  localtime(time+0);



print "<form action=/cgi-bin/tmi/nm_edit.pl method=post>";
print "<select style=\"font-familiy:verdana;font-size:14px;\" name=show>\n";



for ($x=1;$x<=$rr_ligen;$x++){
($rr,$joke)=split(/ / , $liga_namen[$x]);
if ( $kk{$rr} != 1 ) { 
$tx++;
$land[$x] = $rr;
$kk{$rr} = 1;
$land=$land[$x];
if ( $land[$x] eq "San" ) { $land[$x] = "San Marino" }
if ( $land[$x] eq "Nord" ) { $land[$x] = "Nord Irland" }
$aa="";
if ($show eq $land ) {$aa=" selected"}
print "<option value=\"$land\" $aa>Nationalmannschaftskader $land[$x]\n";
}
}
print "</select> <br>&nbsp;";
#if ( ($trainer eq "Walter Eschbaumer") or ($trainer eq "Roberto Maisl") or ( $trainer eq "Mathias Lehde" ) or ( $trainer eq "Wally Dresel" ) or ( $trainer eq "Andy Schafroth" )){ $open=1 }

($egal,$pr,$tc,$ps,$rest)=split ( /\|/,$line{$show});

if ( ($trainer eq $pr) or ( $trainer eq $tc ) ) { $open = 1 }
if ( ($trainer eq "") or ( $trainer eq "unknown" )) { $open=0 }


print "\n<font face=verdana size=1 color=black>\n";


for ($x=1;$x<=$rr_ligen;$x++){

($rr,$joke)=split(/ / , $liga_namen[$x]);
if ( $kd{$rr} != 1 ) { 
$tx++;
$land[$x] = $rr;
$kd{$rr} = 1;

$land=$land[$x];


#if ( $show ne $land ) {
#if ( $open == 1 ) {
#($egal,$pr,$tc,$ps,$rest)=split ( /\|/,$line{$land[$x]});
#print "<input type=hidden name=$land[$x]_ps value=\"$ps\">\n";
#@trainer=split ( /&/,$rest);
#for ($y=1;$y<=25;$y++){
#$gh="";if ($trainer[$y] eq $pr ) {
#print "<input type=hidden name=$land[$x]_pr value=\"$trainer[$y]\"> \n\n";
#}
#$gh="";if ($trainer[$y] eq $tc ) {
#print "<input type=hidden name=$land[$x]_tc value=\"$trainer[$y]\">\n";
#}
#print "<input type=hidden name=$land[$x]_tr$y value=\"$trainer[$y]\">\n";
#}
#}
#}



if ( $show eq $land ) {

$land[$x]=$land;
print '
<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>
<table border=0 cellpadding=3 cellspacing=1>
<tr><td class=ve align=center bgcolor=#eeeeee>Praesi</td><td class=ve align=center bgcolor=#eeeeee>Coach</td><td class=ve colspan=4 align=center bgcolor=#eeeeee>&nbsp;
';

if ( ($trainer eq "") or ( $trainer eq "unknown" )) { $open=0 }

($egal,$pr,$tc,$ps,$rest)=split ( /\|/,$line{$land});
@trainer=split ( /&/,$rest);


if ( $ps eq ""){$ps="http://"}

if ( $open==1) {
print "
Nationalmannschaft $land &nbsp; &nbsp; &nbsp; &nbsp; <input type=text name=",$land,"_ps value=\"$ps\" size=30 style=\"font-family:verdana;font-size:11px;\"></td>
";
}

if ( $open==0) {
print "
Nationalmannschaft $land &nbsp; &nbsp; &nbsp; &nbsp;<a href=$ps target=new>$ps</a> &nbsp;</td>
";
}

$datei ="/tmdata/tmi/nm/".$land."-".$rrunde.".txt";
open (D1,"<$datei");


$spiel1=<D1>;
@spiel1=split(/&/,$spiel1);
foreach $t (@spiel1) {
$art="";
if ( $t =~ /S#/ ) { $art="S"}
if ( $t =~ /E1#/ ) { $art="E1"}
if ( $t =~ /E2#/ ) { $art="E2"}

$t=~s/S#//;$t=~s/E1#//;$t=~s/E2#//;
$sp_1{$t}= $art;

}

$spiel2=<D1>;
@spiel2=split(/&/,$spiel2);
foreach $t (@spiel2) {
$art="";
if ( $t =~ /S#/ ) { $art="S"}
if ( $t =~ /E1#/ ) { $art="E1"}
if ( $t =~ /E2#/ ) { $art="E2"}

$t=~s/S#//;$t=~s/E1#//;$t=~s/E2#//;
$sp_2{$t}= $art;




}
$game1=<D1>;
$game2=<D1>;
chomp $game1;
chomp $game2;
close(D1);


if ( $open == 1 ) {
print "<td class=ve colspan=1 align=center bgcolor=#eeeeee>&nbsp;";
print "<select style=\"font-family:verdana;font-size:11px;\" name=game1><option value=\"Keine Auswahl\" selected>Gegner waehlen\n";

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
$xx="";if ( $rr eq $game1 ) { $xx= " selected" }
print "<option value=\"$rr\"$xx>$rr\n";
}
}
$xx="";if ( $game1 eq "Deutschland" ) { $xx= " selected" }
print "<option value=\"Deutschland\"$xx>Deutschland\n";
print "</select> &nbsp; </td>";
} else { print "<td class=ve colspan=1 align=center bgcolor=#eeeeee>&nbsp; vs. $game1 &nbsp; </td>"}

if ( $open == 1 ) {
print "<td class=ve colspan=1 align=center bgcolor=#eeeeee>&nbsp;";


print "<select style=\"font-family:verdana;font-size:11px;\" name=game2><option value=\"Keine Auswahl\" selected>Gegner waehlen\n";

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
$xx="";if ( $rr eq $game2 ) { $xx= " selected" }
print "<option value=\"$rr\"$xx>$rr\n";
}
}

$xx="";if ( $game2 eq "Deutschland" ) { $xx= " selected" }
print "<option value=\"Deutschland\"$xx>Deutschland\n";
print "</select> &nbsp; </td>" }  else { print "<td class=ve colspan=1 align=center bgcolor=#eeeeee>&nbsp; vs. $game2 &nbsp; </td>"}

print "<td class=ve colspan=1 align=center bgcolor=#eeeeee>&nbsp; Tip &nbsp;</td></tr>\n";

for ($y=1;$y<=25;$y++){


print "<tr>";

if ( $open == 1 ) {
$gh="";if ($trainer[$y] eq $pr ) {$gh=" checked"}
if ( $trainer[$y] eq "" ) { $gh="" }
print "<td class=ve align=center bgcolor=#eeeeee> <input type=radio name=",$land,"_pr value=\"$trainer[$y]\"$gh> </td>\n";
$gh="";if ($trainer[$y] eq $tc ) {$gh=" checked"}
if ( $trainer[$y] eq "" ) { $gh="" }
print "<td class=ve align=center bgcolor=#eeeeee> <input type=radio name=",$land,"_tc value=\"$trainer[$y]\"$gh> </td>\n";
print "<td class=ve align=left bgcolor=#eeeeee> &nbsp;<input type=text name=",$land,"_tr$y value=\"$trainer[$y]\" size=25 style=\"font-family:verdana;font-size:11px;\"> &nbsp; </td>\n";
print "<td class=ve align=left bgcolor=#eeeeee> &nbsp; $verein{$trainer[$y]} &nbsp; &nbsp; </td>\n";
} else {

$gh="";if ($trainer[$y] eq $pr ) {$gh="X"}
if ( $trainer[$y] eq "" ) { $gh="" }

print "<td class=ve align=center bgcolor=#eeeeff>&nbsp; $gh &nbsp;</td>\n";
$gh="";if ($trainer[$y] eq $tc ) {$gh="X"}
if ( $trainer[$y] eq "" ) { $gh="" }

print "<td class=ve align=center bgcolor=#eeeeff>&nbsp; $gh &nbsp;</td>\n";
print "<td class=ve align=left bgcolor=#eeeeee> &nbsp;$trainer[$y] &nbsp; </td>\n";
print "<td class=ve align=left bgcolor=#eeeeee> &nbsp; $verein{$trainer[$y]} &nbsp; &nbsp; </td>\n";

}



$color="#eeeeee";
if ( $liga_namen[$liga{$trainer[$y]}] =~ $land ){ $color="#eeeeee" } else {$color="#dddeff"}



if ( $trainer[$y] eq "" ) { $color="#eeeeee"}
print "<td class=ve align=left bgcolor=$color> &nbsp; $liga_kuerzel[$liga{$trainer[$y]}] &nbsp; &nbsp; </td>\n";
print "<td class=ve align=left bgcolor=#eeeeee> &nbsp; <a href=mailto=$email{$trainer[$y]}>$email{$trainer[$y]}</a> &nbsp; &nbsp; </td>\n";

$xa="";$xb="";$xc="";$xd="";
if ( $sp_1{$trainer[$y]} eq "" ) { $xa= " selected" }
if ( $sp_1{$trainer[$y]} eq "S" ) { $xb= " selected" }
if ( $sp_1{$trainer[$y]} eq "E1" ) { $xc= " selected" }
if ( $sp_1{$trainer[$y]} eq "E2" ) { $xd= " selected" }

if ( $open==1){
print "<td class=ve align=center bgcolor=#eeeeee> &nbsp; 
<select style=\"font-familiy:verdana;font-size=11px;\" name=\"game1_$trainer[$y]\">
<option value=---$xa>---<br>
<option value=S$xb>Stamm<br>
<option value=E1$xc>Ersatz 1<br>
<option value=E2$xd>Ersatz 2<br>
</select>
 &nbsp; </td>\n";
} else {
print "<td class=ve align=center bgcolor=#eeeeee> &nbsp; $sp_1{$trainer[$y]} &nbsp; </td>" }


$xa="";$xb="";$xc="";$xd="";
if ( $sp_2{$trainer[$y]} eq "" ) { $xa= " selected" }
if ( $sp_2{$trainer[$y]} eq "S" ) { $xb= " selected" }
if ( $sp_2{$trainer[$y]} eq "E1" ) { $xc= " selected" }
if ( $sp_2{$trainer[$y]} eq "E2" ) { $xd= " selected" }
if ( $open==1){
print "<td class=ve align=center bgcolor=#eeeeee> &nbsp; 
<select style=\"font-familiy:verdana;font-size=11px;\" name=\"game2_$trainer[$y]\">
<option value=---$xa>---<br>
<option value=S$xb>Stamm<br>
<option value=E1$xc>Ersatz 1<br>
<option value=E2$xd>Ersatz 2<br>

</select>
 &nbsp; </td>\n";
} else {
print "<td class=ve align=center bgcolor=#eeeeee> &nbsp; $sp_2{$trainer[$y]} &nbsp; </td>" }


$ro="";
if ( $tip{$trainer[$y]} ==1 ) {
if ( $liga_namen[$tip_liga{$trainer[$y]}] =~/$land/) {
$ro="X";

}
}
print "<td class=ve align=center bgcolor=#eeeeee> &nbsp; $ro &nbsp; </td>\n";

print "</tr>";

}

print '</table></td></tr></table><br>';
print "<input type=hidden name=ligi value=\"$land\">";
print "<input type=hidden name=runde value=\"$rrunde\">";
}
}





}


if (( $open == 1 ) ){ print "
<select style=\"font-familiy:verdana;font-size:10px;\" name=method>
<option value=none selected>Kader anzeigen\n
<option value=edit>Kader aktualisieren\n
";
if (( $tip_status == 1 ) ){ print "

<option value=aufst>Aufstellung speichern\n
";}
print "
</select><br><br>
\n" }

$kader="Kader zeigen/aktualisieren";
if ( $open ==1 ){$kader="Aktion ausfuehren"}

print "<input type=submit value=\"$kader\"></form>";


print "<form name=back action=/cgi-mod/tmi/login.pl method=post></form>\n";
print "<br><font face=verdana size=1>[ <a href=javascript:document.back.submit()>Zurueck zum Trainer LogIn - Bereich</a> ]\n";

exit;



sub edit {



open (D1,">/tmdata/tmi/nm/$ligi.txt");
for ($x=1;$x<=$rr_ligen;$x++){

($rr,$joke)=split(/ / , $liga_namen[$x]);
if ( $kkj{$rr} != 1 ) { 
$tx++;
$land[$x] = $rr;
$kkj{$rr} = 1;

$land=$land[$x];

if ( $land eq $ligi ) {
$pr = $query->param("$land[$x]_pr");
$tc = $query->param("$land[$x]_tc");
$ps = $query->param("$land[$x]_ps");

if ( $ex{$pr} != 1 ) { $pr="" }
if ( $ex{$tc} != 1 ) { $tc="" }

print D1 "$land[$x]|$pr|$tc|$ps|&";
for ($y=1;$y<=25;$y++){
$tr = $query->param("$land[$x]_tr$y");

if ( $ex{$tr} < 1 ) { $tr="" }
print D1 "$tr&";
}
print D1 "\n";
}
}
}
close (D1);
1;
}



sub aufst {
if ( $tip_status == 1 ) {
$datei = "/tmdata/tmi/nm/" . $ligi . ".txt" ;
open (D1,"<$datei");
while(<D1>){
@ko=split(/\|/,$_);
$team = $ko[4];
}
close(D1);
@ko=split(/&/,$team);
open (D2,">/tmdata/tmi/nm/$ligi-$runde.txt");
foreach $r (@ko) {
$tr="";
$tr = $query->param("game1_$r");
if (( $tr ne "---") and  ( $tr ne "")) {
print D2 "$tr#$r&";
}

}
print D2 "\n";
foreach $r (@ko) {
$tr="";
$tr = $query->param("game2_$r");
if (( $tr ne "---") and  ( $tr ne "")) {
print D2 "$tr#$r&";
}
}
print D2 "\n";
$tr = $query->param("game1");
print D2 "$tr\n";
$tr = $query->param("game2");
print D2 "$tr\n";

close (D2);
}
&edit;
}

