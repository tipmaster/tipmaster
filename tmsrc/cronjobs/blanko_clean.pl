#!/usr/bin/perl

use Date::Calc qw(:all);
require "/tmapp/tmsrc/cronjobs/blanko_process.pl";

my $blanko_file = "/tmdata/blanko.txt";
my $blanko_file_archiv = "/tmdata/blanko.txt.archiv";

my @lines = ();
my @lines_old = ();
open (F,"<$blanko_file");
while(<F>)
{
	my @data = split(/&/,$_);
	my $valid = &checkIfBlankoTipIsOutdated($data[1]);
	if ($valid) {
		push(@lines,$_);
	} else {
		push(@lines_old,$_);
		print "INVALID $_";
	}
}
close(F);

open (C,">>$blanko_file_archiv");
foreach(@lines_old) {
	print C $_;
}
close(C);

open (B,">$blanko_file");
foreach(@lines) {
        print B $_;
}
close(B);




