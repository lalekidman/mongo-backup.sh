#!/usr/bin/env bash
BACKUP_DIR=/data/back-up/;
FILE_NAME=$(date +"%Y-%m-%d");
DB_NAME="kyoo_automotive";
DB_AUTH_NAME="kyoo_automotive";
DB_USERNAME="kyoo_automotive_admin";
DB_PASSWORD="Passw0rdo";
DB_HOST="172.31.0.181:27017";
FULL_DIR="${BACKUP_DIR}${FILE_NAME}.zip"
EXCLUDED_COLLECTIONS=("employee_tokens" "logs");
EXCLUDED_COLLECTION_CMD="";
for i in "${EXCLUDED_COLLECTIONS[@]}";
	do 
		#concat excluded_collections with mongo exlude collection cmd
		EXCLUDED_COLLECTION_CMD="${EXCLUDED_COLLECTION_CMD} --excludeCollection=$i"; 
done
AWS_URI="s3://kyoo-automotive-back-up-db";
mongodump --forceTableScan --host=${DB_HOST} -u ${DB_USERNAME} -p ${DB_PASSWORD} --authenticationDatabase=${DB_AUTH_NAME} --db=${DB_NAME} ${EXCLUDED_COLLECTION_CMD}  --gzip --archive=${FULL_DIR}
sudo aws s3 mv ${FULL_DIR} ${AWS_URI};
