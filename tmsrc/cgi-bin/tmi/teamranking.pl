#!/usr/bin/perl

=head1 NAME
	TMI teamranking.pl

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
require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl" ;
require "/tmapp/tmsrc/cgi-bin/tmi/saison.pl";
require "/tmapp/tmsrc/cgi-bin/runde.pl";

@cl_label = ("Q1","Q2","Q3","GR","AC","VI","HA","FI","CH");
@ue_label = ("Q1","Q2","H1","H2","H3","AC","VI","HA","FI","CH");
@lp_label = ("Q1","Q2","H1","H2","H1","AC","VI","HA","FI","CH");
@cl_org_label = ("Q1","Q2","Q3","GR","GR", "AC","VI","HA","FI","CH");

$script_name = "teamranking.pl";
$order_delta = 100000000000;
@lp_schedule = (1,1,1,2,3,3,4,4,5,5);

print "Content-Type: text/html \n\n";


$query = new CGI;
$me = $query->param('me');
$land = $query->param('land');
$top = $query->param('top');
$sp_start = $query->param('sp_start');
$sp_ende = $query->param('sp_ende');
$into = $query->param('into');
$fileid = $query->param('fileid');
$sai = $query->param('sai');
$runde = $query->param('runde');
$datasource = $query->param('datasource');


&header;
&readin_data;
&display;
exit;







