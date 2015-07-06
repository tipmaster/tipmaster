#! /usr/bin/perl

# Rundenansicht - Zeigt die Ergebnisse der uebergebenen Runde im Ueberblick an
# Verknuepfung zur Detail-Spielansicht moeglich.

use lib '/tmapp/tmsrc/cgi-bin/';

use CGI;
use CLLibrary;
use CLTeam;
use TMSession;

$query = new CGI;
print $query->header;

my $session = TMSession::getSession("tmi_login");
# if no session found, try a btm session
if (!$session) {
	$session = TMSession::getSession("btm_login");
}
my $cllib = new CLLibrary;
my $name = $session->getUser();

my @grptms = ();

$runde = $query->param('runde');
$id = $query->param('id');
$name = $query->param('name');
$uorc = $query->param('uorc');
$mynation = $query->param('nation');

my $debug = 0;

if (!$runde) {$runde = $derzeitige_runde;}
if (!$uorc) {$uorc = "C";}

$bewerb = "Champions League"; $curround = $CLLibrary::clrunde{$runde};
if ($uorc eq "U") {$bewerb = "UEFA-Cup"; $curround = $CLLibrary::uefarunde{$runde};}


print "<HTML><HEAD><TITLE>$bewerb $curround</TITLE>\n";

  

print &style,"\n";

print <<ENDSCR;
<script type="text/javascript">
function loadXMLDoc(box) {
			var gind = 'tipsrow'+box;
			var tipsRow = document.getElementById(gind);
		    tipsRow.style.display="table-row";

			// replace expand button by collapse button
			var buttonexp = 'expbutton'+box;
			var buttoncol = 'colbutton'+box;
			var buttone = document.getElementById(buttonexp).style.display="none";
			var buttonc = document.getElementById(buttoncol).style.display="inline";

}

function closeXMLDoc(box) {
			// replace collapse button by expand button
			var buttonexp = 'expbutton'+box;
			var buttoncol = 'colbutton'+box;
			var buttone = document.getElementById(buttonexp).style.display="inline";
			var buttonc = document.getElementById(buttoncol).style.display="none";

			// remove the cells
			var gind = 'tipsrow'+box;
			var clickedTableRow = document.getElementById(gind);
			clickedTableRow.style.display="none";
}

</script>
ENDSCR
print "</HEAD><BODY>\n";

## Insert Navigation here
print "<center>";
if ($tagplace) {
  # Besten Dank , Thomas :-) !
  require "$tagplace";
  require "$tagplace2";
  print "<br>";
}

#OK, first we find out whether a) it's only a list, b) games are running or c) results are displayed.
my $pagestatus = "list"; #list
my $headertitle = "Auslosung";
my $derzeitige_runde = $cllib->getCurrentCLRound();
my $tipabgabe_offen = $cllib->isFormularOpen();

print "<!--Status  derz: $derzeitige_runde   rund: $runde  TO: ",$tipabgabe_offen," //-->\n";

if ($derzeitige_runde eq $runde && !$tipabgabe_offen) {
	# find out if games are already over and results written
	  open(G,"<$CLLibrary::verz/UEFA_${runde}.DAT");
	  my $line = <G>;
	  ($lfd,$team1id,$team2id,$erg1,$erg2) = split(/&/,$line);
	  print "<!-- Debug Rundenermittliung Erg1 is $erg1 //-->\n"; 

	  if ($erg1 eq "-:-") {
		  $pagestatus = "running";
		  $headertitle = "Zwischenergebnisse";
	  } else {
		  $pagestatus = "final";
		  $headertitle = "Endergebnisse";
	  }
	  close(G);
}  else {
  if ($CLLibrary::rundenfolge{$derzeitige_runde}> $CLLibrary::rundenfolge{$runde}) {
	print "<!-- derzeitige runde: $derzeitige_runde,  runde: $runde //-->\n";
	  $pagestatus = "final";
          $headertitle = "Endergebnisse";
  }


  if ($CLLibrary::rundenfolge{$derzeitige_runde}<$CLLibrary::rundenfolge{$runde}) {
          $pagestatus = "list";
          $headertitle = "Auslosung";
  }

}

