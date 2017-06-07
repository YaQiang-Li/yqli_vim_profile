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

#      File Name: get_pexles_img.sh
#      Author: emlyq@hotmail.com
#      Created on: Wed Jun  7 11:09:20 CST 2017

wget https://www.pexels.com/popular-photos/
img_urls=`grep "<img width=\"...\"" index.html | sed -r 's/.*src="(.*).h.*/\1/'`
for url in ${img_urls}
do
	wget -P /root/bing_background ${url}
done
rm -rf index.html
