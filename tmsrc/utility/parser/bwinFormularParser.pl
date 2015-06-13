#!/usr/bin/perl


#use HTML::TreeBuilder::XPath;
#use XML::XPath;
#use XML::XPath::XMLParser;

sub parseBetbrain() {
    my $filePath = shift;
    my $outputFile = shift;
    my $leagueSelection = shift;
    my @streams = ();
	my $goodDatesRef = &getGoodDates();
	my $goodLeaguesRef = &getGoodLeagues($leagueSelection);
	my $lastHeader = "";
	my $inGoodDay = 0; 
	my $lin_q = "";
	my $league = 0;
	my $c_time = "";
	print "LeagueSelection: $leagueSelection, Looking in $filePath<br> \n";
        #Read in the File
        open(K,"<$filePath") or die "Cannot read quotes file: $!";
        while(<K>) {
			my $line = $_;
			## maybe the last match line is in $lin_q. then we take that one.
	#		print "lin_q is $lin_q <br>\n";
	#		if ($lin_q =~ /\-/) {
	#			print "Took line from last cycle: $lin_q <br>\n";
#					$line = $lin_q;
#			}

			#print "Line: $line<br>\n";

			if ($line =~ /^\s*(.*?) - (.*?)\s*$/) {
			#	print "Match line: $line<br>\n";
				# maybe we caught a duel now.
				my @flds = split(/\s+\-\s+/,$line);
				if (length $flds[1] > 0) {
#					print "Successful Split: ",$flds[0]," - ",$flds[1],"\n";
					($league, my $t1) = &translate_team($flds[0]);
					(undef, my $t2) = &translate_team($flds[1]);

					$match = $t1 . " - " . $t2;
				} else {
					next;
				}
				# now we look for the date.

				$line = <K>;
#				print "Date line is: $line\n";
				if ($line =~ /^\s*(\d\d\/\d\d\/1\d)\s*(\d+:\d+)\s*.*$/) {
					my $date = $1;
					$c_time = $2;
					print "Got date: $date , Time: $c_time<br>\n";
					if ($date =~ /(\d+)\/(\d+)\/(1\d)/) {
	
						#it is the date
						$curr_date = $1.".".&processMonth($2).".".&processYear($3); 
#						print "Testing $curr_date in dateref\n";
						if ($$goodDatesRef{$curr_date}) {
							$inGoodDay = 1;
						} else {
							$inGoodDay = 0;
						}	
	#					print "inGoodDay is ",$inGoodDay,"\n";
					} else {
						#no date found
						print "No date found. continue.\n";
						next;
					}
				}

				if ($inGoodDay) {
					my $leagueID = 0;

						#take 3 lines, see if it is 3 quotes.
						my $qf = 0;
						my @q = ();
						$lin_q = <K>;
	#					print "Analyze Quote row: $lin_q <br>\n";
						while ($lin_q =~ /$\s*(\d+\.\d+)\((\d+\.\d+)\).*$/) {
							my $q = $2;
							$qf++;
							$q[$qf] = $q;
			#				print "Found $qf quote: $q<br>\n";
							if ($qf < 3) {
								$lin_q = <K>;
							} else {
								$lin_q = "";
							}
						}

						if ($qf == 3) {


							my $data = $league."&".$match."&".&processOdd($q[1])."&".&processOdd($q[2])."&".&processOdd($q[3])."&0&_ : _&".$curr_date."&".$c_time."&";
#							print "Take game $league $match, $data <br>\n";

							push (@streams,$data)
						} else {
							print "Didn't find 3 quotes... \n";
						}
				} else {
	#				print "Match date $curr_date is not in valid date range! <br>\n";
				}	#in good day
			}#started with match
	}#while
	close(K);

	#Write the formular file
	open(A,">$outputFile");
my $cnt = 0;
	#print "Writing to output file $outputFile<br>\n";
	foreach(@streams) { print A $_ . "\n";
	 $cnt++};
	#foreach(@streams) { print $_ . "\n"};
	close(A);
	print "Wrote $cnt matches to output file<br>\n";



}



