# XGecu Xgpro wine docker image

This repository is based on the work of [radiomanV's ](https://github.com/radiomanV) [TL866 Winelib](https://github.com/radiomanV/TL866/tree/master/wine) . Thanks for the amazing work! 

It also uses the mirrored [XGecu_Software](https://github.com/Kreeblah/XGecu_Software) repository from [Kreeblah](https://github.com/Kreeblah) to get the Installer.


It aims to provide a one command execution for the linux usage of the TL866/T56/T48 programmer with xgpro.


Only tested with the T48!

## Linux Container

[![linux/amd64](https://github.com/Apfelwurm/Xgpro-docker/actions/workflows/build-linux-image.yml/badge.svg?branch=main)](https://github.com/Apfelwurm/Xgpro-docker/actions/workflows/build-linux-image.yml)

### Download (optional, should be working without this step)

```shell
docker pull apfelwurm/xgpro-docker;
```

### Run xgpro with docker run (recommended way)

```shell
xhost +
docker run --rm --privileged -v $PWD:/currdir -v /dev/bus/usb:/dev/bus/usb -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY apfelwurm/xgpro-docker
```


### Run xgpro as root with docker run (not recommended)

```shell
xhost local:root
docker run --rm --privileged -v $PWD:/currdir -v /dev/bus/usb:/dev/bus/usb -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -e ROOT=TRUE apfelwurm/xgpro-docker
```

### start the container in a bash command line as root and start xgpro manually as user

```shell
xhost +
docker run -it --rm --privileged -v $PWD:/currdir -v /dev/bus/usb:/dev/bus/usb -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY apfelwurm/xgpro-docker /bin/bash
/app/start.sh
```

### start the container in a bash command line as root and start xgpro manually as root

```shell
xhost +
docker run -it --rm --privileged -v $PWD:/currdir -v /dev/bus/usb:/dev/bus/usb -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -e ROOT=TRUE apfelwurm/xgpro-docker /bin/bash
/app/start.sh
```


### Run xgpro with docker compose (not recommended)

* copy the `docker-compose.yml`from the repository to a local folder and cd in it with the console
* execute:

```shell
xhost +
docker compose up
```




### known issues / quirks

* when using (a T48) for the first time, i got a "please reflash firmware" error on startup and every action i tried. This could not be fixed on the linux machine (see quirk below). Had to plug it in a windows machine to reflash the current firmware one time, since then it works. [might work now, since udev works, cannot test that]
* the firmware flashing (on a T48) did not work at all, since i always got a reset error. [might work now, since udev works, cannot test that]
* i had to install the clip/chip before usb powering the (T48) programmer, becaue i get a pincheck error if i don't do it in that order
* when programming (with the T48) with the "erase before" option enabled, only erased the IC and then errored out. A restart of the Software/container was required afterwards. This can be avoided by using the erase function and disabling the "erase before" option for programming [might work now, since udev works, cannot test that]
* had some other quirks, all were fixed by stopping the software, replugging the (T48) programmer and restarting the software.