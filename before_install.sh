if [ "$TRAVIS_OS_NAME" == "linux" ]; then
  sudo apt-get update -qq -y
  sudo apt-get install -y gfortran
  git clone https://github.com/Homebrew/linuxbrew.git $TRAVIS_BUILD_DIR/linuxbrew
  PATH=$PATH:$TRAVIS_BUILD_DIR/linuxbrew/bin/
  brew tap dpo/cutest
  brew install cutest --HEAD
  brew install mastsif --HEAD
  echo "export PATH=$PATH" > $TRAVIS_BUILD_DIR/src_vars
  for f in archdefs mastsif cutest sifdecode
  do
    cat $(brew --prefix $f)/$f.bashrc >> $TRAVIS_BUILD_DIR/src_vars
  done
  sudo ln -s $(brew --prefix cutest)/lib/libcutest.so /usr/local/lib/
else
  # Implement before_install for OSX here
  echo "No support for OSX" yet
fi

julia -e 'Pkg.clone("https://github.com/optimizers/NLP.jl.git")'
