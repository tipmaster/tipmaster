#!/usr/bin/perl


@verwaltung = ( 
	"1|0|0|0|0|0|0|0|/tmapp/tmsrc/utility/content/data/user.txt|TipMaster Team",
	"1|1|1|1|0|0|0|0|/tmapp/tmsrc/utility/content/data/links.txt|Link Liste",
	"1|1|0|1|0|0|0|0|/tmapp/tmsrc/utility/content/data/persons.txt|Kontakt Seite",
	"1|1|0|1|0|0|0|0|/tmapp/tmsrc/utility/content/data/faqs.txt|FAQ Eintraege",
	"1|1|0|1|0|0|0|0|/tmdata/www/Regeln.shtml|Regelbuch",
	"1|1|1|0|0|0|0|0|/tmapp/tmsrc/utility/content/data/blacklist.txt|Foren Sperren"
);

@categories = (
	"Spielleitung|Superuser|Forum Mods|User Support|Tippformular|Top Tip|",
	"Vereins Turniere|NM Turniere|Vereinsseiten|Sonstige Seiten|",
	
	"",
	"",
	"",
	"Gelb|Rot|",
);

@format = (	
	"",
	"[Kategorie Index]|[Link zur Seite]|[Verantwortlicher]|[Titel Seite]|[zuletzt geprueft]|[kurze Beschreibung-max. 100 Zeichen]",
	"",
	"[Frage]|[Antwort]",
	"[Purer HTML Quelltext]",
	"Gelb|Beispiel Trainer|13.10.2005|21.10.2005|"
);

@name = (
	"",
	"Private TipMaster Seiten",
	"TipMaster FAQ",
	"TipMaster FAQ"

);

#takes trainer name and app id as input params
sub grantRights()
{
$tmp1=shift;
$tmp2=shift;
$allow=0;

$this = $verwaltung[$tmp2];
@app=split(/\|/,$this);

open(A,"/tmdata/content/user.txt");
while(<A>)
{
@tmp=split(/\|/,$_);
if ($tmp[8] eq $tmp1)
{
@rights=split(/\|/,$_);
}
}

for ($i=0;$i<8;$i++)
{
if (($app[$i]>0) && ($rights[$i]>0)){$allow=1};

}



return $allow;


}
