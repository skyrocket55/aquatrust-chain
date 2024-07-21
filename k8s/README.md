##### Infrastructure Setup #####
```
1. Create google cloud storage with bucket name k8s-fabric. Create serviceAccountKeyFile to access the storage object and add in the application-gateway folder.
2. Create VM and clone the fabric test network. Do all the installations needed.
3. Setup the project using the steps in README file inside the Chaincode folder.
```

##### Kubernetes Setup #####
```
1. Deploy the manifest files in k8s folder using the command below.
kubectl apply -f .
```