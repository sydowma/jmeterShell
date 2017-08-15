#!/bin/bash
a=$1
b=${a%.*}

file="yacezlr.sh"
for d in `cat $file`
do
#echo ${d:0-1}
if [ ${d:0-1} != c ] ; then
sed -i 's/"LoopController.loops">.*</"LoopController.loops">1</g' $a
sed -i 's/"ThreadGroup.scheduler">.*</"ThreadGroup.scheduler">false</g' $a
sed -i 's/"ThreadGroup.duration">.*</"ThreadGroup.duration"></g' $a
sed -i 's/"ThreadGroup.num_threads">.*</"ThreadGroup.num_threads">'${d}'</g' $a
sh jmeter.sh -n -t $a -l ${b}_${d}_1.jtl
else 
d=${d%c}
sed -i 's/"LoopController.loops">.*</"LoopController.loops">-1</g' $a
sed -i 's/"ThreadGroup.scheduler">.*</"ThreadGroup.scheduler">true</g' $a
sed -i 's/"ThreadGroup.duration">.*</"ThreadGroup.duration">180</g' $a
sed -i 's/"ThreadGroup.num_threads">.*</"ThreadGroup.num_threads">'${d}'</g' $a
sh jmeter.sh -n -t $a -l ${b}_${d}_3min.jtl
fi
done
zip ${b}.zip ${b}*