sub parseStanley() {
    my $filePath = shift;
    my $outputFile = shift;
    my $leagueSelection = shift;
    my @streams = ();
	my $goodDatesRef = &getGoodDates();
	my $goodLeaguesRef = &getGoodLeagues($leagueSelection);
	my $lastHeader = "";
	my $inGoodDay = 0; 
	print "LeagueSelection: $leagueSelection\n";
        #Read in the File
        open(K,"<$filePath") or die "Cannot read quotes file";
        while(<K>) {
		my $line = $_;
                my @flds= split(/\t/,$line);
		#&dumpLine(@line);
                if ($line =~ /Incontro\s*:\s*(\d*)\s*(\w*)\s*(\d{4})/) {
			#it is the date
			$curr_date = $1.".".&processMonth($2).".".$3; 

			if ($$goodDatesRef{$curr_date}) {
				$inGoodDay = 1;
			} else {
				$inGoodDay = 0;
			}	
		}	
		#print "Fld0: $flds[0]<br>Fld1: $flds[1]<br>\n";
		if ($flds[0] =~ /\s*\d+\s*/ and $flds[1] =~ /(.*?) v (.*)\s*/) {
			my $match = $1." - ".$2;
			#print "Found Match $match, header is $lastHeader<br>\n";
			if ($inGoodDay) {
				my $leagueID = 0;
				foreach $a_key (keys %$goodLeaguesRef) {
					if ($lastHeader =~ /$a_key/) {
						$leagueID = $$goodLeaguesRef{$a_key};
					}
				}
				if ($leagueID > 0 or $leagueSelection eq "all") {
					if ($leagueSelection eq "all" && !$leagueID) {
						$leagueID = 9;
					}
					#print "Take game $leagueID $match<br>\n";
					my $data = $leagueID."&".$match."&".&processOdd($flds[3])."&".&processOdd($flds[4])."&".&processOdd($flds[5])."&0&_ : _&".$curr_date."&".$flds[2]."&";
					push (@streams,$data);
				}
			}
		} else {
			# Seems to be a header line
			$lastHeader = $line;
		}
        }
        close(K);

        #Write the formular file
        open(A,">$outputFile");
        foreach(sort sortResults @streams) { print A $_ . "\n"};
        #foreach(@streams) { print $_ . "\n"};
        close(A);


}
sub sortResults {
  # sortiert nach Ligen, innerhalb der Ligen nach Anpfiff.
  my @afld = split(/&/,$a);
  my @bfld = split(/&/,$b);
  my $adate = $afld[7];
  my $bdate = $bfld[7];
  $adate =~ /(\d+)\.(\d+)\.(\d+)/;
  my $asortdate = $2.$1;
  $bdate =~ /(\d+)\.(\d+)\.(\d+)/;
  my $bsortdate = $2.$1;

  $afld[0] <=> $bfld[0]
  or
  $asortdate <=> $bsortdate
  or
  $afld[8] <=> $bfld[8]
  or
  $a <=> $b;
}

sub getGoodLeagues() {
	my $selectMode = shift;
	my %goodLeagues = ();
	if ($selectMode eq "btm") {
       		%goodLeagues = ("Austria Bundesliga",7,"Germany 2nd Bundesliga",2,"Germany 3rd Liga",17,"Germany Bundesliga",1,"Switzerland Super League",6);
	} 
	if ($selectMode eq "tmi") {
       		%goodLeagues = ("Austria Bundesliga",7,"Switzerland Super League",6,"France Ligue 1",4,"Italy Serie A",5,"Netherlands Eredivisie",14,"Portugal A Liga",19,"England Premiership",3,"Scotland Premiership",15,"Spain La Liga",8,"England FA",3,"England Premier League",3);

	}
	if ($selectMode eq "all") {
                %goodLeagues = ("France",4,"Italy",5,"Netherlands",14,"Portugal",19,"England",3,"Scotland",15,"Spain",8,"Switzerland",6,"Austria",7,"Germany",1,"Sweden",10,"Norway",11,"Finland",12,"Denmark",13,"Russia",18,"Ireland",20);

	}	

	return \%goodLeagues;
}

