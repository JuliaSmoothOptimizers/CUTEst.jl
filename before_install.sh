if [ $TRAVIS_OS_NAME == "linux" ]; then
  sudo apt-get update -qq -y
  sudo apt-get install -y gfortran
  git clone https://github.com/Homebrew/linuxbrew.git $TRAVIS_BUILD_DIR/linuxbrew
  brewcmd=$TRAVIS_BUILD_DIR/linuxbrew/bin/brew
  $brewcmd tap dpo/cutest
  $brewcmd install cutest --HEAD
  $brewcmd install mastsif --HEAD
  for f in archdefs mastsif cutest sifdecode
  do
    cp $($brewcmd --prefix $f)/$f.bashrc .
  done
  sudo ln -s $($brewcmd --prefix cutest)/lib/libcutest.so /usr/local/lib/
else
  # Implement before_install for OSX here
fi
