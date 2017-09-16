#!/bin/bash
#
# Build script for fluffy-octo-succotash
#
# Author: Jeremy Reeve
#
git submodule update --remote
# 
pushd necpp
make -f Makefile.git
./configure --without-lapack --prefix=$PWD/../install/necpp
make
make install
popd

pushd OOML
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX:PATH=$PWD/../../install/ooml ..
make
make install
popd

make -f Makefile.git
env LDFLAGS=-L$PWD/install/necpp CPPFLAGS=-I$PWD/install/necpp ./configure --prefix=$PWD/install/curly-octo-succotash
make
make install

