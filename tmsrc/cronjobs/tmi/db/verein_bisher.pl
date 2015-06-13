#!/usr/bin/perl

require "/tmapp/tmsrc/cgi-bin/runde.pl";
$his = "history";
$run=$rrunde; # TIPRUNDE

$saisonq=11;

$start=(($run-1)*4)+1;

#print "Alles geaendert ?\n";
#$a = <stdin>;
 $letzer_verein = 0 ;
 $letzer_trainer = 0 ;

open(DO,"</tmdata/tmi/db/vereine.txt");
while(<DO>) {
$t++;
($nummer , $ve ) = split (/&/ , $_);
chomp $ve ;
$team[$t]=$ve;
$team_id[$nummer] = $ve ;
$verein_ex{$ve} = 1 ;
$verein_nr{$ve} =  $nummer ;
$id[$nummer]=$ve;
if ( $nummer > $letzer_verein ) { $letzer_verein = $nummer }
}
close(DO);

open(DO,"</tmdata/tmi/db/trainer.txt");
while(<DO>) {
$t++;
($nummer , $ve ) = split (/&/ , $_);
chomp $ve ;
$coach_id[$nummer] = $ve ;
$trainer_ex{$ve} = 1 ;
$trainer_nr{$ve} =  $nummer ;
if ( $nummer > $letzer_trainer ) { $letzer_trainer = $nummer }
}
close(DO);


open(B,"</tmdata/tmi/db/spiele.txt") ;
while(<B>){
$line++;
#if ($line>1000){goto ex;}
@cool=split(/&/,$_);
($trainer,$saison)=split(/#/,$cool[0]);
$trainer=$trainer*1;
for ($x=1;$x<=34;$x++){
@cold=split(/#/,$cool[$x]);
if (( $cold[0] ne "-" ) and ( $cold[0] > 0 )) {
$zeit=(($saison-1)*34)+$x;
$karriere{$id[$cold[0]]}=$karriere{$id[$cold[0]]}.$zeit.'-'.$trainer.'#';
}
}
}
close (B);
ex:


open(DO,">/tmdata/tmi/db/karriere.txt");
for ($xj=1;$xj<=$letzer_verein;$xj++){
#for ($xj=1;$xj<=300;$xj++){

$stationen=0;
@stats_begin=();
@stats_ende=();
@stats_trainer=();

@um=split(/#/,$karriere{$team[$xj]});
#print "$karriere{$team[$xj]}\n";
($zeit_anfang,$trainer)=split(/\-/,$um[0]);

$zeit_ende=$zeit_anfang;
for ($x=1;$x<=(scalar(@um)-1);$x++){
($zeit,$tr)=split(/\-/,$um[$x]);

if ($tr==$trainer){$zeit_ende=$zeit}

if ($tr != $trainer){
$stationen=$stationen+1;

$stats_begin[$stationen]=$zeit_anfang;
$stats_ende[$stationen]=$zeit_ende;
$stats_trainer[$stationen]=$trainer;
$zeit_anfang=$zeit;
$zeit_ende=$zeit;
$trainer=$tr;
}
}
$stationen=$stationen+1;

$stats_begin[$stationen]=$zeit_anfang;
$stats_ende[$stationen]=$zeit_ende;
$stats_trainer[$stationen]=$trainer;



print DO "$team[$xj]!$stationen#";
for ($y=1;$y<=(scalar(@um)-1);$y++){
for ($x=1;$x<=$stationen;$x++){
if ( $y==$stats_begin[$x] ) {
print DO "$stats_begin[$x]&$stats_ende[$x]&$coach_id[$stats_trainer[$x]]#";
}
}
}
print DO "\n";

#print DO "$team[$xj]#$karriere{$team[$xj]}\n\n";


}
close (DO);