print "<H2><CENTER><font face=verdana>$bewerb <br>",$curround," <br>$headertitle</font></CENTER></H2><br>\n";
$cllib->printNavigation();
print "<br><br>\n";
$tim = time;
my $timeLeft = $cllib->getTimeLimit() - $tim;
my $daysLeft = int($timeLeft/(60*1440));
my $hoursLeft = ($timeLeft-$daysLeft*60*1440)/3600;
print "<!-- current Time is : $tim, TimeLeft: $timeLeft, TimeLimit is : $timeLimit. Diff is ",($timeLimit - $tim)/60,"  ";
printf "%2d",$daysLeft;print "d ";
printf "%.1f",$hoursLeft;print "h";
print " //-->\n";
# Ab hier abhaengig von der eingetragenen Runde und Wettbewerb
my $fileprefix = "UEFA";
if ($uorc eq "C") {
	$fileprefix = "DATA";
}

if ($uorc eq "C" && ($runde eq "G1" || $runde eq "G2" || $runde eq "G3")) {
    my %gruppe = ();
    @grptms = $cllib->readGroupInfo();
    
    print "<TABLE border=1 width=96% align=center>\n";
    # Zeige die GRUPPEN
    print "<TR><TH class=verd width=48% align=center><font size=2>Hinspiele</font></TH><TH class=verd width=48% align=center><font size=2>R&uuml;ckspiele</font></TH></TR>\n";
    for ($grp = 1; $grp <= 8; $grp++) {
      print "<!-- Print the cells for grp $grp //-->\n";
      print "<TR bgcolor=#EEEEEE><TD colspan=3 align=center><b><br><font face=Verdana> Gruppe ",chr($grp+64),"</font> </b></TD></TR>\n";
      $back = (($grp%2)*2)+66;
      print "<!-- back is : $back (",chr($back),")//-->\n";
      print "<TR><TD bgcolor=#",chr($back) x 6,">\n";
	  &printgames($grp,1);
      print "</TD><TD bgcolor=#",chr($back) x 6,">\n";
      &printgames($grp,2);
      print "</TD></TR><TR bgcolor=#EEEEEE><TD colspan=2 bgcolor=#",chr($back) x 6,">\n";
      &table($grp);
      print "</TD></TR>\n";
    }
    print "</TABLE>\n";
} else {
	# Normale Rundenansicht, Ergebnisliste
    print "<TABLE border=0 cellspacing=0 cellpadding=2 id=\"gamelist\" width=\"90%\">\n";
    open(G,"<$CLLibrary::verz/${fileprefix}_${runde}.DAT");
    while(<G>) {
      ($lfd,$team1id,$team2id,$erg1,$erg2) = split(/&/,$_);
      if ($runde ne "FI") {
                            my $filename1 = "$CLLibrary::verz/tips/${uorc}_${runde}_$team1id.TIP";
                            my $filename2 = "$CLLibrary::verz/tips/${uorc}_${runde}_$team2id.TIP";

			if ($pagestatus eq "running" or $pagestatus eq "final") {

				#ok. we calculate intermediate results!
				my $formularerg = $cllib->readFormular($runde);
				if ($debug) {  print "<!-- Home Debug 1 Tips1: @tips1, Tips2: @tips2 File: $filename1 $filename2 //-->\n";}
			    my @tips1 = $cllib->getTipsFromFile($filename1,1);
			    my @tips2 = $cllib->getTipsFromFile($filename2,2);
			    @tips1 = $cllib->fillTip(5,@tips1);
				@tips2 = $cllib->fillTip(4,@tips2);
				my $pkt1 = 0; my $pkt2 = 0;
				($pkt1,$gamestring1) = $cllib->games($formularerg,@tips1);
				($pkt2,$gamestring2) = $cllib->games($formularerg,@tips2);
				$erg1 = $pkt1.":".$pkt2;
	  
				  my @tips1 = $cllib->getTipsFromFile($filename1,2);
				  my @tips2 = $cllib->getTipsFromFile($filename2,1);
				  @tips1 = $cllib->fillTip(4,@tips1);
				  @tips2 = $cllib->fillTip(5,@tips2);
				  my $pkt1 = 0; my $pkt2 = 0;
				  ($pkt1,$gamestring3) = $cllib->games($formularerg,@tips1);
				  ($pkt2,$gamestring4) = $cllib->games($formularerg,@tips2);
				  $erg2 = $pkt1.":".$pkt2;

			}
			&printRow($lfd,$team1id,$team2id,$erg1,$erg2,$uorc,$pagestatus);
			if ($pagestatus eq "running" or $pagestatus eq "final") {
			  #and one more line for the result
			  print "<TR bgcolor=#",chr($back) x 6," id=\"tipsrow$lfd\" style=\"display:none\" align=\"center\"><TD colspan=\"7\">
			  <TABLE width=\"90%\">
  		   <TR>
			  <TD align=\"right\" class=\"tipgame\" width=\"47%\" id=\"tipscell${lfd}H1\">$gamestring1</TD><TD width=\"6%\">&nbsp;</TD>
			  <TD align=\"left\" class=\"tipgame\" width=\"47%\" id=\"tipscell${lfd}A1\">$gamestring2</TD></TR>
  		   <TR>
			  <TD align=\"right\" class=\"tipgame\" width=\"47%\" id=\"tipscell${lfd}H2\">$gamestring3</TD><TD width=\"6%\">&nbsp;</TD>
			  <TD align=\"left\" class=\"tipgame\" width=\"47%\" id=\"tipscell${lfd}A2\">$gamestring4</TD></TR>
			  
			  
			  </TABLE></TD></TR>\n";
			}
	  } else {
			&printFinale($team1id,$team2id,$erg1,$erg2,$uorc,$pagestatus);
      }
	}
	close(G);
	print "</TABLE>\n";
}
 

