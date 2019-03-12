#!/bin/sh
export QT_SELECT=qt5.12
rm -rf prerequisites/build 2> /dev/null
mkdir prerequisites/build
cd prerequisites/build 
cmake ..
make
cd -
rm -rf build 2> /dev/null
mkdir build
cd build 
cmake .. 
make
cd -
