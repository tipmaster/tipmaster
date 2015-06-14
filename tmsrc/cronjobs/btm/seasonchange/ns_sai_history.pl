#!/usr/bin/perl

require "/tmapp/tmsrc/cgi-bin/btm/saison.pl";
`cp /tmdata/btm/geschichte.txt /tmdata/save/geschichte_btm.txt`;
`mv /tmdata/btm/geschichte.txt /tmdata/btm/geschichte_old.txt`;

$r=0;
open(B,"</tmdata/btm/heer.txt");
while (<B>) {
$r++;
@go = split (/&/ , $_ ) ;
$verein[$r] = $go[5] ;
$platz{$verein[$r]} = $go[0] ;
$liga{$verein[$r]} = $go[1] ;
}
close (B) ;


open(A,">/tmdata/btm/geschichte.txt");
$ein = 0 ;

open(D5,"/tmdata/btm/geschichte_old.txt");
while(<D5>) {
$zeile = $_ ;
chomp $zeile ;
@lost =  split (/&/ , $_ ) ;
$zeile = $zeile . $platz{$lost[1]} . '&' . $liga{$lost[1]} .'&';
print A "$zeile\n" ;
if ( $platz{$lost[1]} != 0 ) { $ex{$lost[1]} = 1 }
if ( $platz{$lost[1]} == 0 ) { 
print "Noch nicht eingtragener Verein: $lost[1]\n" ;
}

}
close (D5);


for ($s=1;$s<=$r;$s++) {

if ( $ex{$verein[$s]} == 0 ) {
print A "&$verein[$s]";

for ($xx=1;$xx<=$main_nr;$xx++){
print A "&0&0";
}

print A "&$platz{$verein[$s]}&$liga{$verein[$s]}&\n";
print "Neuer Verein : $verein[$s]\n";
#$rr=<stdin>;

}


}






close (A) ;

print "Neue BTM Archivdaten abgelegt in /tmdata/btm/geschichte.txt !\n";
