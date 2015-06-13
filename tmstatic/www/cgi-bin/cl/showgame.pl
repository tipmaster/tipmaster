#! /usr/bin/perl

# This script is used to show a match with the tips of
# both and the current standings...

use CGI;
use Clteam;

do 'library.pl';

$query = new CGI;

$runde = $query->param('runde');
#$tipper_id = $query->param('id');
$game_nr = $query->param('game');
$uorc = $query->param('uorc');
$ids = $query->param('ids');

@grptms = ();
%game = ();%tipgame = ();



# get the data of this game

if ($uorc eq "C") {$filename = "DATA_${runde}.DAT";} else
                  {$filename = "UEFA_${runde}.DAT";}

if ($uorc eq "C" && $runde =~ /G(\d)/) {
  open (G,"<$verz/$filename");
  while (<G>) {
    my $line = $_;
    chomp $line;
    if ($line =~ /^(\d+)\&(\d+)\&(\d+)/) {
      (my $grp, my $slot,my $id,my @gms) = split(/&/,$line);
      my $cteam = Clteam->new();
      $cteam->slot($slot);
      $cteam->id($id);
      $cteam->team( $id2team{"$id"} );
      $cteam->games( join("&",@gms) );
      #print "<!-- Reference for $grp/$slot is ",$cteam," //-->\n";
      $grptms[$id] = $cteam;
    }
  }
  close(G);
  
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
  $formularerg = &readFormular($runde);
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

  $name1 = $team2trainer{"$team1"};
  $name2 = $team2trainer{"$team2"};
  

  print "<table border=0 width=80%><tr align=right><td width=45%>\n";
  print "<font size=+2><b>$team1</b></font><br><font size=-2>$name1</font></td><td align=center width=10%>&nbsp; - &nbsp;</td><td align=left width=45%><font size=+2><b>$team2</b></font><br><font size=-2>$name2</font></td></tr>\n";
  $filename1 = "$verz/tips/${uorc}_${runde}_$id1.TIP";
  $filename2 = "$verz/tips/${uorc}_${runde}_$id2.TIP";
  print "<TR> <TD colspan=3 align=center>\n";

  if ($game_nr>3) {$game_nr-=3;}
#  $game_nr = 2-($game_nr % 2);  #Version for 3 rounds
 
  @tips1 = &getTipsFromFile($filename1,$game_nr);
  @tips2 = &getTipsFromFile($filename2,$game_nr);

  print "<!-- got tips from file $filename1, Game Nr. was $game_nr //-->\n";

  @tips1 = fillTip(5,@tips1);
  @tips2 = fillTip(4,@tips2);
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
  ($pkt1,$gamestring1) = &games($formularerg,@tips1);
  ($pkt2,$gamestring2) = &games($formularerg,@tips2);
 
  print "<br><TABLE border=0 width=50%>\n";
  #print "<TR> <TD align=right>$ffv<b> $name1 </b>$ffvo</TD> <TD align=center>-</TD> <TD align=left>$ffv<b> $name2 </b>$ffvo</TD></TR>\n";
  print "<TR><TD align=center colspan=3> ",$ffv,"<font size=+4>",p2t($pkt1),":",p2t($pkt2),"</font>",$ffv,"  &nbsp; [ $pkt1 - $pkt2 ] $ffvo<br></TD></TR>\n";
  print "<TR><TD colspan=3>&nbsp;</TD></TR>\n";
  print "<TR> <TD align=right> ",$ffv,$gamestring1,$ffvo,"</TD><TD align=center>&nbsp;</TD> <TD align=left>",$ffv,$gamestring2,$ffvo,"</TD></TR>\n";
  print "</table>\n";
}

