#! /bin/bash
 
TIMESTAMP=$(date +"%F")
BACKUP_DIR="backup/$TIMESTAMP"
MYSQL_USER="root"
MYSQL=/Applications/MAMP/Library/bin/mysql
MYSQL_PASSWORD="root"
MYSQLDUMP=/Applications/MAMP/Library/bin/mysqldump
 
mkdir -p "$BACKUP_DIR/mysql"
 
databases=`$MYSQL --user=$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`
 
for db in $databases; do
  $MYSQLDUMP --force --opt --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases $db | gzip > "$BACKUP_DIR/mysql/$db.gz"
done
