#!/bin/bash

BEGIN=$(objdump -d -F $1 | grep "<$3>" | awk 'NR==1 {print $NF ;}')
BEGIN=${BEGIN%)*}
((BEGIN=BEGIN+0x0))
echo $BEGIN

END=$(objdump -d -F $1 | grep "<$4>" | awk 'NR==1 {print $NF ;}')
END=${END%)*}
((END=END+0x0))
echo $END

VAR=$((END-BEGIN))
echo $VAR 

dd bs=1 if=$1 of=$2 skip=$BEGIN count=$VAR

if [ "$5" = "c" ]; then
    TMP=tmp;
    touch $TMP;
    echo "unsigned int shellcode[] =" > $TMP;
    od -t x1 $2 | awk '{$1="";print;}' | sed 's/\ /\\x/g' | sed '/^$/d;s/^/\"/g;s/$/\"/g' >> $TMP;
    cat $TMP | awk '{print;} END{print ";";}' > $2;
    rm $TMP;
fi
