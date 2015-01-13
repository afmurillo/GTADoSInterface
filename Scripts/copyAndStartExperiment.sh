#!/bin/bash

SSHARGS="-o StrictHostKeyChecking=no -o ConnectTimeout=6"

echo "Copying topology file. File:" 
sshpass -p "fits" scp ${SSHARGS} -r /var/fits/data/DoSInterface/CreatedExperiments/$1 192.168.254.6:~
wait

echo "Restarting MAGI daemon in nodes"
sshpass -p "fits" ssh ${SSHARGS} 192.168.254.6 sudo /root/startMagiTopo.sh /root/topology.txt
wait

echo "Daemons started!"

echo "Copying experiment file to orchestrator. File:" $1
sshpass -p "fits" scp ${SSHARGS} -r /var/fits/data/DoSInterface/CreatedExperiments/$1 192.168.254.6:~
wait

echo "File copied"

echo "Copying topology file to orchestrator"
sshpass -p "fits" scp ${SSHARGS} -r /home/xen/domains/DETER/TestFence/topology.txt 192.168.254.6:~
wait

echo "File copied"

echo "Starting experiment!"
sshpass -p "fits" ssh ${SSHARGS} 192.168.254.6 sudo /root/expStart.sh $1

wait

echo "Done!"
