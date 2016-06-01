require "dfb_runde1.pl";
require "btm_pokal_ansetzung.pl";
`/bin/cp -f tmi_pokal_leer.txt /tmdata/tmi/pokal/pokal_quote.txt`;
require "tmi_pokal_ansetzung.pl";
`/bin/cp -f pokal_quote_btm.txt /tmdata/btm/pokal/pokal_quote.txt`;

print "\n\n BTM und TMI Pokal neu aufgesetzt !\n";



	#reset rights - problem occurredd fter git trainsition, tp, Aug-24-2105
`chown -R lighttpd:lighttpd /tmdata`;
`chmod -R 755 /tmdata`;