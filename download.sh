#!/bin/bash

flamecloud_folder=/flamecloud-deploy

#创建harbor文件夹
mkdir -p ${flamecloud_folder}/harbor && cd ${flamecloud_folder}/harbor
#下载离线安装包
#wget https://github.com/goharbor/harbor/releases/download/v2.7.0/harbor-offline-installer-v2.7.0.tgz
wget https://ghproxy.com/https://github.com/goharbor/harbor/releases/download/v2.7.0/harbor-offline-installer-v2.7.0.tgz
wget https://ghproxy.com/https://github.com/goharbor/harbor/releases/download/v2.5.0/harbor-offline-installer-v2.5.0.tgz
wget https://ghproxy.com/https://github.com/goharbor/harbor/releases/download/v2.3.0/harbor-offline-installer-v2.3.0.tgz
wget https://ghproxy.com/https://github.com/goharbor/harbor/releases/download/v1.10.0/harbor-offline-installer-v1.10.0.tgz
wget https://storage.googleapis.com/harbor-releases/release-1.8.0/harbor-offline-installer-v1.8.0.tgz
#下载迁移工具
docker pull goharbor/harbor-migrator:v1.8.0
docker pull goharbor/harbor-migrator:v1.10.0
docker pull goharbor/prepare:v2.3.0
docker pull goharbor/prepare:v2.5.0
docker pull goharbor/prepare:v2.7.0
#迁移工具镜像压缩
docker save -o harbor-migrator-1.8.0.tar.gz goharbor/harbor-migrator:v1.8.0
docker save -o harbor-migrator-1.10.0.tar.gz goharbor/harbor-migrator:v1.10.0
docker save -o prepare-2.3.0.tar.gz goharbor/prepare:v2.3.0
docker save -o prepare-2.5.0.tar.gz goharbor/prepare:v2.5.0
docker save -o prepare-2.7.0.tar.gz goharbor/prepare:v2.7.0
#移动至指定目录
mv harbor-migrator-1.8.0.tar.gz harbor-migrator-1.10.0.tar.gz prepare-2.3.0.tar.gz prepare-2.5.0.tar.gz prepare-2.7.0.tar.gz ${flamecloud_folder}/harbor
#压缩目录包
cd ${flamecloud_folder} && tar -czvf harbor.tar.gz ./harbor
rm -rf ${flamecloud_folder}/harbor

