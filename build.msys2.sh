#!sh
rm -rf prerequisites/build 2> /dev/null
mkdir prerequisites/build
cd prerequisites/build 
cmake -G "MSYS Makefiles" ..
make
cd -
rm -rf build 2> /dev/null
mkdir build
cd build 
cmake -G "MSYS Makefiles" .. 
make
cd -
