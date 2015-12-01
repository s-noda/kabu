#!/usr/bin/env bash

function get_kdb_data(){
    DATE=$1;
    if [ ! "$DATE" ];
    then
	DATE=`date +"%Y-%m-%d"`;
    fi
    curl -s -A "Mozilla/5" \
	"http://k-db.com/?p=all&download=csv&date=$DATE" \
	-o "$DATE.csv";
    nkf -w "$DATE.csv" > "$DATE_utf.csv";
}

function get_tagged_value (){
    INPUT=$1;
    TAG=$2;
    REF_PATH=$3;
    if [ ! "$REF_PATH" ];
    then
	REF_PATH="`find . | grep -e "utf.csv" | head -1`";
    fi
    ID=0;
    DETECT="";
    for line in `head $REF_PATH -n 2 | tail -1 | sed -e "s/,/\n/g"`;
    do
	    ##echo $TAG vs $line;
	    ##echo $DETECT;
	if [ "$TAG" == "$line" ];
	then
	    DETECT="true";
	else
	    if [ ! "$DETECT" ];
	    then
		ID=`expr $ID + 1`;
	    fi
	fi
    done
	##
    if [ ! "$DETECT" ];
    then
	echo -e "\e[31mtag $TAG not found\e[m";
    else
	## echo $INPUT;
	echo $INPUT | sed -e "s/,/\n/g" | head -n `expr 1 + $ID` | tail -1;
    fi
}

## source kdb_log.sh; get_tagged_value `cat 20151201_utf.csv | grep わかもと製薬` "始値"; get_tagged_value `cat 20151201_utf.csv | grep わかもと製薬` "終値";
