#!/bin/bash

# https://github.com/SeleniumHQ/docker-selenium/issues/184
# $DISPLAY在dockerfile定义的环境变量，通过处理后，取出的值为99
function get_server_num() {
  echo $(echo $DISPLAY | sed -r -e 's/([^:]+)?:([0-9]+)(\.[0-9]+)?/\2/')
}

