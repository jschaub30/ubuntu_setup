#!/bin/bash

[ "$#" -lt 1 ] && echo USAGE: $0 [interface] && exit 1

IFACE=$1
set -x
HOST=$(hostname)
IP=$(/sbin/ip -o -4 addr list $IFACE | awk '{print $4}' | cut -d/ -f1)

[ "$IP" == "" ] && echo IP Address not found on interface $IFACE && exit 1

echo "######### Generating new ssh keys #########"
rm ~/.ssh/id_rsa*
ssh-keygen -q -t rsa -N "" -f ~/.ssh/id_rsa
echo "######### Adding key to authorized_keys #########"
head -n 1 ~/.ssh/authorized_keys > /tmp/ak.$USER
cat ~/.ssh/id_rsa.pub >> /tmp/ak.$USER
cp ~/.ssh/authorized_keys ~/.ssh/authorized_keys.old
cp /tmp/ak.$USER ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
rm /tmp/ak.$USER

# Add to known_hosts http://serverfault.com/a/316100
echo "######### Removing old key from known_hosts #########"
ssh-keygen -R localhost
ssh-keygen -R $HOST
ssh-keygen -R $IP
ssh-keygen -R $HOST,$IP
echo "######### Adding key to known_hosts #########"
ssh-keyscan -H $HOST,$IP >> ~/.ssh/known_hosts
ssh-keyscan -H $IP >> ~/.ssh/known_hosts
ssh-keyscan -H $HOST >> ~/.ssh/known_hosts
ssh-keyscan -H localhost >> ~/.ssh/known_hosts

# /etc/hosts file
if [ $USER == "root" ]
then
  echo "######### Adding IP to known hosts #########"
  grep -v $IP /etc/hosts > /tmp/hosts
  echo "$IP     $HOST" >> /tmp/hosts
  cp /tmp/hosts /etc/hosts
fi
