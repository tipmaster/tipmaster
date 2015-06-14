open (E,">./tmi_pokal_leer.txt");
$p=1;
for ($x=1;$x<=5;$x++){
$p=$p*2;$r=64/$p;
for ($xa=1;$xa<=49;$xa++){
print E "#$xa-$x&";

for ($y=1;$y<=$r;$y++){
print E"1&";
}

print E "\n";
}}
close(E);

