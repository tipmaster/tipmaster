#!/usr/bin/perl

$uptime =`uptime`; @split  = split(/\,/,$uptime);
if ( $split[4] > 5 ) { print "Zu hoher Load von $split[4]"; exit;}

open(D7,"/tmdata/btm/tip_datum.txt");
$spielrunde_ersatz = <D7> ;
chomp $spielrunde_ersatz;
close(D7);

for ($so=1;$so<=6912;$so++) {
$cc = $so ;
if ( $so < 100 ) { $cc = '0' . $cc  }
if ( $so < 10 ) { $cc = '0' . $cc  }
if ( $so < 1000 ) { $cc = '0' . $cc}
$datei = '/tmdata/btm/tips/' . $spielrunde_ersatz . '/' . $cc . '.txt' ;


open (D1 , $datei ) ;

$zeile = <D1> ;
chomp $zeile ;
($numero , $tipes) = split (/#/, $zeile);	
@tipos = split (/\./, $tipes);	

#print "$zeile\n";

for ($x=0 ; $x <=24 ; $x++ ){

if ( $tipos[$x] eq "1&1" ) { $tip_1[$x]++ }
if ( $tipos[$x] eq "2&1" ) { $tip_1[$x]++ }
if ( $tipos[$x] eq "3&1" ) { $tip_1[$x]++ }
if ( $tipos[$x] eq "4&1" ) { $tip_1[$x]++ }

if ( $tipos[$x] eq "1&2" ) { $tip_0[$x]++ }
if ( $tipos[$x] eq "2&2" ) { $tip_0[$x]++ }
if ( $tipos[$x] eq "3&2" ) { $tip_0[$x]++ }
if ( $tipos[$x] eq "4&2" ) { $tip_0[$x]++ }

if ( $tipos[$x] eq "1&3" ) { $tip_2[$x]++ }
if ( $tipos[$x] eq "2&3" ) { $tip_2[$x]++ }
if ( $tipos[$x] eq "3&3" ) { $tip_2[$x]++ }
if ( $tipos[$x] eq "4&3" ) { $tip_2[$x]++ }

$tip_1[$x]=$tip_1[$x]*1;
$tip_0[$x]=$tip_0[$x]*1;
$tip_2[$x]=$tip_2[$x]*1;
}

close (D1) ;




}

$datei = '/tmdata/btm/tips/' . $spielrunde_ersatz . '/bisher.txt' ;

open (D1 , ">$datei" ) ;
flock (D1,2) ;
for ($x=0 ; $x <=24 ; $x++ ){
print D1 "&$tip_1[$x]&$tip_0[$x]&$tip_2[$x]&\n";
}
flock (D1,2) ;
close (D1) ;

close (D1) ;

@tip_1=();
@tip_0=();
@tip_2=();

open(D7,"/tmdata/tmi/tip_datum.txt");
$spielrunde_ersatz = <D7> ;
chomp $spielrunde_ersatz;
close(D7);

for ($so=1;$so<=(203*18);$so++) {
$cc = $so ;
if ( $so < 100 ) { $cc = '0' . $cc  }
if ( $so < 10 ) { $cc = '0' . $cc  }
if ( $so < 1000 ) { $cc = '0' . $cc}
$datei = '/tmdata/tmi/tips/' . $spielrunde_ersatz . '/' . $cc . '.txt' ;


open (D1 , $datei ) ;

$zeile = <D1> ;
chomp $zeile ;
($numero , $tipes) = split (/#/, $zeile);	
@tipos = split (/\./, $tipes);	


for ($x=0 ; $x <=24 ; $x++ ){

if ( $tipos[$x] eq "1&1" ) { $tip_1[$x]++ }
if ( $tipos[$x] eq "2&1" ) { $tip_1[$x]++ }
if ( $tipos[$x] eq "3&1" ) { $tip_1[$x]++ }
if ( $tipos[$x] eq "4&1" ) { $tip_1[$x]++ }

if ( $tipos[$x] eq "1&2" ) { $tip_0[$x]++ }
if ( $tipos[$x] eq "2&2" ) { $tip_0[$x]++ }
if ( $tipos[$x] eq "3&2" ) { $tip_0[$x]++ }
if ( $tipos[$x] eq "4&2" ) { $tip_0[$x]++ }

if ( $tipos[$x] eq "1&3" ) { $tip_2[$x]++ }
if ( $tipos[$x] eq "2&3" ) { $tip_2[$x]++ }
if ( $tipos[$x] eq "3&3" ) { $tip_2[$x]++ }
if ( $tipos[$x] eq "4&3" ) { $tip_2[$x]++ }

$tip_1[$x]=$tip_1[$x]*1;
$tip_0[$x]=$tip_0[$x]*1;
$tip_2[$x]=$tip_2[$x]*1;
}

close (D1) ;




}

$datei = '/tmdata/tmi/tips/' . $spielrunde_ersatz . '/bisher.txt' ;

open (D1 , ">$datei" ) ;
flock (D1,2) ;
for ($x=0 ; $x <=24 ; $x++ ){
print D1 "&$tip_1[$x]&$tip_0[$x]&$tip_2[$x]&\n";
}
flock (D1,2) ;
close (D1) ;

close (D1) ;
