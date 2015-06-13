require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl";
require "/tmapp/tmsrc/cgi-bin/tmi/saison.pl";

open (D1,"</tmdata/tmi/heer.txt");
while(<D1>){
$a=$_;
@i=split(/&/,$a);
$liga{"$i[5]"} = $liga_namen[$i[1]];

}
close(D1);
open (D5,">/tmdata/tmi/pokal_erfolge.txt");

print D5" 
11&Belgien&SK Beveren&Christian Kraik&VV St.Truiden&Frank Bauer&56&30&\n
10&Belgien&VV St.Truiden&Frank Bauer&KV Kortrijk&Michael Berger&&&\n
9&Belgien&Lierse SK&Michael Hoffmann&KV Mechelen&Tino Welker&62&30&\n
8&Belgien&SK Lommel&Lars Boeck&SC Charleroi&Thomas Urban&54&49&\n
7&Belgien&AA Gent&Boris Linert&SK Lommel&Andreas Pusch&100&96&\n
6&Belgien&RC Harelbeke&Johannes Rudolph&RC Genk&Olaf Scheffler&67&12&\n
11&England&Blackburn Rovers&Chris Queva&FC Everton&Timo Drunagel&35&0&\n
10&England&Derby County&Carl J. Gerhardt&Aston Villa&Thomas Seth&&&\n
9&England&Newcastle United&Christoph Schruefer&Crystal Palace&Guiseppe Paradiso&45&16&\n
8&England&Leicester City&Alexander Barth&Newcastle United&Christoph Schruefer&76&52&
7&England&Manchester United&Daniel Zink&Leicester City&Alexander Barth&85&75&\n
6&England&FC Everton&Armin von Ob&Arsenal London&Karl Huber&68&60&\n
5&England&Nottingham Forest&Holger Mahnke&FC Chelsea&Sven Tartemann&84&39&\n
4&England&Newcastle United&Christoph Schruefer&West Ham United&Gregor Tsagkalidis&73&48&\n
11&Frankreich&AC Le Havre&Manuel Singal&AC Ajaccio&Markus Kick&105&60&\n
10&Frankreich&AS Cannes&Wolfgang Helm&FC Metz&Bernhard Preuss&&&\n
9&Frankreich&Girondins Bordeaux&Robert Wirth&AS Cannes&Wolfgang Helm&43&22&\n
8&Frankreich&FC Metz&Bernhard Preuss&Girondins Bordeaux&Robert Wirth&74&66&\n
7&Frankreich&FC Sochaux&Dirk van der Heyde&FC Toulouse&Adrian Beck&48&18&\n
6&Frankreich&AS Monaco&Markus Kern&FC Sochaux&Dirk van der Heyde&65&40&\n
5&Frankreich&FC Sochaux&Dirk van der Heyde&Olympique Lyon&Juergen Wilke&70&26&\n
4&Frankreich&SEC Bastia&Rene Hausjell&Olympique Marseille&Rahel Gubler&73&0&\n
11&Italien&AC Venezia&Rolf Borkowsky&AC Cesena&Markus Klumpen&81&77&\n
10&Italien&AC Florenz&Peter Russ&Lazio Rom&Joerg Schmaehl&&&\n
9&Italien&AC Parma&Reinhold Abram&FC Genua 93&Sirko Seidel&27&22&\n
8&Italien&Piacenza Calcio&Stephan Bierwirth&Brescia Calcio&Michael Abbass&54&35&\n
7&Italien&Vicenza Calcio&Josef Fuhrmann&Sampdoria Genua&Kolja Dobrindt&76&71&\n
6&Italien&Inter Mailand&Ingo La Roche&AC Mailand&Andreas Kurz&67&60&\n
5&Italien&AC Parma&Reinhold Abram&Piacenza Calcio&Stephan Bierwirth&86&55&\n
4&Italien&FC Bologna&Hartmut Kroeber&FC Empoli&Sandra Boettcher&78&77&\n
11&Niederlande&Ajax Amsterdam&Andreas Stamm&SC Telstar&Kathrin Gebhardt&57&0&\n
10&Niederlande&Sparta Rotterdam&Markus Reiss&FC Volendam&Uwe Pallasch&&&\n
9&Niederlande&Vitesse Arnheim&Simon Moser&MVV Maastricht&Heiko Weiss&56&0&\n
8&Niederlande&Sparta Rotterdam&Markus Reiss&AZ Alkmaar&Marcus Kluehe&65&54&\n
7&Niederlande&FC Den Bosch&Andreas Schulzki&Feyenoord Rotterdam&Frank Schalldach&84&30&\n
6&Niederlande&NEC Nijmwegen&Marcel Spanjer&SC Heerenveen&Bjoern Bludau&56&35&\n
11&Oesterreich&ASK Pasching&Ramon Santer&Untersiebenbrunn&Manfred Kirchner&52&0&\n
10&Oesterreich&TSV Hartberg&Peter Schaferl&Vienna FC&Reto Pfister&&&\n
9&Oesterreich&LASK Linz&Michael Schwab&SV Woergl&Rudolf Espertshuber&65&44&\n
8&Oesterreich&Austria Lustenau&Reto Pfister&SV Schwechat&Harry Weihrich&90&80&\n
7&Oesterreich&Austria Salzburg&Hans Peter Hoefler&Schwarz Weiss Bregenz&Michael Wider&40&0&\n
6&Oesterreich&Schwarz-Weiss Bregenz&Michael Wider&Austria Klagenfurt&Arnold Paule&55&48&\n
11&Portugal&SC Farense&Roman Gubler&CF Uniao Madeira&Daniel Moser&47&30&\n
10&Portugal&Vitoria Setubal&Roman Klapper&Vitoria Guimaraes&Joachim Salg&&&\n
9&Portugal&Benfica Lissabon&Sven Hennemann&Academica Coimbra&Pavel Dvorcuk&65&57&\n
8&Portugal&Sporting Braga&Silvio Hoffmann&Vitoria Guimaraes&Joachim Salg&51&20&\n
7&Portugal&Estrela Amadora&Jussara Iarrobino&SC Farense&Gregory Strohmann&65&46&\n
6&Portugal&Vitoria Guimaraes&Joachim Salg&Boavista Porto&Joerg Hennemann&41&0&\n
11&Schweiz&FC Yverdon Sports&Frank Sauter&FC Lugano&Markus Heer&67&61&\n
10&Schweiz&FC Wil 1900&Marco Cuoco&&&&&\n
9&Schweiz&Lausanne Sports&Arnas Balvonas&FC Luzern&Gabi Keller&42&41&\n
8&Schweiz&SR Delemont&Stephan Krieger&FC Luzern&Gabi Keller&66&15&\n
7&Schweiz&Lausanne Sports&Arnas Balvonas&Young Boys Bern&Renate Maurer&67&18&\n
6&Schweiz&FC Aarau&Rene Franzen&FC Etoile Carouge&Amateurtrainer&75&44&\n
11&Spanien&SD Compostela&Tonio Kroeger&CF Valencia&Markus Leugner&57&54&\n
10&Spanien&San Sebastian&Niki Taubert&RCD Mallorca&Matthias Lang&&&\n
9&Spanien&San Sebastian&Niki Taubert&Sporting Gijon&Henning Schaaf&77&42&\n
8&Spanien&Celta de Vigo&Thomas Eckert&FC Barcelona&Gilbert Nothar&54&23&\n
7&Spanien&Atletico Madrid&Adrian Wittwer&FC Barcelona&Gilbert Nothar&66&53&\n
6&Spanien&San Sebastian&Niki Taubert&CD Teneriffa&Jimbo Rothmeier&67&44&\n
5&Spanien&Atletico Madrid&Adrian Wittwer&Real Saragossa&Andreas Bruehl&27&26&\n
4&Spanien&Espanyol Barcelona&Thomas Buden&Athletic Bilbao&Ralf Steiner&54&25&\n
";

