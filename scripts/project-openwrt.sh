#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate

# Modify default IP
sed -i "s/192.168.1.1/$1/g" package/base-files/files/bin/config_generate
echo "设备IP参数为：$1";
#设置版本为当前时间
date=`date +%Y.%m.%d`
sed -i -e "/\(# \)\?REVISION:=/c\REVISION:=$date" -e '/VERSION_CODE:=/c\VERSION_CODE:=$(REVISION)' include/version.mk

sed -i '/DISTRIB_REVISION/d' package/base-files/files/etc/openwrt_release
echo "DISTRIB_REVISION='R22.03'" >> package/base-files/files/etc/openwrt_release
sed -i '/DISTRIB_DESCRIPTION/d' package/base-files/files/etc/openwrt_release
echo "DISTRIB_DESCRIPTION='v$date \/'" >> package/base-files/files/etc/openwrt_release

# Remove r8168 driver
rm -rf package/ctcgfw/r8168

# 删除自定义源默认的 argon 主题
rm -rf package/lean/luci-theme-argon
# 部分第三方源自带 argon 主题，上面命令删除不掉的请运行下面命令
find ./ -name luci-theme-argon | xargs rm -rf;
#拉取 argon的源码
# git clone --depth=1 https://github.com/cyh92/luci-theme-argon package/luci-theme-argon

git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon

#支持OpenWrt官方源码22.03版本luci-app-zerotier
find ./ -name luci-app-zerotier | xargs rm -rf;
git clone https://github.com/lylus/luci-app-zerotier package/luci-app-zerotier


#git clone https://github.com/SuLingGG/default-settings package/default-settings


