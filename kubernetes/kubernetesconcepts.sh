#!/bin/bash

#---------------ETCD Installation and usage---------------------------------------------

# Instructions and source file Available on https://github.com/etcd-io/etcd/releases/
# Install via Git
ETCD_VER=v3.5.7
GITHUB_URL=https://github.com/etcd-io/etcd/releases/download
DOWNLOAD_URL=${GITHUB_URL}
curl -L ${DOWNLOAD_URL}/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz -o etcd-${ETCD_VER}-linux-amd64.tar.gz #Download Binaries
tar xzvf etcd-${ETCD_VER}-linux-amd64.tar.gz #Extract
./etcd #Run ETCD Service

#Store a key-value pair
./etcdctl set key1 value1
# Retrive the value of a key
./etcdctl get key1
#view more options (without arguments)
./etcdctl


# To Run a specific version, especially with API version 3.0 of ETCD
etcdctl --version  #find the version of ETCDCTL version
# change the etcdctl to work with version 3
ETCD_API=3 ./etcd version  # Method 1 , but you have to invoke this command before executing every command
# export the version as an environment variable , this way you dont have to specify it each time
export ETCD_API=3
./etcdctl version
./etcdctl  #now check the commands 
#Few examples of v3.0 commands
./etcdctl put key1 value1 # Store a key value pair
./etcdctl get key1 #retreive a value a specified key



