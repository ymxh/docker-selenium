#!/bin/bash

#source作用是立即编译生效
source /opt/bin/functions.sh
/opt/selenium/generate_config > /opt/selenium/config.json

#export声明变量，并复制到子shell中
export GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"

#判断文件不存在，则执行then
if [ ! -e /opt/selenium/config.json ]; then
  echo No Selenium Node configuration file, the node-base image is not intended to be run directly. 1>&2
  exit 1
fi

#判断变量为空，$HUB_PORT_4444_TCP_ADDR与$HUB_PORT_4444_TCP_PORT这#两个变量在docker运行容器通过，--link参数来连接hub容器得到
if [ -z "$HUB_PORT_4444_TCP_ADDR" ]; then
  echo Not linked with a running Hub container 1>&2
  exit 1
fi

function shutdown {
  kill -s SIGTERM $NODE_PID
  wait $NODE_PID
}

if [ ! -z "$REMOTE_HOST" ]; then
  >&2 echo "REMOTE_HOST variable is *DEPRECATED* in these docker containers.  Please use SE_OPTS=\"-host <host> -port <port>\" instead!"
  exit 1
fi

if [ ! -z "$SE_OPTS" ]; then
  echo "appending selenium options: ${SE_OPTS}"
fi

# TODO: Look into http://www.seleniumhq.org/docs/05_selenium_rc.jsp#browser-side-logs

#从functions.sh中得到
SERVERNUM=$(get_server_num)

rm -f /tmp/.X*lock
#env得到root用户环境变量，cut截取sort排序保存在asroot文件， 
#切换到seluser用户同理保存在asseluser文件，然后grep比较文件不同的值输出
#xvfb运行node节点
env | cut -f 1 -d "=" | sort > asroot
  sudo -E -u seluser -i env | cut -f 1 -d "=" | sort > asseluser
  sudo -E -i -u seluser \
  $(for E in $(grep -vxFf asseluser asroot); do echo $E=$(eval echo \$$E); done) \
  DISPLAY=$DISPLAY \
  xvfb-run -n $SERVERNUM --server-args="-screen 0 $GEOMETRY -ac +extension RANDR" \
  java ${JAVA_OPTS} -jar /opt/selenium/selenium-server-standalone.jar \
    -role node \
    -hub http://$HUB_PORT_4444_TCP_ADDR:$HUB_PORT_4444_TCP_PORT/grid/register \
    -nodeConfig /opt/selenium/config.json \
    ${SE_OPTS} &
NODE_PID=$!

trap shutdown SIGTERM SIGINT
#循环10次，每次等待0.5秒，等待xvfb运行的信息完全放入黑洞
#xdpyinfo显示xvfb运行的信息放入黑洞不显示出来
for i in $(seq 1 10)
do
  xdpyinfo -display $DISPLAY >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    break
  fi
  echo Waiting xvfb...
  sleep 0.5
done

#通过fluxbox显示窗口
fluxbox -display $DISPLAY &

#启动远程服务，提供VNC客户端连接查看窗口
#-forever关闭远程的vncviewer之后不关闭x11vnc的服务
#-usepw 密码连接
#-shared 可支持多个vncviewer客户端连接
#-rfbport 监听端口
x11vnc -forever -usepw -shared -rfbport 5900 -display $DISPLAY &
wait $NODE_PID