for ($run=1;$run<=2;$run++){

if ($run == 1){$a1 =12;$a2 = $main_nr-1}
if ($run == 2){$a1 =$main_nr;$a2 = $main_nr}

for ($saison=$a1;$saison<=$a2;$saison++) {

@data=();
%trainer=();
@team=();
@id=();
@all=();
@bb1=();
@vereine=();


$url="/tmdata/tmi/archiv/$main_kuerzel[$saison]/";

@i=();

open (D1,"<$url/heer.txt");

while(<D1>){
$a=$_;
@i=split(/&/,$a);
$nr=(($i[1]-1)*18)+$i[4];
$team[$nr] = $i[5];
}
close(D1);
$sx=0;
open (D1,"<$url/pokal/pokal.txt");
while(<D1>){
$sx++;
$row[$sx]=$_;
chomp $row[$sx];
}
close (D1);

for($x=1;$x<=49;$x++){
open (D1,"<$url/pokal/pokal_quote.txt");
$aa=1;
for($r=1;$r<=5;$r++){

for($l=1;$l<=$x-1;$l++){$_=<D1>;}

#@bb1=();
if ( $r==1){
@id=split(/&/,$row[$x]);
}

$_=<D1>;
$kk=$_;
@all=split(/&/,$kk);

$aa=$aa*2;
$bb=(64/$aa);
#nprint "$bb -";


for ($y=2;$y<=$bb;$y=$y+2){
$xx=$y-1;

$xy = int($y/2);
if ( $id[$y] == 9999 ) { $all[$y] = -1 }

if ( $r < 5 ) {
if ( $all[$xx] > $all[$y] ) {
$bb1[$xy]=$id[$xx];$ok=$id[$y]; 

if ( $cc{$team[$id[$y]]} eq "" ) {$verein++;$array[$verein]=$team[$id[$y]];}

$cc{$team[$id[$y]]} .= "#$saison&$r";

} else {  
$bb1[$xy]=$id[$y];$ok=$id[$xx] ;
if ( $cc{$team[$id[$xx]]} eq "" ) {$verein++;$array[$verein]=$team[$id[$xx]];}
$cc{$team[$id[$xx]]} .= "#$saison&$r";

}
}

}
@id=();
@id = @bb1;
for($l=$x+1;$l<=49;$l++){$_=<D1>;}
}
close(D1);




$rr = 0;
$li=0;
$liga=0;
open(DQ2,"$url/history.txt");
while(<DQ2>) {
$li++;
@vereine = split (/&/, $_);

$ey = 0;
for ( $ex = 1; $ex < 19; $ex++ )
{
$ey++;
chomp $verein[$ey];
$data[$ex] = $vereine[$ey];
$ey++;
chomp $verein[$ey];
$datb[$ex] = $vereine[$ey];
$aktiv{"$datb[$ex]"} = 1;
$ey++;
chomp $verein[$ey];
$datc[$ex] = $vereine[$ey];
$trainer{$data[$ex]}=$datb[$ex];
}
}
close(DQ2);

$yy="";
$yy= $liga{"$team[$bb1[1]]"};

#print "$saison $liga{$team[$bb1[1]]} $team[$bb1[1]]\n";
($yy,$yhg)=split(/ /,$yy);
if ( $all[1] > $all[2] ) {

if ( $cc{$team[$bb1[1]]} eq "" ) {$verein++;$array[$verein]=$team[$bb1[1]];}
if ( $cc{$team[$bb1[2]]} eq "" ) {$verein++;$array[$verein]=$team[$bb1[2]];}
$cc{$team[$bb1[1]]} .= "#$saison&6";
$cc{$team[$bb1[2]]} .= "#$saison&5";

print D5 "$saison&$yy&$team[$bb1[1]]&$trainer{$team[$bb1[1]]}&$team[$bb1[2]]&$trainer{$team[$bb1[2]]}&$all[1]&$all[2]&\n";
} else {

if ( $cc{$team[$bb1[1]]} eq "" ) {$verein++;$array[$verein]=$team[$bb1[1]];}
if ( $cc{$team[$bb1[2]]} eq "" ) {$verein++;$array[$verein]=$team[$bb1[2]];}
$cc{$team[$bb1[1]]} .= "#$saison&5";
$cc{$team[$bb1[2]]} .= "#$saison&6";

print D5 "$saison&$yy&$team[$bb1[2]]&$trainer{$team[$bb1[2]]}&$team[$bb1[1]]&$trainer{$team[$bb1[1]]}&$all[2]&$all[1]&\n";
}

}
}
close(D5);



if ($run == 1)
{
open (GG,">/tmdata/pokaldump.txt");
for ($x=1;$x<=$verein;$x++){
if ( $array[$x] ne "" ) {
print GG "&$array[$x]$cc{$array[$x]}\n";
}}
close(GG);
@array=();
%cc=();
}

if ($run == 2)
{
open (GG,">/tmdata/pokaldump_cur.txt");
for ($x=1;$x<=$verein;$x++){
if ( $array[$x] ne "" ) {
print GG "&$array[$x]$cc{$array[$x]}\n";
}}
close(GG);
}

}




exit;
