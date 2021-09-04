#!/bin/bash
if [[ $# > 0 ]]
then
	VVMDIR=$1
else
	VVMDIR=$HOME/Documents/Cybersecurity-Bootcamp/Linux-Module
fi
​
echo "Vagrant VM dir is " $VVMDIR
​
if [[ ! -d $VVMDIR ]]
then
	echo "Couldn't find vagrant dir in expected location " $VVMDIR && exit 1
fi
​
if [[ ! -f $VVMDIR/Vagrantfile ]]
then
	echo "Couldn't find a Vagrantfile in vagrant dir in expected location " $VVMDIR && exit 1
fi
​
vagrant global-status --prune && cd $VVMDIR && vagrant box update && vagrant destroy --force && vagrant up && vagrant box prune
