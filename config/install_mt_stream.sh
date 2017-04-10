#!/bin/bash

if [ -f mt_stream/mt_stream.o ]; then
    echo "mt_stream.o found -- nothing to build."
else
    mkdir mt_stream
    cd mt_stream
    wget http://theo.phys.sci.hiroshima-u.ac.jp/~ishikawa/PRNG/mt_stream_f90.tar.gz
    tar zxvf mt_stream_f90.tar.gz
    cd mt_stream_f90-1.11
    sed -i -e 's/ifort/gfortran/g' Makefile
    sed -i -e 's/icpc/g++/g' Makefile
    sed -i -e 's/FFLAGS := -O3 -g -traceback/FFLAGS := -O3 -g -fno-range-check/g' Makefile
    make
    cd ../../
    test "$?BASH_VERSION" = "0" || eval 'setenv() { export "$1=$2"; }'
    setenv MT_STREAM mt_stream/mt_stream_f90-1.11
fi
