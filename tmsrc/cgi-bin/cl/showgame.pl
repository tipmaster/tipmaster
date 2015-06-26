#! /usr/bin/perl

# This script is used to show a match with the tips of
# both and the current standings...

use lib '/tmapp/tmsrc/cgi-bin/';

use CGI;
use CLLibrary;
use CLTeam;
use TMSession;

$query = new CGI;
my $cllib = new CLLibrary();

$runde = $query->param('runde');
#$tipper_id = $query->param('id');
$game_nr = $query->param('game');
$uorc = $query->param('uorc');
$ids = $query->param('ids');

my @grptms = ();
%game = ();%tipgame = ();



# get the data of this game

if ($uorc eq "C") {$filename = "DATA_${runde}.DAT";} else
                  {$filename = "UEFA_${runde}.DAT";}

if ($uorc eq "C" && $runde =~ /G(\d)/) {
	@grptms = $cllib->readGroupInfo();
  
} else {
  open (G,"<$verz/$filename");
  while (<G>) {
    my $line = $_;
    chomp $line;
    ($lfd,$team1,$team2,$erg1,$erg2) = split(/&/,$line);
    if ($lfd eq $game_nr) {
      %game = (
	       lfd   => $lfd,
	       team1 => $team1,
	       team2 => $team2,
	       rnd   => $runde,
	       bewerb =>  $uorc,
	      );
      $game{lfd} = $lfd;
    }
  }
  close(G);
}
# display that game, read the tips in.
print $query->header;
print "<HTML><HEAD><TITLE>Spielansicht</TITLE>\n";
  
print &style,"\n";
  
print "</HEAD><BODY>\n";

print "<center>\n";
if ($tagplace) {
# Besten Dank , Thomas :-) !
require "$tagplace";
require "$tagplace2";
print "<br><br>";
}

if ($runde eq $derzeitige_runde && $tipabgabe_offen) {
  print "<H1> Die Tips k&ouml;nnen erst nach Schlie&szlig;ung der Tipabgabe eingesehen werden!</H1>";
} else {
  $formularerg = $cllib->readFormular($runde);
  if ($formularerg eq "no") {
    print "<H1> Das Tipformular f&uuml;r diese Runde liegt noch nicht vor</H1>\n";
  } else {
    &spielanzeige(\%game);
  }
}

print "</BODY></HTMl>\n";
exit 0;


sub spielanzeige {
  my $spiel = shift;
  $i1 = $spiel->{team1};$i2 = $spiel->{team2};
  if ($runde =~ /G(\d)/ && $uorc eq "C") {
    &printCLGame($ids);
  } elsif ($runde eq "FI") {
    &printCLFinale($i1,$i2);
  } else {
    &printAGame($i1,$i2,$uorc);
  }
}

sub printCLGame {
  my $ides = shift;
  ($id1, $id2) = split(/-/,$ides);

  print "<!-- in CLGame, $id1 $id2 $game_nr //-->\n";

  $team1 = $grptms[$id1]->team;
  $team2 = $grptms[$id2]->team;

  $name1 = $cllib->team2trainer("$team1");
  $name2 = $cllib->team2trainer("$team2");
  

  print "<table border=0 width=80%><tr align=right><td width=45%>\n";
  print "<font size=+2><b>$team1</b></font><br><font size=-2>$name1</font></td><td align=center width=10%>&nbsp; - &nbsp;</td><td align=left width=45%><font size=+2><b>$team2</b></font><br><font size=-2>$name2</font></td></tr>\n";
  $filename1 = "$verz/tips/${uorc}_${runde}_$id1.TIP";
  $filename2 = "$verz/tips/${uorc}_${runde}_$id2.TIP";
  print "<TR> <TD colspan=3 align=center>\n";

  if ($game_nr>3) {$game_nr-=3;}
#  $game_nr = 2-($game_nr % 2);  #Version for 3 rounds
 
  @tips1 = $cllib->getTipsFromFile($filename1,$game_nr);
  @tips2 = $cllib->getTipsFromFile($filename2,$game_nr);

  print "<!-- got tips from file $filename1, Game Nr. was $game_nr //-->\n";

  @tips1 = $cllib->fillTip(5,@tips1);
  @tips2 = $cllib->fillTip(4,@tips2);
  &printTipTable($team1,$team2,@tips1,@tips2);
  print "</TD></TR></table>\n";
 

}

sub printTipTable {
  $name1 = shift;
  $name2 = shift;
  my $ffv = "<font face=verdana size=+1>";
  my $ffvo = "</font>";

  my @tips1 = @_[0..4];
  my @tips2 = @_[5..8];
  if (@_[9]) {
    @tips2 = @_[5..9];
  }
  print "<!-- PrintTIpTable: @tips1 / @tips2 //-->\n";
  ($pkt1,$gamestring1) = $cllib->games($formularerg,@tips1);
  ($pkt2,$gamestring2) = $cllib->games($formularerg,@tips2);
 
  print "<br><TABLE border=0 width=50%>\n";
  #print "<TR> <TD align=right>$ffv<b> $name1 </b>$ffvo</TD> <TD align=center>-</TD> <TD align=left>$ffv<b> $name2 </b>$ffvo</TD></TR>\n";
  print "<TR><TD align=center colspan=3> ",$ffv,"<font size=+4>",$cllib->p2t($pkt1),":",$cllib->p2t($pkt2),"</font>",$ffv,"  &nbsp; [ $pkt1 - $pkt2 ] $ffvo<br></TD></TR>\n";
  print "<TR><TD colspan=3>&nbsp;</TD></TR>\n";
  print "<TR> <TD align=right> ",$ffv,$gamestring1,$ffvo,"</TD><TD align=center>&nbsp;</TD> <TD align=left>",$ffv,$gamestring2,$ffvo,"</TD></TR>\n";
  print "</table>\n";
}

