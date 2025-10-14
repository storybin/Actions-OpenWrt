#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# 修改默认IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
# sed -i 's/LEDE/NST/g' package/base-files/files/bin/config_generate

# 清除默认密码，这使得首次登录时无需密码
# sed -i '/CYXluq4wUazHjmCDBCqXF/d' package/lean/default-settings/files/zzz-default-settings

# 定义密码 '12361236' 的加密哈希
# 使用 openssl passwd -1 -salt 'random' '12361236' 生成加密密码,这里我们没有手动指定 salt, 而是使用了工具随机生成的 salt
# 在打包固件前，修改 /etc/shadow 文件以设置新密码
ENCRYPTED_PASSWORD='$1$jIAv5u2S$v5ybfz.m3fCV22gNlg5U8/'
sed -i "s#^root:[^:]*:#root:${ENCRYPTED_PASSWORD}:#g" package/base-files/files/etc/shadow
