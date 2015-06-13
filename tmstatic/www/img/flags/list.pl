open(A,"<tmp.txt");
while(<A>)
{
@all=split(/\"/,$_);

print "$all[3]\n";
$img = lc($all[3]);
`wget http://www.komar.org/ip_to_country/flags/$img.gif`;
}
close(A);