sub printCLFinale {
  
  my $i1 = shift;
  my $i2 = shift;
  my $team1 = ""; my $team2 = "";

  if ($uorc eq "C") {
    $team1 = $id2team{$i1};
    $team2 = $id2team{$i2};
  } else {
    $team1 = $uid2team{$i1};
    $team2 = $uid2team{$i2};
  }
  
  $name1 = $team2trainer{"$team1"};
  $name2 = $team2trainer{"$team2"};
  
  
  print "<table border=0 width=90%><tr align=right><td width=45%>\n";
  print "<font size=+2 face=verdana><b>$team1</b></font><br><font face=verdana size=-2>$name1</font></td><td align=center width=10%>&nbsp; - &nbsp;</td><td align=left width=45%><font face=verdana size=+2><b>$team2</b></font><br><font face=verdana size=-2>$name2</font></td></tr>\n";
  
  
  
  $filename1 = "$verz/tips/${uorc}_${runde}_$i1.TIP";
  $filename2 = "$verz/tips/${uorc}_${runde}_$i2.TIP";
  
  print "<TR> <TD colspan=3 align=center>\n";
  @tips1 = &getTipsFromFile($filename1,1);
  @tips2 = &getTipsFromFile($filename2,1);
  print "<!-- Debug 1 Tips1: @tips1, Tips2: @tips2 //-->\n";
  @tips1 = fillTip(5,@tips1);
  @tips2 = fillTip(5,@tips2);
  &printTipTable($team1,$team2,@tips1,@tips2);
  print "</td></tr></table>\n";
  
}

sub printAGame {
  my $i1 = shift;
  my $i2 = shift;
  my $uorc = shift;
  my $team1 = ""; my $team2 = "";

  if ($uorc eq "C") {
    $team1 = $id2team{$i1};
    $team2 = $id2team{$i2};
  } else {
    $team1 = $uid2team{$i1};
    $team2 = $uid2team{$i2};
  } 
  
  $name1 = $team2trainer{"$team1"};
  $name2 = $team2trainer{"$team2"};
  
  
  print "<table border=0 width=80%><tr align=right><td width=45%>\n";
  print "<font size=+2><b>$team1</b></font><br><font size=-2>$name1</font></td><td align=center width=10%>&nbsp; - &nbsp;</td><td align=left width=45%><font size=+2><b>$team2</b></font><br><font size=-2>$name2</font></td></tr>\n";
  
  
  
  $filename1 = "$verz/tips/${uorc}_${runde}_$i1.TIP";
  $filename2 = "$verz/tips/${uorc}_${runde}_$i2.TIP";

  print "<TR> <TD colspan=3 align=center><br><br>Hinspiel</TD></TR>\n";
  
  print "<TR> <TD colspan=3 align=center>\n";
  print "<!-- Debug 1 Tips1: @tips1, Tips2: @tips2 File: $filename1 $filename2 //-->\n";

  @tips1 = &getTipsFromFile($filename1,1);
  @tips2 = &getTipsFromFile($filename2,2);
  print "<!-- Debug 2 Tips1: @tips1, Tips2: @tips2 //-->\n";
  @tips1 = fillTip(5,@tips1);
  @tips2 = fillTip(4,@tips2);
  print "<!-- Debug 3 Tips1: @tips1, Tips2: @tips2 //-->\n";
  &printTipTable($team1,$team2,@tips1,@tips2);
  print "</TD></TR><TR> <TD colspan=3 align=center><br><br>R&uuml;ckspiel</TD></TR>\n";
  print "<TR><TD colspan=3 align=center>\n";
  
  @tips1 = &getTipsFromFile($filename1,2);
  @tips2 = &getTipsFromFile($filename2,1);
  @tips2 = fillTip(5,@tips2);
  @tips1 = fillTip(4,@tips1);
  &printTipTable($team2,$team1,@tips2,@tips1);
  
  print "</td></tr></table>\n";
  
}

