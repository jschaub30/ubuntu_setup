set -x

echo '"\e[A": history-search-backward' > ~/.inputrc
echo '"\e[B": history-search-forward' >> ~/.inputrc
cp ~/.inputrc /home/ubuntu/.
chown ubuntu:ubuntu /home/ubuntu/.inputrc

echo "syntax enable" > ~/.vimrc
echo "set background=dark" >> ~/.vimrc
echo "set tabstop=4 shiftwidth=4 expandtab" >> ~/.vimrc
echo "set ruler" >> ~/.vimrc
echo "set pastetoggle=<F2>" >> ~/.vimrc
echo "set relativenumber" >> ~/.vimrc
echo "inoremap {<cr> {<cr>}<c-o>O<tab>" >> ~/.vimrc
echo "inoremap [<cr> [<cr>]<c-o>O<tab>" >> ~/.vimrc
echo "inoremap (<cr> (<cr>)<c-o>O<tab>" >> ~/.vimrc

FLAG=$(grep ubuntu /etc/sudoers | grep NOPASSWD | wc -l)
if [ $FLAG -eq 0 ]
then
  echo Setting NOPASSWD option for user ubuntu
  echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
fi

cp ~/.vimrc /home/ubuntu/.
chown ubuntu:ubuntu /home/ubuntu/.vimrc

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


#./setup_networking.sh
#./setup_user.sh ubuntu
