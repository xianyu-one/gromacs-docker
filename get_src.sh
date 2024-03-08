#!/bin/bash

# 获取最新tag
latest_tag=$(curl -s https://api.github.com/repos/gromacs/gromacs/tags | jq -r '.[0].name')

# 下载源码
wget https://github.com/gromacs/gromacs/archive/$latest_tag.tar.gz

# 解压源码
tar -xzf $latest_tag.tar.gz

# 删除压缩包
rm $latest_tag.tar.gz

# 更改文件夹名
mv $latest_tag /app