# Development machine

# Ubuntu 16.04

* Install using USB stick
* Soon after installation, execute
  ```
  $ sudo apt-get upgrade
  $ sudo apt-get update
  ```

# Environment
* Manual install (.deb): download and install manually.
  * chrome
  * teamviewer
  * virtualebox (failed)
  * skype
    ```
    $ sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
    $ sudo dpkg --add-architecture i386
    $ sudo apt-get update
    $ sudo apt-get install skype
    ```

* Packages: `$ sudo apt-get install git zsh terminator fleet p7zip-full`

* Docker:
  ```bash
  $ sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
  $ echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
  $ sudo apt-get update
  $ sudo apt-get install docker-engine
  ```

* Python
  * pip: `$ sudo python get-pip.py`
  * Root python packages: `$ sudo pip install virtualenvwrapper colorama invoke`

* Shell configuration
  * Configure zsh: ```chsh -s `which zsh` ```;
  * Create new SSH key: `$ ssh-keygen`;
  * Register the key on github.com;
  * Download .dotfiles: `$ git clone git@github.com:Kaniabi/dotfiles.git .dotfiles`
  * Download .oh-my-zsh: `$ git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh`

* Install PyCharm
  * Download PROFESSIONAL version
  * Register using login/password
  * Download settings from DROPBOX
  * SAVE: how to save/load settings?

* DNS (WIP)
  * `/etc/resolv.conf`
  
* Enable SysReq: REISUB
  A way out when we get Ubuntu Freeze:

  * http://askubuntu.com/questions/4408/what-should-i-do-when-ubuntu-freezes/36717#36717

  ```
  $ sudo nano /etc/sysctl.d/10-magic-sysrq.conf
  # and switch 176 to 244
  $ echo 244 | sudo tee /proc/sys/kernel/sysrq
  ```

  NOTE: Can't make it work, thou.
