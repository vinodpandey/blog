#!/bin/bash
# create a directory and run this script to create a virtualenv 
# inside that directory
# mkdir test
# cd test
# wget --no-check-certificate -O virtualenv-python2.7.3.sh https://raw.github.com/vinodpandey/blog/master/virtualenv-python2.7.3.sh
# chmod +x virtualenv-python2.7.3.sh
# ./virtualenv-python2.7.3.sh
# source bin/activate
# python -version
# deactivate
# test will now have virtual environment created with Python 2.7.3


if [ "$(python2.7 -c 'import sys; print(".".join(map(str, sys.version_info[:3])))')" != "2.7.3" ]; then
    if [ "$SUDO_USER" = "" ]; then
        echo "Please run this script with sudo. We need to install Python 2.7.3"
    else
        echo "Installing Python 2.7.3"
        sudo yum -y install zlib zlib-devel gcc httpd-devel
        mkdir -p temp
        cd temp
        wget http://www.python.org/ftp/python/2.7.3/Python-2.7.3.tgz
        tar zxvf Python-2.7.3.tgz
        cd Python-2.7.3
        ./configure --prefix=/usr/local --with-threads --enable-shared --with-zlib=/usr/include
        make
        sudo make altinstall
        cd ..
        cd ..
        rm -rf temp
        sudo echo "/usr/local/lib" > /etc/ld.so.conf.d/python2.7.conf 
        sudo /sbin/ldconfig
        sudo ln -s /usr/local/bin/python2.7 /usr/bin/python2.7
    fi

else
    echo "Creating virtualenv"
    wget http://pypi.python.org/packages/source/v/virtualenv/virtualenv-1.5.1.tar.gz
    tar zxvf virtualenv-1.5.1.tar.gz
    python2.7 virtualenv-1.5.1/virtualenv.py --no-site-packages .
    source bin/activate
    python -V 
    pip install fabric
    rm -rf virtualenv-1.5.1  virtualenv-1.5.1.tar.gz
    deactivate
fi


 



