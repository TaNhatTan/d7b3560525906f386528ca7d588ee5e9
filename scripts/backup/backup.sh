#!/bin/bash

DATE=$(date +%d-%m-%Y_%H:%M:%S);
LOG="./backup.log";
FILE_NUM="$#";
TMP1=".tmp1";
TMP2=".tmp2";
if [ $# -eq 0 ]; then
	echo "[-] Nothing to backup.";
	exit;
fi
echo -e "======$DATE========" >> $LOG;
if [ ! -f "backup.tar.gz" ]; then
	echo "[+] Create new 'backup.tar.gz'" >> $LOG;
	if tar -czf "backup.tar.gz" $@ 2>> $LOG;
		then
		echo "[+] User '$(whoami)' has backup $# files." | tee -a $LOG;
		echo "---" >> $LOG;
		for FILE_NAME in $@
		do
			echo $(wc -c "$FILE_NAME" | sed -r "s/([0-9]+)(\s+)(.+)/\3\2\1 bytes/g") >> $LOG;
		done
		echo "---" >> $LOG;
		echo "[+] Backup successful!" | tee -a $LOG;
	else
		echo "[-] Backup failed!" | tee -a $LOG;

	fi
else
	tar -tf "backup.tar.gz" > $TMP1;
	if tar -czf "backup1.tar.gz" $@ 2>>$LOG; then
		tar -tf "backup1.tar.gz" > $TMP2;
		diff ".tmp1" ".tmp2" > ".diff";
		echo "[+] User '$(whoami)' is using backup." | tee -a $LOG;
		echo "---" >> $LOG;
		if [[ -z $(diff ".tmp1" ".tmp2") ]]; then
			echo "---" >> $LOG;
			echo "[+] Everything is up today." | tee -a $LOG;
		else
			MATCH1=$(cat .diff | grep -Ei "[<>=].+" | cut -d " " -f 1);
			MATCH2=$(cat .diff | grep -Ei "[<>=].+" | cut -d " " -f 2);
			CHANGE1=(${MATCH1// /});
			CHANGE2=(${MATCH2// /});
			LENGTH=${#CHANGE1[@]};
			for i in $(seq 0 $(($LENGTH-1)))
			do
				if [ ${CHANGE1[$i]} = ">" ]; then
					echo "[+] Add file ${CHANGE2[$i]}." >> $LOG;
				elif [ ${CHANGE1[$i]} = "<" ]; then
					echo "[+] Remove file ${CHANGE2[$i]}." >> $LOG;
				else
					echo "[+] Everything is up today." | tee -a $LOG;
				fi
			done
			echo "---" >> $LOG;
			echo "[+] Changing successful." | tee -a $LOG;
		fi
		mv "backup1.tar.gz" "backup.tar.gz";
		rm -rf "backup1.tar.gz";
		rm -rf ".tmp1" ".tmp2" ".diff";
	else
		rm -rf ".tmp1";
		rm -rf "backup1.tar.gz";
		echo "[-] Backup failed!" | tee -a $LOG;

	fi
fi
