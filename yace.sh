#!/bin/bash

# 命令执行参数
#
# sh jmeterShellPath -n -t score_select.jmx -l score_select.jtl
# Author: MARK
# Email:  mamian521@gmail.com

# 功能需求
# 1. 根据输入的命令来增加压测任务  完成
# 2. 提前设置好线程数 读取执行  完成


# 已知问题
# 1. zip压缩后不在当前目录  已修复
# 2. -nr 参数必须放在最后面


# 接收选项式的参数输入
while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    # jmeter 路径
    -j|--jmeter)
    jmeterShellPath="$2"
    shift # past argument
    ;;
    # jmx 文件路径
    -m|--jmx)
    jmxFilePath="$2"
    shift # past argument
    ;;
    # zip文件保存路径
    -z|--zip)
    zipPath="$2"
    shift # past argument
    # 不用read
    ;;

    -nr|--noread)
    # LEN="$#"
    # nr="$2"
    # 循环遍历保存每个线程组数字
    echo "提前设置的好的线程组数量是 "$@" "
    # 已知问题 -nr 参数必须在最后面
    NUM_THREADS=( "$@" )
    NUM_THREADS_LENGTH=$#

    # 过滤参数
    # for((i=1;i<$array_length;i++))
    # do
    #     # 如果不是数字
    #     if [ "$i" -ne 1 ]; then
    #         echo "非法数字"
    #         break
    #     fi
    #     NUM_THREADS[$i]=${array[$i]}
    # done
    # continue

    # NUM_THREADS=( "$@" )
    # LEN=$#
    # echo "$LEN"
    # for((i=1;i<$LEN;i++))
    # do
    #     echo "$NUM_THREADS[$i]"
    # done
    shift # past argument # resume (to find  later )
    ;;
    --default)
    DEFAULT=YES
    ;;
    -h|--help)
            # unknown option
    printf "%s\n" "使用方法"
    printf "%s\n" "-j jmeter路径"
    printf "%s\n" "-m jmx文件路径"
    printf "%s\n" "-z zip文件保存路径"
    printf "%s\n" "-nr 提前设置的好的线程组数量, 以空格间隔, 依序执行"
    ;;
    *)
            # unknown option
    # echo '使用方法, -j jmeter路径\n -m jmx文件路径\n -z zip文件保存路径'
    ;;

esac
shift # past argument or value
done

if [[ -n $1 ]]; then
    echo "Last line of file specified as non-opt/last argument:"
    tail -1 $1
fi


# jmeterShellPath=$1
# jmxFilePath=$2
# echo $no


# 判断jmeter路径是否为空
if [ ! ${jmeterShellPath} ] || [ ! ${jmxFilePath} ]
then
    printf "%s\n" "缺少相关参数"
    printf "%s\n" "-j  jmeter sh文件路径, 通常在 jmeter/bin 目录下"
    printf "%s\n" "-m  jmx文件路径"
    printf "%s\n" "-z  zip文件保存路径"
    exit
fi

# 如果有zip保存的路径, 就删除 jtl zip文件斜杠前面的路径
# if [ ${zipPath} ]
# then

# fi




#echo $a

# 文件名zlr
jtlFile=${jmxFilePath%.*}

# 线程组设置
# 如果没有提前输入 -nr 线程数, 那么就提醒用户手动输入, 这个时候只支持单个
if [ ! ${NUM_THREADS[1]} ]
then
    while true
    do
    # 充次数, 无意义
    NUM_THREADS[0]="1"
   # 让使用者选择所需要登陆服务器的所属序号
    read -p '请输入要设置的线程组数量: ' NUM_THREADS[1]


    # 如果输入为空格或者回车，显示错误信息，后续代码不再执行，重新循环。
    if [ ! ${NUM_THREADS[1]} ]
    then
        echo '请输入序号'
        continue
    fi

    # 如果输入的不是数字，显示错误信息，后续代码不再执行，重新循环。
    if [[ "${NUM_THREADS[1]}" =~ [^0-9]+ ]]
    then
        echo '序号是数字'
        continue
    fi

    # 如果输入的以 0 开头的数字、大于等于服务器台数、小于 0，显示错误信息，后续代码不再执行，重新循环。
    # if [[ "${NUM_THREADS}" =~ ^0[0-9]+ ]] || [ ${NUM_THREADS} -ge ${LEN} ] || [ ${NUM_THREADS} -lt 0 ]
    if [[ "${NUM_THREADS[1]}" =~ ^0[0-9]+ ]] || [ ${NUM_THREADS[1]} -lt 0 ]
    then
        echo '请输入存在的序号'
        continue
    fi

    # 跳出循环
    break

    done
fi

# 重置所有 线程组到1
# sed -i "s/\"ThreadGroup.num_threads\">[0-9]*/\"ThreadGroup.num_threads\">1/g" $jmxFilePath

# 开始运行
# sed -i 's/"ThreadGroup.num_threads">1/"ThreadGroup.num_threads">100/g' $a
# sh jmeterShellPath -n -t $a -l ${b}_100_1.jtl
# sed -i 's/"ThreadGroup.num_threads">100/"ThreadGroup.num_threads">500/g' $a
# sh jmeterShellPath -n -t $a -l ${b}_500_1.jtl



# sed 找到目标位置修改
# 为了正常找到"", 需要对其进行转义
# LEN=${#NUM_THREADS[@]}



