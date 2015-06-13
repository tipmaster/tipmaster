#! /usr/bin/perl

$uptime =`uptime`; @split  = split(/\,/,$uptime);
if ( $split[5] > 5 ) { print "Zu hoher Load von $split[5]"; exit;}

$mydir = "/tmdata/btm/logs";
opendir(DIR,"$mydir") or die "No dir $mydir";
@trainer = readdir(DIR);
close(DIR);
$anzahl = 0;
open(K,">/tmdata/online_who.txt") or die "Cannot write to online_who.txt";
foreach $a_tr (@trainer) {
        $filename = "$mydir/${a_tr}";
        $age = -C $filename;
        if ($age>0 && $age < 0.0104167) {
		$trainername = $a_tr;
		$trainername =~ s/\.txt//;
       		print K "$trainername\n";
		$anzahl++;
	}
}
close(K);
open(L,">/tmdata/online_c.txt") or die "Cannot write to online_c.txt";
print L $anzahl,"\n";
close(L);

print "\n -> $anzahl Trainer online \n\n\n";

exit 0;
