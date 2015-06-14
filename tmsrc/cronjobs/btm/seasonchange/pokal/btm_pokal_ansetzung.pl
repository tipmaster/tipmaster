open(E,">/tmdata/btm/pokal/pokal.txt");
rand();

open(D,"./pokal_db.tmp");
while(<D>){
$liga++;
if ( $liga < 17 ) {
print E "#$liga-1&";
}
$rest=$_;chomp $rest;
@all=split(/&/,$rest);

@haus = sort @all;
@so = &rand_array(@haus);
#auslosung
foreach $t (@so) {
print E "$t&";
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