# 取线程组数量
NUM_THREADS_LENGTH=${#NUM_THREADS[@]}

# screen_echo() {

# for((i=1;i<$NUM_THREADS_LENGTH;i++))
# do
#     printf "%-7s" '线程组数量为'　
#     printf "\e[31m %-5s\e[0m\n" "${NUM_THREADS[$i]}" # 颜色为红色
# done


# # for((i=0; i <$LEN; i++))
# # do
# #     printf "\e[31m %-5s\e[0m|" "$i" # 颜色为红色
# #     printf "%-15s\n |" "${NUM_THREADS[$i]}"  # 显示线程组数量
# # done

# }


# # 调用函数，让信息显示出来
# screen_echo

# 重置控制器
sed -i "s/\"ThreadGroup.scheduler\">[a-zA-Z]*/\"ThreadGroup.scheduler\">false/g" $jmxFilePath

auto_stress_test() {

    for (( i=1; i<${NUM_THREADS_LENGTH}; i++ ));
    do
        # 提示开始测试
        printf "%-7s" '线程组数量为'　
        printf "\e[31m %-5s\e[0m\n" "${NUM_THREADS[$i]}" # 颜色为红色

        # 开始循环
        # 1. 保存的jtl文件名称
        jtlFileName=${jtlFile}_${NUM_THREADS[i]}_1.jtl
        # 暂时先放在这里 , 后续要指定目录   ${jtlFileName##*/} 去掉 / 之前的路径
        # 2. 保存的jtl文件路径
        jtlFilePath=$zipPath/${jtlFileName##*/}.zip
        echo $jtlFilePath
        # 3. 修改jmx文件线程数
        sed -i "s/\"ThreadGroup.num_threads\">[0-9]*/\"ThreadGroup.num_threads\">${NUM_THREADS[$i]}/g" $jmxFilePath
        # 4. 执行
        sh $jmeterShellPath -n -t $jmxFilePath -l $jtlFileName
            # 压缩
        zip ${jtlFilePath} ${jtlFileName}
    done



    # jtlFileName=${jtlFile}_${NUM_THREADS}_1.jtl
    # # 暂时先放在这里 , 后续要指定目录   ${jtlFileName##*/} 去掉 / 之前的路径
    # jtlFilePath=$zipPath/${jtlFileName##*/}.zip
    # echo $jtlFilePath
    # sed -i "s/\"ThreadGroup.num_threads\">[0-9]*/\"ThreadGroup.num_threads\">$NUM_THREADS/g" $jmxFilePath
    # sh $jmeterShellPath -n -t $jmxFilePath -l $jtlFileName
    # zip ${jtlFilePath} ${jtlFileName}
    # tar -zcvf /home/xahot.tar.gz /xahot
}


auto_stress_test


# sed -i "s/\"ThreadGroup.num_threads\">[0-9]*/\"ThreadGroup.num_threads\">${num_threads[1]}/g" $jmxFilePath
# sh jmeterShellPath -n -t $jmxFilePath -l ${jtlFile}_${num_threads[1]}_1.jtl
# sed -i "s/\"ThreadGroup.num_threads\">[0-9]*/\"ThreadGroup.num_threads\">${num_threads[2]}/g" $jmxFilePath
# sh jmeterShellPath -n -t $jmxFilePath -l ${jtlFile}_${num_threads[2]}_1.jtl
# sed -i "s/\"ThreadGroup.num_threads\">[0-9]*/\"ThreadGroup.num_threads\">${num_threads[3]}/g" $jmxFilePath
# sh jmeterShellPath -n -t $jmxFilePath -l ${jtlFile}_${num_threads[3]}_1.jtl

# # 设置循环次数

# # 控制器  不需要改
# sed -i 's/"LoopController.loops">1/"LoopController.loops">-1/g' $jmxFilePath

# # 控制器 不需要改
# sed -i 's/"ThreadGroup.scheduler">false/"ThreadGroup.scheduler">true/g' $jmxFilePath

# # 时间: 3分钟
# sed -i 's/"ThreadGroup.duration">/"ThreadGroup.duration">180/g' $jmxFilePath

# # 并发数 修改回1000
# sed -i 's/"ThreadGroup.num_threads">5000/"ThreadGroup.num_threads">1000/g' $jmxFilePath

# # sh jmeterShellPath -n -t $a -l ${b}_100_3min.jtl
# # sed -i 's/"ThreadGroup.num_threads">100/"ThreadGroup.num_threads">500/g' $a
# # sh jmeterShellPath -n -t $a -l ${b}_500_3min.jtl
# sed -i 's/"ThreadGroup.num_threads">1000/"ThreadGroup.num_threads">1000/g' $jmxFilePath
# sh jmeterShellPath -n -t $jmxFilePath -l ${jtlFile}_${num_threads[1]}_3min.jtl
# sed -i 's/"ThreadGroup.num_threads">1000/"ThreadGroup.num_threads">3000/g' $jmxFilePath
# sh jmeterShellPath -n -t $jmxFilePath -l ${jtlFile}_${num_threads[2]}_3min.jtl
# sed -i 's/"ThreadGroup.num_threads">3000/"ThreadGroup.num_threads">5000/g' $jmxFilePath
# sh jmeterShellPath -n -t $jmxFilePath -l ${jtlFile}_${num_threads[3]}_3min.jtl

# # 还原到原先状态
# sed -i 's/"LoopController.loops">-1/"LoopController.loops">1/g' $jmxFilePath
# sed -i 's/"ThreadGroup.scheduler">true/"ThreadGroup.scheduler">false/g' $jmxFilePath
# sed -i 's/"ThreadGroup.duration">180/"ThreadGroup.duration">/g' $jmxFilePath
# sed -i 's/"ThreadGroup.num_threads">5000/"ThreadGroup.num_threads">1/g' $jmxFilePath


