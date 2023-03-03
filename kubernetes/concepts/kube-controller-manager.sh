#!/bin/bash

# Install kube-controller-manager using source
$ wget https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kube-controller-manager
#By default all controllers are enabled, but you can choose to enable specific one from kube-controller-manager.service
#View kube-controller-manager options (using same command)
$ cat /etc/systemd/system/kube-controller-manager.service
#

# Install kube-controller-manager using kubeadm
$ kubectl get pods -n kube-system # List the pods and find kube-controller-manager
$ cat /etc/kubernetes/manifests/kube-controller-manager.yaml #View kube-controller-manager options
#see the running process and affective options by listing the process on master node and searching for kube-controller-manager
$ ps -aux | grep kube-controller-manager