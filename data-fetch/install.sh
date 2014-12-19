#!/bin/bash
#################################################
#################################################
#          Environmet Setup for QOTD            #
#################################################
#################################################

#-----------------------------------------------#
#               Define Variables                #
#-----------------------------------------------#
# Get this script's location
SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )

# List of apt-get applications to install
LIST_OF_APPS="
    python-pip
    "

# List of easy install applications to install
LIST_OF_EASY_INSTALL="
    python-twitter
    "

# List of python pip libraries to install
LIST_OF_PY_LIBS="
    http://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-2.0.2.zip
    https://pypi.python.org/packages/source/U/Unidecode/Unidecode-0.04.16.tar.gz
    "

#-----------------------------------------------#
#              Fix locale issues                #
#-----------------------------------------------#
locale-gen en_US en_US.UTF-8
dpkg-reconfigure locales

#-----------------------------------------------#
#          Install defined Packages             #
#-----------------------------------------------#
# Install apt-get packages
sudo apt-get update
sudo apt-get install -y ${LIST_OF_APPS}

# Install easy_install packages
sudo easy_install ${LIST_OF_EASY_INSTALL}

# Install python packages
sudo pip install ${LIST_OF_PY_LIBS}

#-----------------------------------------------#
#       Finalize Environment Installation       #
#-----------------------------------------------#
# Back to script dir
cd ${SCRIPTPATH}

# Environment setup completed
echo "*****             Environment Installation Completed              *****"
