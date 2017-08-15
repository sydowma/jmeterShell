# jmeterShell

### 功能介绍:

通过sed命令直接修改jmx文件

- 支持设置JMeter线程组数量
- 支持设置JMeter开启调度器设置循环时间
- 支持设置报告压缩文件夹

### 运行方法

```shell
./yace.sh -j jmeterPath -m jmxPath 
# jmeterPath Apache JMeter 路径  必填
# jmxPath    JMX 文件 路径  必填

./yace.sh -j jmeterPath -m jmxPath -n 100
# 设置线程组数量100

./yace.sh -j jmeterPath -m jmxPath -n 100 -d 120
# 设置线程组数量100 循环120秒

./yace.sh -j jmeterPath -m jmxPath -n 100 -d 120 -z /home/work
# 设置线程组数量100 循环120秒 zip解压缩在/home/work目录下



```



