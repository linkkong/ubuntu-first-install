#Powered By Linkkong
if [ ! -w $PWD ]; then
    echo '请确保当前文件夹可写入!'
    exit
fi
#change apt source, use tsinghua source https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

(
cat <<EOF
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse

EOF
) > ./sources.list
sudo mv ./sources.list /etc/apt/sources.list 
sudo apt-get update

#----------------install docker
#step1. Uninstall Old versions
sudo apt-get remove docker docker-engine docker.io
#step2. install Docker-ce
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
#step3. Add Docker’s official GPG key:
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#stpe4. Use the following command to set up the stable repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

#step5. Install docker-ce stable version
sudo apt update 
sudo apt-get install -y docker-ce
#setp6. Start the docker service
sudo service docker start
#step7. Join the docker group
sudo gpasswd -a ${USER} docker
#-----------------install docker-compose 
sudo curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
#-----------------install vscode
sudo curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code

#-----------------install phpstorm
sudo snap install phpstorm --classic
#-----------------install chrome browser
#wget https://repo.fdzh.org/chrome/google-chrome.list -P /etc/apt/sources.list.d/
