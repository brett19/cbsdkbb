# CB SDK Build Bot Auto Setup

## Description
A common and well-defined configuration for SDK build
bots, currently supports libcouchbase, php-couchbase
and couchnode on Windows, CentOS and Ubuntu.

## Installation

### Windows

1. Install VMWare Tools
1. Install Prerequisites
  1. Install Visual C++ Express 2008
  1. Install Visual C++ Express 2010
  1. Install Visual Studio Express 2012
  1. Install Visual Studio Community 2015
  1. Install Windows SDK 7.0
    1. Make sure to fix the VCROOT error in SetEnv.
  1. Install Windows SDK 7.1
  1. Install Git
    1. Make sure `git` is in your PATH
  1. Install Java 1.7
    1. Make sure `java` is in your PATH
  1. Install Python 2.7
    1. Make sure `python` is in your PATH
  1. Install CMake

1. Setup SDK Folder
  ```batch
  mkdir C:\cbsdkbb
  git clone https://github.com/brett19/cbsdkbb.git C:\cbsdkbb
  cd C:\cbsdkbb
  setup.bat
  ```

1. Connect Jenkins
  1. Install as Service
  1. Update service to execute as user rather than LOCAL SERVICE.

### CentOS, Ubuntu

1. Install VMWare Tools
  ```bash
  sudo mkdir /mnt/cdrom
  sudo mount /dev/cdrom /mnt/cdrom
  tar xzvf /mnt/cdrom/VMwareTools-*.tar.gz -C /tmp/
  cd /tmp/vmware-tools-distrib/
  sudo ./vmware-install.pl -d
  ```

1. Install Prerequisites
  1. The Basics
    ```bash
    CentOS:
    sudo yum groupinstall 'Development Tools'
    sudo yum install git cmake
    sudo yum install libevent-devel openssl-devel
    sudo yum install glibc-devel.i686 glibc-devel libstdc++-devel.i686

    Ubuntu:
    sudo apt-get install build-essential
    sudo apt-get install git autoconf cmake
    sudo apt-get install libevent-dev
    sudo apt-get install g++-multilib
    ```

  1. Java 1.7 (Ubuntu Only)
    ```bash
    sudo apt-get install python-software-properties
    sudo add-apt-repository ppa:webupd8team/java
    sudo apt-get update
    sudo apt-get install oracle-java7-installer
    ```

1. Setup SDK Folder
  ```bash
  sudo mkdir /cbsdkbb
  sudo chown buildbot cbsdkbb
  git clone https://github.com/brett19/cbsdkbb.git /cbsdkbb
  cd /cbsdkbb
  ./setup
  ```

### SmartOS

1. Install Prerequisites
  1. The Basics
    ```bash
    pkgin update
    pkgin in git gcc47 sun-jre6-6.0.26 libtool-base autoconf automake libevent gmake cmake
    ```
1. Setup SDK Folder
  ```bash
  sudo mkdir /cbsdkbb
  git clone https://github.com/brett19/cbsdkbb.git /cbsdkbb
  cd /cbsdkbb
  ./setup
  ```
