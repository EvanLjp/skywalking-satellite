#!/bin/bash

#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


HOME_DIR="$(cd "$(dirname "$0")" && cd .. && pwd)"
BIN_DIR=${HOME_DIR}/bin
LOG_DIR=${HOME_DIR}/logs
CONFIG_DIR=${HOME_DIR}/configs
LOG_FILE_LOCATION=${LOG_DIR}/satellite.log

if [ ! -d "${LOG_DIR}" ]; then
 mkdir -p "${LOG_DIR}"
fi

if uname -s | grep Darwin; then
 START_UP_PROCESS=$(find "$BIN_DIR" -name "skywalking-satellite*darwin*")
elif uname -s | grep Linux; then
 START_UP_PROCESS=$(find "$BIN_DIR" -name "skywalking-satellite*linux*")
else
 START_UP_PROCESS=$(find "$BIN_DIR" -name "skywalking-satellite*windows*")
fi

eval exec "$START_UP_PROCESS" start --config="$CONFIG_DIR"/satellite_config.yaml 1> "$LOG_FILE_LOCATION" 2>&1 &

if [ $? -eq 0 ]; then
 sleep 1
 echo "SkyWalking Satellite started successfully!"
else
 echo "SkyWalking Satellite started failure!"
 exit 1
fi
