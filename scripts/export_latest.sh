#!/usr/bin/env bash

set -o errexit

echo "WARNING: This script is deprecated. Please use export.sh"

function show_help {
  echo
  "Pharo Export Script
  ==================
  This script will download Pharo and export its sources to the current git repository.
  
  Note: if on OSX, you may not have gnu readlink downloaded in your system. You may install it by doing:
  
      sudo port install coreutils
	  
  and adding to your .bashrc
  
      export PATH=\"/opt/local/libexec/gnubin/:$PATH\"
	  
  Or the equivalent in brew.
  
  Script arguments
  ================
  -v
    Pharo version number to download and export. E.g., 60523.
	By default this will load latest Pharo version.
  -h -?
    Prints this help message
  "
  exit 0
}

VERSION="latest"

# Use -gt 1 to consume two arguments per pass in the loop (e.g. each
# argument has a corresponding value to go with it).
# Use -gt 0 to consume one or more arguments per pass in the loop (e.g.
# some arguments don't have a corresponding value to go with it such
# as in the --default example).
# note: if this is set to -gt 0 the /etc/hosts part is not recognized ( may be a bug )
while getopts "h?v:" opt; do
    case "${opt}" in
	v) #Version
        VERSION=${OPTARG};
        ;;
    h|\?)
        show_help;
        exit 0;
        ;;
  esac
done

PWD="$( dirname $(readlink -f $0) )"
git checkout master

echo "GET LATEST PHARO"
wget --quiet -O - get.pharo.org/vm60 | bash
wget http://files.pharo.org/image/60/${VERSION}.zip
unzip ${VERSION}.zip
rm ${VERSION}.zip
mv Pharo-${VERSION}.image Pharo.image
mv Pharo-${VERSION}.changes Pharo.changes
VERSION=`./pharo Pharo.image eval SystemVersion current highestUpdate`

echo "GOT ${VERSION}!"

echo "INSTALL GIT FILETREE SUPPORT"
./pharo Pharo.image --save --quit ${PWD}/pre_install_exporter.st

echo "EXPORTING SOURCE CODE"
./pharo Pharo.image --save --quit ${PWD}/export.st

echo "GIT COMMIT, TAG, AND PUSH"
git add src
git add -u
git commit -m "EXPORT VERSION ${VERSION}"
git tag -fa v${VERSION} -m "TAG VERSION v${VERSION}"
git push git@github.com:guillep/pharo-core.git
git push --tags git@github.com:guillep/pharo-core.git
