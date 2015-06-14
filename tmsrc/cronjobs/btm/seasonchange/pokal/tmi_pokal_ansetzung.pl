open(E,">/tmdata/tmi/pokal/pokal.txt");
rand();
$liga=0;
open(D,"pokal_tmi_db.tmp");
while(<D>){
$liga++;
if ( $liga < 50 ) {
print E "#$liga-1&";
}
$rest=$_;chomp $rest;
$rest=~s/9999&//g;
@all=split(/&/,$rest);

@haus = sort @all;
@so = &rand_array(@haus);


$p=0;
#auslosung
foreach $t (@so) {
if ( $t != 9999 ) {
$p++;
print E "$t&";
}
if ( $p > 4 && $liga > 47 ) {
print E "9999&";
}


}


print E "\n";
}
close(D);

close(E);

return 1;

sub rand_array {
  # Spuckt den uebergebenen Array in zufaelliger Reihenfolge aus
  @arr = @_;
  foreach $a_arr (@arr) {
    $rand[$a_arr] = rand 10000;
  }
  return sort {$rand[$a] <=> $rand[$b] } @arr;
}

