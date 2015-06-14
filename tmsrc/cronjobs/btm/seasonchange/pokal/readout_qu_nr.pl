
open(D,"/tmdata/btm/heer.txt");
while(<D>){
@all=split(/&/,$_);
$nr=(($all[1]-1)*18)+$all[4];
$nummer{$all[5]} = $nr ;
}
close(D);

open(E,">quali_nr.txt");
open(D,"/tmdata/btm/finals.txt");
while(<D>){
$a++;
@all=split(/&/,$_);
$verein[$a]=$all[1];
print E " $nummer{$verein[$a]} ,";
}
close(D);
close(E);
return 1;
