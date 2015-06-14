#! /usr/bin/perl
require Net::SMTP;
use DB_File;

my $hasChanged = &roundHasChanged();
if ($hasChanged) {

        if (1) {
                &updateRoundNotifier();
                print "Round counter updated\n";
        }
        if (1) {
                my $recpt_ref = &getListOfRecipients();
                &writeMail($recpt_ref);
        }
} else {
        print "No round change detected!\n";
}
my $ec_hasChanged = &ECroundHasChanged();
if ($ec_hasChanged) {
	if (1) {
			&ECupdateRoundNotifier();
			print "EC Round counter updated\n";
	}
	if (1) {
				%id2team = ();%id2nat = ();%team2trainer = (); %team2id = (); 
				my $ec_recpt_ref = &getListOfECRecipients($ec_hasChanged);
				&writeECMail($ec_recpt_ref);
		}
} else {
	print "No EC round change detected!\n";
}
exit 0;

sub updateRoundNotifier {
        my $rrunde;
        open (D1,"</tmdata/rrunde.txt");$rrunde=<D1>;chomp $rrunde;close(D1);

        open (D1,">/tmdata/btm/notifier_last_round.txt");
        print D1 $rrunde,"\n";
        close(D1);
}

sub roundHasChanged {
        my $rrunde;
        open (D1,"</tmdata/rrunde.txt");$rrunde=<D1>;chomp $rrunde;close(D1);
        my $lastcheck;
        open (D1,"</tmdata/btm/notifier_last_round.txt");$lastcheck=<D1>;chomp $lastcheck;close(D1);
        if ($rrunde ne $lastcheck) {
                return 1;
        }
        return 0;
}

sub ECupdateRoundNotifier {
        my $rrunde;
        open (D1,"</tmdata/cl/runde.dat");$rrunde=<D1>;chomp $rrunde;close(D1);

        open (D1,">/tmdata/cl/notifier_last_round.txt");
        print D1 $rrunde,"\n";
        close(D1);
}


sub ECroundHasChanged {
        my $rrunde;
        open (D1,"</tmdata/cl/runde.dat");$rrunde=<D1>;chomp $rrunde;close(D1);
        my $lastcheck;
        open (D1,"</tmdata/cl/notifier_last_round.txt");$lastcheck=<D1>;chomp $lastcheck;close(D1);
        if ($rrunde ne $lastcheck) {
                return $rrunde;
        }
        return 0;
}


sub getListOfRecipients {
        my @mail_list = ();
        my %t2m;

        ## read trainer to mail array
        open (D1,"</tmdata/pass.txt");
        while(<D1>) {
                my @passes = split (/&/, $_);
                $t2m{$passes[1]} = $passes[3];
        }
        close(D1);


        my $flags = O_RDWR;
        my $mode = "0777";
        my $db = tie %notifiers, 'DB_File', "/tmdata/btm/notifiers.dbm", $flags, $mode, $DB_HASH or die "Cannot create DB: $!";

        my $fd = $db->fd;                                            # Get file descriptor
        open DBM, "+<&=$fd" or die "Could not dup DBM for lock: $!"; # Get dup filehandle
        flock DBM, LOCK_EX;                                          # Lock exclusively
        undef $db;                                                   # Avoid untie probs

        my @all_recpt = keys %notifiers;
        foreach $a_recpt (@all_recpt) {
                if ($notifiers{$a_recpt} eq "1") {
                        push @mail_list, $t2m{$a_recpt};
                }
        }

        untie %h;

        foreach (@all_recpt) {
                print "$_ will get a notifier! (to ",$t2m{$_},"\n";
        }
        return \@mail_list;
}

sub getListOfECRecipients {
		my $dir = "/tmdata/cl";
        my @mail_list = ();
		my $runde = shift;
        my %t2m;
		print "AKtuelle Runde: $runde\n";

        ## read trainer to mail array
        open (D1,"</tmdata/pass.txt") or die "Cannot open passwords: $!\n";
        while(<D1>) {
                my @passes = split (/&/, $_);
                $t2m{$passes[1]} = $passes[3];
        }
        close(D1);
		print "Passwords read!\n";

		# Filling IDs.
		&fillECIDs();
		print "EC IDs filled\n";

		# Who is still in the cup?
		my $tr_ref = &getTrainerList($runde);
		print "Trainer List recieved, size: ",scalar(@$tr_ref),"\n";

		# Filter for those with opt-out notification

        my $flags = O_RDWR;
        my $mode = "0777";
        my $db = tie %notifiers, 'DB_File', "/tmdata/cl/notifiers.dbm", $flags, $mode, $DB_HASH or die "Cannot create DB: $!";

        my $fd = $db->fd;                                            # Get file descriptor
        open DBM, "+<&=$fd" or die "Could not dup DBM for lock: $!"; # Get dup filehandle
        flock DBM, LOCK_EX;                                          # Lock exclusively
        undef $db;                                                   # Avoid untie probs

        foreach $a_recpt (@$tr_ref) {
                if ($notifiers{$a_recpt} ne "1") {
                        push @mail_list, $t2m{$a_recpt};
						print "$a_recpt will get a notifiert to $t2m{$a_recpt}\n";
                } else {
						print "$a_recpt opted out. No notifier!\n";
				}
        }

        untie %h;
        return \@mail_list;
}

