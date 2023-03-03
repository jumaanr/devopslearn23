#!/bin/bash

#Create a POD
kubectl run ngin --image 'nginx'
#deploys a nginx docker container by creating a pod, this image is downloaded from the docker-hub repository

#See the list of pods available and details such as state , number of containers and restarts
kubectl get pods
#get more details such as ip of the node and ip of the pod, check events happened since pod created. labels assigned 
kubectl describe pod nginx 
#get some details including networking information
kubectl get pods -o wide


#Run a yaml definition file
kubectl create -f pod-definition.yaml