sub printCLFinale {
  
  my $i1 = shift;
  my $i2 = shift;
  my $team1 = ""; my $team2 = "";

  if ($uorc eq "C") {
    $team1 = $cllib->id2team($i1);
    $team2 = $cllib->id2team($i2);
  } else {
    $team1 = $cllib->uid2team($i1);
    $team2 = $cllib->uid2team($i2);
  }
  
  $name1 = $cllib->team2trainer("$team1");
  $name2 = $cllib->team2trainer("$team2");
  
  
  print "<table border=0 width=90%><tr align=right><td width=45%>\n";
  print "<font size=+2 face=verdana><b>$team1</b></font><br><font face=verdana size=-2>$name1</font></td><td align=center width=10%>&nbsp; - &nbsp;</td><td align=left width=45%><font face=verdana size=+2><b>$team2</b></font><br><font face=verdana size=-2>$name2</font></td></tr>\n";
  
  
  
  $filename1 = "$verz/tips/${uorc}_${runde}_$i1.TIP";
  $filename2 = "$verz/tips/${uorc}_${runde}_$i2.TIP";
  
  print "<TR> <TD colspan=3 align=center>\n";
  @tips1 = $cllib->getTipsFromFile($filename1,1);
  @tips2 = $cllib->getTipsFromFile($filename2,1);
  print "<!-- Debug 1 Tips1: @tips1, Tips2: @tips2 //-->\n";
  @tips1 = $cllib->fillTip(5,@tips1);
  @tips2 = $cllib->fillTip(5,@tips2);
  &printTipTable($team1,$team2,@tips1,@tips2);
  print "</td></tr></table>\n";
  
}

sub printAGame {
  my $i1 = shift;
  my $i2 = shift;
  my $uorc = shift;
  my $team1 = ""; my $team2 = "";

  if ($uorc eq "C") {
    $team1 = $cllib->id2team($i1);
    $team2 = $cllib->id2team($i2);
  } else {
    $team1 = $cllib->uid2team($i1);
    $team2 = $cllib->uid2team($i2);
  } 
  
  $name1 = $cllib->team2trainer("$team1");
  $name2 = $cllib->team2trainer("$team2");
  
  
  print "<table border=0 width=80%><tr align=right><td width=45%>\n";
  print "<font size=+2><b>$team1</b></font><br><font size=-2>$name1</font></td><td align=center width=10%>&nbsp; - &nbsp;</td><td align=left width=45%><font size=+2><b>$team2</b></font><br><font size=-2>$name2</font></td></tr>\n";
  
  
  
  $filename1 = "$verz/tips/${uorc}_${runde}_$i1.TIP";
  $filename2 = "$verz/tips/${uorc}_${runde}_$i2.TIP";

  print "<TR> <TD colspan=3 align=center><br><br>Hinspiel</TD></TR>\n";
  
  print "<TR> <TD colspan=3 align=center>\n";
  print "<!-- Debug 1 Tips1: @tips1, Tips2: @tips2 File: $filename1 $filename2 //-->\n";

  @tips1 = $cllib->getTipsFromFile($filename1,1);
  @tips2 = $cllib->getTipsFromFile($filename2,2);
  print "<!-- Debug 2 Tips1: @tips1, Tips2: @tips2 //-->\n";
  @tips1 = $cllib->fillTip(5,@tips1);
  @tips2 = $cllib->fillTip(4,@tips2);
  print "<!-- Debug 3 Tips1: @tips1, Tips2: @tips2 //-->\n";
  &printTipTable($team1,$team2,@tips1,@tips2);
  print "</TD></TR><TR> <TD colspan=3 align=center><br><br>R&uuml;ckspiel</TD></TR>\n";
  print "<TR><TD colspan=3 align=center>\n";
  
  @tips1 = $cllib->getTipsFromFile($filename1,2);
  @tips2 = $cllib->getTipsFromFile($filename2,1);
  @tips2 = $cllib->fillTip(5,@tips2);
  @tips1 = $cllib->fillTip(4,@tips1);
  &printTipTable($team2,$team1,@tips2,@tips1);
  
  print "</td></tr></table>\n";
  
}


sub style {
  my $ret = "<STYLE TYPE=\"text/css\">\n<!--\n";
  $ret .= "TR.black {background:#AAAAAA;}\n";
  $ret .= "TR.bold {background:#99FF99;}\n";
  $ret .= "TR.grey {}\n";
  $ret .= "TR.lightgrey {background:#DDCCCC;}\n";
  $ret .= "TD.tga {font-size:11;}\n";
  $ret .= "//-->\n</STYLE>\n";
  return $ret;
}
