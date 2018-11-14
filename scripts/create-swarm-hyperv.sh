#!/bin/bash

# Creating 6 nodes 
echo "### Creating nodes ..."
docker-machine create -d hyperv --hyperv-virtual-switch "Primary Virtual Switch" swarm-manager
for c in {1..2} ; do
    docker-machine create -d hyperv --hyperv-virtual-switch "Primary Virtual Switch" swarm-noeud$c
done

# Get IP from leader node
leader_ip=$(docker-machine ip swarm-manager)

# Init Docker Swarm mode
echo "### Initializing Swarm mode ..."
eval $(docker-machine env swarm-manager)
docker swarm init --advertise-addr $leader_ip

# Swarm tokens
manager_token=$(docker swarm join-token manager -q)
worker_token=$(docker swarm join-token worker -q)

# Join worker nodes
echo "### Joining worker modes ..."
for c in {1..2} ; do
    eval $(docker-machine env swarm-noeud$c)
    docker swarm join --token $worker_token $leader_ip:2377
done

# Clean Docker client environment
echo "### Cleaning Docker client environment ..."
eval $(docker-machine env -u)