sub writeECMail {
        $msg = Net::SMTP->new("localhost");

        my $recips = shift;
        $msg->mail('info@tipmaster.de');
        $msg->to('bodo@tipmaster.de');
        foreach my $a_rec (@$recips) {
                $msg->bcc($a_rec);
        }

        $msg->data;
        $msg->datasend("Subject: Tipmaster: Europacup-Tipabgabe!");
        $msg->datasend("\n");
        $msg->datasend("Hallo Tipmaster-Trainer!\n\nSie spielen im Europa-Cup und diese Runde sollten Sie einen Tip abgeben!\nDas Formular f&uuml;r diese Woche ist fertig., ab jetzt k&ouml;nnen die Tips abgegeben werden.\n\n");
        $msg->datasend("Falls Sie keine Europacup-Erinnerungsmails mehr bekommen wollen,\nk&ouml;nnen Sie diese Funktion auf Ihrer TM-Profilseite deaktivieren.\n\n");
        $msg->datasend("Viel Gl�ck!\nDas Tipmaster Team\n");
        $msg->dataend;
        $msg->quit;
}

sub writeMail {
        $msg = Net::SMTP->new("localhost");

        my $recips = shift;
        $msg->mail('info@tipmaster.de');
        $msg->to('bodo@tipmaster.de');
        foreach my $a_rec (@$recips) {
                $msg->bcc($a_rec);
        }

        $msg->data;
        $msg->datasend("Subject: Das Tipmaster-Formular f&uuml;r diese Woche ist jetzt online!");
        $msg->datasend("\n");
        $msg->datasend("Hallo Tipmaster-Trainer!\n\nDas Formular f&uuml;r diese Woche ist fertig.\nAb jetzt k&ouml;nnen die Tips abgegeben werden\n\n");
        $msg->datasend("Viel Gl�ck!\nDas Tipmaster Team\n");
        $msg->dataend;
        $msg->quit;
}

sub fillECIDs {
	my $verz = "/tmdata/cl";
	my $btmverz = "/tmdata/btm";
	my $tmiverz = "/tmdata/tmi";

	open (K,"<$verz/ID.dat");

	while(<K>) {
		($lfd,$natkey,$teamname) = split(/&/,$_);
		$teamname =~ s/\s*$//;
		($natkey, $natnr) = split(/_/,$natkey);
		$id2nr{"$lfd"} = $natnr;
		$id2nat{"$lfd"} = $natkey;
		#print "id2nat: nat for $lfd is $natkey\n";
		$id2team{"$lfd"} = $teamname;
		$team2id{"$teamname"} = $lfd;
	}
	close(K);

	## Filling the ID Array
	open (K,"<$verz/UEFA_ID.dat") || die "cannot find UEFA_ID.dat";
	%uid2team = ();%uid2nat = ();%uteam2id = (); %uid2nr = ();
	while(<K>) {
		($lfd,$natkey,$teamname) = split(/&/,$_);
		$teamname =~ s/\s*$//;
		($natkey, $natnr) = split(/_/,$natkey);
		$uid2nat{"$lfd"} = $natkey;
		$uid2nr{"$lfd"} = $natnr;
		$uid2team{"$lfd"} = $teamname;
		$uteam2id{"$teamname"} = $lfd;
	}
	close(K);

	# Filling the team/name translation, first btm then tmi

	open (K,"<$btmverz/history.txt");
	while(<K>) {
	  $line = $_; chomp $line;
	  @entries = split(/&/,$line);
	  if ($entries[0] =~ /x(\d+)/) {
		$key1 = $1;
	  }
	  if ($key1 == "01" or $key1 == "02" or $key1 == "03" or $key1 == "12" or $key1 == "27") {
		for (1..18) {
		  my $subkey1 = $entries[($_-1)*3+1];
			$subkey1 =~ s/\s*$//g;
		  my $subkey2 = $entries[($_-1)*3+2];
		  $team2trainer{"$subkey1"} = $subkey2;
		  $btmteamid{"$subkey1"} = "0_".eval($_+($key1-1)*18);
		}
	  }
	}
	close(K);
		
	open (K,"<$tmiverz/history.txt");
	while(<K>) {
	  $line = $_; chomp $line;
	  @entries = split(/&/,$line);
	  if ($entries[0] =~ /x(\d+)/) {
		$key1 = $1;
	  }

	  for (1..18) {
		my $subkey1 = $entries[($_-1)*3+1];

			$subkey1 =~ s/\s*$//g;
		my $subkey2 = $entries[($_-1)*3+2];
  	  $team2trainer{"$subkey1"} = $subkey2;
 	  $tmiteamid{"$subkey1"} = $key1."_".eval($_*1);

	  }

	}
	close(K);


}


sub getTrainerList() {
		my $dir = "/tmdata/cl";
		my $runde = shift;
   	  my @thieds = ();

		# Build list of CL trainers who must tip this round.
		$data = "DATA_${runde}.DAT";		
		open(K,"<$dir/$data") or die "No data file: $!";
		while(<K>) {
		  if ($runde =~ /G\d/) {
			if ($_ =~ /\d&\d&(\d+)&/) {
				push @thieds, $team2trainer{$id2team{$1}};
			}
		  } else {
			if ($_ =~ /\d&(\d+)&(\d+)/) {
				push @thieds, $team2trainer{$id2team{$1}},$team2trainer{$id2team{$2}};
			}
		  }
		}
		close(K);

		# Build list of UEFA trainers who must tip this round.
		$data = "UEFA_${runde}.DAT";		
		open(K,"<$dir/$data") or die "No data file: $!";
		while(<K>) {
		  if ($_ =~ /\d&(\d+)&(\d+)/) {
			push @thieds, $team2trainer{$uid2team{$1}},$team2trainer{$uid2team{$2}};
		
		  }
		}
		close(K);
	return \@thieds;
}
