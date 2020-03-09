#!/bin/bash
echo "======== Running Gatling Performance/Load Test \n ========== "
echo "*********************************\n "
_USERS=$2
_TIME=$3
if [[ "$1" == "Basic" ]]; then
sh bin/gatling.sh -sf user-files/simulations/ -s BasicSimulation
fi
if [[ "$1" == "Advance" ]]; then
sed -i "s/REPLACE_USERS/$_USERS/g" user-files/simulations/dockerregistry/DockerSandboxSimulation.scala
sed -i "s/REPLACE_TIME/$_TIME/g" user-files/simulations/dockerregistry/DockerSandboxSimulation.scala
sed -i 's/REPLACE_USERS/$_USERS/g' user-files/simulations/dockerregistry/DockerTestOKD.scala
sed -i 's/REPLACE_TIME/$_TIME/g' user-files/simulations/dockerregistry/DockerTestOKD.scala
sh bin/gatling.sh -sf user-files/simulations/ -s DockerSandboxSimulation

sh bin/gatling.sh -sf user-files/simulations/ -s DockerTestOKD        
fi 
