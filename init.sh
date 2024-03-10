#!/bin/bash

top_dir="/usr/local/gromacs/share/gromacs/top"
tar_file="/usr/local/gromacs/share/gromacs/top.tar.gz"

# 检查目标文件夹是否存在且为空
if [ ! -d "$top_dir" ] || [ -z "$(ls -A $top_dir)" ]; then
    # 解压缩文件
    tar -xzf $tar_file -C /usr/local/gromacs/share/gromacs/top
fi

useradd -ms /bin/bash -u $USER_UID gmx_user
chown $USER_UID:$USER_UID /work
echo 'source /usr/local/gromacs/bin/GMXRC' >> /home/gmx_user/.bashrc
chown -R $USER_UID:$USER_UID /home/gmx_user/
chown -R $USER_UID:$USER_UID /usr/local/gromacs/share
su -s /bin/bash gmx_user
source /home/gmx_user/.bashrc