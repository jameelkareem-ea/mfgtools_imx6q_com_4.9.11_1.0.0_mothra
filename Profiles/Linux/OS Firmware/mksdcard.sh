#!/bin/sh

# partition size in MB
BOOT_ROM_SIZE=4

# wait for the SD/MMC device node ready
while [ ! -e $1 ]
do
sleep 1
echo "wait for $1 appear"
done

# call sfdisk to create partition table
# destroy the partition table
node=$1
dd if=/dev/zero of=${node} bs=1024 count=1

sfdisk --force ${node} << EOF
${BOOT_ROM_SIZE}M,8M,0c
12M,,83
EOF
