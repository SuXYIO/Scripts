#!/bin/bash
# Easy RSA
# By SuXY
# Interface for simple RSA encryption and decryption based on openssl
#openssl test
openssl version | grep "3.[0-9].[0-9]" || opensslfail
#functions
function keygen {
	clear
	echo -e '\033[32mRSA Keygen\n\nEnter \033[31mPrivateKeyName\033[32m(Without file extension name. Press Enter to skip and use "pri" as filename)\033[0m'
	read -rp '> ' PRINAME
	clear
	echo -e '\033[32mRSA Keygen\n\nEnter \033[31mKeylenth\033[32m(Any positive integer, power of two will be better. Press Enter to skip and use 1024 as keylenth)'
	read -rp '> ' LEN
	clear
	echo -e '\033[32mRSA Keygen\n\nEnter \033[31mPubKeyName\033[32m(Without file extension name. Press Enter to skip and use pub as filename)'
	read -rp '> ' PUBNAME
	if [ "$PRINAME" == '' ]; then
		PRINAME='pri'
	fi
	if [ "$LEN" == '' ]; then
		LEN='1024'
	fi
	if [ "$PUBNAME" == '' ]; then
		PUBNAME='pub'
	fi
	openssl genrsa -out ${PRINAME}.pem ${LEN}
	openssl rsa -in ${PRINAME}.pem -out ${PUBNAME}.pem -pubout
	echo -e '\033[32mGeneration Complete, Quitting...\033[0m'
	sleep 2
	exit 0
}
function en {
	clear
	echo -e '\033[32mRSA Encryption\n\nEnter \033[34mraw file name\033[32m\033[0m'
	read -rep '> ' RAWNAME
	clear
	echo -e '\033[32mRSA Encryption\n\nEnter \033[34mpublic key file name\033[32m\033[0m'
	read -rep '> ' PUBNAME
	clear
	echo -e '\033[32mRSA Encryption\n\nEnter \033[31mencrypt file name\033[32m(Press Enter to skip and use "(RawFileName).en")\033[0m'
	read -rp '> ' ENNAME
	if [ "$ENNAME" == "" ]; then
		ENNAME="${RAWNAME}.en"
	fi
	openssl pkeyutl -encrypt -in ${RAWNAME} -inkey ${PUBNAME} -pubin -out ${ENNAME}
	echo -e '\033[32mEncryption Complete, Quitting...\033[0m'
	sleep 2
	exit 0
}
function de {
	clear
	echo -e '\033[32mRSA Decryption\n\nEnter \033[34mencrypted file name\033[32m\033[0m'
	read -rep '> ' ENNAME
	clear
	echo -e '\033[32mRSA Decryption\n\nEnter \033[34mprivate key file name\033[32m\033[0m'
	read -rep '> ' PRINAME
	clear
	echo -e '\033[32mRSA Decryption\n\nEnter \033[31mdecrypt file name\033[32m(Press Enter to skip and use "(EncryptedFileName).de")\033[0m'
	read -rp '> ' DENAME
	if [ "$DENAME" == "" ]; then
		DENAME="${ENNAME}.de"
	fi
	openssl pkeyutl -decrypt -in ${ENNAME} -inkey ${PRINAME} -out ${DENAME}
	echo -e '\033[32mDecryption Complete, Quitting...\033[0m'
	sleep 2
	exit 0
}
function opensslfail {
	echo '\033[31mOpenSSL 3.?.? not found, Quitting...\033[0m'
	exit 1
}
#title
clear
echo -e '\033[32m___________                     __________  _________   _____   \n\_   _____/____    _________.__.\______   \/   _____/  /  _  \  \n |    __)_\__  \  /  ___<   |  | |       _/\_____  \  /  /_\  \ \n |        \/ __ \_\___ \ \___  | |    |   \/        \/    |    \\\n/_______  (____  /____  >/ ____| |____|_  /_______  /\____|__  /\n        \/     \/     \/ \/             \/        \/         \/ \033[0m'
#menu
echo -e '\033[32m\nMenu\n\t0 RSA key gen\n\t1 RSA encryption\n\t2 RSA decryption\n\t3 Help\n\t4 Quit\n\033[0m'
read -rn 1 -p '> ' CH
echo -e '\n'
if [ "$CH" == '0' ]; then
	#keygen
	keygen
	exit 0
elif [ "$CH" == '1' ]; then
	#encryption
	en
	exit 0
elif [ "$CH" == '2' ]; then
	#decryption
	de
	exit 0
elif [ "$CH" == '3' ]; then
	#help
	echo -e '\033[1mERSA\n\033[1mEasy RSA\n\033[1mHelp Page\n\t\033[1mIntro\n\t\tSimple interface for RSA keygen, encryption and decryption based on openssl(non-official). \n\t\033[1mInstall\n\t\tDownload this file and install openssl 3.?.?(install info on github.com/openssl/openssl) and run this script using \"bash /path/to/file/ersa_1.0.0.sh\"(first install WSL on windows)\n\t\033[1mUsage\n\t\tMost of the functions, except help and quit will generate files in your current directory, recommend to create a new empty directory and cd into it before starting up any of the other functions in this program, in case mixing the files with other files. \n\t\tWhen this program needs you to enter a name(filename, etc.), there are blue ones for input names(that does exist before starting the function), and red ones for output names(that doesnt exist before starting the function and needs you to name one). \n\t\033[1mUninstall\n\t\tDelete this file, no cache is left except the keys generated and the encryption/decryption files. \033[0m' | less && clear && exit 0
elif [ "$CH" == '4' ]; then
	#quit
	echo -e '\033[32mQuitting...\033[0m'
	sleep 0.8
	clear
	exit 0
else
	#invalid
	echo -e "\033[31mInvalid option: ${CH}\nQuitting...\033[0m"
	sleep 2
	clear
	exit 1
fi