#Hier Schlussnavigation
print $cllib->form("login.pl"),"<br>\n";
print "<input type=hidden name=\"modus\" value=\"mainpage\">\n";
print "<input type=submit value=\"Zur&uuml;ck zur Europacup-Hauptseite\">\n";
print "</form><br>\n";
if ($pagestatus eq "list") {
print "<font face=verdana size=1>Jetzt neu mit Tipanzeige: <img src=\"/img/icons/other/greenmark.jpg\"/> Tip ist eingegangen, <img src=\"/img/icons/other/redmark.jpg\"/> Tip steht noch aus</font>\n"; 
}
print "</CENTER></BODY></HTML>\n";


##### Hilfsskripte

sub printRow {
  (my $lfd, my $team1id, my $team2id, my $erg1, my $erg2, my $uor, my $pagestatus) = @_;
	
  if ($uorc eq "C") {

    $team1 = $cllib->id2team($team1id);
    $nat1 = $cllib->id2nat($team1id);
    $nat1 =~ s/_.+//;
    
    if ($team2id ne "FREILOS") {
      $team2 = $cllib->id2team("$team2id");
      $nat2 = $cllib->id2nat("$team2id");
      $nat2 =~ s/_.+//;
    } else {
      $team2 = "FREILOS";
      $nat2 = 119;
    }

  } elsif ($uor eq "U") {
    $team1 = $cllib->uid2team("$team1id");
    $nat1 = $cllib->uid2nat("$team1id");
    $nat1 =~ s/_.+//;
    
    if ($team2id ne "FREILOS") {
      $team2 = $cllib->uid2team("$team2id");
      $nat2 = $cllib->uid2nat("$team2id");
      $nat2 =~ s/_.+//;
    } else {
      $team2 = "FREILOS";
      $nat2 = 119;
    }

  } else {
    die "Falscher UORC\m";
  }

  # determine who has won:
  ($winner,$hinspiel,$rueckspiel,$decision) = $cllib->whowins($erg1,$erg2);
		  $hi2 = "";$hi2z = "";
		  $hi1 = "";$hi1z = "";

  $colres = "";
  if ($pagestatus eq "final") {
		  if ($winner==1) {
		    $hi1 = "<B>";$hi1z = "</B>";
		  } elsif ($winner==2) {
		    $hi2 = "<B>";$hi2z = "</B>";
		  }
  } else {
	  #blank it
	  $decision = "";
	  $winner = 0;
	  #make result red.
	  $colres = " color=red";


  }
  my $tipda1 = ""; my $tipda2 = "";
  if ($pagestatus eq "list") {
	# Tip schon da?
	($tipda1,$tipda2) = $cllib->tipda($uorc,$runde,$team1id,$team2id);
  }
  $col1 = "";$col1z = "";$col2 = ""; $col2z = "";


  if ($mynation == $nat1) {
    $col1 = "<FONT color=green>"; $col1z = "</FONT>";
  } elsif ($mynation == $nat2) {
    $col2 = "<FONT color=green>"; $col2z = "</FONT>";
  }
#  print "<!-- Compare $mynation $nat1 / $nat2: col1: $col1, col2: $col2//-->\n";

  if ($team1id == $id) {
    $col1 = "<FONT color=red>"; $col1z = "</FONT>";
  } elsif ($team2id == $id) {
    $col2 = "<FONT color=red>"; $col2z = "</FONT>";
  }

  $name1 = $cllib->team2trainer("$team1");
  $name2 = $cllib->team2trainer("$team2");

## Buildin a separate window launcher for tip sheet

  $back = (($lfd%2)*2)+68;

############### FLAGGEN DATEINAME ERMITTELN ######################################
my $flag = lc($CLLibrary::nation[$nat1]);
$flag=~s/cze/tch/;$flag=~s/rom/rum/; $flag=~s/hun/ung/; $flag=~s/cyp/zyp/; $flag=~s/azb/ase/; $flag=~s/far/fae/; $flag=~s/mak/maz/;
$flag=~s/sma/sam/;$flag=~s/bhz/boh/;$flag=~s/cro/kro/;$flag=~s/gre/gri/;   
my $flag1 = $flag ;

$flag = lc($CLLibrary::nation[$nat2]);
$flag=~s/cze/tch/;$flag=~s/rom/rum/; $flag=~s/hun/ung/; $flag=~s/cyp/zyp/; $flag=~s/azb/ase/; $flag=~s/far/fae/; $flag=~s/mak/maz/;
$flag=~s/sma/sam/;$flag=~s/bhz/boh/;$flag=~s/cro/kro/;$flag=~s/gre/gri/;
my $flag2 = $flag ;
###################################################################################

#addon tp 04-09-02
my $team1_id=$team1;$team1_id=~s/ /%20/g;
my $team2_id=$team2;$team2_id=~s/ /%20/g;
my $coach1_id=$name1;$coach1_id=~s/ /%20/g;
my $coach2_id=$name2;$coach2_id=~s/ /%20/g;
my $dest1="tmi";my $dest2="tmi";
if ( $CLLibrary::nation[$nat1] eq "GER" ) { $dest1="btm" }
if ( $CLLibrary::nation[$nat2] eq "GER" ) { $dest2="btm" }


  print "<TR bgcolor=#",chr($back) x 6," id=\"gamerow$lfd\"><TD align=right><font face=verdana size=2> &nbsp; $col1 $hi1 <a href=/cgi-mod/$dest1/verein.pl?ident=$team1_id>$team1</a>  (",$CLLibrary::nation[$nat1],")$hi1z $col1z</font><br><font face=verdana size=1><a href=/cgi-mod/$dest1/trainer.pl?ident=$coach1_id>$name1</a>$tipda1</font></TD><TD align=center> &nbsp; <img src=/img/flags/$flag1.jpg> - <img src=/img/flags/$flag2.jpg> &nbsp; </TD><TD align=left><font face=verdana size=2>$col2 $hi2 <a href=/cgi-mod/$dest2/verein.pl?ident=$team2_id>$team2</a> (",$CLLibrary::nation[$nat2],") $hi2z $col2z</font><br><font face=verdana size=1>$tipda2<a href=/cgi-mod/$dest2/trainer.pl?ident=$coach2_id>$name2</a></font></TD>\n";
  if ($team2 ne "FREILOS" && !($pagestatus eq "list")) {
    $tiplink = "<img id=\"expbutton$lfd\" src=\"$CLLibrary::images/expand.gif\" onClick=\"loadXMLDoc($lfd)\" border=0>".
	           "<img id=\"colbutton$lfd\" src=\"$CLLibrary::images/collapse.gif\" onClick=\"closeXMLDoc($lfd)\" border=0 style=\"display:none\">";
  } else {$tiplink = "&nbsp;" ;
    $hinspiel = ""; $rueckspiel = "";
}
    
  print "<TD><font face=verdana size=2 $colres>$hinspiel</font></TD><TD><font face=verdana size=2 $colres>&nbsp;$rueckspiel</font></TD><TD align=center><font face=verdana size=2>&nbsp;$decision</font></TD><TD><font face=verdana size=2>&nbsp; $tiplink &nbsp;</font></TD></TR>\n";
  

}


