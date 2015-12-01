set -x

echo '"\e[A": history-search-backward' > ~/.inputrc
echo '"\e[B": history-search-forward' >> ~/.inputrc
cp .inputrc /home/ubuntu

apt-get install -y vim bc git wget
apt-get install -y tmux ed nmon dstat htop time sysstat fio
apt-get install -y bc hwloc
apt-get install -y hwloc
apt-get install -y numactl
apt-get install -y mdadm 
#apt-get install -y ioping
#apt-get install -y r-base 
#apt-get install -y maven # sometimes
#apt-get install -y openjdk-8-jdk 


./setup_networking.sh
#./setup_user.sh ubuntu
