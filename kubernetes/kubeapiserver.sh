#!/bin/bash

# Contains two installation methods of kubeapiserver : https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/02-Core-Concepts/05-Kube-API-Server.md
# Documentation : https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/
# Installation : https://github.com/shawnsong/kubernetes-handbook/blob/master/kube-apiserver/setup-kube-apiserver.md
# 1) using binaries (from scratch)

# Download Binaries from : 
$ wget https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kube-apiserver
# View and configure options
$ cat /etc/systemd/system/kube-apiserver.service
#see the running process and affective options by listing the process on master node and searching for kube-apiserver
$ ps -aux | grep kube-apiserver

# 2) using kubeadm tool
$ kubectl get pods -n kube-system
#You can see the options with in the pod definition file located at /etc/kubernetes/manifests/kube-apiserver.yaml
$ cat /etc/kubernetes/manifests/kube-apiserver.yaml
