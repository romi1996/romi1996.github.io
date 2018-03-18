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
if grep -q Maintainer control
	then
		echo "Path string detected Maintainer"
        else
                echo "Missing Maintainer 0x1"
                echo "You need to add Maintainer to Deb Controll"
                echo "Added stock Maintainer to Deb Controller"
                sed -i 's/^ *//; s/ *$//; /^$/d' control
                read -p "Please add Maintainer name =>>>>>>" maint
                echo "Maintainer: $maint" >> control
fi
if grep -q Package control
	then
		echo "Path string detected Package"
		read -p "You may want to change this deb name =>>>>>" debn
		cat control | grep -o "Package.*"
		sed -i -e "/Package/c\Package: $debn" control
	else
		echo "Terminal Error : 0x0 Deb Broken"
		exit 0
fi
if grep -q Depiction control
	then
		echo "Path string detected Depiction"
		read -p "You may want to change this deb Depiction =>>>>>" debd
		cat control | grep -o "Depiction.*"
		sed -i -e "/Depiction/c\Depiction: $debd" control
	else
		echo "Terminal Error : 0x0 Deb Broken"
		exit 0
fi
if grep -q Section control
	then
		echo "Path string detected Section"
		read -p "You may want to set category for this deb =>>>>>" debsec
		cat control | grep -o "Section.*"
		sed -i -e "/Section/c\Section: $debsec" control
	else
		echo "Terminal Error : 0x0 Deb Broken"
		exit 0
fi
#Processing-request-PHASE2

#Processing-request-PHASE3
cd ..
cd ..
dpkg-deb -b $debfol
#Processing-request-PHASE3

#FINAL
read -p "DONE ... Press any key to end!"

set +x
#FINAL