sub getGoodDates() {
	#Returns an hash containing the dates of upcoming Friday, Saturday and Sunday
       my $local_time = gmtime();

        (undef,undef,undef,my $day,my $mon,my $yr,my$wday,undef,undef)  = gmtime(time);
        $mon++;
        $yr = $yr + 1900;
        #Target weekdays are 5,6,7 --> compute them
        my $dist = 5-$wday;
        my %gooddays = ();
        for (my $i=0; $i<3; $i++) {
                my $d1 = time+(($i+$dist)*86400);
                (undef,undef,undef,my $d2,my $m2,my $yr2,my$wday,undef,undef)  = gmtime($d1);
                #print "Good date: $d2 $m2 $yr2\n";
                if ($d2 < 10) {$d2 = "0".$d2;}
                if (++$m2 < 10) {$m2 = "0".$m2;}
                my $datekey = $d2.".".$m2.".".eval($yr2+1900);
                print "Good day: $datekey\n";
                $gooddays{"$datekey"} = 1;
        }
	return \%gooddays;
}

sub processMonth() {
	my $monthname = shift;
	if ($monthname =~ /\d\d/) {
		return $monthname;
	}
	my %mn = ("Jan","01","Feb","02","Mar","03","Apr","04","Mai","05","Jun","06","Jul","07","Aug","08","Sep","09","Okt","10","Nov","11","Dez","12","Dec","12","May","05","Oct","10");
        my $toret = $mn{"$monthname"};
	if (!$toret) {$toret = "00";}
	return $toret;	
}

sub processYear() {
	my $year = shift;
	if ($year =~ /\d\d/) {
		return "20".$year;
	}
	return $year;
}

