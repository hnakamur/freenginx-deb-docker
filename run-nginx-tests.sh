#!/bin/bash
cd /src/nginx-tests
sudo -u nginx TEST_NGINX_UNSAFE=1 TEST_NGINX_BINARY=../freenginx/objs/nginx prove -j9 .
