#!/usr/bin/perl


#nach saisonerhoehung ausfuehren !
require "/tmapp/tmsrc/cgi-bin/tmi/saison.pl";
open (D1,">/tmdata/tmi/erfolge.txt");

print D1 "4#Italien Serie A#AC Venezia#Ralf Borkowski#\n";
print D1 "5#Italien Serie A#AC Parma#Reinhold Abram#\n";
print D1 "6#Italien Serie A#Udinese Calcio#Richard Weichselbaeumer#\n";
print D1 "7#Italien Serie A#Hellas Verona#Jan Frunzke#\n";
print D1 "8#Italien Serie A#Inter Mailand#Ingo La Roche#\n";
print D1 "9#Italien Serie A#AC Parma#Reinhold Abram#\n";
print D1 "10#Italien Serie A#Vicenza Calcio#Josef Fuhrmann#\n";
print D1 "11#Italien Serie A#Udinese Calcio#Richard Weichselbaeumer#\n";

print D1 "4#England Premier League#Sheffield Wednesday#Marcus Brink#\n";
print D1 "5#England Premier League#FC Chelsea#Sven Tartemann#\n";
print D1 "6#England Premier League#Aston Villa#Daniel Zink#\n";
print D1 "7#England Premier League#Tottenham Hotspurs#Nils Masuch#\n";
print D1 "8#England Premier League#Leeds United#Thomas Frymann#\n";
print D1 "9#England Premier League#FC Liverpool#Markus Meyer#\n";
print D1 "10#England Premier League#FC Southampton#Oliver Krueger#\n";
print D1 "11#England Premier League#Newcastle United#Christoph Schruefer#\n";

print D1 "4#Spanien Primera Division#Athletic Bilbao#Ralf Steiner#\n";
print D1 "5#Spanien Primera Division#Real Saragossa#Andreas Bruehl#\n";
print D1 "6#Spanien Primera Division#RCD Mallorca#Matthias Lang#\n";
print D1 "7#Spanien Primera Division#San Sebastian#Niki Taubert#\n";
print D1 "8#Spanien Primera Division#CF Valencia#Markus Leugner#\n";
print D1 "9#Spanien Primera Division#UD Las Palmas#Torsten Lang#\n";
print D1 "10#Spanien Primera Division#Celta de Vigo#Thomas Eckert#\n";
print D1 "11#Spanien Primera Division#San Sebastian#Niki Taubert#\n";

print D1 "4#Frankreich Ligue Une#Girondis Bordeaux#Robert Wirth#\n";
print D1 "5#Frankreich Ligue Une#Paris St. Germain#Andreas Winkler#\n";
print D1 "6#Frankreich Ligue Une#AS Monaco#Markus Kern#\n";
print D1 "7#Frankreich Ligue Une#AS Monaco#Markus Kern#\n";
print D1 "8#Frankreich Ligue Une#AS Nancy#Andreas Domaser#\n";
print D1 "9#Frankreich Ligue Une#FC Metz#Bernhard Preuss#\n";
print D1 "10#Frankreich Ligue Une#AS Monaco#Markus Kern#\n";
print D1 "11#Frankreich Ligue Une#Racing Strasbourg#Andreas Rinder#\n";

print D1 "6#Niederlande Ehrendivision#PSV Eindhoven#Thomas Schruefer#\n";
print D1 "7#Niederlande Ehrendivision#PSV Eindhoven#Thomas Schruefer#\n";
print D1 "8#Niederlande Ehrendivision#Sparta Rotterdam#Markus Reiss#\n";
print D1 "9#Niederlande Ehrendivision#Willem II Tilburg#Sven Preiss#\n";
print D1 "10#Niederlande Ehrendivision#FC Volendam#Uwe Pallasch#\n";
print D1 "11#Niederlande Ehrendivision#Roda JC Kerkrade#Reimund Breucker#\n";

print D1 "6#Belgien 1.Division#Germinal Beerschot#Rene Naas#\n";
print D1 "7#Belgien 1.Division#VV St. Truiden#Frank Bauer#\n";
print D1 "8#Belgien 1.Division#SC Charleroi#Thomas Urban#\n";
print D1 "9#Belgien 1.Division#RSC Anderlecht#Thomas Prommer#\n";
print D1 "10#Belgien 1.Division#KV Kortrijk#Amateurtrainer#\n";
print D1 "11#Belgien 1.Division#VV St. Truiden#Frank Bauer#\n";

