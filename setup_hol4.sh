#!/bin/bash

# Install Apache Ant, ruby
apt install ant ruby2.7

#FIXME: Change to your local installation/git repository folder
BASEDIR=/opt/test/

cd $BASEDIR

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
    echo "Lassie cannot be installed without the non-anonymous material. Please put `non_anonymous.zip` in $BASEDIR and rerun the script."
    unzip non_anonymous.zip -d Lassie
    cd Lassie/sempre && ./pull-dependencies core interactive && ant core interactive
    cd $BASEDIR/Lassie/src && $HOLDIR/bin/Holmake

echo "Please add the following lines to your shell configuration file:\n export HOLDIR=$BASEDIR/HOL/ \nexport LASSIEDIR=$BASEDIR/Lassie/"
