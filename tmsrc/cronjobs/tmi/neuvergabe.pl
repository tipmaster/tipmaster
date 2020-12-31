#!/usr/bin/perl

require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl" ;
$calculate=1;
open(R12,"/tmdata/tmi/warte.txt");
while(<R12>) {
@all = split (/&/ , $_);
$c=time();
$c=$all[6]+(72*60*60)-$c;
$c=int($c/60);
$xx++;
if ( $c > 0 ) {

###### FREIE VEREINE ##########################
$frei = 0;$liga = 0;

open(D2,"/tmdata/tmi/history.txt");
while(<D2>) {
$liga++;
@vereine = split (/&/, $_);	
if ( !&listOnBoerse($liga) ) {
$y = 0;
for ( $x = 1; $x < 19; $x++ )
{
$y++;
chomp $verein[$y];
$data[$x] = $vereine[$y];
$y++;
chomp $verein[$y];
$datb[$x] = $vereine[$y];
if ( $datb[$x] eq "Trainerposten frei" ) { 
$frei++;
$auswahl_verein[$frei] = $data[$x] ;
$auswahl_liga[$frei] = $liga ;
}
$y++;
chomp $verein[$y];
$datc[$x] = $vereine[$y];
}}}


$frei=$frei*1;
print "$frei Verein(e) zu vergeben ...\n\n";
if ( $frei == 0 ) {goto return2}
#################################################

$frei = $auswahl_verein[1] ;
$verein = $frei;
$freio = '&' . $auswahl_verein[1] . '&' ;
$adresse = $all[3] ;$mail=$adresse;
srand();  
$aa = " ";$ac = "&";
$voller_name = $all[1] ;
$suche = $ac . $voller_name . $ac ;
$pass1 = $all[2];$pass2 = $all[2];

&get_date;
&return_html;
}


return1:
}
close(R12);



return2:
open(D,"</tmdata/tmi/warte.txt");
while(<D>){
@all=split(/&/,$_);
if ( $vergeben{$all[1]} != 1 ) {
$line++;
$lines[$line]=$_; chomp $lines[$line];
}}
close(D);

open(D,">/tmdata/tmi/warte.txt");
for($x=1;$x<=$line;$x++){
print D "$lines[$x]\n";
}
close(D);
goto mark;
exit;


