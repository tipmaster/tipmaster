open(A,">>xx2.txt");
for($x=(256*18)+1;$x<=(384*18);$x+=18){
$y=$x-2289;
print A " $y , $x\n";
$y1=$y+1;$x1=$x+1;
print A " $y1 , $x1\n";
$y1=$y+2;$x1=$x+2;
print A " $y1 , $x1\n";


}





