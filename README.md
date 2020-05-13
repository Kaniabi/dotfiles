# Development machine

## Install Ubuntu from USB

### Create Ubuntu 16.04 installation pendrive

* Using Startup Disc Creator generates a 16Gb in a 2Gb pendrive.
    * Can't write files on it (custom files);
    * Can't create a different partition for custom files;
    * [USB Startup Disk Creator Block Size Problem](http://askubuntu.com/questions/778660/usb-startup-disk-creator-block-size-problem)

* The package UNetBootin version doesn't work on Ubutun 16.04.

### unetbootin
```bash
$ sudo add-apt-repository ppa:gezakovacs/ppa
$ sudo apt-get update
$ sudo apt-get install unetbootin
```

### Install

Install Ubuntu 16.04 using the generated pendrive.

### Upgrade and Update the system
```bash
$ sudo apt-get upgrade
$ sudo apt-get update
```

## Install (latest) Ubunto WSL

* Install OS

```
# Windows console:

$ FILENAME=eoan-server-cloudimg-amd64-wsl.rootfs.tar.gz
$ wget https://cloud-images.ubuntu.com/eoan/current/$FILENAME
$ wsl --import Eoan d:\Eoan $FILENAME

$ apt update
$ apt upgrade
```

* Create user

```
$ wsl -d Eoan
$ adduser kaniabi
$ usermod -a -G sudo kaniabi
$ sed --in-place 's/%sudo\tALL=(ALL:ALL) ALL/%sudo\tALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers
$ sudo apt install zsh
(...)
$ su - kaniabi
$ touch ~/.ssh/id_rsa
$ chmod 400 ~/.ssh/id_rsa
$ chsh zsh
```

```
```

```
```

* /etc/wsl.conf

```
# Enable extra metadata options by default
[automount]
enabled = true
root = /windir/
options = "metadata,umask=22,fmask=11"
mountFsTab = false

# Enable DNS – even though these are turned on by default, we’ll specify here just to be explicit.
[network]
generateHosts = true
generateResolvConf = true
```


### Update the KERNEL

We're having some random freezes with kernel panic (blinking CAPSLOCK). Updating the kernel to the latest available
HOPEFULLY solve the problem

```bash
$ wget kernel.ubuntu.com/~kernel-ppa/mainline/v4.7-rc5-yakkety/linux-headers-4.7.0-040700rc5_4.7.0-040700rc5.201606262232_all.deb
$ wget kernel.ubuntu.com/~kernel-ppa/mainline/v4.7-rc5-yakkety/linux-headers-4.7.0-040700rc5-generic_4.7.0-040700rc5.201606262232_amd64.deb
$ wget kernel.ubuntu.com/~kernel-ppa/mainline/v4.7-rc5-yakkety/linux-image-4.7.0-040700rc5-generic_4.7.0-040700rc5.201606262232_amd64.deb
$ sudo dpkg -i linux-headers-4.7*.deb linux-image-4.7*.deb
$ sudo update-grub
$ sudo reboot
```


* [Ubuntu 15.10 and 16.04 keep freezing randomly](http://askubuntu.com/questions/761706/ubuntu-15-10-and-16-04-keep-freezing-randomly)


### Microsoft Keyboard

```
$ sudo sed -i -e 's/XKBOPTIONS=""/XKBOPTIONS="numpad:microsoft"/g' /etc/default/keyboard
```

## Configure environment

### chrome (not tested)
```bash
$ sudo apt-get install libxss1 libappindicator1 libindicator7
$ wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
$ sudo dpkg -i google-chrome*.deb
$ sudo apt-get install -f
```

### teamviewer (not tested)
```bash
$ wget http://download.teamviewer.com/download/teamviewer_amd64.deb
$ sudo dpkg -i teamviewer_amd64.deb
$ sudo apt-get install -f
```

### virtualbox
```bash
$ sudo apt-add-repository "deb http://download.virtualbox.org/virtualbox/debian xenial contrib"
$ wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
$ sudo apt-get update
$ sudo apt-get install virtualbox-5.0
```

* Still not working on Ubuntu 16.04 with Kernel 4.7.0rc5.

    * During installation we have the following message

        ```
        Starting VirtualBox kernel modules ...failed!
          (modprobe vboxdrv failed. Please use 'dmesg' to find out why)
        ```

    * Checking

        ```
        $ VBoxManage --version
        WARNING: The vboxdrv kernel module is not loaded. Either there is no module
                 available for the current kernel (4.7.0-040700rc5-generic) or it failed to
                 load. Please recompile the kernel module and install it by

                 sudo /sbin/rcvboxdrv setup

                 You will not be able to start VMs until this problem is fixed.
        5.0.24r108355
        ```

    * Trying rcvboxdrv

        ```
        $ sudo /sbin/rcvboxdrv setup
        Stopping VirtualBox kernel modules ...done.
        Uninstalling old VirtualBox DKMS kernel modules ...done.
        Trying to register the VirtualBox kernel modules using DKMS ...done.
        Starting VirtualBox kernel modules ...failed!
          (modprobe vboxdrv failed. Please use 'dmesg' to find out why)
        ```


### skype
```bash
$ sudo add-apt-repository "deb http://archive.canonical.com/ xenial partner"
$ sudo dpkg --add-architecture i386
$ sudo apt-get update
$ sudo apt-get install skype
```

### git
```bash
$ sudo add-apt-repository ppa:git-core/ppa
$ sudo apt-get update
$ sudo apt-get install git
```

### docker
```bash
$ sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
$ sudo add-apt-repository "deb https://apt.dockerproject.org/repo ubuntu-xenial main"
$ sudo apt-get update
$ sudo apt-get install docker-engine=1.11.1-0~xenial
$ sudo apt-mark hold docker-engine
```

Installing latest version of docker (1.11.2) is failing with the following error:

* ERROR: [Ubuntu 16.04 install for 1.11.2 hangs](https://github.com/docker/docker/issues/23347)


#### Docker without sudo

* [How can I use docker without sudo?](http://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo)

```bash
$ sudo gpasswd -a ${USER} docker
$ newgrp docker
```

### system packages:
```bash
$ sudo apt-get install zsh terminator fleet p7zip-full default-jre
```

### pip
```bash
$ sudo python get-pip.py
```

### python packages
```bash
$ sudo pip install virtualenvwrapper colorama invoke
```

### Use zsh
```bash
$ chsh -s `which zsh`
```

### Generate a new ssh-key
```bash
$ ssh-keygen
# TASK: Register the key on github.com;
```

### dotfiles
```bash
$ git clone git@github.com:Kaniabi/dotfiles.git .dotfiles
$ git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh
$ .dotfiles/scripts/bootstrap
```


### bullet-train (zsh)
```bash
$ sudo apt-get install ttf-ancient-fonts
$ export TERM="xterm-256color"

```

### pycharm

* Download PROFESSIONAL version
* Register using login/password
* Download settings from DROPBOX
* TODO: how to automatically import/export pycharm settings?
* [Inotify Watches Limit](https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit)

### Custom hosts names

* FILE: `/etc/hosts`
    ```
    192.168.0.66  hack-01
    192.168.0.66  registry.axado.com.br
    192.168.0.66  devpi.axado.com.br
    192.168.0.61  hack-02
    192.168.0.27  hack-03
    ```

### Enable SysReq: REISUB
A way out when we get Ubuntu Freeze. Once enabled you can use `Alt+PrtScn+ R E I S U B`.

```bash
$ sudo sed -i -e 's/176/244/g' /etc/sysctl.d/10-magic-sysrq.conf
$ echo 244 | sudo tee /proc/sys/kernel/sysrq
```

* [What should I do when Ubuntu freezes?](http://askubuntu.com/questions/4408/what-should-i-do-when-ubuntu-freezes/36717#36717)

### Installing kubectl

http://kubernetes.io/docs/getting-started-guides/kubeadm/

```bash
$ curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee apt-key add -
$ cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
$ apt-get update
$ apt-get install -y kubectl
```

### Disabling IPv6
```
$ cat <<EOF | sudo tee -a /etc/sysctl.conf
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOF
$ sudo sysctl -p
```

### Installing GitHub's HUB

* There is no release for Ubuntu 16.10 (yakkety).
* Reference: https://launchpad.net/~cpick/+archive/ubuntu/hub

```bash
$ sudo apt-add-repository "deb http://ppa.launchpad.net/cpick/hub/ubuntu xenial main"
$ sudo apt-get update
$ sudo apt-get install hub
```
