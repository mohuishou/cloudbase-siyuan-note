#!/bin/bash

if [ ! -d $data  ];then
  mkdir -p $data
fi

if [ ! -d $conf  ];then
  mkdir -p $conf
fi

if [ "$RCLONE" = "sync" ] ; then

  echo "will sync by rclone"
  if [ ! -d /siyuan/rclone/sync  ];then
    echo "will first run sync"
    rclonesync onedrive:note/home/ /siyuan/data/home --config $RCLONE_CONFIG -f /siyuan/rclone/filter.txt -w /siyuan/rclone/sync -1
    rclonesync onedrive:note/work/ /siyuan/data/work --config $RCLONE_CONFIG -f /siyuan/rclone/filter.txt -w /siyuan/rclone/sync -1
  fi
  
  crontab /root/cron
  crond
fi

cd /opt/siyuan
/opt/siyuan/kernel --conf=$conf \
                  --resident=$resident \
                  --readonly=$readonly \
                  --authCode=$authCode \
                  --auth=$auth \
                  --ssl=$ssl \
                  --data=$data \
                  --servePath=$servePath