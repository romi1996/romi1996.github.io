#Intro
echo "$(tput sgr0)"
echo "$(tput setaf 2)========> Welcome to the ReDeb !"
#Intro

#DEFINE
read -e -p "What is the name of the deb ? ==> $(tput bold)" debname
read -p "Which folder you wanna put your extracted deb ? =>> $(tput bold)" debfol
#DEFINE

#safety-protocol
rm -r $debfol
#safety-protocol

#Processing-request-PHASE1
mkdir $debfol
mkdir $debfol/DEBIAN
chmod 755 $debfol/DEBIAN
dpkg-deb -e $debname ./$debfol/DEBIAN/
dpkg-deb -x $debname ./$debfol
set -x

#Processing-request-PHASE2
cd $debfol
cd DEBIAN
if grep -q Maintainer /control
	then
		echo "Path string detected Maintainer"
		echo -e "$(grep Maintainer /control)\n"
	else
		echo "Missing Maintainer"
		echo "Added stock Maintainer to Deb Controller"
		sed -i 's/^ *//; s/ *$//; /^$/d' control
		read -p "Please add Maintainer name =>>>>>>" maint
		echo "Maintainer: $maint" >> control
		echo "Building deb ..."
fi
cd ..
cd ..
dpkg-deb -b $debfol
read -p "DONE ... Press any key to end!"

set +x
#Processing-request
