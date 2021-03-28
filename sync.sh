#!/bin/bash

rclonesync onedrive:note/home/ /siyuan/data/home --config $RCLONE_CONFIG -f /siyuan/rclone/filter.txt -w /siyuan/rclone/sync
rclonesync onedrive:note/work/ /siyuan/data/work --config $RCLONE_CONFIG -f /siyuan/rclone/filter.txt -w /siyuan/rclone/sync