sub printFinale {
  (my $team1id, my $team2id, my $erg1, my $erg2, my $uorc) = @_;
  
   if ($uorc eq "C") {
    $team1 = $cllib->id2team("$team1id");
    $nat1 = $cllib->id2nat("$team1id");
    $team2 = $cllib->id2team("$team2id");
    $nat2 = $cllib->id2nat("$team2id");
  } else {
    $team1 = $cllib->uid2team("$team1id");
    $nat1 = $cllib->uid2nat("$team1id");
    $team2 = $cllib->uid2team("$team2id");
    $nat2 = $cllib->uid2nat("$team2id");
  }


  $nat1 =~ s/_.+//;
  $nat2 =~ s/_.+//; 
  # determine who has won:
  ($winner,$hinspiel,$rueckspiel,$decision) = $cllib->whowins($erg1,$erg2);
##special
#if ($uorc eq "C") {
#  $erg1 = "- : -";
#  $decision = "Wiederholungsspiel!";
#  $tipabgabe_offen = 0;
#  print "<!-- spec //-->\n";
#}
  if ($erg1 =~ /(\-?\d+):(\-?\d+)/) {
    print "<!-- Decision made //-->\n";

    $p1 = $1; $p2 = $2;
    if ($p1 >= $p2) {
      $winner = 1;
    } else {
      $winner = 2;
    }
    $hinspiel = "<b> ".$cllib->p2t($p1)." : ".$cllib->p2t($p2)."</b> ($p1 - $p2)";
    if ($cllib->p2t($p1) == $cllib->p2t($p2)) {
      if ($winner == 1) {
	$decision = eval($cllib->p2t($p1)+1) . " : " . $cllib->p2t($p2) . " n.V.";
      } else {
	$decision = $cllib->p2t($p1) . " : " . eval($cllib->p2t($p2)+1) . " n.V.";
      }
    }
 
  } else {
    print "<!-- No decision yet //-->\n";
    $winner = 0;
    $hinspiel = "- : -";
  }
   my $tipda1 = ""; my $tipda2 = "";
  if ($pagestatus eq "list") {
        # Tip schon da?
        ($tipda1,$tipda2) = $cllib->tipda($uorc,$runde,$team1id,$team2id);
  }
 
  
  $hi2 = "";$hi2z = "";
  $hi1 = "";$hi1z = "";
  	
  if ($winner==1) {
    $hi1 = "<B>";$hi1z = "</B>";
  } elsif ($winner==2) {
    $hi2 = "<B>";$hi2z = "</B>";
  }

  $col1 = "";$col1z = "";$col2 = ""; $col2z = "";
  if ($team1id == $id) {
    $col1 = "<FONT color=red>"; $col1z = "</FONT>";
  } elsif ($team2id == $id) {
    $col2 = "<FONT color=red>"; $col2z = "</FONT>";
  }

  $name1 = $cllib->team2trainer("$team1");
  $name2 = $cllib->team2trainer("$team2");

  print "<TR><TD align=right><font face=verdana size=2>$col1 $hi1 $team1 (",$CLLibrary::nation[$nat1],")$hi1z $col1z<br><font size=1>$name1 $tipda1</font></TD><TD align=center> - </TD><TD align=left><font face=verdana size=2>$col2 $hi2 $team2 (",$CLLibrary::nation[$nat2],") $hi2z $col2z<br><font size=1>$tipda2 $name2</font></TD>\n";
print "<!-- $derzeitige_runde -- $runde -- ",$tipabgabe_offen," -->\n";
  if ($team2 ne "FREILOS" && !($derzeitige_runde eq $runde && $tipabgabe_offen)) {
    $tiplink = "<a href=\"$CLLibrary::cgiverz/showgame.pl?runde=$runde&uorc=$uorc&game=$lfd\">Tips</a>";
  } else {$tiplink = "&nbsp;"}
    
  print "<TD><font face=verdana size=2>$hinspiel</font></TD><TD>&nbsp;</TD><TD align=center><font face=verdana size=2>$decision</font></TD><TD>&nbsp;<font face=verdana size=2> $tiplink </font>&nbsp;</TD></TR>\n";
 if ($uorc eq "C" and $sondermessage eq 1) {
	print "<TR><TD align=center colspan=5><font face=verdana size=1>Coventry City nach EC-Regeln zum Sieger erkl&auml;rt</TD></TR>\n";
}
}


  # show the games of a round
