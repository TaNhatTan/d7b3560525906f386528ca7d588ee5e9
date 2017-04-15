#!/bin/bash

DATE=$(date +%d-%m-%Y_%H:%M%Ss);
BACKUP="backup";
LOG="$BACKUP/backup.log";
LIST_HDD=("var/lib/vz/images/111/disk1.raw" "var/lib/vz/images/111/disk2.raw" "var/lib/vz/images/111/disk3.raw");
echo "======$DATE=====" >> $LOG;
for HDD in ${LIST_HDD[@]}
do
	NAME=$(echo $HDD | rev | cut -d "/" -f -1 | rev);
	if [[ ! -f "$HDD" ]]; then
		echo "[-] '$HDD: No such file or directory. Backup failed!'" >> $LOG;
	else
		if [[ -f "$BACKUP/$NAME" ]]; then
			find backup/ -type f -name "$NAME" -mtime 1 -delete 2>> $LOG;
			echo "[+] Delete '$NAME' success!" >> $LOG;
		fi
		if cp "$HDD" "$BACKUP/$NAME"  2>> $LOG; then
			echo "[+] Backup success: $HDD" >> $LOG 
		else 
			echo "[-] Backup failed: $HDD" >> $LOG;
		fi
	fi
done