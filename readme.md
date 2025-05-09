Node Application:

kubectl -n default create deploy node-app --image siddharth67/node-service:v1
kubectl -n default expose deploy node-app --name node-service --port 5000

Endpoint URL:

http://172.16.188.160:31090/compare/60
http://172.16.188.160:31090/increment/60

Jenkins pipeline syntax

https://www.jenkins.io/doc/book/pipeline/syntax/

Course Git Repositories

https://github.com/kodekloudhub/kubernetes-devops-security

https://github.com/kodekloudhub/devsecops