#!/bin/bash

#---------------ETCD Installation and usage---------------------------------------------

# Instructions and source file Available on https://github.com/etcd-io/etcd/releases/
# Further instructions available on : https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/02-Core-Concepts/03-ETCD-For-Beginners.md
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

# Configurating ETCD manually - Kubernetes Installation from Scratch : 

#1) Install ETCD Binaries
$ wget -q --https-only "https://github.com/etcd-io/etcd/releases/download/v3.3.11/etcd-v3.3.11-linux-amd64.tar.gz"
#2) Configure the etcd.service

# Configurating ETCD using kubeadm

#1) Setup kubeadm
kubectl get pods -n kubesystem
#2) To list all keys stored
$ kubectl exec etcd-master -n kube-system -- sh -c "ETCDCTL_API=3 etcdctl --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key --cacert=/etc/kubernetes/pki/etcd/ca.crt get / --prefix --keys-only"

#---------------ETCD HA Environment---------------------------------------------
#set right parameters in etcd.service configuration

#From API version to vesion commands are changing

#ETCDCTL version 2 supports the following commands:
etcdctl backup
etcdctl cluster-health
etcdctl mk
etcd mkdir
etcd set

#API 3 support following commands
etcdctl snapshot save
etcdctl endpoint health
etcdctl get
etcdctl put

#When API version is not set, it assumes as API 2 , set right version to ENV
export ETCDCTL_API=3
# must also specify the path to certificate files so that ETCDCTL can authenticate to the ETCD API Server
--cacert /etc/kubernetes/pki/etcd/ca.crt
--cert /etc/kubernetes/pki/etcd/server.crt
--key /etc/kubernetes/pki/etcd/server.key

#Final Form of deployment
kubectl exec etcd-controlplane -n kube-system -- sh -c "ETCDCTL_API=3 etcdctl get / --prefix --keys-only --limit=10 --cacert /etc/kubernetes/pki/etcd/ca.crt --cert /etc/kubernetes/pki/etcd/server.crt --key /etc/kubernetes/pki/etcd/server.key"

