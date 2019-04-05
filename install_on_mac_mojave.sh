#! /bin/bash

##############################
# PREREUIRED.
##############################
#MAC (Mojave 10.14.3)


##############################
# install gcc for h8300-elf.
##############################

# INSTALL GMP.
curl -O https://gmplib.org/download/gmp/gmp-6.1.2.tar.bz2 && \
tar -jxvf gmp-6.1.2.tar.bz2 && \
cd gmp-6.1.2 && \
mkdir build && \
cd build && \
../configure --prefix=$HOME/usr  --enable-cxx && \
make && \
make install && \
cd ../../ && \


# INSTALL MPFR.
curl -O https://www.mpfr.org/mpfr-current/mpfr-4.0.2.tar.gz && \
tar -xvf mpfr-4.0.2.tar.gz && \
cd mpfr-4.0.2 && \
mkdir build && \
cd build && \  
../configure --prefix=$HOME/usr --with-gmp=$HOME/usr && \
make && \
make install && \
cd ../../ && \


# INSTALL MPC.
curl -O https://ftp.gnu.org/gnu/mpc/mpc-1.1.0.tar.gz && \
tar -xvf mpc-1.1.0.tar.gz && \
cd mpc-1.1.0 && \
mkdir build && \
cd build && \  
../configure --prefix=$HOME/usr --with-gmp=$HOME/usr --with-mpfr=$HOME/usr && \
make && \
make install && \
cd ../../ && \


# INSTALL BINUTILS.
curl -O ftp://ftp.gnu.org/gnu/binutils/binutils-2.32.tar.gz && \
tar -xvf binutils-2.32.tar.gz && \
cd binutils-2.32 && \
mkdir build && \
cd build && \
../configure --prefix=$HOME/usr --target=h8300-elf --disable-nls && \
cd ../../ && \


# INSTALL GCC.
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/usr

curl -O ftp://ftp.gnu.org/gnu/gcc/gcc-4.8.5/gcc-4.8.5.tar.gz && \
tar -xvf gcc-4.8.5.tar.gz && \
cd gcc-4.8.5 && \
mkdir build && \
cd build && \
../configure --prefix=$HOME/usr --target=h8300-elf --disable-nls --disable-threads --disable-shared --enable-languages=c --disable-libssp --with-gmp=$HOME/usr --with-mpc=$HOME/usr --with-mpfr=$HOME/usr && \
make && \
make install && \



##############################
#  install h8write tool.
##############################

curl -O http://mes.osdn.jp/h8/h8write.c && \
gcc h8write.c -o h8write && \
chmod +x h8write && \
mv h8write $HOME/usr/bin


