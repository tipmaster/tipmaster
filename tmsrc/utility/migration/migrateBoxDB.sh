echo "Start Mysql Dump ..."
ssh root@ber "mysqldump -uroot -pDungaum33! mbox > /tmp/mbox.sql"
echo "Dump finished."
ssh root@ber "bzip2 /tmp/mbox.sql"
echo "Start secure copy ..."
scp root@ber:/tmp/mbox.sql.bz2 /tmp
echo "Secure copy finished."
bunzip2 /tmp/mbox.sql.bz2
echo "Start DB import ..."
mysql -uroot -pDungaum33! mbox -e"drop database mbox; create database mbox;use flt;source /tmp/mbox.sql;"
echo "Import finished."
