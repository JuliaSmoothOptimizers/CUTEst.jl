#!/bin/bash

set -e

if [ "$TRAVIS_OS_NAME" == "linux" ]; then
  sudo apt-get update -qq -y

  #install LinuxBrew
  sudo apt-get install build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev
  echo -ne '\n' | ruby -e "$(wget -O- https://raw.github.com/Homebrew/linuxbrew/go/install)"
  brewdir=$HOME/.linuxbrew

  #Symlink GCC to avoid installing Homebrew GCC
  gccver=$(gcc -dumpversion | cut -d. -f1,2)
  ln -s $(which gcc) $brewdir/bin/gcc-$gccver
  ln -s $(which g++) $brewdir/bin/g++-$(g++ -dumpversion |cut -d. -f1,2)

  #Install GFORTRAN and add to visible location
  sudo apt-get -y install gfortran-$gccver
  ln -s $(which gfortran-$gccver) $brewdir/bin/gfortran-$gccver
  ln -s $(which gfortran-$gccver) $brewdir/bin/gfortran

  PATH=$brewdir/bin/:$PATH
  LD_LIBRARY_PATH=$brewdir/lib/:$LD_LIBRARY_PATH
fi

brew tap dpo/cutest
brew install cutest --HEAD
brew install mastsif --HEAD
echo "export PATH=$PATH" > $TRAVIS_BUILD_DIR/src_vars
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH" >> $TRAVIS_BUILD_DIR/src_vars
for f in archdefs mastsif cutest sifdecode
do
  cat $(brew --prefix $f)/$f.bashrc >> $TRAVIS_BUILD_DIR/src_vars
done

#Workaround for LD_LIBRARY_PATH
if [ "$TRAVIS_OS_NAME" == "linux" ]; then
  sudo ln -s $(brew --prefix cutest)/lib/libcutest.so /usr/local/lib
  sudo ln -s /usr/lib/gcc/x86_64-linux-gnu/4.6/libgfortran.so /usr/local/lib
fi

julia -e 'Pkg.clone("https://github.com/optimizers/NLP.jl.git")'

set +e
