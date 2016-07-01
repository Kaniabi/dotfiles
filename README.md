# Development machine

## Preparation

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

## Install OS

### Install

Install Ubuntu 16.04 using the generated pendrive.

### Upgrade and Update the system
```bash
$ sudo apt-get upgrade
$ sudo apt-get update
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

### virtualbox (not tested)
```bash
$ sudo apt-add-repository "deb http://download.virtualbox.org/virtualbox/debian xenial contrib"
$ wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
$ sudo apt-get update
$ sudo apt-get install virtualbox-5.0
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
$ echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
$ sudo apt-get update
$ sudo apt-get install docker-engine
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

### pycharm

* Download PROFESSIONAL version
* Register using login/password
* Download settings from DROPBOX
* TODO: how to automatically import/export pycharm settings?

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

