#!/usr/bin/env bash

source kdb_log.sh;

DATE=`date +"%Y%m%d"`;
TARGET="わかもと製薬";
DATA=`cat $DATE_utf.csv | grep $TARGET`;
LOG=wakamoto.log;

get_kdb_data $DATE ;

echo -n $DATE >> $LOG;
echo -n `get_tagged_value $DATA "始値";` >> $LOG;
echo -n `get_tagged_value $DATA "終値";` >> $LOG;
echo "" >> $LOG;

cat $LOG;
