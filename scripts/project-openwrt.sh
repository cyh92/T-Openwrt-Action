#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

#sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate
#默认无线SSID
#sed -i 's/ssid=ImmortalWrt/ssid=OpenWrt/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#sed -i 's/ssid=ImmortalWrt/ssid=OpenWrt/g' package/network/config/wifi-scripts/files/lib/wifi/mac80211.sh

sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' package/base-files/files/etc/shadow
sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' package/base-files/files/etc/shadow

# Modify default IP
sed -i "s/192.168.1.1/$1/g" package/base-files/files/bin/config_generate
echo "设备IP参数为：$1";
#设置版本为当前时间
date=`date +%Y.%m.%d`
sed -i -e "/\(# \)\?REVISION:=/c\REVISION:=$date" -e '/VERSION_CODE:=/c\VERSION_CODE:=$(REVISION)' include/version.mk

sed -i '/DISTRIB_REVISION/d' package/base-files/files/etc/openwrt_release
echo "DISTRIB_REVISION='R22.03'" >> package/base-files/files/etc/openwrt_release
sed -i '/DISTRIB_DESCRIPTION/d' package/base-files/files/etc/openwrt_release
echo "DISTRIB_DESCRIPTION='v$date'" >> package/base-files/files/etc/openwrt_release

#rm -r package/emortal/default-settings
#echo "删除成功"

# Remove r8168 driver
rm -rf package/ctcgfw/r8168

# 删除自定义源默认的 argon 主题
#rm -rf package/lean/luci-theme-argon
# 部分第三方源自带 argon 主题，上面命令删除不掉的请运行下面命令
#find ./ -name luci-theme-argon | xargs rm -rf;
#拉取 argon的源码
# git clone --depth=1 https://github.com/cyh92/luci-theme-argon package/luci-theme-argon
#git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon


#find ./ -name luci-app-oaf | xargs rm -rf;
#find ./ -name oaf | xargs rm -rf;
#find ./ -name open-app-filter | xargs rm -rf;

#git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
#在线设备
git clone --depth=1 https://github.com/danchexiaoyang/luci-app-onliner package/luci-app-onliner
#网络设置向导
git clone --depth=1 https://github.com/sirpdboy/luci-app-netwizard package/luci-app-netwizard
#高级设置-Plus
git clone --depth=1 https://github.com/sirpdboy/luci-app-advancedplus package/luci-app-advancedplus
#家长控制
#git clone https://github.com/sirpdboy/luci-app-parentcontrol package/luci-app-parentcontrol
#网络设置
git clone --depth=1 https://github.com/kiddin9/luci-app-wizard package/luci-app-wizard
#集客AC控制器
#git clone https://github.com/Akimio521/luci-app-gecoosac package/luci-app-gecoosac
#DNS转发器
#git clone --depth=1 https://github.com/sbwml/luci-app-mosdns package/luci-app-mosdns

# 删除自定义源默认的 argon 主题
#rm -rf package/lean/luci-theme-argon
# 部分第三方源自带 argon 主题，上面命令删除不掉的请运行下面命令
find ./ -name luci-app-homeproxy | xargs rm -rf;
git clone --depth=1 https://github.com/muink/luci-app-homeproxy package/luci-app-homeproxy
find ./ -name luci-app-passwall | xargs rm -rf;
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall
#git clone --depth=1 https://github.com/linkease/nas-packages-luci package/nas-packages-luci
