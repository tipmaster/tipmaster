package BadAutoTip;

sub new {
	my ($inPkg) = @_;
	my $self = {};
	bless $self,$inPkg;
	return $self;
}

sub getBadTipList {
	my ($inPkg,$filename) = @_;
	my @badlist = ();
	die if (!defined $filename || !-e $filename);
	open (my $k, "<", $filename) or die "Cannot open $filename";
	my $tipnr = 0;
	my %gottip = ();
	while (my $line = <$k>) {
		next if $line =~ /^\s*$/;
		$tipnr++;
	 	my @formline = split(/&/,$line);
	 	if (isBadTip($formline[2])) {
	 		push @badlist,"$tipnr-1-$formline[2]";
	 		$gottip{$tipnr}++;
	 	}
	 	if (isBadTip($formline[3])) {
	 		push @badlist,"$tipnr-2-$formline[3]";
	 		$gottip{$tipnr}++;
	 	}
	 	if (isBadTip($formline[4])) {
	 		push @badlist,"$tipnr-3-$formline[4]";
	 		$gottip{$tipnr}++;
	 	}
	 	# make sure we do not end up with too few tips
	 	#print "Tipnr is $tipnr, Size of gottip is ",scalar(keys(%gottip)),":",join("-",keys(%gottip)),"\n";
	 	if (25-$tipnr+scalar(keys(%gottip)) < 19) {
	 		## take this one, too
	 		push @badlist,"$tipnr-2-$formline[3]";
	 		$gottip{$tipnr}++;
	 		#print "Added one by force. Size is now ",scalar(keys(%gottip)),"\n";
	 	}
	}	
	close($k);
	return \@badlist;	
}

## build 5 tips out of given list, take the one with the worst optimizer
sub createBadTip {
	my ($inPkg,$haha,$badlist) = @_;

	## check if HAHA is not numeric.
	if ($haha =~ /H|A/) {
		$haha =~ s/H/5/g;
		$haha =~ s/A/4/g;
	}
	
	## check if we have enough tips in bad list
	my $num_required = 0;
	map {$num_required += $_} split (//,$haha);
	#print "Required: $num_required Tips\n";

	my %gottip = ();
	map {my ($spnr,$tip,$prob) = split(/-/,$_);$gottip{$spnr}++;} @{$badlist};
	if (scalar(keys(%gottip)) < $num_required) {
		die "Not enough tips in tiplist: ".scalar(keys(%gottip))." vs $num_required for $haha";
	}

	my $worst_overkill = 0;
	my $retstring = "";
	for (1..5) {
		#now produce the tip line
		my @tipanz = split(//,$haha);
		my $spnr = 0;
		my %tip_taken = ();my %tip_value = ();my $exp_overkill = 0;
		foreach my $anz (@tipanz) {
			$spnr++;my @vals = ();
			## choose an arbitrary entry from not yet taken tipline.
			for (1..$anz) {
				my $success = 0;
				while (!$success) {
					my $take_nr = int(rand(scalar(@{$badlist})));
					my ($tipnr,$tip,$value) = split(/-/,$badlist->[$take_nr]);
					if (!$tip_taken{$tipnr}) {
						$success = 1;
						$tip_taken{$tipnr} = $spnr."&".$tip;
						push @vals,$value;
					}
				}
			}
			$exp_overkill += $inPkg->computeOverkill(@vals);
		}
		if ($exp_overkill > $worst_overkill) {

			my @t = ();
			for (1..25) {
				if (!$tip_taken{$_}) {
					$tip_taken{$_} = "0&0";
				}
				push @t,$tip_taken{$_};
			}
			$retstring = join(",",@t);
			$worst_overkill = $exp_overkill;
			#print "New worst overkill: $worst_overkill\n";
		}
	}
	return ($retstring,$worst_overkill);
}

sub computeOverkill {
	my ($inself,@value) = @_;
	my @perc = ();
	my @bit = (1,2,4,8,16);
	my $exp_overkill = 0;
	
	map { push @perc,toPerc($_) } @value;
	#print "Val: @value, Perc: @perc\n";
	for (0 .. (2**scalar(@value))-1) { # ergebnis-kombi
	
		my $pts = 0; my $proba = 1;
		for ($g=0; $g < scalar(@value); $g++) {
			if ($_ & $bit[$g]) {
				## game comes.
				$pts += $value[$g];
				$proba *= ($perc[$g]/100);
			} else {
				## game does not come.
				$proba *= (1-$perc[$g]/100);
			}	
		}
		#print "Game ";printf '%#b',$_;print "-> Proba ",$proba*100," Pts $pts, Overkill: ",overkill($pts),"\n";
		$exp_overkill += overkill($pts) * $proba;
	}
	#print "Expected overkill: $exp_overkill \n";
	return $exp_overkill;		
}

sub overkill {
	my $val = shift;
	my @limits = (155,130,105,80,60,40,15);
	foreach my $a_limit (@limits) {
		if ($val >= $a_limit) {
			return $val - $a_limit;
		}
	}
	return $val;
}

sub toPerc {
	my $val = shift;
	return 925/$val;
}

sub isBadTip {
	my $tip = shift;
	if ($tip >= 10 && $tip <= 39) {return 1;}
	return 0;
}
1;
