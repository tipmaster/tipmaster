#! /usr/bin/perl

use JSON qw(to_json);
use CGI;

do 'library.pl';

my $query = new CGI;
#print $query->header(-type=>'application/json');
print $query->header(-type=>'text/html');

my $runde = $query->param('runde');
my $bort = $query->param('tm');
if (!$runde) {$runde = $derzeitige_runde;}
if (defined $bort && $bort eq "btm") {
  $runde = "B".$runde;
}
my $spielref = &readFormular($runde);

delete $$spielref{10};
my $retstr = "{\"tipspiele\":[";
my %spiel = %$spielref;

my $first = 1;
foreach $a_match (sort keys %spiel) {
	if (!$first) {
		$retstr .= ",";
	} else {
	    $first = 0;
	}
	$retstr .= "{";
   	$retstr .= "\"gamestring\":\"" . $spiel{$a_match}->{match} . "\",";

	$spiel{$a_match}->{q1}->{wert} = $spiel{$a_match}->{1};
	$spiel{$a_match}->{q1}->{prognose} = 1;
	delete $spiel{$a_match}->{1};
	$spiel{$a_match}->{q2}->{wert} = $spiel{$a_match}->{2};
	$spiel{$a_match}->{q2}->{prognose} = 2;
	delete $spiel{$a_match}->{2};
	$spiel{$a_match}->{q0}->{wert} = $spiel{$a_match}->{0};
	$spiel{$a_match}->{q0}->{prognose} = 0;
	delete $spiel{$a_match}->{0};


	$retstr .= "\"hpts\":" . $spiel{$a_match}->{q1} .",";
	$retstr .= "\"upts\":" . $spiel{$a_match}->{q0} .",";
	$retstr .= "\"apts\":" . $spiel{$a_match}->{q2} .",";
   	$retstr .= "\"result\":\"" . $spiel{$a_match}->{erg} . "\"";

	$retstr .= "}";
   
}
$retstr .= "]}";

my $formg = {
	gameString => 'Bayern - Schalke',
	hpts => 15,
	upts => 30,
	apts => 40,
	result => 4};

#print $retstr,"\n";
#print to_json($formg);

print to_json($spielref, {pretty => 0}),"\n";
exit 0;

