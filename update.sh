#!/bin/sh
dpkg-scanpackages -m . /dev/null >Packages
bzip2 -c9k ./Packages > ./Packages.bz2
gzip -c9k ./Packages > ./Packages.gz
printf "Origin: tor's Repo\nLabel: tor\nSuite: stable\nVersion: 1.0\nCodename: tor\nArchitecture: iphoneos-arm\nComponents: main\nDescription: tor's Tweaks\nMD5Sum:\n "$(cat ./Packages | md5sum | cut -d ' ' -f 1)" "$(stat ./Packages --printf="%s")" Packages\n "$(cat ./Packages.bz2 | md5sum | cut -d ' ' -f 1)" "$(stat ./Packages.bz2 --printf="%s")" Packages.bz2\n" >Release;
exit 0