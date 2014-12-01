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
    "

# List of aptitude applications to install
LIST_OF_APTITUDE="
    "

# List of easy install applications to install
LIST_OF_EASY_INSTALL="
    python-twitter
    "

# List of python pip libraries to install
LIST_OF_PY_LIBS="
    https://pypi.python.org/packages/source/M/MySQL-python/MySQL-python-1.2.5.zip#md5=654f75b302db6ed8dc5a898c625e030c
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
sudo aptitude install -y ${LIST_OF_APTITUDE}

# Install easy_install packages
sudo easy_install-2.7 ${LIST_OF_EASY_INSTALL}

# Install python packages
sudo pip install ${LIST_OF_PY_LIBS}

#-----------------------------------------------#
#       Finalize Environment Installation       #
#-----------------------------------------------#
# Back to script dir
cd ${SCRIPTPATH}

# Environment setup completed
echo "*****             Environment Installation Completed              *****"
