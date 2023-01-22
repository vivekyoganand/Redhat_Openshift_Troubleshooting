#!/bin/bash
echo "=========================="
echo "Create name of the project"
echo "=========================="
read -p "Please give the project name:" project
oc new-project $project
echo "=========================="
echo "Create name of the application"
echo "=========================="
read -p "Please give the application name:" app
read -p "Please give the application name:" image
oc new-app --name $app $image
echo "=========================="
echo "Create the serviceaccount"
echo "=========================="
oc create serviceaccount admin
oc adm policy add-scc-to-user anyuid -z admin
dep=$(oc get deployment -o=name)
oc set serviceaccount $dep admin
svc=$(oc get service -o=name)
oc expose $svc 
