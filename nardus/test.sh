#! /bin/bash
FILE="t.out";
i=0
f=0
o=0
b=true
file=(*)
while $b
do
if `echo ${file[$i]} | grep ".simpl" 1>/dev/null 2>&1`
then
testF[$f]=${file[$i]}
f=$[$f+1]
fi
if `echo ${file[$i]} | grep ".test" 1>/dev/null 2>&1`
then
testO[$o]=${file[$i]}
o=$[$o+1]
fi
if [ -z "${file[$i]}" ] 
then
b=false
fi
i=$[$i+1]
done
b=true;
i=0;
while $b
do
if [ -z "${testF[$i]}" ]
then
b=false;
break;
fi
./testscanner ${testF[$i]} &> $FILE
echo ${testF[$i]}
DIFF=$(diff ${testO[$i]} $FILE)
rm $FILE
FILE="t.out"
i=$[$i+1]
done
