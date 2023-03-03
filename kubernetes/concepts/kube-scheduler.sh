#!/bin/bash

#Install kube-scheduler - Manual
$ wget https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kube-scheduler
#extract it and run it as a service

#View kube-scheduler options - kubeadm
$ kubectl get pods -n kube-system
$ cat /etc/kubernetes/manifests/kube-scheduler.yaml

#see the running process and affective options by listing the process on master node and searching for kube-apiserver
$ ps -aux | grep kube-scheduler