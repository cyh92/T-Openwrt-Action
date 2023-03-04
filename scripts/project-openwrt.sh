#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================
# Modify default IP
sed -i "s/192.168.1.1/192.168.50.5/g" package/base-files/files/bin/config_generate
#设置版本为当前时间
date=`date +%Y.%m.%d`
sed -i -e "/\(# \)\?REVISION:=/c\REVISION:=$date" -e '/VERSION_CODE:=/c\VERSION_CODE:=$(REVISION)' include/version.mk

# Remove r8168 driver
rm -rf package/ctcgfw/r8168

# 删除自定义源默认的 argon 主题
rm -rf package/lean/luci-theme-argon
# 部分第三方源自带 argon 主题，上面命令删除不掉的请运行下面命令
find ./ -name luci-theme-argon | xargs rm -rf;
#拉取 argon的源码
git clone --depth=1 https://github.com/cyh92/luci-theme-argon package/luci-theme-argon

#git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
# #全能推送
# git clone https://github.com/cyh92/luci-app-pushbot package/luci-app-pushbot
