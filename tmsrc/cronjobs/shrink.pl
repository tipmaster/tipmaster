#!/usr/bin/perl


&shrink_last100;

&shrink_anmeldung();


sub shrink_last100 {
`/usr/bin/wget http://www.tipmaster.de/cgi-bin/btm/last100.pl -O /tmdata/frontdata/tmp.txt -o /dev/null` ;
$i=0;
open(B,">/tmdata/frontdata/best_btm.txt");
open(A,"/tmdata/frontdata/tmp.txt");
while(<A>)
{
if ($i<10){
if ($_=~/trainer\.pl/)
{
$_=~m/\"Trainerstatistik (.*)\"/;
print B $1."##";
}

if ($_=~/\s:\s/) {
$_=~m/&nbsp;(.*)\:/;
print B $1."#\n";
}}}
close(A);

`/usr/bin/wget http://www.tipmaster.de/cgi-bin/tmi/last100.pl -O /tmdata/frontdata/tmp1.txt -o /dev/null`;
$i=0;
open(B,">/tmdata/frontdata/best_tmi.txt");
open(A,"/tmdata/frontdata/tmp1.txt");
while(<A>)
{
if ($i<10){
if ($_=~/trainer\.pl/)
{
$_=~m/\"Trainerstatistik (.*)\"/;
print B $1."#";
}

if ($_=~/ligaid/) {
$_=~m/ligaid\=(.*)\-\-/;
print B $1."#";
}


if ($_=~/\s:\s/) {
$_=~m/&nbsp;(.*)\:/;
print B $1."#\n";
}


}}


close(A);

}

sub shrink_anmeldung {
my $tmp = `/usr/bin/tail -10 /tmdata/frontdata/anmeldung.txt`;
my @data = split (/\n/,$tmp);
my @test = reverse @data;

open(A,">/tmdata/frontdata/anmeldung_s.txt");
foreach(@test)
{
@k = split(/&/,$_);

if (($flag{$k[4]} != 1) && $i < 5 )
{
print A "$_\n";
$flag{$k[4]} = 1;
$i++;
}

}
close(A);
}

