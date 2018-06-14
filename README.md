# docker-selenium

## 1.base
添加base DockerFile，主要基于ubuntu:<br>
（1）安装jdk<br>
（2）下载并安装中文语言<br>
（3）下载selenium-server-standalone-2.53.1.jar，存放在/opt/selenium/selenium-server-standalone.jar<br>
##2.hub
添加hub DockerFile，主要基于base:2.53.1<br>
（1）监听端口为4444