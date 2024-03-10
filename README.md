# gromacs-docker

Containerized build of [gromacs](https://gromacs.org)

## Instructions

You can run this container using the following command

```bash
docker run --rm -it --name gromacs mrxianyu/gromacs:latest /bin/bash
```

Optional parameters

| Parameters | Explanation |
| --- | --- |
| -v ${PWD}:/work | Mount the working directory to the container |
| -v ${PWD}:/usr/local/gromacs/share/top | Mount the top directory to facilitate adding data |
| -e USER_UID | Custom UID |