#!/bin/bash

#Install kubelet
#download the source
$ wget https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kubelet
#run it as a service
kubelet.service
#see the running process and affective options by listing the process on worker node and searching for kubelet
$ ps -aux |grep kubelet