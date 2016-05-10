#! /bin/bash
today=$(date +%A)
if [ $today == 'Friday' ]
    then
        FOLDERNAME=$(date +%A)-$(date +%Y%m%d)
    else
        FOLDERNAME=$(date +%A)
fi
 
BACKUP_DIR="backup/$FOLDERNAME"
HOST=""
MYSQL_USER=""
MYSQL=/usr/local/mysql/bin/mysql
MYSQL_PASSWORD=""
MYSQLDUMP=/usr/local/mysql/bin/mysqldump
 
mkdir -p "$BACKUP_DIR"
 
databases=`$MYSQL --host=$HOST --user=$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`
 
for db in $databases; do
  $MYSQLDUMP --force --opt --host=$HOST --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases $db | gzip > "$BACKUP_DIR/$db.gz"
done
