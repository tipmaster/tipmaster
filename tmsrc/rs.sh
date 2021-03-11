while kill -9 `cat /cgi/logs/fcgi-tm.pid` >/dev/null 2>&1; do
	sleep .1
done
spawn-fcgi -u nginx -p 9002 -F 8 -P /cgi/logs/fcgi-tm.pid -- /tipmaster/tmsrc/dispatcher.pl