sub games_local {
  my @tips = @_;
  my $pts = 0;
  $ret = "<TABLE BORDER=0 cellpadding=0 cellspacing=0>\n";
  for (1..25) {
    my $lfd = $_;
    print "<!-- Lfd ist: $lfd, Tip ist $guess game is $tipgame{$lfd}{match}//-->\n";
  }
  foreach $a_tip (@tips) {
    $class = "";
    ($lfd,$guess) = split(/_/,$a_tip);
    $lfd+=10;

    if ($tipgame{$lfd}{erg} == 9) {
      $pts+=10;
      $printpts = 10;
      $class = "lightgrey";
    } else {
      $printpts = $tipgame{$lfd}->{$guess};
      $class = "black";
    }   

    if ($tipgame{$lfd}{erg} == $guess) {
      $pts+=$tipgame{$lfd}->{$guess};
      $class = "bold";
    } elsif ($tipgame{$lfd}{erg} == 3) {
      $class = "grey";
    }
    print "<!-- Lfd ist: $lfd, Tip ist $guess game is $tipgame{$lfd}{match}//-->\n";
    if ($guess != 5) {
      $ret .= "<TR class=\"$class\"><TD>&nbsp;".$tipgame{$lfd}{match}."&nbsp;</TD><TD>&nbsp;$guess&nbsp;</TD><TD>&nbsp;( $printpts ) &nbsp;</TD></TR>\n";
    } else {
      $ret .= "<TR><TD colspan=3> ----- Kein Tip abgegeben ----- </TD></TR>\n";
    }
  }
  if ($#tips == 3) {
    $ret .= "<TR><TD colspan=3> &nbsp; </TD></TR>\n";
  }
  $ret .= "</TABLE>\n";

  return ($pts,$ret);
}


# extract tip numbers from tipfile
sub getTipsFromFile {
  my $filename = shift;
  my $tipno = shift;
  my @tips = ();
  
  # iterate over tokens and look for tipno
  if (-e $filename) {
    open (G,"<$filename");
    $spstring = <G>;
    chomp $spstring;
    close(G);
    my @t = split(/&/,$spstring);
    for (1..25) {
      (my $spnum,my $erg) = split(/_/,$t[$_]);
	#print "Hit $t[$_] on searching $tipno => $erg<br>\n";
      if ($spnum == $tipno) {
	push @tips,"${_}_$erg";
      }
    }
    print "<!-- Returning from $filename: @tips //-->\n";
    return @tips;
  } else {
    return ();
  }
}

sub readFormular {
  my $runde = shift;

  #dummy-eintrag.
  $tipgame{10}{match} = "Kein Tip abgegeben";
  $tipgame{10}{erg} = 8;

  $formularname = "$verz/formular${runde}.txt";
  if (!-e $formularname) {return "no";}
  open(G,"<$formularname") or die "Cannot open formular $formularname: $!";
  $lfd = 10;
  while(<G>) {
    $line = $_;
    if ($line =~ /4&(a.*?)&/) {
	my $subst = $1;
      $line =~ s/$subst/_ : _/;
      $line =~ s/abge./_ : _/;
      $line =~ s/ausg./_ : _/;
    }

    if ($line =~ /&(.*?)&(\d+)&(\d+)&(\d+)&(\d)&(\d|_) ?(:|\-) ?(\d|_)&/ ) {
      $lfd++;
      $tipgame{$lfd}{match} = $1;
      $tipgame{$lfd}->{1}  = $2;
      $tipgame{$lfd}->{0}  = $3;
      $tipgame{$lfd}->{2}  = $4;
      print "<!-- Now checking $1, lfd $lfd, Eingetragen $5, $6, $7&nbsp;\n";
      if ($5 < 4) {
	if ($6>$8) { $tipgame{$lfd}->{erg} = 1;}
	if ($6==$8) {$tipgame{$lfd}->{erg} = 0;}
	if ($6<$8) { $tipgame{$lfd}->{erg} = 2;}
	if ($6 eq "_") {$tipgame{$lfd}->{erg} = 3;}
      } else {
	$tipgame{$lfd}->{erg} = 9;
      }
      #print "Result: ",$tipgame{$lfd}->{erg},"//-->\n";
    }
  }
  close(G);
  for (1..35) {
	
    my $lfd = $_;
    print "<!-- Read: ist: $lfd, Tip ist $guess game is $tipgame{$lfd}{match}//-->\n";
  }
  
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
