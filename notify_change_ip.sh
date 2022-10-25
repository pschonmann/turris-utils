#!/bin/bash

NOW=$(date +%F_%T)

WORKING_DIR=/var/tmp/$(basename $0 .sh)

if [ ! -d $WORKING_DIR ];then
  mkdir -p $WORKING_DIR
fi

OLDIP_FILE=$WORKING_DIR/old.ip

if [ ! -f $OLDIP_FILE ];then
  NOWIP="CREATED_FILE_${OLDIP_FILE}_${NOW}"
  echo "$NOWIP" > $OLDIP_FILE
fi

OLDIP=$(cat $OLDIP_FILE)

NOWIP=$(dig +short myip.opendns.com @resolver1.opendns.com)
if [ $? -ne 0 ];then
  NOWIP=$(cat OLDIP_FILE)
fi

#Cant get IP for some reason, probably DNS not operational and return null value
if [ -z $NOWIP ]  ;then
  NOWIP=$(cat $OLDIP)
fi

if [ "$OLDIP" != "$NOWIP" ];then
  create_notification -t -s news "IP ADDRESS changed on $HOSTNAME OLD: $OLDIP NOW: $NOWIP" &>/dev/null
  echo $NOWIP > $OLDIP_FILE
fi