sub header{

$ein=0;
for ( $x = 1; $x <= 11; $x++ ) {
if ( $x == $me ) { $ein = 1 }
}
if ($ein == 0 ) {$me=11}



($saison_sel,$runde_sel)=split(/&/,$runde);


$ein=0;
for ( $x = 1; $x <= 7; $x++ ) {
if ( $x == $into ) { $ein = 1 }
}
if ($ein == 0 ) {$into=4}



if (($top!= 50)&&($top!=100)&&($top!=200)&&($top!=500)&&($top!=1000)){$top=50}
if (($datasource!= 1)&&($datasource!=2)){$datasource=1}

print "<head>\n";
print "<style type=\"text/css\">";
print "td { font-family:tahoma; font-size:7pt; color:black; text-align:right;}\n";
print "td.v { font-family:tahoma; font-size:7pt; color:black; text-align:left;}\n";
print "td.c { font-family:tahoma; font-size:7pt; color:black; text-align:center;}\n";
print "</style>\n";
print "</head>\n";

if ( $saison_sel eq "" ) { $saison_sel = $main_nr }
if ( $runde_sel == 0 ) { $runde_sel = $rrunde -1 }

print " <html><title>TipMaster Trainer - Vereins-Ranking </title><p align=left><body bgcolor=white text=black>\n";

require "/tmapp/tmsrc/cgi-bin/tag.pl" ;
require "/tmapp/tmsrc/cgi-bin/tag_small.pl" ;
print "<br>\n";
print "<font face=tahoma size=1>";
$trainer = $leut ;

require "/tmapp/tmsrc/cgi-bin/loc_tmi.pl" ;


$tmp1 = $runde_sel - 1;
$tmp2 = $runde_sel + 1;

$ru_zurueck = $saison_sel.'&'.$tmp1;
$ru_vor = $saison_sel.'&'.$tmp2;
$ss1= $saison_sel -1;
$ss2= $saison_sel+1;
if ($tmp1 == 0){$ru_zurueck = $ss1.'&9'}
if ($tmp2 == 10){$ru_vor = $ss2.'&1'}


$last=(($saison_sel-6)*34)+(($tmpr-1)*4);

print "<br/><form method=post action=/cgi-bin/tmi/".$script_name." target=_top style=\"display:inline\">\n";




print "<select style=\"font-family: tahoma; font-size: 11px; font-weight: normal; color: #000000;\" name=me>";

$gh = "";
if ( $me == 11 ) { $gh = "selected" }
print "<option value=11 $gh>TMI Vereinsranking \n";

$gh = "";
if ( $me == 1 ) { $gh = "selected" }
print "<option value=1 $gh>Die erfolgreichsten Meisterschafts Vereine\n";
$gh = "";
if ( $me == 2 ) { $gh = "selected" }
print "<option value=2 $gh>Die erfolgreichsten Champions League Vereine\n";
$gh = "";
if ( $me == 3 ) { $gh = "selected" }
print "<option value=3 $gh>Die erfolgreichsten UEFA Cup Vereine\n";
$gh = "";
if ( $me == 4 ) { $gh = "selected" }
print "<option value=4 $gh>Die erfolgreichsten Landespokal Vereine\n";
$gh = "";
if ( $me == 5 ) { $gh = "selected" }
print "<option value=5 $gh>Die groessten Fahrstuhlmannschaften\n";
$gh = "";
if ( $me == 7 ) { $gh = "selected" }
print "<option value=7 $gh>Sortierung aktuelle CL Teilnehmer\n";
$gh = "";
if ( $me == 8 ) { $gh = "selected" }
print "<option value=8 $gh>Sortierung aktuelle UEFA Cup Teilnehmer\n";
$gh = "";
if ( $me == 9 ) { $gh = "selected" }
print "<option value=9 $gh>Sortierung aktuelle Landespokal Teilnehmer\n";
$gh = "";
if ( $me == 10 ) { $gh = "selected" }
print "<option value=10 $gh>Sortierung aktuelle Meisterschaft\n";
$gh="";
if ( $me == 6 ) { $gh = "selected" }
print "<option value=6 $gh>Sortierung nach Liga und Position\n";
$gh = "";

print "</select>&nbsp;&nbsp;";

print "<select style=\"font-family: tahoma; font-size: 11px; font-weight: normal; color: #000000;\" name=top>";

$gh = "";
if ( $top == 50 ) { $gh = "selected" }
print "<option value=50 $gh>Top 50\n";
$gh = "";
if ( $top == 100 ) { $gh = "selected" }
print "<option value=100 $gh>Top 100\n";
$gh = "";
if ( $top == 200 ) { $gh = "selected" }
print "<option value=200 $gh>Top 200\n";
$gh = "";
if ( $top == 500 ) { $gh = "selected" }
print "<option value=500 $gh>Top 500\n";
$gh = "";
if ( $top == 1000 ) { $gh = "selected" }
print "<option value=1000 $gh>Top 1000\n";

print "</select>&nbsp;&nbsp;";

#laenderliste erstellen
$tx = 0;
for($rx=1;$rx<=203;$rx++){
($rr,$joke)=split(/ / , $liga_namen[$rx]);
if ( $rr eq "San" ) { $rr = "San Marino" }
if ( $rr eq "Nord" ) { $rr = "Nord Irland" }
if ( $kk{$rr} != 1 ) {
$land[$tx] = $rr;
$kk{$land[$tx]} = 1;
$tx++;
}
}

@land=sort(@land);
print "<select style=\"font-family: tahoma; font-size: 11px; font-weight: normal; color: #000000;\" name=land>";
$gh = "";
if ( $land eq "Alle" ) { $gh = "selected" }
print "<option value=Alle $gh>Alle Laender\n";
foreach (@land)
{
$gh = "";
if ( $land eq $_ ) { $gh = "selected" }
print "<option value=\"$_\" $gh>$_\n";
}


print "</select>&nbsp;&nbsp;\n";




print "<select style=\"font-family: tahoma; font-size: 11px; font-weight: normal; color: #000000;\" name=datasource>";

$gh = "";
if ( $datasource == 1 ) { $gh = "selected" }
print "<option value=1 $gh>&Uuml;ber alle Saisons\n";
$gh = "";
if ( $datasource == 2 ) { $gh = "selected" }
print "<option value=2 $gh>Nur letzte 10 Saisons\n";

print "</select>&nbsp;&nbsp;\n";








print "&nbsp;&nbsp;<input type=hidden name=id value=\"$id\"><input style=\"font-family: tahoma; font-size: 11px; font-weight: normal; color: #000000;\"  type=submit value=\"Tabelle laden\"></form>";

print "<font size=1><br><br><font face=verdana size=2><b>TMI - Vereinsranking (Beta)</b> <font size=1> &nbsp; &nbsp; Kommentare, Bugmeldungen, konstr. Kritik bitte an info\@tipmaster.de mailen<br/><br/>";
print " &nbsp; >> zum bisherigen <a href=vranking.pl>Vereinsranking</a><br><br>";

}
















sub readin_data {

open(D2,"/tmdata/tmi/history.txt");
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
$trainerteam{"$datb[$x]"} = $data[$x] ;
$trainer{"$data[$x]"} = $datb[$x] ;
$liga{"$data[$x]"} = $li ;
$y++;
chomp $verein[$y];
$datc[$x] = $vereine[$y];
}
}
close(D2);

