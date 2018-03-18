clear
#Getting-deb-list
ls
#Intro
echo "$(tput sgr0)"
echo "$(tput setaf 2)========> Welcome to the ReDeb !"
#Intro
#DEFINE
read -e -p "What is the name of the deb ? ==> $(tput bold)" debname
read -p "Which folder you wanna put your extracted deb ? =>> $(tput bold)" debfol
#DEFINE
#safety-protocol
echo "Safety Protocol Initiated"
rm -r $debfol
#safety-protocol
clear
#Processing-request-PHASE1
echo "PROCESSING PHASE 1"
mkdir $debfol
echo "Extracted $debfol"
mkdir $debfol/DEBIAN
echo "Making DEBIAN Folder"
chmod 755 $debfol/DEBIAN
echo "Setting Permission"
dpkg-deb -e $debname ./$debfol/DEBIAN/
dpkg-deb -x $debname ./$debfol
rm -r $debname
echo "WARNING: REMOVED $debname to prevent update to Packages file by mistake"
echo
echo
#Processing-request-PHASE2
echo "PROCESSING PHASE 2"
cd $debfol
cd DEBIAN
if grep -q Maintainer control
	then
		echo "Path string detected Maintainer"
        else
                echo "Missing Maintainer 0x1"
                echo "You need to add Maintainer to Deb Controll"
                sed -i 's/^ *//; s/ *$//; /^$/d' control
                read -p "Please add Maintainer name =>>>>>>" maint
                echo "Maintainer: $maint" >> control
fi
echo
echo
if grep -q Package control
	then
		echo "Path string detected Package"
                cat control | grep -o "Package.*"
		read -p "You may want to change this deb name =>>>>>" debn
		sed -i -e "/Package/c\Package: $debn" control
	else
		echo "Terminal Error : 0x0 Deb Broken"
		exit 0
fi
echo
echo
if grep -q Depiction control
	then
		echo "Path string detected Depiction"
		cat control | grep -o "Depiction.*"
		read -p "You may want to change this deb Depiction =>>>>>" debd
		sed -i -e "/Depiction/c\Depiction: $debd" control
	else
		echo "Terminal Error : 0x0 Deb Broken"
		exit 0
fi
echo
echo
if grep -q Section control
	then
		echo "Path string detected Section"
                cat control | grep -o "Section.*"
		read -p "You may want to set category for this deb =>>>>>" debsec
		sed -i -e "/Section/c\Section: $debsec" control
	else
		echo "Terminal Error : 0x0 Deb Broken"
		exit 0
fi
#Processing-request-PHASE2
clear
#Processing-request-PHASE3
echo "PROCESSING PHASE 3"
cd ..
cd ..
dpkg-deb -b $debfol
echo "built $debfol"
#Processing-request-PHASE3
#FINAL
echo "FINAL STAGE .... ALMOST THERE !!!!!"
dpkg-scanpackages -m . /dev/null >Packages
echo "Created Packages"
bzip2 -c9k ./Packages > ./Packages.bz2
echo "Compressed Packages to bzip2"
gzip -c9k ./Packages > ./Packages.gz
echo "Compressed Packages to gzip"
printf "Origin: tor's Repo\nLabel: tor\nSuite: stable\nVersion: 1.0\nCodename: tor\nArchitecture: iphoneos-arm\nComponents: main\nDescription: tor's Tweaks\nMD5Sum:\n "$(cat ./Packages | md5sum | cut -d ' ' -f 1)" "$(stat ./Packages --printf="%s")" Packages\n "$(cat ./Packages.bz2 | md5sum | cut -d ' ' -f 1)" "$(stat ./Packages.bz2 --printf="%s")" Packages.bz2\n" >Release;
echo "Updated Release Files"
read -p "DONE!! ... Press any key to end!"
#FINAL
