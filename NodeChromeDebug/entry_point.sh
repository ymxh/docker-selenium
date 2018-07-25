#!/bin/bash

#这句比较重要，表示整个文件都以/bin/bash编译，这样linux才能明白文件的内容

#定义ROOT、CONF变量
ROOT=/opt/selenium
CONF=$ROOT/config.json

#>表示创建config.json文件，并把generate_config内容写入
$ROOT/generate_config >$CONF

#echo打印一句话，cat查看文件内容
echo "starting selenium hub with configuration:"
cat $CONF

#-z判断为空，这里是判断$SE_OPTS这个变量不为空，则执行then，$SE_OPTS这个变量在docker启动容器时可传入，不传入则保持为空
if [ ! -z "$SE_OPTS" ]; then
  echo "appending selenium options: ${SE_OPTS}"
fi

#定义一个shutdown函数，kill表示杀掉进程，wait等待kill任务执行完成
function shutdown {
    echo "shutting down hub.."
    kill -s SIGTERM $NODE_PID
    wait $NODE_PID
    echo "shutdown complete"
}

#${JAVA_OPTS}在启动容器时传入，不传入保持为空；
#启动hub节点，&表示同时执行把hub节点启动的进程id复制给NODE_PID变量
java ${JAVA_OPTS} -jar /opt/selenium/selenium-server-standalone.jar \
  -role hub \
  -hubConfig $CONF \
  ${SE_OPTS} &
NODE_PID=$!

#捕捉SIGTERM、SIGINT信号会调用shutdown信号，执行kill hub节点进程操作
trap shutdown SIGTERM SIGINT

#注意NODE_PID存的是$!，表示的上一个子进程id，并不是存了一个id值，这里是等待上面的捕捉信号执行shutdown任务完成
wait $NODE_PID