#!/usr/bin/env bash
BACKUP_DIR=/data/back-up/;
FILE_NAME=$(date +"%Y-%m-%d");
DB_NAME="";
DB_AUTH_NAME="";
DB_USERNAME="";
DB_PASSWORD="";
DB_HOST="";
FULL_DIR="${BACKUP_DIR}${FILE_NAME}.zip"
EXCLUDED_COLLECTIONS=();
EXCLUDED_COLLECTION_CMD="";
for i in "${EXCLUDED_COLLECTIONS[@]}";
	do 
		#concat excluded_collections with mongo exlude collection cmd
		EXCLUDED_COLLECTION_CMD="${EXCLUDED_COLLECTION_CMD} --excludeCollection=$i"; 
done
AWS_URI="s3://kyoo-automotive-back-up-db";
mongodump --forceTableScan --host=${DB_HOST} -u ${DB_USERNAME} -p ${DB_PASSWORD} --authenticationDatabase=${DB_AUTH_NAME} --db=${DB_NAME} ${EXCLUDED_COLLECTION_CMD}  --gzip --archive=${FULL_DIR}
sudo aws s3 mv ${FULL_DIR} ${AWS_URI};
