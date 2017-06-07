#!/bin/sh
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements. See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership. The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License. You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#

#      File Name: get_bing_bg.sh
#      Author: emlyq@hotmail.com
#      Created on: Mon Jun  5 23:03:13 PDT 2017

wget http://cn.bing.com
bg_img_url=http://cn.bing.com`grep "g_img=" index.html | sed -r 's/.*g_img=\{url: "(.*)",id:.*/\1/'`
echo ${bg_img_url}
wget ${bg_img_url}
bg_img_name=`echo ${bg_img_url} | sed -r 's/.*\/(.*)/\1/' `
echo ${bg_img_name}
mv $bg_img_name /root/bing_background/bingbg-`date "+%Y-%m-%d-%H%M%S"`-${bg_img_name}
rm -rf index.html
