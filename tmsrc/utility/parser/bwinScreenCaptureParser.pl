#! /usr/bin/perl
require "/tmapp/tmsrc/utility/parser/bwinFormularParser.pl";

sub parseBwinScreenOdds() {

	my $filePath = shift;
	my $outputFile = shift;

	#Read in the File
	open(K,"<$filePath") or die "Cannot read quotes file";
	while(<K>) {
		my @line = split(/\t/,$_);
		#&dumpLine(@line);
		my $data = &getId($line[3])."&".&trimSt($line[4])."&".&processOdd($line[5])."&".&processOdd($line[6])."&".&processOdd($line[7])."&0&_ : _&".&processDateScreen($line[2]);
		push(@streams,$data);	
	}
	close(K);

	#Write the formular file
	open(A,">$outputFile");
	foreach(@streams) { print A $_ . "\n"};
	#foreach(@streams) { print $_ . "\n"};
        close(A);




}

sub trimSt() {
	my $st = shift;
	$st =~ s/\s+$//;
	return $st;
}

sub processDateScreen() {
        my $date = shift;
        (my $datum, my $time) = split(/\s/, $date);
        (my $day, my $month, $year) = split(/\./, $datum);
#        if ($day <10) {$day = "0".$day};
#        if ($month <10) {$month = "0".$month};
	if ($year =~ /20(..)/) {$year = $1;}
        (my $hour, $minute) =  split(/:/,$time);
        return $day . "." . $month . "." . $year .  "&" . $hour . ":" . $minute . "&";



}

sub getId() {
	my $para = shift;
	$para = &trimSt($para);
	if ($para eq "Ligue 1") {
return "4";}
	if ($para eq "Bundesliga") {return "1";}
	if ($para eq "Premier League") {return "3";}
	if ($para eq "2. Bundesliga") {return "2";}
	if ($para eq "Serie A") {return "5";}
	if ($para eq "Primera Division") {return "8";}
	if ($para eq "Super League") {return "8";}

	return "0";


}
sub dumpLine() {
	my $k = 0;
	my @line = @_;
	foreach (@line) {
		print $k++ . " " . $_ . " \n";;
	}
}

1;
