cd /
echo -e "\033[1;33mFor alpine linux v3.14 on ish 1.3.2\033[0m"
echo -e "\033[1;33mRecommend to read these carefully. If this program crashes the machine, just rerun this.\033[0m"
echo -e "\033[1;32mSetting apk mirrors to aliyun mirrors\033[0m"
echo http://mirrors.aliyun.com/alpine/v3.14/main > /etc/apk/repositories
echo http://mirrors.aliyun.com/alpine/v3.14/community >> /etc/apk/repositories
apk update
echo -e "\033[1;32mTesting network connection status to github.com\033[0m"
apk add curl
urlstatus=$(curl -s -m 5 -IL github.com | grep 200)
if [ "$urlstatus" == "" ]; then
	echo -e "\033[1;32mgithub connection failed, trying gitee\033[0m"
	urlstatus=$(curl -s -m 5 -IL gitee.com | grep 200)
	if [ "$urlstatus" == "" ]; then
		echo -e "\033[1;31mWarning: Unable to connect to github,gitee. Please try again later.\033[0m"
		apk del curl
		exit
	else
		echo -e "\033[1;32mgitee connection success, install at end of program.\033[0m"
		USEGE=1
	fi
else
	echo -e "\033[1;32mgithub connection success, downloading ohmyzsh, install at end of program.\033[0m"
	apk add git zsh
	git clone http://github.com/ohmyzsh/ohmyzsh.git --depth 1
fi
echo -e "\033[1;32mInstall openssh,curl,neofetch,neovim,clang,python3,net-tools. Needs network (doesn't contain pip)\033[0m"
apk add openssh curl neofetch neovim python3 clang net-tools
echo -e "\033[1;32mPrevent apk mirrors reset during reboot\033[0m"
echo "echo "http://mirrors.aliyun.com/alpine/v3.14/main" > /etc/apk/repositories" > /root/repo.sh
echo "echo "http://mirrors.aliyun.com/alpine/v3.14/community" >> /etc/apk/repositories" >> /root/repo.sh
echo "source /root/repo.sh" >> /etc/profile
echo -e "\033[1;32mFix zsh no matches found when using * to find\033[0m"
echo "setopt nonomatch" >> ~/.zshrc
source ~/.zshrc
echo -e "\033[1;33mInstall finished, please check the messages above\033[0m"
echo -e "\033[1;33mEdit custom msg on startup. you can use the command "vi /etc/motd" to chang it yourself. Press Return to skip.\033[0m"
read SMSG
if [ "$SMSG" == "" ];then
	echo -e "\033[1;33mUsing "Welcome to Alpine."\033[0m"
	echo "Welcome to Alpine." > /etc/motd
else
	echo "$SMSG" > /etc/motd
fi
echo -e "\033[1;33mInstalling zsh and ohmyzsh. \033[0m"
sed -i "s/ash/zsh/g" /etc/passwd
if [ "$USEGE" == "1" ]; then
	apk add zsh
	wget https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh
	sed -i 's/REPO=${REPO:-ohmyzsh\/ohmyzsh}/REPO=${REPO:-mirrors\/oh-my-zsh}/' install.sh
	sed -i 's/REMOTE=${REMOTE:-https:\/\/github.com\/${REPO}.git}/REMOTE=${REMOTE:-https:\/\/gitee.com\/${REPO}.git}/' install.sh
	sh ./install.sh
else
	cd /ohmyzsh/tools
	sh install.sh
fi
