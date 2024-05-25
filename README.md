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

### Run xgpro with docker run

```shell
xhost +
docker run --rm --privileged -v $PWD:/currdir -v /dev/bus/usb:/dev/bus/usb -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY apfelwurm/xgpro-docker
```

### start the container in a bash command line

```shell
xhost +
docker run -it --rm --privileged -v $PWD:/currdir -v /dev/bus/usb:/dev/bus/usb -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY apfelwurm/xgpro-docker /bin/bash
```


### Run xgpro as root with docker run

```shell
xhost local:root
docker run --rm --privileged -u 0 -v $PWD:/currdir -v /dev/bus/usb:/dev/bus/usb -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY apfelwurm/xgpro-docker
```

### start the container as root in a bash command line

```shell
xhost local:root
docker run -it --rm --privileged -u 0 -v $PWD:/currdir -v /dev/bus/usb:/dev/bus/usb -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY apfelwurm/xgpro-docker /bin/bash
```


### Run xgpro with docker compose (not recommended)

* copy the `docker-compose.yml`from the repository to a local folder and cd in it with the console
* execute:

```shell
xhost +
docker compose up
```




### known issues / quirks

* when using (a T48) for the first time, i got a "please reflash firmware" error on startup and every action i tried. This could not be fixed on the linux machine (see quirk below). Had to plug it in a windows machine to reflash the current firmware one time, since then it works.
* the firmware flashing (on a T48) did not work at all, since i always got a reset error.
* replugging the USB of the (T48) Programmer does require to either restart the entire container, or Xgpro (if you are using the container in console mode)
* i had to install the clip/chip before usb powering the (T48) programmer, becaue i get a pincheck error if i don't do it in that order
* when programming (with the T48) with the "erase before" option enabled, only erased the IC and then errored out. A restart of the Software/container was required afterwards. This can be avoided by using the erase function and disabling the "erase before" option for programming
* had some other quirks, all were fixed by stopping the software, replugging the (T48) programmer and restarting the software.