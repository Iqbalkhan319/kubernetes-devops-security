Node Application:

kubectl -n default create deploy node-app --image siddharth67/node-service:v1
kubectl -n default expose deploy node-app --name node-service --port 5000

#Endpoint URL:

http://172.16.188.160:31090/compare/60
http://172.16.188.160:31090/increment/60

#Jenkins pipeline syntax

https://www.jenkins.io/doc/book/pipeline/syntax/

#Course Git Repositories

https://github.com/kodekloudhub/kubernetes-devops-security

https://github.com/kodekloudhub/devsecops



sudo iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to-destination 172.16.188.160:8080
sudo iptables -t nat -A POSTROUTING -d 172.16.188.160 -p tcp --dport 8080 -j MASQUERADE

sudo apt install iptables-persistent
sudo netfilter-persistent save


sudo iptables -t nat -A POSTROUTING -s 172.16.188.0/24 -o wlp0s20f3 -j MASQUERADE


sudo iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to-destination 172.16.188.160:8080
sudo iptables -t nat -A POSTROUTING -s 172.16.188.0/24 -j MASQUERADE

#Install Tailisman in single project:

# Download the talisman installer script
curl https://thoughtworks.github.io/talisman/install.sh > ~/install-talisman.sh
chmod +x ~/install-talisman.sh
~/install-talisman.sh
#or:

curl https://thoughtworks.github.io/talisman/install.sh > /tmp/install-talisman.sh
chmod +x /tmp/install-talisman.sh
cd /root/kubernetes-devops-security
bash /tmp/install-talisman.sh pre-commit

#PIT Mutation:
#Ref URL:
https://pitest.org/quickstart/mutators/
