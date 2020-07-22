#!/usr/bin/env bash
BACKUP_DIR=/data/back-up/;
FILE_NAME=date + "%Y-%m-%d";
DB_NAME="";
DB_USERNAME="";
DB_PASSWORD="";
DB_HOST="";
FULL_DIR=${BACKUP_DIR}${FILE_NAME}
mongodump --forceTableScan --host=${DB_HOST} -u ${DB_USERNAME} -p ${DB_PASSWORD} --authenticationDatabase=${DB_AUTH_NAME} --db=${DB_NAME} --excludeCollection=employee_tokens --excludeCollection=logs --gzip --archive=${FULL_DIR}
