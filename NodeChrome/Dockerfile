# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# NOTE: DO *NOT* EDIT THIS FILE.  IT IS GENERATED.
# PLEASE UPDATE Dockerfile.txt INSTEAD OF THIS FILE
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
FROM ymxhtest/ds-node-base:2.53.1
MAINTAINER ymxhtest <ymxhtest@163.com>

USER root

#=================================
# Chrome Off-line installation离线安装
#=================================
COPY intsallchrome.sh /opt/intsallchrome
RUN chmod +x /opt/intsallchrome
RUN sh /opt/intsallchrome
                                                 
#==================
# Chrome webdriver
#==================
ARG CHROME_DRIVER_VERSION=2.36
RUN wget --no-verbose -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip \
  && rm -rf /opt/selenium/chromedriver \
  && unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \
  && rm /tmp/chromedriver_linux64.zip \
  && mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && chmod 755 /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && sudo ln -fs /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION /usr/bin/chromedriver

#========================
# Selenium Configuration
#========================
# As integer, maps to "maxInstances"
ENV NODE_MAX_INSTANCES 1
# As integer, maps to "maxSession"
ENV NODE_MAX_SESSION 1
# As integer, maps to "host"
ENV NODE_HOST 0:0:0:0
# As integer, maps to "port"
ENV NODE_PORT 5555
# In milliseconds, maps to "registerCycle"
ENV NODE_REGISTER_CYCLE 5000
# In milliseconds, maps to "nodePolling"
ENV NODE_POLLING 5000
# In milliseconds, maps to "unregisterIfStillDownAfter"
ENV NODE_UNREGISTER_IF_STILL_DOWN_AFTER 60000
# As integer, maps to "downPollingLimit"
ENV NODE_DOWN_POLLING_LIMIT 2
# As string, maps to "applicationName"
ENV NODE_APPLICATION_NAME "chrome65"

COPY generate_config /opt/selenium/generate_config
RUN chmod +x /opt/selenium/generate_config \
#=================================
# Chrome Launch Script Modication
#=================================
COPY chrome_launcher.sh /opt/google/chrome/google-chrome
RUN chmod +x /opt/google/chrome/google-chrome \
    && chown -R seluser:seluser /opt/selenium

# Following line fixes
# https://github.com/SeleniumHQ/docker-selenium/issues/87
RUN echo "DBUS_SESSION_BUS_ADDRESS=/dev/null" >> /etc/environment

USER seluser

RUN /opt/selenium/generate_config > /opt/selenium/config.json

