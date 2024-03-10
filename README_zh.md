# gromacs-docker

[gromacs](https://gromacs.org)的容器化构建

## 使用方法

你可以使用以下命令来运行此容器

```bash
docker run --rm -it --name gromacs mrxianyu/gromacs:latest /bin/bash
```

可选参数

| 参数 | 解释 |
| --- | --- |
| -v ${PWD}:/work | 挂载工作目录至容器 |
| -v ${PWD}:/usr/local/gromacs/share/top | 挂载top目录方便添加数据 |
| -e USER_UID | 自定义UID |
