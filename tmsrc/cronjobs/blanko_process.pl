#!/usr/bin/perl

use Date::Calc qw(:all);
use TMSession;
@prognosen = ("","Heimsiege","Remis","Auswaertssiege");

sub getHtmlBlankotip()
{
$verb = "aktivieren";
$trainer = shift;
$html = "
<br/><br/>
<table border=0 cellpadding=5 cellspacing=5 bgcolor=#eeeeff>
<tr>
<td> <img src=/img/sonnenschirm.gif width=100 heigth=100> </td>
<td width=10 />
<td align=left><font face=verdana size=1><b>Urlaubstipp</b> - Sie haben ueber einen bestimmten Zeitraum - bspw. urlaubsbedingt - keine Moeglichkeit Ihren Tipp abzugeben ?<br>
 Dann benuetzen Sie fuer diesen Zeitraum bitte unseren Blanko - Tipp Service um eine Entlassung zu verhindern.<br>
 Ein Blankotipp ist jeweils fuer 30 Tage aktiv und tippt fuer Sie in diesem Zeitraum automatisiert und zufallsbasiert (>> <a href=/Regeln.shtml#blankotipp target=_new>Details</a> ).
 <br><br>
 
 
 <b>Aktueller Status</b> - 
 ".
 &checkForBlankotip($trainer);
 
 
 $html.=
 "
 <br><br>
 <b>Aktion</b> - 
 <a href=javascript:document.blanko1.submit()>Zufallsbasierten Blankotipp $verb</a> &nbsp; &nbsp;  
 
 </td>
</tr></table>
 

";

return $html;
}



sub checkForBlankotip()
{
	$myhtml = "";
 	$trainer = shift;

	$currentime = time();
	@datav = &getBlankoTime($trainer);
	$myblankotime = $datav[0];
	$myprognose = $datav[1];

	
	if ( $myblankotime == 0)
	{
		$myhtml = "Im Moment ist kein Blankotipp f&uuml;r ihren Account aktiviert. Tipp: Aktive Blankotipps eignen sich unter<br>anderem auch als R&uuml;ckfallversicherung um eine Entlassung durch zwei in Folge vergessene Tippabgaben zu verhindern. ";
	}
	
	if ( $myblankotime > 0)
	{
		($year,$month,$day, $hour,$min,$sec) = Time_to_Date($myblankotime);
		if ($min<10){$min1="0"}

		$myhtml = "<font color=green>Zufallsbasierter Blankotipp aktiv bis $day.$month.$year $hour:$min1$min. Eine regul&auml;re Tippabgabe &uuml;berschreibt ihren Blankotipp.<font color=black>";
		$verb = "auffrischen";
	}
	
	return $myhtml;
}


sub alterBlankoTip
{
	$method = shift;
	$tmp = shift;
	$pro = shift;
	my $flag=0;
	
	$trainer = TMSession::getSession()->getUser();
	
	$zeile=0;
	open(A,"/tmdata/blanko.txt");
	while(<A>)
	{
		$zeilen[$zeile]=$_;
		$zeile++;
	}
	close(A);
	
	
	open(B,">/tmdata/blanko.txt");
	foreach(@zeilen)
	{
	@datav = split(/&/,$_);
	if ($datav[0] eq $trainer && $method eq "add")
		{
		$flag1=1;
		#30 days
		$time = time()+(60*60*24*30);
		print B $trainer.'&'.$time.'&'.$pro."\n";
		}
	else
		{
		print B $_;
		}
	}	
	if ($flag == 0)
	{
                $time = time()+(60*60*24*30);
                print B $trainer.'&'.$time.'&'.$pro."\n";


	}
	close(B);

}

sub getBlankoTime
{
	$tmp = shift;
	
	$content = shift;
	$blankotime = 0;
	$pro = 0;

	open(A,"/tmdata/blanko.txt");
	while(<A>)
	{
		if ($_ =~ /^$tmp&/)
		{
			@datav = split(/&/,$_);
			$blankotime = $datav[1];
			$pro = $datav[2];
		}
	}
	close(A);

	$datav[0] = $blankotime;
	$datav[1] = $pro;

	return @datav;
}

sub blanko()
{
&alterBlankoTip("add",$trainer,$prognose);
}

sub checkIfBlankoTipIsOutdated()
{
	$date = shift;
	$current_time = time();
	$diff = $date - $current_time;
	return ($date>$current_time) ? 1 : 0;
}
    

1;