# go on formatting

sub printgames {
  my $grp = shift;
  my $horr = shift;
  print "<TABLE border=0 width=100%>\n";

  
  for (my $sptag = $horr*3-2; $sptag <= $horr*3; $sptag++) {
    for ($s = 1; $s <= 2; $s++) {
      (my $k1, my $k2) = $cllib->getSlot($sptag,$s);
      #print "<!-- Hashval: ",$grptms[($grp-1)*4+$k1-1]," //-->\n";
      my $heim = $grptms[($grp-1)*4+$k1-1];
      my $gast = $grptms[($grp-1)*4+$k2-1];
      $erg = $heim->showerg($sptag);
      my $currlfdround = 3;
      if ($derzeitige_runde =~ /G(\d)/) {
	$currlfdround = $1;
      } 
#      if (!$tipabgabe_offen || $sptag<($currlfdround*2-1)) {   # Version for 3 Rounds
      if (!$tipabgabe_offen || $sptag<=($currlfdround*3-3)) {
	$spcnt = (($sptag-1)*2)+$s;
	$formnr = int(($sptag-1)/3)+1;
	$tiplink = "<a href=\"$CLLibrary::cgiverz/showgame.pl?uorc=C&runde=G${formnr}&game=$sptag&ids=".$heim->id."-".$gast->id."\"><img border=0 src=\"$CLLibrary::images/ti.jpg\"></a>";
      } else {
	$tiplink = "&nbsp;";
      }      

      print "<tr><td width=70%><font face=verdana size=1> ",$heim->team," - ",$gast->team,"</font></td><td width=25%><font face=verdana size=1>$erg</font></td><td width=5% align=center>$tiplink</td></tr>\n";
    }
  }
  print "</TABLE>\n";
}

