#!/bin/bash

top_dir="/usr/local/gromacs/share/gromacs/top"
tar_file="/usr/local/gromacs/share/gromacs/top.tar.gz"

# 检查目标文件夹是否存在且为空
if [ ! -d "$top_dir" ] || [ -z "$(ls -A $top_dir)" ]; then
    # 解压缩文件
    tar -xzvf $tar_file -C /usr/local/gromacs/share/gromacs/
    echo "解压完成"
else
    echo "目标文件夹不为空"
fi
