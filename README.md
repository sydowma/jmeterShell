## yace
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fmagaofei%2FjmeterShell.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fmagaofei%2FjmeterShell?ref=badge_shield)


### 功能介绍

通过修改配置文件，修改jmx文件信息，进而执行jmeter

```shell

chmod 0600 yace.sh

# run jmx with duration 60 seconds
./yace.sh example.jmx 60
# 在JMeter/bin 目录下运行
```



### 配置文件信息

```shell
100
50m
150
```

执行完毕后 jtl文件 默认压缩到Apache JMeter/bin 文件夹下



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





## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fmagaofei%2FjmeterShell.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fmagaofei%2FjmeterShell?ref=badge_large)