sub return_html {
$fehler=0;

###### verbotene Emails ####################################
$ban=0;
open (D1,"/tmdata/banmail.txt");
while(<D1>){$rr=$_;chomp $rr;
if ( $mail =~ /$rr/ ) { $ban=1;$ban_id=$rr ;}}
close(D1);
if ( $ban == 1 ){
$fehler++;}
###########################################################


################# CHECK BTM UND TMI #########################
$vorhanden_tmi=0;$vorhanden_para=0;$vorhanden_btm=0;$vorhanden = 0;$r = 0;$mail_vorhanden = 0;

open(D2,"/tmdata/btm/history.txt");
while(<D2>) {$r++;
$zeilen[$r] = $_;
chomp $zeilen[$r];
if ($_ =~ /$suche/i) {
$vorhanden_btm = 1;
}}close(D2);

open(D2,"/tmdata/tmi/history.txt");
while(<D2>) {$r++;
$zeilen[$r] = $_;
chomp $zeilen[$r];
if ($_ =~ /$suche/i) {
$vorhanden_tmi = 1;
}}close(D2);

$ae = "!" ;
$suche = $ae . $suche ;
$r = 0;open(D2,"/tmdata/pass.txt");
while(<D2>) {
$r++;
$zeileno[$r] = $_;
chomp $zeileno[$r];
if ($_ =~ /$suche/) {
$vorhanden_para = 1;
@aal=split(/&/,$_);
$pass_richtig = $aal[2];
$mail_richtig = $aal[3];
}

if ($_ =~ /&$mail&/) {
@aal=split(/&/,$_);
$tmp1 = $aal[1];
$tmp2 = $aal[3];
if ( $tmp1 ne $voller_name){
$mail_vorhanden = 1;
}

}


}
close(D2);

###################################################################


$ein = 1;
if ($voller_name =~ /^[A-Z]([a-z]|-[A-Z])* [A-Z]([a-z]|-[A-Z])*$/) { $ein = 0; }
$mail_ok = 0;

if ( $adresse !~ /^.+\@(\[?)[a-zA-Z0-9\-\.]+\.([a-zA-Z]{2,3}|[0-9]{1,3})(\]?)$/) { $mail_ok = 1 }
if ( $adresse =~ / /) { $mail_ok = 1 }


$rr = length($voller_name);
if ( $rr > 22 ) { $ein = 1 }
if ( $rr < 6 ) {$ein = 1 }
$rr = length($pass1);
if ( $rr < 4 || $rr > 16 || $pass1 =~ / / || $pass1 =~ /\&/ || $pass1=~ /\!/ || $pass1 =~ /\#/ ) { $pass_ok=1 }


if ( $ein == 1 ) { 
$fehler++;
}	

if ( $mail_ok == 1 ) { 
$fehler++;
}	

if ( $vorhanden_tmi == 1 ) { 
$fehler++;
}	

if ( $mail_vorhanden == 1 ) { 
$fehler++;
}	


if ( $pass_ok == 1 ) { 
$fehler++;
}	


if ( $vorhanden_para == 1 && (($pass_richtig ne $pass1) || ($mail_richtig ne $mail))) { 
$fehler++;
}


if ( $method ne "W" ) {
$r=0;
open(D2,"/tmdata/tmi/history.txt");
while(<D2>) {
$r++;$zeilen[$r] = $_;
chomp $zeilen[$r];
if ($_ =~ /$freio/i) {
@vereind = split (/&/, $_);	
$linie = $r ;}}
close(D2);
$lor[0] = $vereind[0] ;
$y = 0;
for ( $x = 1; $x < 19; $x++ )
{$y++;chomp $vereind[$y];
$data[$x] = $vereind[$y];
$y++;chomp $vereind[$y];
$datb[$x] = $vereind[$y];
$y++;}
for ( $x = 1; $x < 19; $x++ )
{if ( $data[$x] eq $verein ) {
if ( $datb[$x] ne "Trainerposten frei" ) { 
$fehler++;
}
$datb[$x] = $voller_name ;
$datc[$x] = $adresse ;
}}
}
if ( $fehler == 0) { &anmelden }
if ( $fehler > 0) {
$vergeben{$voller_name} = 1;
print "$voller_name abgelehnt -> $fehler Fehler\n";goto return1;
}
}


sub anmelden {

$pass=$pass1;

$aa = "&";
$zeilen[$linie] = $lor[0] . $aa ;
for ( $x = 1; $x < 19; $x++ )
{
$zeilen[$linie] = $zeilen[$linie] . $data[$x] . $aa . $datb[$x] . $aa . $aa ;
}


if ( $vorhanden_para != 1 ) {
open(D2,">>/tmdata/pass.txt");
flock (D2, 2);
print D2 "!&$voller_name&$pass1&$adresse&\n";
flock (D2, 8);
close (D2) ;
}

open(A2,">/tmdata/tmi/history.txt");
flock (A2, 2);
for ( $x = 1; $x <=$rr_ligen; $x++ )
{
print A2 "$zeilen[$x]\n";

}
flock (A2, 8);
close(A2);

open(A2,">>/tmdata/tmi/link.txt");
print A2 "&$voller_name&Automatische Vergabe&\n";
close (A2) ;     
open(A2,">>/tmdata/tmi/anmeldung.txt");
flock (A2 , 2);
print A2 "&$date&$time&Automatische Vergabe&$voller_name&$adresse&$linko&\n";
flock (A2 , 8);
close (A2) ; 

open(D,"</tmdata/check_ip_tmi.txt");
$ips=<D>;@ip=split(/&/,$ips);
close(D);
open(D,">/tmdata/check_ip_tmi.txt");
print D "Automatische Vergabe&$ip[0]&$ip[1]&$ip[2]&$ip[3]&";
close(D);


&send_mail;

}

sub send_mail {

$tmp = $voller_name;
$tmp =~s/ /%20/g;
srand();  $nr="";
for ( $x=1 ; $x <=9 ; $x ++ ) {
$nn = int(rand(9)) + 1 ;
$nr = $nr . $nn;
}

open(AA,">/tmdata/tmi/free/$trainer");
print AA $nr;
close(AA);
$mail{Message}="";
   $mail{Message} .= "TipMaster international\nhttp://www.tipmaster.de/tmi/\n\n\n ";
   $mail{Message} .= "             *** Einstellungsschreiben ***\n\n";
   $mail{Message} .= "Sehr geehrte(r) $voller_name ,\n\n";
   $mail{Message} .= "herzlichen Glueckwunsch . Sie sind ab sofort neue(r) Trainer(in)\n";
   $mail{Message} .= "bei $frei in der $liga_namen[$linie] .\n\n";
   $mail{Message} .= "Ihre Zugansdaten fuer den TipMaster LogIn :\n\n";
   $mail{Message} .= "Trainername  : $voller_name\n";
   $mail{Message} .= "Passwort     : $pass\n\n

Bitte aktivieren Sie zum Freischalten Ihres Accounts folgenden Link :\n
http://www.tipmaster.de/cgi-bin/tmi/anmeldung.pl?m=f&t=$tmp&nr=$nr\n\n";

   $mail{Message} .= "Bei Fragen zum Spielsystem lesen Sie bitte das Regelbuch sowie die FAQ zum TipMaster .\nWir wuenschen Ihnen viel Spass und Erfolg beim TipMaster .\n\n";
   $mail{Message} .= "Mit freundlichen Gruessen\nIhr TipMaster - Team\n";

    $mailprog = '/usr/sbin/sendmail';
    open(MAIL,"|$mailprog -t");
    print MAIL "To: $adresse\n";
    print MAIL "From: service\@tipmaster.net ( TipMaster online )\n";
    print MAIL "Subject: TipMaster international Anmeldung\n\n" ;
    print MAIL "$mail{Message}";
    close (MAIL);

$vergeben{$voller_name} = 1;
print "Vergabe erfolgt : $voller_name -> $frei\n";
$yy=time();
open(AB,">>/tmdata/tmi/newjob.txt");
print AB "$voller_name&$frei&$all[6]&$yy&\n";
close(AB);
$calculate=1;
}

mark:
if ( $calculate == 1 ) {
open(DD,"</tmdata/tmi/newjob.txt");
while(<DD>){
$u++;
@kk=split(/&/,$_);
$dif[$u]=$kk[3]-$kk[2];
}
close(DD);

$end=$u-99;$div=100;
if ( $end < 1 ) { $end = 1 ; $div = $u;}
for($x=$u;$x>=$end;$x--){
$summe+=$dif[$x];
$rr=int($dif[$x]/60/60);
print "$x $rr\n";
}

$avg=int($summe/$div/60);
open(A,">/tmdata/avg_neu_tmi.txt");
print A $avg;
close(A);
}












sub get_date {

    @days   = ('Sunday','Monday','Tuesday','Wednesday',
               'Thursday','Friday','Saturday');
    @months = ('January','February','March','April','May','June','July',
	         'August','September','October','November','December');
$secs=localtime(time);
    ($sec,$min,$hour,$mday,$mon,$year,$wday) = (localtime(time+0))[0,1,2,3,4,5,6];
    $time = sprintf("%02d:%02d:%02d",$hour,$min,$sec);
    $year += 1900;

    $date = "$months[$mon] $mday, $time";

}

