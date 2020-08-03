#!/bin/bash

#FIXME: Change to your local installation/git repository folder
BASEDIR=/opt/

cd $BASEDIR

# Make sure necessary packages are installed:
#apt-get update && \
#apt-get install -y build-essential aspcud m4 wget unzip git curl ant ruby openjdk-8-jdk

# Install polyml from git
git clone https://github.com/polyml/polyml.git polyml && \
    cd polyml && \
    ./configure --prefix=/usr && make && make compiler && make install

# Install HOL4
cd $BASEDIR && \
    git clone https://github.com/HOL-Theorem-Prover/HOL HOL && \
    cd HOL && git checkout master &&\
    poly < tools/smart-configure.sml && bin/build

export HOLDIR=$BASEDIR/HOL/

cd $BASEDIR && \
    git clone https://gitlab.mpi-sws.org/AVA/lassie.git Lassie &&\
    cd Lassie/sempre && ./pull-dependencies core interactive && ant core interactive

echo "Please add the following lines to your shell configuration file:\n export HOLDIR=$BASEDIR/HOL/ \nexport LASSIEDIR=$BASEDIR/Lassie/"