sub table {
  my $grp = shift;
  my @teams = @grptms[($grp-1)*4..$grp*4-1];
  my @sorteams = sort {$cllib->compare2teams($b,$a)} @teams;

  print "<table width=100%>\n";
  for ($rnk=1;$rnk<=4;$rnk++) {
    my $teama = $sorteams[$rnk-1];
    my $theteam = $teama->{TEAM};
    my $thename = $cllib->team2trainer("$theteam");
    my $nat1 = $cllib->id2nat($teama->{ID});

my $flag = lc($CLLibrary::nation[$nat1]);
$flag=~s/cze/tch/;$flag=~s/rom/rum/; $flag=~s/hun/ung/; $flag=~s/cyp/zyp/; $flag=~
s/azb/ase/; $flag=~s/far/fae/; $flag=~s/mak/maz/;
$flag=~s/sma/sam/;$flag=~s/bhz/boh/;$flag=~s/cro/kro/;$flag=~s/gre/gri/;
my $flag1 = "<img src=/img/flags/$flag.jpg>";
    print "<tr><td width=13%>&nbsp;</td><td width=5%><font face=verdana size=2>${rnk}.</font></td><td witdh=6%>$flag1</td><td width=25%><font face=verdana size=2><b> $theteam</b></font></td><td width=20%> <font face=verdana size=1> $thename </font></td><td width=12%><font face=verdana size=2>",$teama->{PT},":",$teama->{MT}," </font></td><td width=6%><font face=verdana size=2>",$teama->{PP},"</font> </td><td width=13%>&nbsp;</TD></tr>\n";
  }
  print "</table>\n";

}





sub form {
  $scriptname = shift;
  my $ret = "<FORM name=bla action=\"$CLLibrary::cgiverz/$scriptname\" method=post>\n";
  $ret = "$ret <input type=hidden name=\"name\" value=\"$name\">\n";
  $ret = "$ret <input type=hidden name=\"sessionkey\" value=\"$sessionkey\">\n";
  $ret = "$ret <input type=hidden name=\"runde\" value=\"$derzeitige_runde\">\n";
  return $ret;
}


sub style {
  my $ret = "<STYLE TYPE=\"text/css\">\n";
  $ret .= "TH.verd {font-family:verdana; font-size:3}\n";
  $ret .= "TR.black {background:#AAAAAA;}\n";
  $ret .= "TR.bold {background:#99FF99;}\n";
  $ret .= "TR.grey {}\n";
  $ret .= "TR.lightgrey {background:#DDCCCC;}\n";

$ret .=' 
          A:link {text-decoration: none; color:#00007F;}
          A:visited {text-decoration: none; color:#00007F;}  
          A:active {text-decoration: none; color:#00007F;}
          A:hover {text-decoration: none; color:blue;} 
'; 

$ret .= "TD.tipgame {font-family:monospace; font-size:16px;}\n";
$ret .= "TD.tga {font-family:Verdana; font-size:10px;}\n";

  $ret .= "\n</STYLE>\n";
  return $ret;
}