print D1 "6#Portugal 1.Divisao#FC Alverca#Martin Ostar#\n";
print D1 "7#Portugal 1.Divisao#Salgueiros Porto#Steffen Mazur#\n";
print D1 "8#Portugal 1.Divisao#FC Leca#Herbert Kurz#\n";
print D1 "9#Portugal 1.Divisao#UD Leiria#Guillaume Cordier#\n";
print D1 "10#Portugal 1.Divisao#CF Belenenses#Thorsten Lueth#\n";
print D1 "11#Portugal 1.Divisao#FC Gil Vicente#Daniel Claussen#\n";

print D1 "6#Schweiz Nationalliga A#FC Wil 1900#Marco Cuoco#\n";
print D1 "7#Schweiz Nationalliga A#Grasshopper Zuerich#Markus Jahn#\n";
print D1 "8#Schweiz Nationalliga A#SC Kriens#Kerstin Blust#\n";
print D1 "9#Schweiz Nationalliga A#FC Locarno#Karsten Schueler#\n";
print D1 "10#Schweiz Nationalliga A#SC Kriens#Kerstin Blust#\n";
print D1 "11#Schweiz Nationalliga A#FC Chiasso#Ingo Wiegel#\n";

print D1 "6#Oesterreich Bundesliga#VfB Admira/Wacker#Michael Martins#\n";
print D1 "7#Oesterreich Bundesliga#Austria Salzburg#Hans Peter Hoefler#\n";
print D1 "8#Oesterreich Bundesliga#DSV Leoben#Jan Lueke#\n";
print D1 "9#Oesterreich Bundesliga#Schwarz Weiss Bregenz#Michael Wieder#\n";
print D1 "10#Oesterreich Bundesliga#Vienna FC#Reto Pfister#\n";
print D1 "11#Oesterreich Bundesliga#LASK Linz#Michael Schwab#\n";

$ti=0;
for ($saison=11;$saison<=$main_nr-2;$saison++){

$url = "/archiv/$main_kuerzel[$saison+1]/";
if ( $saison ==  11 ) { $saison_liga = 60 }
if ( $saison ==  12 ) { $saison_liga = 60 }
if ( $saison ==  13 ) { $saison_liga = 118 }
if ( $saison ==  14 ) { $saison_liga = 118 }
if ( $saison >  14 ) { $saison_liga = 203 }

$datei_quoten = '/tmdata/tmi' . $url . "history.txt";
$rr = 0;
$li=0;
$liga=0;
print "$saison - $datei_quoten\n";
open(DQ2,"$datei_quoten");
while(<DQ2>) {
#print  $_;

#print "$saison - $_\n";;
$li++;
@vereine = split (/&/, $_);

$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
$y++;
chomp $verein[$y];
$data[$x] = $vereine[$y];
$y++;
chomp $verein[$y];
$datb[$x] = $vereine[$y];
$aktiv{"$data[$x]"} =$datb[$x] ;
$y++;
chomp $verein[$y];
$datc[$x] = $vereine[$y];
}
}
close(DQ2);

$datei_quoten = '/tmdata/tmi' . $url . "heer.txt";
print "$datei_quoten\n";
open(D2,"$datei_quoten");
for ($qq=1;$qq<=$saison_liga;$qq++){
$a=<D2>;
#print $a;
chomp $a;
@all=split(/&/,$a);
$ra=$saison+1;

if ( $saison > 19 ) {
require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl";
$all[3]=$liga_namen[$all[1]];
}

$write=0;
if ( $all[3] eq "Italien Serie A" ||  $all[3] eq "England Premier League" ||  $all[3] eq "Spanien Primera Division" ||  $all[3] eq "Frankreich Ligue Une" || $all[3] eq "Niederlande Ehrendivision" || $all[3] eq "Portugal 1.Divisao" || $all[3] eq "Belgien 1.Division" || $all[3] eq "Schweiz Nationalliga A" || $all[3] eq "Oesterreich Bundesliga" ) { $write =1 }
if ( $all[3] =~ /1\.Liga/ ) { $write = 1 }

if ( $write == 1 ) {
print D1 "$ra#$all[3]#$all[5]#$aktiv{$all[5]}#\n";
}
for ($x=1;$x<=17;$x++){
$a=<D2>;
}}
close(D2);
}
close(D1);
