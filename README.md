# docker-selenium

## 1.base
添加base DockerFile，主要基于ubuntu镜像,同步到DockerHub镜像名称【ds-base】<br>
（1）安装jdk<br>
（2）下载并安装中文语言<br>
（3）下载selenium-server-standalone-2.53.1.jar，存放在/opt/selenium/selenium-server-standalone.jar<br>
## 2.hub
添加hub DockerFile，主要基于ds-base:2.53.1镜像,同步到DockerHub镜像名称【ds-hub】<br>
（1）监听端口为4444<br>
（2）设置hub节点参数
## 3.NodeBase
添加node base DockerFile，主要基于ds-base:2.53.1镜像,准备node节点,同步到DockerHub镜像名称【ds-node-base】<br>
## 4.NodeChrome
添加node chrome DockerFile，主要基于ds-node-base:2.53.1,同步到DockerHub镜像名称【ds-node-chrome】<br>
（1）离线安装chrome浏览器<br>
（2）下载chromedriver<br>
（3）设置node节点参数<br>
## 5.NodeChromeDebug
添加node chrome debug DockerFile，主要基于ds-node-chrome:65,同步到DockerHub镜像名称【ds-node-chrome-debug】<br>
（1）安装VNC服务<br>
（2）运行node节点