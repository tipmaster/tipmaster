#!/usr/bin/perl

use DBI;

require "/tmapp/tmsrc/cgi-bin/btm_ligen.pl" ;
require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl" ;


 use Properties;
 our $options = Properties->new('/tmdata/tm.properties');

use lib qw{/tmapp/tmsrc/cgi-bin};
use Test;
my $mlib= new Test;

my @btm_liga_namen = $mlib->btm_liga_namen();
my @tmi_liga_namen = $mlib->tmi_liga_namen();
my @liga_kuerzel = $mlib->tmi_liga_kuerzel();


open(D2,"/tmdata/btm/heer.txt");
while(<D2>) {
@all = split (/&/ , $_);
$platz{$all[5]}=$all[0];

}
close (D2);

$e=0;
open(D2,"/tmdata/btm/history.txt");
while(<D2>) {
@vereine = ();
$e++ ;
@vereine = split (/&/, $_);	
$ya = 0;
for ( $x = 1; $x < 19; $x++ )
{
$ya++;
$y++;
chomp $vereine[$ya];
$x[$y] = $vereine[$ya];
$ya++;
chomp $vereine[$ya];
$b[$y] = $vereine[$ya];

$ya++;
chomp $vereine[$ya];
$datc[$y] = $vereine[$ya];
$liga[$y] = $e ;
$vereine_btm{$b[$y]} = $x[$y];
$liga_btm{$b[$y]} = $e;
$coach{$b[$y]} = $b[$y];
}
}
close(D2);

open(D2,"/tmdata/tmi/heer.txt");
while(<D2>) {
@all = split (/&/ , $_);
$platz{$all[5]}=$all[0];

}
close (D2);
$e=0;
open(D2,"/tmdata/tmi/history.txt");
while(<D2>) {
@vereine = ();
$e++ ;
@vereine = split (/&/, $_);	
$ya = 0;
for ( $x = 1; $x < 19; $x++ )
{
$ya++;
$y++;
chomp $vereine[$ya];
$x[$y] = $vereine[$ya];
$ya++;
chomp $vereine[$ya];
$b[$y] = $vereine[$ya];

$ya++;
chomp $vereine[$ya];
$datc[$y] = $vereine[$ya];
$liga[$y] = $e ;
$vereine_tmi{$b[$y]} = $x[$y];
$liga_tmi{$b[$y]} = $e;
$coach{$b[$y]} = $b[$y];

}
}
close(D2);


#load data
for my $key ( keys %coach ) {
        my $value = $coach{$key};
#        print "$index $key => $value $vereine_btm{$key} $vereine_tmi{$key}\n";
	$index++;


#	print "$key .......\n$coach{$key}\n\n";
@go=();
	&openDB();
      $sql = "SELECT userid FROM user WHERE username='".$coach{$key}."'";
      $sth = $dbh->prepare($sql);
      $sth->execute() or die "caanot execute query $sql";
      while (@data = $sth->fetchrow_array){@go=@data}
      $sth->finish();
	&closeDB;


print "$key $go[0]\n";


my $signature = '<div style="font-family:tahoma,verdana;font-size:11px;padding-top:10px;"><span style="font-size:12px"><b>'.$coach{$key}.'</b></span><div style="padding-top:10px;vertical-align:middle"><table>';

if ($vereine_btm{$key} ne "") {
$signature .= '<tr><td style="font-family:tahoma,verdana;font-size:11px;"><img src="http://www.tipmaster.de/img/flags/de.gif" width=20 height=12> &nbsp; '.$vereine_btm{$coach{$key}}.' &nbsp; &nbsp; </td><td style="font-family:tahoma,verdana;font-size:11px;">' . $btm_liga_namen[$liga_btm{$coach{$key}}]. ' &nbsp; </td><td align=right style="font-family:tahoma,verdana;font-size:11px;"> &nbsp; ' . $platz{$vereine_btm{$coach{$key}}} . '. Platz </td></tr>';
}

if ($vereine_tmi{$key} ne "") {

(my $short,$xx)= split(/ /,$liga_kuerzel[$liga_tmi{$coach{$key}}]);
$short=lc($short);
if ($short eq "---"){$short="ger"}

$signature .= '<tr><td style="font-family:tahoma,verdana;font-size:11px;"><img src="http://www.tipmaster.de/img/fg/'.$short.'.gif" width=20 height=12> &nbsp; '.$vereine_tmi{$coach{$key}}.' &nbsp; &nbsp; </td><td style="font-family:tahoma,verdana;font-size:11px;">' . $tmi_liga_namen[$liga_tmi{$coach{$key}}]. ' &nbsp; </td><td align=right style="font-family:tahoma,verdana;font-size:11px;"> &nbsp; ' . $platz{$vereine_tmi{$coach{$key}}} . '. Platz</td></tr>';
}



$signature .= '</table></div></div>';


$signature=~s/\'/\\\'/g;

if ($key eq "Forum Moderation") {$signature = "";}
if( $go[0] ne "") {
	&openDB();
      $sql = "UPDATE usertextfield SET signature='$signature' where userid=".$go[0];
      $sth = $dbh->prepare($sql) or die "could not prepare query ".$sql . "\n".$sth->errstr;
      $sth->execute() or die "could not execute query ".$sql. "\n".$sth->errstr;
      $sth->finish();
	&closeDB;

        &openDB();
      $sql = "UPDATE sigparsed SET signatureparsed='$signature' where userid=".$go[0];
      $sth = $dbh->prepare($sql)or die "could not prepare query ".$sql . "\n".$sth->errstr;
      $sth->execute() or die "could not execute query ".$sql. "\n".$sth->errstr;
      $sth->finish();
        &closeDB;

    }
}


sub openDB {
    my $db = "forum";
    my $host = "localhost";
    my $user = $options->getProperty("db.user");;
    my $password = $options->getProperty("db.password");;
    $dbh = DBI->connect("DBI:mysql:database=$db;host=$host",
                        $user, $password, {RaiseError => 0, PrintError => 0});
    }

sub closeDB {
    $dbh->disconnect();
}