sub parseBwinEmailOdds() {

    my $filePath = shift;
    my $outputFile = shift;

    my $tree         = HTML::TreeBuilder::XPath->new;
    $tree->parse_file( $filePath );

    my @streams = ();
    my %flag = ();
    for ( $tree->findnodes(q{//tr}) ) {

        my $url = $_->findvalue(q{td[5]});
        if ( $url ne "" && $url =~/-/ && $flag{$url} != 1 ) {
                my $data = "1&" . $_->findvalue(q{td[5]}) . "&" . &processOdd($_->findvalue(q{td[6]})) . "&" . &processOdd($_->findvalue(q{td[7]})) . "&" . &processOdd($_->findvalue(q{td[8]}))  ."&0&_ : _&" . &processDate($_->findvalue(q{td[3]})) ;
                push( @streams, $data );
                $flag{$url} = 1;
        }
    }

        #write file
        open (A,">$outputFile");
        foreach(@streams) { print A $_ . "\n"};
        close(A);

}

sub processOdd() {
        my $odd = shift;
        $odd=~s/\.//;
        $odd = int($odd/10.4);
        if ($odd > 90) {$odd = 90;}
        return $odd;
}

sub processDate() {
        my $date = shift;
        (my $datum, my $time, my $ampm) = split(/\s/, $date);
        (my $month, my $day, $year) = split(/\//, $datum);
        if ($day <10) {$day = "0".$day};
        if ($month <10) {$month = "0".$month};
        (my $hour, $minute) =  split(/:/,$time);
        if ($ampm eq "PM" && $hour < 12) {$hour+=12}
        return $day . "." . $month . "." . $year .  "&" . $hour . ":" . $minute . "&";

}

sub translate_team {
	my $team = shift;
	my $ret_team = "";

#1. Liga
	if ($team =~ /Dortm/i || $team =~ /BV Bor/) {$ret_team = "Borussia Dortmund";}
	if ($team =~ /Augsb/i) {$ret_team = "FC Augsburg";}
	if ($team =~ /Leverk/i) {$ret_team = "Bay. Leverkusen";}
	if ($team =~ /Wolfsbu/i) {$ret_team = "VfL Wolfsburg";}
	if ($team =~ /gladb/i) {$ret_team = "Bor. M'gladbach";}
	if ($team =~ /reuth/i) {$ret_team = "Greuther Fürth";}
	if ($team =~ /E.*Frankf/i) {$ret_team = "Eintr. Frankfurt";}
	if ($team =~ /Bayern/i) {$ret_team = "Bayern München";}
	if ($team =~ /Werder/i) {$ret_team = "Werder Bremen";}
	if ($team =~ /Schalk/i) {$ret_team = "Schalke 04";}
	if ($team =~ /Hamburg/i) {$ret_team = "Hamburger SV";}
	if ($team =~ /Freib/i) {$ret_team = "SC Freiburg";}
	if ($team =~ /rnber/i) {$ret_team = "1.FC Nürnberg";}
	if ($team =~ /Mainz/i) {$ret_team = "Mainz 05";}
	if ($team =~ /Hanno/i) {$ret_team = "Hannover 96";}
	if ($team =~ /Stutt/i) {$ret_team = "VfB Stuttgart";}
	if ($team =~ /Hoffen/i) {$ret_team = "Hoffenheim";}
	if ($team =~ /Duss/i) {$ret_team = "Fort. Düsseldorf";}

# 2. Liga
	if ($team =~ /aisersl/i) {$ret_team = "K'lautern";}
	if ($team =~ /Koln/i) {$ret_team = "1.FC Köln";}
	if ($team =~ /Bochum/i) {$ret_team = "VfL Bochum";}
	if ($team =~ /zgeb/i) {$ret_team = "Erzgeb. Aue";}
	if ($team =~ /Aalen/i) {$ret_team = "VfR Aalen";}
	if ($team =~ /ngols/i) {$ret_team = "FC Ingolstadt";}
	if ($team =~ /Dyn/i) {$ret_team = "Dyn. Dresden";}
	if ($team =~ /Pauli/i) {$ret_team = "FC St. Pauli";}
	if ($team =~ /Regens/i) {$ret_team = "Jahn Regensburg";}
	if ($team =~ /FSV F/i) {$ret_team = "FSV Frankfurt";}
	if ($team =~ /Duis/i) {$ret_team = "MSV Duisburg";}
	if ($team =~ /Sandh/i) {$ret_team = "SV Sandhausen";}
	if ($team =~ /Paderb/i) {$ret_team = "SC Paderborn";}
	if ($team =~ /Union/i) {$ret_team = "Union Berlin";}
	if ($team =~ /TSV M/i) {$ret_team = "1860 München";}
	if ($team =~ /Cott/i) {$ret_team = "Energie Cottbus";}
	if ($team =~ /Hert/i) {$ret_team = "Hertha BSC";}
	if ($team =~ /Eint.*Br/i) {$ret_team = "E. Braunschweig";}

# 3. Liga
	if ($team =~ /ttgarter K/i) {$ret_team = "Stuttg. Kickers";}
	if ($team =~ /eiss Erf/i) {$ret_team = "RW Erfurt";}
	if ($team =~ /Karlsruh/i) {$ret_team = "Karlsruher SC";}
	if ($team =~ /Babels/i) {$ret_team = "SV Babelsberg";}
	if ($team =~ /Alema/i) {$ret_team = "Alem. Aachen";}
	if ($team =~ /Hansa/i) {$ret_team = "Hansa Rostock";}
	if ($team =~ /Saarb/i) {$ret_team = "Saarbrücken";}
	if ($team =~ /Chemn/i) {$ret_team = "Chemnitzer FC";}
	if ($team =~ /Armin/i) {$ret_team = "Armin. Bielefeld";}
	if ($team =~ /Wehen/i) {$ret_team = "SV Wehen";}
	if ($team =~ /Darmst/i) {$ret_team = "Darmstadt 98";}
	if ($team =~ /Unterh/i) {$ret_team = "Unterhaching";}
	if ($team =~ /Offenb/i) {$ret_team = "Kick. Offenbach";}
	if ($team =~ /Preuss/i) {$ret_team = "Preussen Münster";}
	if ($team =~ /Wacker B/i) {$ret_team = "Wacker Burghausen";}
	if ($team =~ /Halle/i) {$ret_team = "Hallescher FC";}
	if ($team =~ /Osna/i) {$ret_team = "VfL Osnabrück";}
	if ($team =~ /Heiden/i) {$ret_team = "1.FC Heidenheim";}
	if ($team =~ /Leipz/i) {$ret_team = "RB Leipzig";}
	if ($team =~ /Elvers/i) {$ret_team = "SV Elversberg";}
	if ($team =~ /Holst/i) {$ret_team = "Holstein Kiel";}

	if ($ret_team) { return (1,$ret_team); }
	
#England
	if ($team =~ /Queen/i) {$ret_team = "Queens Park R.";}
	if ($team =~ /Wigan/i) {$ret_team = "Wigan Athl.";}
	if ($team =~ /Man. U/i) {$ret_team = "Manchester Utd.";}
	if ($team =~ /Man Ci/i) {$ret_team = "Manchester City";}
	if ($team =~ /Arsen/i) {$ret_team = "FC Arsenal";}
	if ($team =~ /Norwi/i) {$ret_team = "Norwich City";}
	if ($team =~ /Aston/i) {$ret_team = "Aston Villa";}
	if ($team =~ /Fulham/i) {$ret_team = "FC Fulham";}
	if ($team =~ /Evert/i) {$ret_team = "FC Everton";}
	if ($team =~ /Readi/i) {$ret_team = "FC Reading";}
	if ($team =~ /Liverp/i) {$ret_team = "FC Liverpool";}
	if ($team =~ /Southam/i) {$ret_team = "Southampton";}
	if ($team =~ /West H/i) {$ret_team = "West Ham Utd.";}
	if ($team =~ /Newca/i) {$ret_team = "Newcastle Utd.";}
	if ($team =~ /Sunder/i) {$ret_team = "FC Sunderland";}
	if ($team =~ /Stoke/i) {$ret_team = "Stoke City";}
	if ($team =~ /Chelse/i) {$ret_team = "FC Chelsea";}
	if ($team =~ /Tottenh/i) {$ret_team = "Tottenham Hotsp.";}
	if ($ret_team) { return (3,$ret_team); }
#Italien
	if ($team =~ /Inter/i) {$ret_team = "Inter Mailand";}
	if ($team =~ /Atal/i) {$ret_team = "Atal. Bergamo";}
	if ($team =~ /Napoli/i) {$ret_team = "SSC Neapel";}
	if ($team =~ /Genoa/i) {$ret_team = "FC Genua";}
	if ($team =~ /AS Rom/i) {$ret_team = "AS Rom";}
	if ($team =~ /Lazio/i) {$ret_team = "Lazio Rom";}
	if ($team =~ /Pescara/i) {$ret_team = "Pescara";}
	if ($team =~ /Siena/i) {$ret_team = "AC Siena";}
	if ($team =~ /Fiorent/i) {$ret_team = "AC Florenz";}
	if ($team =~ /Palerm/i) {$ret_team = "US Palermo";}
	if ($team =~ /Bologn/i) {$ret_team = "FC Bologna";}
	if ($team =~ /Parma/i) {$ret_team = "AC Parma";}
	if ($team =~ /Udinese/i) {$ret_team = "Udinese";}
	if ($team =~ /Cagliari/i) {$ret_team = "Cagliari";}
	if ($team =~ /Chievo/i) {$ret_team = "AC Chievo";}
	if ($team =~ /Catania/i) {$ret_team = "Catania";}
	if ($team =~ /Torin/i) {$ret_team = "FC Turin";}
	if ($team =~ /AC Milan/i) {$ret_team = "AC Mailand";}
	if ($team =~ /Milan/i && $team !~ /nter/i) {$ret_team = "AC Mailand";}
	if ($team =~ /Juve/i) {$ret_team = "Juventus Turin";}
	if ($ret_team) { return (5,$ret_team); }
#Spanien
	if ($team =~ /Osasu/i) {$ret_team = "FC Osasuna";}
	if ($team =~ /Espany/i) {$ret_team = "Espanyol Barcelona";}
	if ($team =~ /Getaf/i) {$ret_team = "FC Getafe";}
	if ($team =~ /Atleti/i) {$ret_team = "Atletico Madrid";}
	if ($team =~ /Valencia/i) {$ret_team = "FC Valencia";}
	if ($team =~ /Vallad/i) {$ret_team = "Real Valladolid";}
	if ($team =~ /Sevilla F/i) {$ret_team = "FC Sevilla";}
	if ($team =~ /Athletic/i) {$ret_team = "Athl. Bilbao";}
	if ($team =~ /Betis/i) {$ret_team = "Betis Sevilla";}
	if ($team =~ /Levan/i) {$ret_team = "Levante";}
	if ($team =~ /Depor/i) {$ret_team = "Depor. La Coruna";}
	if ($team =~ /Malag/i) {$ret_team = "FC Malaga";}
	if ($team =~ /Vallec/i) {$ret_team = "Rayo Vallecano";}
	if ($team =~ /Socie/i) {$ret_team = "San Sebastian";}
	if ($team =~ /Grana/i) {$ret_team = "CF Granada";}
	if ($team =~ /Zarag/i) {$ret_team = "Real Saragossa";}
	if ($team =~ /Barce/i) {$ret_team = "FC Barcelona";}
	if ($team =~ /Real M/i) {$ret_team = "Real Madrid";}
	if ($ret_team) { return (8,$ret_team); }
#Frankreich
	if ($team =~ /Valencie/i) {$ret_team = "Valenciennes";}
	if ($team =~ /St. Et/i) {$ret_team = "AS St. Etienne";}
	if ($team =~ /Troy/i) {$ret_team = "AS Troyes";}
	if ($team =~ /PSG/i) {$ret_team = "Paris St. Germain";}
	if ($team =~ /Ajacc/i) {$ret_team = "AC Ajaccio";}
	if ($team =~ /Nancy/i) {$ret_team = "AS Nancy";}
	if ($team =~ /Bordeaux/i) {$ret_team = "Gir. Bordeaux";}
	if ($team =~ /Montpe/i) {$ret_team = "HSC Montpellier";}
	if ($team =~ /Evian/i) {$ret_team = "Evian Thonon G.";}
	if ($team =~ /Stade R/i) {$ret_team = "Stade Rennes";}
	if ($team =~ /Lorient/i) {$ret_team = "FC Lorient";}
	if ($team =~ /Bastia/i) {$ret_team = "SC Bastia";}
	if ($team =~ /Stade Bre/i) {$ret_team = "Stade Brest";}
	if ($team =~ /Reims/i) {$ret_team = "Stade de Reims";}
	if ($team =~ /Nice/i) {$ret_team = "OGC Nizza";}
	if ($team =~ /Sochaux/i) {$ret_team = "FC Sochaux";}
	if ($team =~ /Lyon/i) {$ret_team = "Olympique Lyon";}
	if ($team =~ /Toulouse/i) {$ret_team = "FC Toulouse";}
	if ($team =~ /Lille/i) {$ret_team = "OSC Lille";}
	if ($team =~ /Marseille/i) {$ret_team = "Olymp. Marseille";}
		if ($ret_team) { return (4,$ret_team); }
#Schweiz/Austria
	if ($team =~ /Wolfsbe/i) {$ret_team = "Wolfsberger AC";}
	if ($team =~ /Ried/i) {$ret_team = "SV Ried";}
	if ($team =~ /Rapid/i) {$ret_team = "Rapid Wien";}
	if ($team =~ /Magna/i) {$ret_team = "Wiener Neustadt";}
	if ($team =~ /Matter/i) {$ret_team = "SV Mattersburg";}
	if ($team =~ /Red B/i) {$ret_team = "RB Salzburg";}
	if ($team =~ /Admir/i) {$ret_team = "Admira Wacker";}
	if ($team =~ /Inns/i) {$ret_team = "Wacker Innsbruck";}
	if ($team =~ /Sturm/i) {$ret_team = "Sturm Graz";}
	if ($team =~ /Austri/i) {$ret_team = "Austria Wien";}
	if ($ret_team) { return (7,$ret_team); }
	if ($team =~ /Thun/i) {$ret_team = "FC Thun";}
	if ($team =~ /Lausan/i) {$ret_team = "Lausanne Sports";}
	if ($team =~ /Serve/i) {$ret_team = "Servette Genf";}
	if ($team =~ /Young/i) {$ret_team = "Young Boys Bern";}
	if ($team =~ /Basel/i) {$ret_team = "FC Basel";}
	if ($team =~ /Galle/i) {$ret_team = "St. Gallen";}
	if ($team =~ /Sion/i) {$ret_team = "FC Sion";}
	if ($team =~ /Grassh/i) {$ret_team = "Grasshopper";}
	if ($team =~ /Luzern/i) {$ret_team = "FC Luzern";}
	if ($team =~ /FC Z/i) {$ret_team = "FC Zürich";}
	if ($ret_team) { return (6,$ret_team); }


	# default handling
	chomp $team;
	$team =~ s/^\s*//;
	$team =~ s/\s*$//;
	$team =~ s/\s+/ /g;
	return (0,$team);
}

# remove this again!
#print "Start parsing!\n";
#&parseBetbrain("q2.txt","out.txt","all");
#print "Stop parsing!\n";
#exit 0;


1;
