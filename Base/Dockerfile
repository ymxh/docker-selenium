#========================
# 基础镜像是ubuntu:16.04
#========================
FROM ubuntu:16.04
MAINTAINER ymxhtest <ymxhtest@163.com>

#========================
# 使用Ubuntu标准的Apt-get源
#========================
RUN  echo "deb http://archive.ubuntu.com/ubuntu xenial main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu xenial-updates main universe\n" >> /etc/apt/sources.list \
  && echo "deb http://security.ubuntu.com/ubuntu xenial-security main universe\n" >> /etc/apt/sources.list
  
#========================
# 安装需要的包：
# 包括apt-get安装方式、jdk8.0环境、解压缩unzip、wget下载工具;locales主要用于后面设置中文语言
#========================
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    bzip2 \
    ca-certificates \
    openjdk-8-jre-headless \
    tzdata \
    sudo \
    locales \
    unzip \
    wget \
    curl \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
  && sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/' ./usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security

#========================
# 配置中文语言
#========================
ENV LANGUAGE zh_CN.UTF-8
ENV LANG zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8
RUN  apt-get update -qqy \
  && /usr/share/locales/install-language-pack zh_CN \
  && locale-gen zh_CN.UTF-8 \
  && dpkg-reconfigure --frontend noninteractive locales \
  && apt-get -qqy --no-install-recommends install language-pack-zh-hans

#========================
# 安装基本字体
#========================
RUN  apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    fonts-ipafont-gothic \
    xfonts-100dpi \
    xfonts-75dpi \
    xfonts-cyrillic \
    xfonts-scalable

#========================
# 安装文泉驿微米黑字体
#========================
RUN  apt-get update -qqy \
  && apt-get -qqy install ttf-wqy-microhei \
  && ln /etc/fonts/conf.d/65-wqy-microhei.conf /etc/fonts/conf.d/69-language-selector-zh-cn.conf

#========================
# 设置时区
#========================
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && dpkg-reconfigure --frontend noninteractive tzdata

#========================================
# 创建用户seluser并赋予组，免密码
#========================================
RUN useradd seluser \
         --shell /bin/bash  \
         --create-home \
  && usermod -a -G sudo seluser \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'seluser:secret' | chpasswd

#==========
# 新建selenium文件夹，并赋予seluser用户可操作权限
# 下载selenium-server-3.9.1的jar包
#==========
RUN mkdir -p /opt/selenium \
  && chown -R seluser:seluser /opt/selenium \
  && wget --no-verbose https://selenium-release.storage.googleapis.com/3.9/selenium-server-standalone-3.9.1.jar \
    -O /opt/selenium/selenium-server-standalone.jar