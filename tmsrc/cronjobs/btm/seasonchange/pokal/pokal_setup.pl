require "dfb_runde1.pl";
require "btm_pokal_ansetzung.pl";
`mv tmi_pokal_leer.txt /tmdata/tmi/pokal/pokal_quote.txt`;
require "tmi_pokal_ansetzung.pl";
`mv pokal_quote_btm.txt /tmdata/btm/pokal/pokal_quote.txt`;

print "\n\n BTM und TMI Pokal neu aufgesetzt !\n";



