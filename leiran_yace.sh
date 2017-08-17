#!/bin/bash

# Author: ZouLeiran
# Email:  zouleiran@100tal.com
# LICENSE:  Apache License 2.0

#
# 通过修改配置文件，修改jmx文件信息，进而执行jmeter
# 使用前需要把shell文件放置到 Apache JMeter/bin 目录下
# ./leiran_yace.sh zlr3.jmx
# 在JMeter/bin 目录下运行

# yace_zlr.txt 文件信息
# 100
# 50c
# 150
# 100并发*1次+50并发*3分钟+150并发*1次



a=$1
b=${a%.*}

file="yacezlr.txt"
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
