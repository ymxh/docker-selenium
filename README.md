# docker-selenium

## 1.base
添加base DockerFile，主要基于ubuntu:<br>
（1）安装jdk<br>
（2）下载并安装中文语言<br>
（3）下载selenium-server-standalone-2.53.1.jar，存放在/opt/selenium/selenium-server-standalone.jar<br>
## 2.hub
添加hub DockerFile，主要基于base:2.53.1<br>
（1）监听端口为4444<br>
（2）设置hub节点参数
## 3.NodeBase
添加node base DockerFile，基于base:2.53.1,准备node节点<br>
## 4.NodeChrome
添加node chrome DockerFile，主要基于node-base:2.53.1<br>
（1）离线安装chrome浏览器<br>
（2）下载chromedriver<br>
（3）设置node节点参数<br>