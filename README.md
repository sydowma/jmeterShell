## mamian_yace

### 功能介绍:

通过sed命令直接修改jmx文件

- 支持设置JMeter线程组数量
- 支持设置JMeter开启调度器设置循环时间
- 支持设置报告压缩文件夹

### 运行方法

```shell
./mamian_yace.sh -j jmeterPath -m jmxPath 
# jmeterPath Apache JMeter 路径  必填
# jmxPath    JMX 文件 路径  必填

./mamian_yace.sh -j jmeterPath -m jmxPath -n 100
# 设置线程组数量100

./mamian_yace.sh -j jmeterPath -m jmxPath -n 100 -d 120
# 设置线程组数量100 循环120秒

./mamian_yace.sh -j jmeterPath -m jmxPath -n 100 -d 120 -z /home/work
# 设置线程组数量100 循环120秒 zip解压缩在/home/work目录下


```



## leiran_yace

### 功能介绍

通过修改配置文件，修改jmx文件信息，进而执行jmeter

```shell
./leiran_yace.sh zlr3.jmx
# 在JMeter/bin 目录下运行
```



### 配置文件信息

```shell
100
50c
150
# 100次*1+50*3分钟+150*1
```

