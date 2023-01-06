#!/bin/bash
unzip_folder=/deploy/harbor_deploy
old_harbor_folder=/opt/software/harbor
new_harbor_folder=/opt/software
mkdir -p ${unzip_folder}/harbor
#解压缩文件
#tar -C ${unzip_folder}/ -xzvf ${unzip_folder}/harbor.tar.gz
###################################harbor升级v1.6.1->v1.8.0#############################################
cd ${old_harbor_folder}
#停止harbor
docker-compose down

mkdir -p /my_backup_dir/harbor_1_6_1/database
#备份文件夹
mv ${old_harbor_folder} /my_backup_dir/harbor_1_6_1

#解压缩升级版本离线安装包
tar -C ${new_harbor_folder}/ -xzvf ${unzip_folder}/harbor/harbor-offline-installer-v1.8.0.tgz
#备份数据库
cp -r /data/database /my_backup_dir/harbor_1_6_1/database
#载入迁移工具镜像
cd ${unzip_folder}/harbor
docker load -i harbor-migrator-1.8.0.tar.gz
#配置文件迁移
docker run -it --rm -v /my_backup_dir/harbor_1_6_1/harbor/harbor.cfg:/harbor-migration/harbor-cfg/harbor.cfg -v ${new_harbor_folder}/harbor/harbor.yml:/harbor-migration/harbor-cfg-out/harbor.yml goharbor/harbor-migrator:v1.8.0 --cfg up
#安装harbor 1.8.0
cd ${new_harbor_folder}/harbor
./install.sh
#数据库的模式升级和数据迁移是core在Harbor启动时执行预留升级时间
sleep 10m
###################################harbor升级v1.6.1->v1.8.0#############################################

###################################harbor升级v1.8.0->v1.10.0############################################
cd ${new_harbor_folder}/harbor
#停止harbor
docker-compose down
#备份文件夹
mv ${new_harbor_folder}/harbor /my_backup_dir/harbor_1_8_0

#解压缩升级版本离线安装包
tar -C ${new_harbor_folder}/ -xzvf ${unzip_folder}/harbor/harbor-offline-installer-v1.10.0.tgz
#备份数据库
cp -r /data/database /my_backup_dir/harbor_1_8_0/database
#载入迁移工具镜像
cd ${unzip_folder}/harbor
docker load -i harbor-migrator-1.10.0.tar.gz
#配置文件迁移
cp /my_backup_dir/harbor_1_8_0/harbor.yml ${new_harbor_folder}/harbor/
docker run -it --rm -v ${new_harbor_folder}/harbor/harbor.yml:/harbor-migration/harbor-cfg/harbor.yml goharbor/harbor-migrator:v1.10.0 --cfg up
#安装harbor 1.10.0
cd ${new_harbor_folder}/harbor
sh ./install.sh
#数据库的模式升级和数据迁移是core在Harbor启动时执行预留升级时间
sleep 10m
###################################harbor升级v1.8.0->v1.10.0############################################

###################################harbor升级v1.10.0->v2.3.0############################################
cd ${new_harbor_folder}/harbor
#停止harbor
docker-compose down
#备份文件夹
mv ${new_harbor_folder}/harbor /my_backup_dir/harbor_1_10_0

#解压缩升级版本离线安装包
tar -C ${new_harbor_folder}/ -xzvf ${unzip_folder}/harbor/harbor-offline-installer-v2.3.0.tgz
#备份数据库
cp -r /data/database /my_backup_dir/harbor_1_10_0/database
#载入迁移工具镜像
cd ${unzip_folder}/harbor
docker load -i prepare-2.3.0.tar.gz
#配置文件迁移
cp /my_backup_dir/harbor_1_10_0/harbor.yml ${new_harbor_folder}/harbor/
docker run -it --rm -v /:/hostfs goharbor/prepare:2.3.0 migrate -i ${new_harbor_folder}/harbor/harbor.yml
#安装harbor 2.3.0
cd ${new_harbor_folder}/harbor
./install.sh
#数据库的模式升级和数据迁移是core在Harbor启动时执行预留升级时间
sleep 10m
###################################harbor升级v1.10.0->v2.3.0############################################

###################################harbor升级v2.3.0->v2.5.0#############################################
cd ${new_harbor_folder}/harbor
#停止harbor
docker-compose down
#备份文件夹
mv ${new_harbor_folder}/harbor /my_backup_dir/harbor_2_3_0

#解压缩升级版本离线安装包
tar -C ${new_harbor_folder}/ -xzvf ${unzip_folder}/harbor/harbor-offline-installer-v2.5.0.tgz
#备份数据库
cp -r /data/database /my_backup_dir/harbor_2_3_0/database
#载入迁移工具镜像
cd ${unzip_folder}/harbor
docker load -i prepare-2.5.0.tar.gz
#配置文件迁移
cp /my_backup_dir/harbor_2_3_0/harbor.yml ${new_harbor_folder}/harbor/
docker run -it --rm -v /:/hostfs goharbor/prepare:2.5.0 migrate -i ${new_harbor_folder}/harbor/harbor.yml
#安装harbor 2.5.0
cd ${new_harbor_folder}/harbor
./install.sh
#数据库的模式升级和数据迁移是core在Harbor启动时执行预留升级时间
sleep 10m
###################################harbor升级v2.3.0->v2.5.0############################################

###################################harbor升级v2.5.0->v2.7.0############################################
cd ${new_harbor_folder}/harbor
#停止harbor
docker-compose down
#备份文件夹
mv ${new_harbor_folder}/harbor /my_backup_dir/harbor_2_5_0

#解压缩升级版本离线安装包
tar -C ${new_harbor_folder}/ -xzvf ${unzip_folder}/harbor/harbor-offline-installer-v2.7.0.tgz
#备份数据库
cp -r /data/database /my_backup_dir/harbor_2_5_0/database
#载入迁移工具镜像
cd ${unzip_folder}/harbor
docker load -i prepare-2.7.0.tar.gz
#配置文件迁移
cp /my_backup_dir/harbor_2_5_0/harbor.yml ${new_harbor_folder}/harbor/
docker run -it --rm -v /:/hostfs goharbor/prepare:2.7.0 migrate -i ${new_harbor_folder}/harbor/harbor.yml
#安装harbor 2.7.0
cd ${new_harbor_folder}/harbor
./install.sh
#数据库的模式升级和数据迁移是core在Harbor启动时执行预留升级时间
sleep 10m
###################################harbor升级v2.5.0->v2.7.0############################################




