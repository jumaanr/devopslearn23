#!/bin/bash

#Install kube-proxy - Manual
$ wget https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kube-proxy
#Run it as a service
kube-proxy.service

#View kube-proxy options - kubeadm
#If you set it up with kubeadm tool, kubeadm tool will deploy the kube-proxy as pod in kube-system namespace. In fact it is deployed as a daemonset on master node.
$ kubectl get pods -n kube-system
$ kubectl get daemonset -n kube-system

