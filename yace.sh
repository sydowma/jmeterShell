#!/bin/bash

# Author: mark
# LICENSE:  Apache License 2.0

#
# 通过修改配置文件，修改jmx文件信息，进而执行jmeter
# 使用前需要把shell文件放置到 Apache JMeter/bin 目录下
# ./yace.sh example.jmx
# ./yace.sh example.jmx 60
# 在JMeter/bin 目录下运行

# yace.txt 文件信息
# 100
# 50m
# 150
# 100并发*1次+50并发*3分钟+150并发*1次


# $1 第一个参数
# $2 持续时间 需要持续时间参数
# jmxFileName  不带后缀


jmxFile=$1

jmxFileName=${jmxFile%.*}


file="yacezlr.txt"
for d in `cat $file`
do
	#echo ${d:0-1}
	if [ ${d:0-1} != m ] ; then
		sed -i 's/"LoopController.loops">.*</"LoopController.loops">1</g' $jmxFile
		sed -i 's/"ThreadGroup.scheduler">.*</"ThreadGroup.scheduler">false</g' $jmxFile
		sed -i 's/"ThreadGroup.duration">.*</"ThreadGroup.duration"></g' $jmxFile
		sed -i 's/"ThreadGroup.num_threads">.*</"ThreadGroup.num_threads">'${d}'</g' $jmxFile
		sh jmeter.sh -n -t $jmxFile -l ${jmxFileName}_${d}_1.jtl
	else
		duration=$2
		numberD=${d%?}
		sed -i 's/"LoopController.loops">.*</"LoopController.loops">-1</g' $jmxFile
		sed -i 's/"ThreadGroup.scheduler">.*</"ThreadGroup.scheduler">true</g' $jmxFile
		# sed -i 's/"ThreadGroup.duration">.*</"ThreadGroup.duration">${duration}</g' $jmxFile
		sed -i "s/\"ThreadGroup.duration\">.*</\"ThreadGroup.duration\">${duration}</g"
		sed -i 's/"ThreadGroup.num_threads">.*</"ThreadGroup.num_threads">'${numberD}'</g' $jmxFile
		sh jmeter.sh -n -t $jmxFile -l ${jmxFileName}_${d}_${duration}.jtl
	fi
	sleep 10s
	echo "sleep 10s"
done
zip ${jmxFileName}.zip ${jmxFileName}*
