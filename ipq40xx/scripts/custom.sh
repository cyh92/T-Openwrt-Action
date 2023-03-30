#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================
# Modify default IP
sed -i 's/192.168.1.1/192.168.3.1/g' package/base-files/files/bin/config_generate

# Add date version
export DATE_VERSION=$(date -d "$(rdate -n -4 -p pool.ntp.org)" +'%Y-%m-%d')
sed -i "s/%C/%C (${DATE_VERSION})/g" package/base-files/files/etc/openwrt_release

# Fix mt76 wireless driver
pushd package/kernel/mt76
sed -i '/mt7662u_rom_patch.bin/a\\techo mt76-usb disable_usb_sg=1 > $\(1\)\/etc\/modules.d\/mt76-usb' Makefile
popd

# Rename hostname to OpenWrt
pushd package/base-files/files/bin
sed -i 's/ImmortalWrt/OpenWrt/g' config_generate
popd

# Change default shell to zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

rm -rf package/ctcgfw/r8168

# 删除自定义源默认的 argon 主题
#rm -rf package/lean/luci-theme-argon
# 部分第三方源自带 argon 主题，上面命令删除不掉的请运行下面命令
#find ./ -name luci-theme-argon | xargs rm -rf;
#拉取 argon的源码
#git clone --depth=1 https://github.com/cyh92/luci-theme-argon package/luci-theme-argon

#git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon

#支持OpenWrt官方源码22.03版本luci-app-zerotier
#find ./ -name luci-app-zerotier | xargs rm -rf;
#git clone https://github.com/lylus/luci-app-zerotier package/luci-app-zerotier


