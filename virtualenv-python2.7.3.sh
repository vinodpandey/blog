#!/bin/bash
# create a directory and run this script to create a virtualenv 
# inside that directory
# mkdir test
# cd test
# wget --no-check-certificate -O virtualenv-python2.7.3.sh https://raw.github.com/vinodpandey/blog/master/virtualenv-python2.7.3.sh
# chmod +x virtualenv-python2.7.3.sh
# ./virtualenv-python2.7.3.sh
# source bin/activate
# python --version
# deactivate
# test will now have virtual environment created with Python 2.7.3

# check python version, if version 2.7.3 not present, install it
if [[ $(python2.7 -c 'import sys; print(".".join(map(str, sys.version_info[:3])))') != 2.7.* ]]; then
    echo "Installing Python 2.7.3"
    sudo yum -y install zlib zlib-devel gcc httpd-devel bzip2-devel
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
    sudo echo "/usr/local/lib" > python2.7.conf 
    sudo mv python2.7.conf /etc/ld.so.conf.d/python2.7.conf 
    sudo /sbin/ldconfig
    sudo ln -sfn /usr/local/bin/python2.7 /usr/bin/python2.7
else
   echo "Python 2.7.X present"
fi

# check easy_install, if not present, install it
if [[ $(easy_install-2.7 --version) != distribute* ]]; then
    echo "Installing easy_install-2.7"
    wget --no-check-certificate https://pypi.python.org/packages/source/d/distribute/distribute-0.6.35.tar.gz
    tar zxvf distribute-0.6.35.tar.gz
    cd distribute-0.6.35
    sudo python2.7 setup.py install
    sudo ln -sfn /usr/local/bin/easy_install-2.7 /usr/bin/easy_install-2.7
    cd ..
    sudo rm -rf distribute-0.6.35.tar.gz distribute-0.6.35
else
    echo "easy_install-2.7 present"
fi
  
# check pip, if not present, install it
if [[ $(pip-2.7 --version) != pip* ]]; then
   echo "Installing pip" 
   sudo easy_install-2.7 pip
   sudo ln -sfn /usr/local/bin/pip-2.7 /usr/bin/pip-2.7
else
   echo "pip-2.7 present"
fi

# check if virtualenv is present, otherwise install it
if [[ $(virtualenv-2.7 --version) != 1.9.1* ]]; then
    sudo pip-2.7 install virtualenv==1.9.1
else
    echo "virtualenv-2.7 v1.9.1 present"
fi

echo "creating virtual environment"
virtualenv-2.7 --no-site-packages .
source bin/activate
python -V 
pip install fabric
deactivate