open(D2,"/tmdata/tmi/heer.txt");
while(<D2>) {
@go = ();
@go = split (/&/ , $_);
$vplatz{"$go[5]"} = $go[0] ;
}
close (D2);

#readin current ec participants
open(D3,"/tmdata/tmi/swechsel/ec_erfolge_cur.txt");
while(<D3>)
{
	@tmp = split(/#/,$_);
	if ($tmp[2] eq "U") { $uefa{$tmp[1]} = $tmp[3] }
	if ($tmp[2] eq "C") { $champions{$tmp[1]} = $tmp[3] }
	
	$uefa{$tmp[1]}=~s/Q3/H1/;
	$uefa{$tmp[1]}=~s/G1/H2/;
	$uefa{$tmp[1]}=~s/G2/H3/;
	$champions{$tmp[1]}=~s/G1/GR/;
	$champions{$tmp[1]}=~s/G2/GR/;

	my $rr=0;
	foreach $tt (@cl_label){
	$rr++;
	if ($tt eq $champions{$tmp[1]}){$ch_r{$tmp[1]}=$rr}
	}

        my $rr=0;
        foreach $tt (@ue_label){
        $rr++;
        if ($tt eq $uefa{$tmp[1]}){$ue_r{$tmp[1]}=$rr}
        }



}

#readin current league cup participants
open(D3,"/tmdata/tmi/swechsel/pokaldump_cur.txt");
while(<D3>)
{
@tmp = split(/&/,$_);
@tmp1 = split(/#/,$tmp[1]);
$leaguecup{$tmp1[0]}=$tmp[2];
if ($lp_schedule[$rrunde] < $leaguecup{$tmp1[0]})
{ $leaguecup{$tmp1[0]} = $lp_schedule[$rrunde] }

       

}

if ($datasource ==1 ) {
$file = "/tmdata/tmi/alltime_ranking.txt";
} else {
$file = "/tmdata/tmi/alltime_ranking_last10.txt";
}


#if (!-e $file) {exit;}

open(A,$file);
while(<A>){
@data = split(/#/,$_);$tmp=$_;chomp $tmp;

$team[$tr] = $data[0];
$cl[$tr] = $data[1];
$ue[$tr] = $data[2];
$po[$tr] = $data[3];
$li[$tr] = $data[4];
$auf[$tr] = $data[5];
$season[$tr] = $data[6];

$nor[$tr] = $liga{$data[0]}.'&'.$vplatz{$data[0]};
$champ_round[$tr] = $ch_r{$data[0]};
$uefa_round[$tr] = $ue_r{$data[0]};
$lp_round[$tr] = $leaguecup{$data[0]};



#### ranking points ####
my $pp=0;

@tmp=split(/&/,$li[$tr]);
@points_li = (100,70,50,30,10);
my $i=0; foreach $t (@tmp) {$pp+=$t*$points_li[$i];$i++;}

@tmp=split(/&/,$cl[$tr]);
@points_li = (150,100,80,60,40,20,0,0,0);
my $i=0; foreach $t (@tmp) {$pp+=$t*$points_li[$i];$i++;}

@tmp=split(/&/,$ue[$tr]);
@points_li = (100,70,55,40,25,10,0,0,0);
my $i=0; foreach $t (@tmp) {$pp+=$t*$points_li[$i];$i++;}

@tmp=split(/&/,$po[$tr]);
@points_li = (40,25,15,10,0,0,0,0);
my $i=0; foreach $t (@tmp) {$pp+=$t*$points_li[$i];$i++;}



$points[$tr] = $pp;
####








#analyse league results
@tmp= split(/&/,$liga{$data[0]});
for ($x=0;$x<=4;$x++){
if ($vplatz{$data[0]} == ($x+1) && $liga_kuerzel[$liga{$data[0]}] =~/\sI$/) { $meister_round[$tr] = (100 - $vplatz{$data[0]});$meister_Round[$tr].='&'.$liga{$data[0]}.'&'.$vplatz{$data[0]}};
}



$tr++;
}
close(A);

&calculate_ranking;

}


sub calculate_ranking()
{
	
	#assign data coresponding to ranking type
	if ($me == 1) {@data = @li;}
	if ($me == 2) {@data = @cl;}
	if ($me == 3) {@data = @ue;}
	if ($me == 4) {@data = @po;}
	if ($me == 5) {@data = @auf;}
	if ($me == 6) {@data = @nor;}
	if ($me == 7) {@data = @champ_round;}
	if ($me == 8) {@data = @uefa_round;}
	if ($me == 9) {@data = @lp_round;}
	if ($me == 10) {@data = @meister_round;}
	if ($me == 11) {@data = @points;}
	
	
	my $id=0;
	
	foreach(@team)
	{
		
		@tmp = split(/&/,$data[$id]);
		#add delta for simple ordering
		for ($x=0;$x<=10;$x++) {
		my $ttmp = "";

		if ($me == 5) { $tmp[0] += $tmp[1]}
		if ($tmp[$x] < 1000) {$ttmp = "0"}
		if ($tmp[$x] < 100) {$ttmp .= "0"}
		if ($tmp[$x] < 10) {$ttmp .= "0"}
		
		$rank[$id].=$ttmp.($tmp[$x]*1);
		}
	
		if ($me == 9)
		{
			$rank[$id].= 100000 - 1- $id;
		}
	
		$rank[$id].= 100000 + $points[$id];
		$rank[$id].= 100000 - 1- $id;
		$rank[$id].='#'.$id;

		$rank_all[$id].= 100000 + $points[$id];
                $rank_all[$id].= 100000 - 1- $id;
                $rank_all[$id].='#'.$id;


		$id++;
	}

@rank = sort(@rank);
@rank_all = reverse(sort(@rank_all));
	
	if ($me != 6 ) {
	@rank = reverse(@rank);
	}

my $i=1;
foreach(@rank_all){

	
	@t = split(/#/,$_);
	$ranking[$t[1]] = $i;
	$i++;

}



}

sub display {

print "<table border=0 cellpadding=0 cellspacing=0 bgcolor=black><tr><td>\n";
print "<table border=0 cellpadding=1 cellspacing=1>\n";


print "<tr>\n";

my $col=2;
if ($me == 11 ) { $col = 1}
print "<td bgcolor=#eeeeee align=left colspan=$col rowspan=2>&nbsp;</td>\n";
print "<td class=v bgcolor=#eeeeee align=left rowspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Verein</td>\n";
print "<td class=v bgcolor=#eeeeee align=left rowspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Trainer </td>\n";

$color="#eeeeee";if ($me == 6 ) {$color = "#999999"}
print "<td bgcolor=$color rowspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Liga &nbsp;&nbsp;</td>\n";
$color="#eeeeee";if ($me == 1) {$color = "#999999"}
print "<td class=c bgcolor=$color align=center colspan=5> Meisterschaft </td>\n";
$color="#eeeeee";if ($me == 5 ) {$color = "#999999"}
print "<td class=c bgcolor=$color align=center colspan=2> Auf-/Abst. </td>\n";
$color = "#eeeeee";
print "<td class=c bgcolor=$color align=center colspan=2> 1.Liga</td>\n";


$color="#eeeeee";if ($me == 2 || $me == 7) {$color = "#999999"}
print "<td class=c bgcolor=$color align=center colspan=9>Champions League</td>\n";
$color="#eeeeee";if ($me == 3 || $me == 8) {$color = "#999999"}
print "<td class=c bgcolor=$color align=center colspan=10>UEFA Cup</td>\n";
$color="#eeeeee";if ($me == 4 || $me == 9) {$color = "#999999"}
print "<td class=c bgcolor=$color align=center colspan=6>Landespokal</td>\n";
$color="#eeeeee";if ($me == 11) {$color = "#999999"}
print "<td bgcolor=$color align=center colspan=1 rowspan=2 nowrap>&nbsp; Punkte &nbsp;
</td>\n";

print "</tr>\n";

print "<tr>\n";

for($x=1;$x<=5;$x++){print "<td class=c bgcolor=#eeeeee align=center>$x.</td>";}
print "<td class=c bgcolor=#eeeeee align=center><img src=/img/pfeil+.gif></td>";
print "<td class=c bgcolor=#eeeeee align=center><img src=/img/pfeil-.gif></td>";
print "<td class=c bgcolor=#eeeeee nowrap>&nbsp; Pl. &#216; &nbsp;</td>";
print "<td class=c bgcolor=#eeeeee align=center nowrap>&nbsp;Sai. #&nbsp;</td>";

for($x=8;$x>=0;$x--){print "<td bgcolor=#eeeeee align=center>$cl_label[$x]</td>";}
for($x=9;$x>=0;$x--){print "<td bgcolor=#eeeeee align=center>$ue_label[$x]</td>";}
for($x=9;$x>=4;$x--){print "<td bgcolor=#eeeeee align=center>$lp_label[$x]</td>";}

print "</tr>\n";


$rrr=0;$place = 0;
for ($t=0;$t<=$tr;$t++){

$ein=0;



$color=black;

@data = split(/#/,$rank[$t]);
$id=$data[1];

if (($trainer{$team[$id]} eq $trainer )){$color="red"}


$ein=0;

if (($land eq "Alle" )) { $ein = 1 }
if ($liga_namen[$liga{$team[$id]}]=~/^$land/ ) { $ein = 1 }

my $tmp=0;
if ($rrr>=$top){$ein=0;$place++}
if (($trainer{$team[$id]} eq $trainer ) && ( ($land eq "Alle" ) || ($liga_namen[$liga{$team[$id]}]=~/^$land/))){$color="red"; $ein=1;$tmp=1}

if ($tmp==1 && $rrr>=$top){$place--}


if ( $ein == 1 ) {
$place++;
$rrr++;
#if ( $t == $p{$data[0]} ) { $ima = "pfeil=.gif" }
#if ( $t < $p{$data[0]} ) { $ima = "pfeil++.gif" }
#if ( $t > $p{$data[0]} ) { $ima = "pfeil--.gif" }
#if ( $t < ( $p{$data[0]} - 10 ) ) { $ima = "pfeil+.gif" }
#if ( $t > ( $p{$data[0]} + 10 ) ) { $ima = "pfeil-.gif" }

#if ( $p{$data[0]} eq "" ) { $ima = "pfeil+.gif" }
#if ( $p{$data[0]} eq "") { $p{$data[0]} = "--" }

print "<tr>\n";

#check if team in same country as trainer
my @tmp1 = split(/ /,$liga_kuerzel[$liga{$trainerteam{$trainer}}]);
my @tmp2 = split(/ /,$liga_kuerzel[$liga{$team[$id]}]);
$color1="#f5f5ff";
if ($tmp1[0] eq $tmp2[0]) {$color1="#ccccff"}
##########

print "<td bgcolor=$color1 NOWRAP><font face=tahoma size=1 color=$color>&nbsp; &nbsp;".($place).".&nbsp;</td>\n";

if ($me != 11){
	print "<td bgcolor=$color1 NOWRAP><font face=tahoma size=1 color=$color>&nbsp; &nbsp;$ranking[$id].&nbsp;</td>\n";
}

#print "<td bgcolor=#f5f5ff NOWRAP>&nbsp;( $p{$data[0]}.)&nbsp;</td>\n";
$tmp=$team[$id];$tmp=~s/ /%20/g;
print "<td class=v bgcolor=#eeeeff align=left NOWRAP><font face=tahoma size=1 color=$color>&nbsp;&nbsp;<a  style=\"text-decoration: none\" href=/cgi-mod/tmi/verein.pl?ident=$tmp target=new alt=\"Vereinsstatistik $data[0]\">$team[$id]</a>&nbsp;&nbsp;</td>\n";
$color="black" ;

$tmp=$trainer{$team[$id]};$tmp=~s/ /%20/g;

if ($tmp ne "")  {

print "<td class=v bgcolor=#f5f5ff align=left NOWRAP><font face=tahoma size=1 color=$color>&nbsp;&nbsp;<a  style=\"text-decoration: none\" href=/cgi-mod/tmi/trainer.pl?ident=$tmp target=new alt=\"Vereinsstatistik $verein{$data[0]}\">$trainer{$team[$id]}</a>&nbsp;&nbsp;</td>\n";
$tmp="";if ($vplatz{$team[$id]} < 10){$tmp="0"}
print "<td bgcolor=#ccccff NOWRAP align=right><font face=tahoma size=1 color=$color>&nbsp;&nbsp;$liga_kuerzel[$liga{$team[$id]}] [$tmp$vplatz{$team[$id]}.]&nbsp;&nbsp;</td>\n";
} else {
print "<td bgcolor=#ccccff colspan=2></td>";
}


#show league results
@tmp= split(/&/,$li[$id]);
for ($x=0;$x<=4;$x++){
$color = "#f5f5ff";
if ($vplatz{$team[$id]} == ($x+1) && $liga_kuerzel[$liga{$team[$id]}] =~/\sI$/)  { $color = "#66ff66" }
print "<td bgcolor=$color NOWRAP>&nbsp;$tmp[$x]&nbsp;</td>\n";
}

#show up/down
@tmp= split(/&/,$auf[$id]);

my $auf = int($liga_type[$liga{$team[$id]}]/10);
my $ab =  $liga_type[$liga{$team[$id]}]-$auf*10;

for ($x=0;$x<=1;$x++){
$color1 = "#ccccff";
if ($vplatz{$team[$id]} <= $auf && $x==0)  {$color1 = "#66ff66"}
if ($vplatz{$team[$id]} > 18-$ab && $x==1)  {$color1 = "#ff6666"}

print "<td class=c bgcolor=$color1 NOWRAP> &nbsp;$tmp[$x] </td>\n";
}

#season places
@tmp= split(/&/,$season[$id]);
for ($x=0;$x<=1;$x++){

if ($x==0)
{
	if ($tmp[1] < 1) { $tmp[0] = "---"} else 
	{
		$tmp[0] /= $tmp[1];
		$tmp[0] = int($tmp[0]*10)/10;
		if (int($tmp[0]) == $tmp[0]){$tmp[0].=".0"}
	}
	

}

print "<td bgcolor=#f5f5ff NOWRAP>&nbsp; $tmp[$x] &nbsp;</td>\n";
}



#show champions league
@tmp= split(/&/,$cl[$id]);

for ($x=0;$x<=9;$x++){
if ($x!=6){
$color = "#ccccff";

if ($champions{$team[$id]} eq $cl_org_label[9-$x]) { 
$color="#ff6666";
if (($rrunde-1) == (9-$x)){$color="#66ff66"}
}


print "<td class=c bgcolor=$color NOWRAP> $tmp[$x] </td>\n";
}}

#show uefa cup

@tmp= split(/&/,$ue[$id]);
for ($x=0;$x<=9;$x++){
$color = "#f5f5ff";
if ($uefa{$team[$id]} eq $ue_label[9-$x]) { 
$color="#ff6666";
if (($rrunde-1) == (9-$x)){$color="#66ff66"}
}

print "<td class=C bgcolor=$color NOWRAP> $tmp[$x] </td>\n";
}

#show country cup
@tmp= split(/&/,$po[$id]);
for ($x=0;$x<=5;$x++){
$color = "#ccccff";
if ($leaguecup{$team[$id]} == (6-$x)) { 
if ($leaguecup{$team[$id]} == $lp_schedule[$rrunde])
{$color="#66ff66";} else {$color="#ff6666"}

}

print "<td class=c bgcolor=$color NOWRAP> $tmp[$x] </td>\n";



}

print "<td bgcolor=#f5f5ff NOWRAP align=right> $points[$id]&nbsp;</td>\n";



print "</tr>";

}
}


print "</table>\n";
print "</td></tr></table>\n";

print "<br><br><font face=verdana size=1>Anmerkungen zur Statistik:
<br/>* Aus technischen Gruenden koennen derzeit nur TMI Vereine in der Statistik gelistet werden
<br/>* Europapokal- & Landespokaldaten umfassen alle Wettbewerbe seit der Saison 2000'3 ohne Beruecksichtigung der laufenden Saison
<br/>* Gruene Hinterlegung Pokalwettberbe: Erreichte Runde des Vereins in der aktuellen Saison, Verein weiterhin im Wettberwerb vertreten
<br/>* Rote Hinterlegung Pokalwettberbe: Erreichte Runde des Vereins in der aktuellen Saison, Verein aus dem Wettbewerb ausgeschieden
<br/>* Daten 1.Liga: Angabe zur durchschnittlichen Platzierung des Vereins in der 1.Liga des jeweiligen Landes sowie der Anzahl der gespielten Erstliga-Saisons
<br/><br/>
Punktesystem Vereinsranking:
<br/>* Platz 1 bis 5 in der Meisterschaft: 100, 70, 50, 30, 10 Punkte
<br/>* Titelgewinn bis Gruppenphase Champions League: 150, 100, 80, 60, 40, 20 Punkte
<br/>* Titelgewinn bis 3.Hauptrunde UEFA-Cup: 100, 70, 55, 40, 25, 10 Punkte
<br/>* Titelgewinn bis Viertelfinale Landespokal: 40, 25, 15, 10 Punkte
";
}
