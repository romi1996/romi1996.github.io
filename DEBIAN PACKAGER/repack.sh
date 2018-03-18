#Intro
echo "$(tput sgr0)"
echo "$(tput setaf 2)========> Welcome to the ReDeb !"
#Intro

#DEFINE
read -e -p "What is the name of the deb ? ==> $(tput bold)" debname
read -e -p "Which folder you wanna put your extracted deb ? =>> $(tput bold)" debfol
#DEFINE

#safety-protocol
rm -r $debfol
#safety-protocol

#Processing-request
mkdir $debfol
mkdir $debfol/DEBIAN
dpkg-deb -e $debname ./$debfol/DEBIAN/
dpkg-deb -x $debname ./$debfol
read -p "DONE ... Press any key to end!"
#Processing-request
