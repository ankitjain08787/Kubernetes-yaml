cat >>/etc/modules-load.d/crio.conf<<EOF
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter
lsmod | grep overlay
lsmod | grep br_netfilter
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
EOF

sysctl --system
ufw enable
sudo ufw allow 6443/tcp
sudo ufw allow 2379:2380/tcp
sudo ufw allow 10250/tcp
sudo ufw allow 10259/tcp
sudo ufw allow 10257/tcp
sudo ufw allow 179/tcp
sudo ufw allow 4789/udp
sudo ufw allow 4789/tcp
sudo ufw allow 2379/tcp
sudo ufw status
sudo ufw allow 10250/tcp
sudo ufw allow 30000:32767/tcp
sudo ufw allow 179/tcp
sudo ufw allow 4789/udp
sudo ufw allow 4789/tcp
sudo ufw allow 2379/tcp
sudo ufw status
sudo ufw allow 22/tcp
cat /etc/os-release 
OS=xUbuntu_24.04
CRIO_VERSION=1.26
apt update -qq && apt install -y   libbtrfs-dev   golang-github-containers-common   git   libassuan-dev   libglib2.0-dev   libc6-dev   libgpgme-dev   libgpg-error-dev   libseccomp-dev   libsystemd-dev   libselinux1-dev   pkg-config   go-md2man   crun   libudev-dev   software-properties-common   gcc   make
OS=xUbuntu_22.04
CRIO_VERSION=1.26
echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /"|sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
echo "deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$CRIO_VERSION/$OS/ /"|sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION.list
echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /"|sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
echo "deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$CRIO_VERSION/$OS/ /"|sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION.list
curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$CRI_VERSION/$OS/Release.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/libcontainers.gpg add -
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/libcontainers.gpg add -
sudo apt-get update 
sudo apt-get install -qq -y cri-o cri-o-runc cri-tools
systemctl daemon-reload
systemctl enable --now crio
crictl info
crictl version
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl enable --now kubelet
systemctl enable kubelet
kubeadm config images pull
kubeadm init --pod-network-cidr=192.168.0.0/16 --cri-socket unix:///var/run/crio/crio.sock
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
exit
export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl get nodes
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml
kubectl get nodes
kubectl label nodes worker ROLES=compute-plane
kubectl get nodes
kubectl describe nodes/master
kubectl describe nodes/worker
kubectl edit nodes/worker
kubectl describe nodes/worker
kubectl label node worker node-role.kubernetes.io/worker=compute-plane
kubectl get node
kubectl describe nodes/worker | less
kubectl get nodes
kubectl label node worker2 node-role.kubernetes.io/worker=compute-plane
kubectl get nodes
kubectl new-project training
kubectl project training
kubectl --help
kubectl new-namespace training
kubectl namespace training
kubectl get namespace
kubectl cluster info
kubectl cluster-info
kubectl cluster-info dump
kubectl cluster-info
kubectl get nodes
crictl ps -a
kubectl create deploy nginx-web-server --image nginx
kubectl get all
cat /etc/kubernetes/admin.conf
kubectl get nodes
c
kubectl cluster info
kubectl cluster-info
kubectl create --help
kubectl create deployment training1 --image=registry.redhat.io/rhel8/httpd-2.4
kubectl get deployment
kubectl get pods
kubectl create deployment training1 --image=httpd
kubectl create deployment training --image=httpd
kubectl get pods
kubectl create deployment my-dep --image=busybox
kubectl get deployment
kubectl get pods
kubectl config view
ubectl config view --raw 
kubectl config view --raw 
kubectl config get-contexts
kubectl config get-contexts -o name
kubectl events --types=Warning
kubectl get nodes
kubectl run my-first-pod --image stacksimplify/kubenginx:1.0.0
kubectl get pods
kubectl login registry.rehat.io -u ankitkkjain

vim nginx-deployment.yaml
kubectl apply -f nginx-deployment.yaml
vim nginx-deployment.yaml
kubectl get namespace
kubectl create namespace training
kubectl get namespace
vim nginx-deployment.yaml
kubectl apply -f nginx-deployment.yaml
kubectl get deployment
kubectl get pods
kubectl logs pod/training-744478dd95-j7fl7 | less
kubectl logs pod/training-744478dd95-j7fl7
kubectl api-resources
kubectl get nodes
kubectl describe nodes/worker
kubectl get pods
crictl ps -a
kubectl get deployment
kubectl delete deployment/my-dep
kubectl get deployment
kubectl delete deployment/nginx-web-server
kubectl delete deployment/training
kubectl delete deployment/training1
kubectl gt nodes
kubectl get nodes
kubectl get deploy
kubectl get deployment
kubectl get pods
kubectl get po
kubectl get no
ping worker
kubectl get co
kubectl get operator
kubectl get clusteroperator
kubectl get csr
kubectl api-resources
crictl ps -a
kubectl get pods -A
kubectl get nodes
kubectl version
kubectl describe node/master
kubectl describe node worker
kubectl describe node/worker
kubectl describe node/master | less
kubectl get nodes
kubectl describe node/worker | les
kubectl describe node/worker | less
kubectl get nodes
kubectl get pods
kubectl get pods -n kube-system
kubectl get namespace
kubectl get pods
kubectl config set-context --current --namespace=kube-system
kubectl get nodes
kubectl get pods
kubectl get pods -n training
kubectl get pods -n default
kubectl cluster-info
kubectl get componentstatuses
kubectl config view
kubectl cluster-info
kubectl get events
kubectl get events -n training
kubectl get events -n default
oc get nodes
kubectl get nodes
kubectl edit node/master
kubectl get pods
kubectl get events -n training
kubectl get pods -n training
kubectl edit pod/app1-nginx-deployment-ffb78d447-fckf4
kubectl edit pod/app1-nginx-deployment-ffb78d447-fckf4 -n training
kubectl get pods -n training
oc get nodes
kubectl get nodes
kubectl describe node/master | less
kubectl api-versions
kubectl cluster-info
kubectl config view
kubectl get componentstatuses
kubectl api --version
kubectl api-versions
kubectl api-resources
kubectl get RoleBinding
kubectl describe RoleBinding/kube-proxy | less
kubectl describe RoleBinding/kube-proxy
oc fget deployment
kubectl get deployment
kubectl get deployment -n training
oc describe deployment/app1-nginx-deployment
kubectl describe deployment/app1-nginx-deployment
kubectl describe deployment/app1-nginx-deployment -n training
kubectl edit deployment/app1-nginx-deployment -n training
kubectl edit RoleBinding/kube-proxy
kubectl get api-resources
kubectl api-reso
kubectl api-versions
kubectl get daemonset
kubectl get rolebinding
kubectl cluster-info
kubectl cluster-info dump | wc -l
kubectl cluster-info | head
kubectl cluster-info dump | head
kubectl cluster-info dump | head -50
kubectl get nodes
oc describe node/master | less
kubectl describe node/master | less
kubectl get nodes
kubectl describe node/worker | less
kubectl explain deployment
kubectl explain pods
kubectl explain rolebinding
kubectl api-resources | grep -i rolebinding
kubectl --help
kubectl logs --help
kubectl describe --help
kubectl get pods
crictl ps
kubectl get pods
kubectl describe pods/etcd-master | less
kubectl edit pods/etcd-master 
kubectl get nodes
kubectl edit pods/etcd-master 
kubectl get pods -A
kubectl get deployment -A
kubectl get deployment
kubectl get deployment -n kube-system
kubectl get pods
kubectl exec etcd-master -it -- sh
kubectl get nodes
etcdctl
apt install etcd-client
crictl ps -a
kubectl get pods -A
crictl pull image ngnix
crictl pull nginx
cat /etc/containers/registries.conf
crictl pull nginx
vim /etc/containers/registries.conf
crictl pull nginx
systemctl restart crio.service
systemctl status crio.service
crictl pull nginx
crictl login hub.docker.com
curl hub.docker.com
crictl pull nginx
crictl pull hub.docke.com/_/ngnix
crictl pull ngnix
crictl login --help
exit
kubectl get node
crilctl pods
crictl pod
crictl pods
crictl image nginx
crictl pull mukeshjava92/ecomrc-cart:tagname
cat cat /etc/containerd/config.toml 
cat /etc/containerd/config.toml 
cd /etc/crio/crio.conf.d/
ll
cat 01-crio-runc.conf 
docker ps 
cd 
cd /etc/containers/registries.conf.d/
cd ..
ls -ltra
cat registries.conf
curl -vk https://hub.docker.com"
curl -vk https://hub.docker.com
cd
kubectl get po
kubectl get secret -A
kubectl create secret --help
kubectl create secret docker-registry docker-repo --help
kubectl create secret docker-registry docker-repo --docker-username=mukeshjava92 --docker-password=Cloud#321 --docker-server=hub.docker.com
kubectl get secret 
kubectl create deploy nginx --image=mukeshjava92/nginx 
kubectl get po
kubectl get deploy
kubectl describe po nginx-97d78c6fd-s5gcm
podman ps
cat /etc/containers/registries.conf
vi /etc/containers/registries.conf
systemctl status containerd
systemctl status podman
systemctl status crio.service
systemctl restart crio.service
systemctl status crio.service
kubectl get deploy
kubectl get po
kubectl delete po nginx-97d78c6fd-s5gcmnginx-97d78c6fd-s5gcm
kubectl delete po nginx-97d78c6fd-s5gcm
kubectl get po
crictl  pull nginx
vi /etc/containers/registries.conf
systemctl restart crio.service
crictl  pull nginx
vi /etc/containers/registries.conf
systemctl restart crio.service
crictl  pull nginx
crictl image ps
kubectl get po
kubectl delete po nginx-97d78c6fd-8dzlr
kubectl get po
cat $HOME/.config/containers/registries.conf
cd $HOME
ll
vi /etc/containers/registries.conf
systemctl restart crio.service
crictl  pull nginx
apt install docker
vi /etc/containers/registries.conf
systemctl restart crio.service
crictl  pull nginx
vi /etc/containers/registries.conf
systemctl restart crio.service
crictl  pull nginx
crictl  pull mukeshjava92/nginx
crictl  pull hub.docker.com/mukeshjava92/nginx
docker run -d -p 5000:5000 --name registry registry:2.7
apt install docker.io
docker run -d -p 5000:5000 --name registry registry:2.7
crictl image ls
docker ps
docker image ls
kubectl get po
kubectl delete po nginx-97d78c6fd-cjnnd
kubectl get po
history 
vi /etc/containers/registries.conf
systemctl restart crio.service
crictl pull nginx
crictl pull mukeshjava92/nginx
docker ps 
docker pull nginx
docker ps 
docker image ls
docker push b52e0b094bc0 localhost:5000/ankit
systemctl status containerd
systemctl status crio
apt remove docker.io
kubectl get po
crictl login docker.io
kubectl create secret docker-registry docker-repo --docker-username=mukeshjava92 --docker-password=Cloud#321 --docker-server=docker.io
kubectl create secret docker-registry docker-repo1 --docker-username=mukeshjava92 --docker-password=Cloud#321 --docker-server=docker.io
kubectl get deploy
kubectl edit  deploy nginx
kubectl get secret
kubectl get deploy nginx -o yaml
docker-repo1
kubectl get po
apt install docker
apt install docker.io
docker login 
crictl pull mukeshjava92/nginx
crictl pull -v mukeshjava92/nginx
crictl creds -
crictl pull -v mukeshjava92/nginx --creds --help
crictl pull mukeshjava92/nginx --creds --help
crictl pull mukeshjava92/nginx --creds 
crictl pull mukeshjava92/nginx --creds mukeshjava92:Cloud#321
crictl pull mukeshjava92/nginx
journalctl -u crictl
journalctl -u cri
cat /var/log/syslog
rpm -qa --last | grep -i podman
rpm -qa --last | grep -i docker
cat /etc/crio/crio.conf
yum remove docker.io
apt remove docker.io
apt update
containerd config default > /etc/containerd/config.toml
mkdir /etc/containerd/
containerd config default > /etc/containerd/config.toml
cat /etc/containerd/config.toml
docker pull registry.k8s.io/pause:3.10
crictl pull registry.k8s.io/pause
crictl pull nginx
crictl pull mukesjava92/nginx
sudo ctr -n=k8s.io images import pause.tar
crictl pull nginx:latest
sudo crictl images
crictl pull docker.io/nginx:latest
cat /etc/crictl.yaml 
history | grep -i cri
history | grep -i conf
cat /etc/containers/registries.conf
vi /etc/containers/registries.conf
systemctl restart crio.service
journalctl -u crio.service
systemctl stop crio.service
systemctl start crio.service
vi /etc/containers/registries.conf
systemctl stop crio.service
systemctl start crio.service
crictl pull docker.io/nginx:latest
crictl pull nginx:latest
crictl image ls
docker image ls
sudo crictl images
sudo crictl pull nginx
sudo crictl pull docker.io/nginx
kubectl get po
cat /etc/containerd/config.toml 
cat /etc/containerd/config.toml | grep -i regis
reboot 
sudo crictl pull docker.io/nginx
sudo crictl pull docker.io/busybox
sudo crictl pull busybox
sudo crictl pull tomcat
sudo crictl image ls
sudo crictl images
sudo crictl pull busybox
sudo crictl pull tocat
sudo crictl pull tomcat
sudo crictl pull mukeshjava92/nginx
sudo crictl pull mysql
crictl pull mysql
sudo crictl pull docker.io/busybox
sudo crictl pull docker.io/mysql
crictl image ls
crictl image
sudo crictl pull docker.io/mukeshjava92/nginx
kubectl get po
kubectl get deploy
kubectl get edit deploy nginx
kubectl edit deploy nginx
kubectl get deploy
kubectl get po
kubectl get secret 
kubectl delete secret --all
history 
vi /etc/containers/registries.conf
systemctl stop crio.service
systemctl start crio.service
crictl image 
crictl pull kafka
crictl pull nginx
crictl rmif nginx
crictl rmi nginx
crictl image 
crictl image nginx
crictl pull nginx
crictl pull wordpress
crictl image 
cd /etc/
exit
crictl ps
exit
history
kubectl get nodes
exit
kubectl get nodes
kubectl get all -A
kubectl top nodes
kubectl top pods
kubectl delete deployment.apps/ingress-nginx-controller -n ingress-nginx
kubectl delete deployment.apps/kubernetes-bootcamp -n training
kubectl get all -A
kubectl delete service/ingress-nginx-controller service/ingress-nginx-controller
kubectl get all -A
kubectl delete service/ingress-nginx-controller service/ingress-nginx-controller -n ingress-nginx
kubectl delete service/ingress-nginx-controller service/ingress-nginx-controller-admission -n ingress-nginx
kubectl get all -A
kubectl get all -n training
kubectl get all -n default
kubectl get all -A
kubectl top pods -A
kubectl edit deployment.apps/metrics-server -n kube-system
kubectl top pods -A
kubectl get all -A
kubectl get pods -A
kubectl logs pods/metrics-server-596474b58-fcqx8
kubectl get pods -A
kubectl top pods
kubectl top nodes
kubectl logs pods/metrics-server-5896448686-v29dn 
kubectl top nodes
kubectl get deployment
kubectl describe deployment/metrics-server
kubectl top nodes
kubectl get nodes
kubectl get pods -A
kubectl top nodes
kubectl top pods
vim pod1.yml
kubectl create -f pod1.yml 
vim pod1.yml
kubectl create -f pod1.yml 
vim pod1.yml
kubectl create -f pod1.yml 
kubectl get pods
vim pod1.yml
kubectl apply -f pod1.yml
kubectl  pods
kubectl get pods
vim pod1.yml
kubectl apply -f pod1.yml
vim pod1.yml
kubectl delete pod/nginx
kubectl apply -f pod1.yml
kubectl get pods
kubectl logs pods/nginx
kubectl describe pods/nginx
vim /etc/containers/registries.conf
vim pod1.yml
kubectl apply -f pod1.yml
kubectl get pods
vim /etc/containers/registries.conf
kubectl delete pod/nginx
kubectl get pods
history | grep -i context
kubectl config set-context --current --namespace=training
kubectl get pods
kubectl apply -f pod1.yml
kubectl get pods
systemctl restart kubelet
systemctl status  kubelet
kubectl get pods
kubectl delete pod/nginx
kubectl apply -f pod1.yml
kubectl get pods
kubectl describe pods/nginx
kubectl get pods
kubectl delete pod/nginx
kubectl create deployment nginx nginx
kubectl create deployment nginx --image=nginx
kubectl get pods
vim /etc/containers/registries.conf
systemctl restart kubelet.service
systemctl status kubelet.service
kubectl get pods
kubectl delete pod/nginx-7854ff8877-r472n
kubectl get pods
kubectl get deployment
kubectl delete deployment/nginx
kubectl get deployment
kubectl get pods
kubectl create deployment nginx --image=nginx
kubectl get pods
vim 1.yaml
git init
git add README.md
exit
vim /etc/containers/registries.conf
systemctl restart kubelet.service
kubectl get pods
kubectl get deployment
kubectl delete deployment/nginx
kubectl get all
ls l-trh
ls -ltrh
mv pod1.yml pod.yml
ls -ltrh
vim pod.yml 
kubectl create -f pod.yml 
kubectl get pods
kubectl get pods -w
kubectl get pods
ls -ltrh
kubectl get pods
kubectl create deployment --name nginx2 --image=docker.io/nginx:latest
kubectl create deployment nginx2 --image=docker.io/nginx:latest
kubectl get deployment
kubectl get pods
kubectl delete deployment
kubectl delete deployment/nginx
kubectl get deployment
kubectl delete deployment/nginx2
kubectl get pods
kubectl delete pod/nginx
ls -ltrh
cat nginx-deployment.yaml
vim pod.yml 
kubectl create -f pod.yml 
kubectl get pods
kubectl describe  pods/nginx
kubectl get pods
cat pod.yml 
vim pod.yml 
vim replicationcontroller.yaml
kubectl create -f replicationcontroller.yaml 
vim replicationcontroller.yaml
kubectl create -f replicationcontroller.yaml 
vim replicationcontroller.yaml
kubectl create -f replicationcontroller.yaml 
kubectl get pods
vim replicationcontroller.yaml
kubectl get all
kubectl delete replicationcontroller/myapp-rc
kubectl get all
kubectl delete pod/nginx
kubectl get all
ls -ltrh
vim replicationcontroller.yaml
kubectl get pods
kubectl create -f replicationcontroller.yaml 
kubectl get all
kubectl delete replicationcontroller/myapp-rc
kubectl get all
ls -ltrh
cp replicationcontroller.yaml replicaset.yaml
ls -ltrh
vim replicaset.yaml
kubectl create -f replicaset.yaml 
kubectl get all
ls -ltrh
kubectl delete replicaset.apps/myapp-replicaset
kubectl get all
ls -ltrh
rm nginx-deployment.yaml
ls -ltrh
vim replicaset.yaml
vim replicationcontroller.yaml
kubectl get all
kubectl create -f replicaset.yaml 
kubectl scale replicaset.apps/myapp-replicaset --replicas=5
kubectl get all
vim replicaset.yaml
kubectl delete replicaset.apps/myapp-replicaset
kubectl get all
kubectl create -f replicaset.yaml 
kubectl get all
kubectl delete replicaset.apps/myapp-replicaset
kubectl get all
vim manualscheduling.yaml
ls -ltrh
vim pod.yml
vim manualscheduling.yaml
kubectl get nodes
kubectl create -f manualscheduling.yaml 
kubectl get all
kubectl get all -o wide
kubectl edit pod/nginx
kubectl get all -o wide
ls -ltrh
kubectl get all 
kubectl delete pod/nginx
kubectl get all 
ls -ltrh
vim manualscheduling.yaml
ls -ltrh
vim cat pod.yml
cat pod.yml
kubectl get all
ls -ltrh
vim labelsandselector.yaml
kubectl get all
ls -lth
kubectl create -f labelsandselector.yaml
vim labelsandselector.yaml
kubectl create -f labelsandselector.yaml
kubectl get all
kubectl delete -f labelsandselector.yaml
kubectl get all
vim labelsandselector.yaml
kubectl get all
vim labelsandselector.yaml
kubectl get all
kubectl create -f labelsandselector.yaml
kubectl get all
kubectl delete -f labelsandselector.yaml
ls -ltrh
vim taint&toleration.yaml
vim taintandtoleration.yaml
ls -ltrh
vim taintandtoleration.yaml
kubectl create -f taintandtoleration.yaml 
kubectl get all
kubectl delete -f taintandtoleration.yaml 
kubectl get nodes
kubectl taint node worker app=blue:NoScheule
kubectl taint node worker app=blue:NoSchedule
kubectl get nodes
kubectl describe nodes/worker | less
ls -ltrh
kubectl create -f taintandtoleration.yaml 
kubectl get all -o wide
kubectl delete -f taintandtoleration.yaml 
kubectl taint node worker2 app=blue:NoSchedule
kubectl create -f taintandtoleration.yaml 
kubectl get all -o wide
kubectl create -f pod.yml
kubectl get all -o wide
kubectl describe pods/pod/nginx
kubectl describe pod/nginx
kubectl taint node worker2 app=blue:
kubectl taint node worker2 app=blue:-
kubectl taint node worker2 app=blue:NoSchedule-
kubectl taint node worker app=blue:NoSchedule-
vim taintandtoleration.yaml
kubectl get all -A
kubectl get all
kubectl delete all
kubectl delete all --all
kubectl get all -A
kubectl delete all
kubectl get all
ls -ltrh
vim nodeselectors.yaml
ls -ltrh
kubectl create -f nodeselectors.yaml 
vim nodeselectors.yaml
kubectl create -f nodeselectors.yaml 
vim nodeselectors.yaml
kubectl create -f nodeselectors.yaml 
vim nodeselectors.yaml
kubectl create -f nodeselectors.yaml 
vim nodeselectors.yaml
kubectl create -f nodeselectors.yaml 
kubectl get all
kubectl describe pods/myapp-nodeselector
kubectl get nodes --labels
kubectl get nodes -L size=Large
kubectl describe node/worker
kubectl label node worker size=Large
kubectl get nodes --show-labels
kubectl get pods
kubectl label node worker size-
kubectl get nodes --show-labels
LS -LTRH
ls -ltrh
vim nodeselectors.yaml
ls -ltrh
vim nodeaffinity.yaml
vim nodeselectors.yaml
vim nodeaffinity.yaml
#kubectl create -f nodeaffinity.yaml
kubectl get all
kubectl get all --all
kubectl delete all --all
kubectl get all
#kubectl create -f nodeaffinity.yaml
kubectl create -f nodeaffinity.yaml
vim nodeaffinity.yaml
kubectl create -f nodeaffinity.yaml
vim nodeaffinity.yaml
kubectl create -f nodeaffinity.yaml
vim nodeaffinity.yaml
kubectl create -f nodeaffinity.yaml
kubectl get all
vim nodeaffinity.yaml
kubectl get all
kubectl delete all --all
kubectl get all
kubectl create -f nodeaffinity.yaml
kubectl get all
kubectl label node worker size=Large
kubectl get all
kubectl label node worker size-
ls -ltrh
cat 1
rm 1
ls -ltrh
vim Podwithresources.yaml
kubectl get all
kubectl get all --all
kubectl delete all --all
kubectl label node worker size-
kubectl create -f Podwithresources.yaml
vim Podwithresources.yaml
kubectl create -f Podwithresources.yaml
kubectl get all 
kubectl describe pod/myapp-with-defined-resources
kubectl delete all --all
ls -ltrh
vim Podwithresources.yaml
vim limitrange.yaml
kubectl create -f limitrange.yaml
vim limitrange.yaml
kubectl create -f limitrange.yaml
vim limitrange.yaml
kubectl create -f limitrange.yaml
vim limitrange.yaml
kubectl create -f limitrange.yaml
kubectl get all 
kubectl get limitrange
kubectl delete all --all
kubectl delete limitrange/cpu-limitrange-training
vim limitrange.yaml 
mv limitrange.yaml limitrange-cpu.yaml
ls -ltrh
cp limitrange-cpu.yaml limitrange-memory.yaml
vim limitrange-memory.yaml
vim limitrange-memory.yaml 
kubectl get limitrange
kubectl get all 
vim resourcequota.yaml
kubectl create -f resourcequota.yaml 
vim resourcequota.yaml
kubectl create -f resourcequota.yaml 
vim resourcequota.yaml
kubectl create -f resourcequota.yaml 
vim resourcequota.yaml
kubectl create -f resourcequota.yaml 
kubectl get all 
kubectl get resourcequota
kubectl delete resourcequota/my-resource-quota
kubectl apply -f https://k8s.io/examples/admin/resource/quota-mem-cpu-pod.yaml
kubectl get all 
kubectl delete all --all
vim resourcequota.yaml 
vim daemonset.yaml
kubectl create daemonset.yaml 
kubectl create -f daemonset.yaml 
vim daemonset.yaml
kubectl apply -f https://k8s.io/examples/application/basic-daemonset.yaml
kubectl get all 
wget https://k8s.io/examples/application/basic-daemonset.yaml
ls -ltrh
vim basic-daemonset.yaml
rm -rf 1
ls -ltrh
kubectl get pods
kubectl get pods -w
kubectl get hpa php-apache --watch
kubectl get all
kubectl delete -f https://k8s.io/examples/application/basic-daemonset.yaml
kubectl get all
ls -ltrh
history | grep -i boot
mkdir /yaml
ls -ltrh
mkdir yaml
ls -ltrh
cd yaml
ls -ltrh
vim rc.yaml
kubectl get apiresources
kubectl get api-resources
kubectl apiresources
kubectl api-resources
vim rc.yaml
kubectl get all
kubectl create -f rc.yaml 
vim rc.yaml
kubectl create -f rc.yaml 
kubectl get all
kubectl scale replicationcontroller/myapp-rc --replicas=5
kubectl get all
vim pod.yaml
cd ..
ls -ltrh
kubectl create -f pod.yml
kubectl get all
kubectl describe pod/nginx
ls -ltrh
vim replicaset.yaml
kubectl create -f replicaset.yaml 
kubectl get all
vim replicaset.yaml 
vim deployment.yaml
kubectl create -f deployment.yaml
kubectl get all
kubectl get pods
kubectl get all
kubectl describe deployment.apps/nginx-deployment | less
kubectl edit deployment.apps/nginx-deployment
kubectl get all
kubectl get pods
kubectl edit nginx-deployment-5fff89f69-4j7h9
kubectl edit pods/nginx-deployment-5fff89f69-4j7h9
kubectl edit deployment.apps/nginx-deployment
ls -ltrj
ls -ltrh
vim manualscheduling.yaml
kubectl get all
kubectl delete all --all
kubectl get all
ls -ltrh
vim manualscheduling.yaml
kubectl apply -f manualscheduling.yaml 
kubectl get all
kubectl get all -o wide
vim manualscheduling.yaml
kubectl apply -f manualscheduling.yaml 
kubectl get all -o wide
kubectl describe pod/nginx | less
kubectl create -f pod.yml 
kubectl get all
kubectl delete all --all
kubectl get all
ls -ltrh
vim labelsandselector.yaml
cd yaml/
ls -ltrh
vim pod-selector.yaml
kubectl create pod-selector.yaml 
kubectl create -f pod-selector.yaml 
kubectl get all
kubectl dscribe pod/simple-webapp
kubectl describe pod/simple-webapp
vim replicaset-labels.yaml
kubectl create -f replicaset-labels.yaml 
kubectl get all
vim replicaset-labels.yaml 
vim service-labels.yaml
kubectl create -f service-labels.yaml
kubectl get l
kubectl get all
cd ..
ls -ltrh
vim labelsandselector.yaml
kubectl get 
kubectl describe service/simple-webapp-service
kubectl describe replicaset.apps/simple-webapp
kubectl get pods --selector app=App1 --no-headers
kubectl get pods --show-labels
kubectl get nodes --show-labels
kubectl get all
kubectl get nods
kubectl get nodes
kubectl describe node/worker | grep -i taint
kubectl describe node/master | grep -i taint
kubectl get pods -o wide
kubectl get nodes
kubectl describe node/worker | grep -i taint
kubectl describe node/worker2 | grep -i taint
kubectl describe node/master | grep -i taint
kubectl taint nodes worker app=blue:NoSchedule
kubectl describe node/worker | grep -i taint
kubectl taint nodes worker2 app=blue:NoSchedule
kubectl describe node/worker2 | grep -i taint
ls -ltrh
vim taintandtoleration.yaml
kubectl create -f pod.yml
kubectl get pods
kubectl get nods
kubectl get nodes
kubectl describe pod/nginx | less
kubectl get pods
vim taintandtoleration.yaml
kubectl create -f taintandtoleration.yaml 
kubectl get pods
kubectl get pods -o wide
kubectl edit pods/nginx
kubectl get pods
kubectl describe pods/myapp-taint
kubectl get pods
kubectl edit pods/nginx
kubectl get pods
ls -ltrh
vim manualscheduling.yaml
kubectl get all
kubectl get all --all
kubectl delete all --all
kubectl get all --all
kubectl get all
ls -ltrh
vim nodeselectors.yaml
kubectl create -f nodeselectors.yaml 
kubectl get pods
kubectl describe pods/myapp-nodeselector | less
kubectl describe node/worker | grep -i taint
kubectl describe node/worker2 | grep -i taint
kubectl taint nodes worker app=blue:NoSchedule-
kubectl taint nodes worker2 app=blue:NoSchedule-
kubectl describe node/worker | grep -i taint
kubectl describe node/worker2 | grep -i taint
kubectl get pods
kubectl describe pods/myapp-nodeselector | less
kubectl get pods
kubectl label node worker size=Large
kubectl get pods
kubectl label node worker size=Medium
kubectl logs pods/myapp-nodeselector
kubectl get nodes --show-labels
kubectl get pods
vim nodeselectors.yaml 
kubectl create -f nodeselectors.yaml 
kubectl get nodes
kubectl get pods
vim nodeselectors.yaml 
kubectl delete all --all
kubectl get all
kubectl create -f nodeselectors.yaml 
kubectl get pods
vim nodeselectors.yaml 
ls -ltrh
vim nodeaffinity.yaml
kubectl get pods
kubectl delet pods/myapp-nodeselector1
kubectl delete pods/myapp-nodeselector1
kubectl get all
ls -ltrh
vim nodeselectors.yaml
kubectl get nodes --show-labels
vim nodeselectors.yaml
kubectl lable node worker size=Large-
kubectl label node worker size=Large-
cat nodeselectors.yaml 
kubectl label node worker size-
kubectl get nodes --show-labels
kubectl label node worker size=Large
kubectl get nodes --show-labels
cat nodeselectors.yaml 
kubectl create -f nodeselectors.yaml 
kubectl get pods
kubectl get pods -o wide
kubectl delete all --all
ls -ltrh
vim nodeaffinity.yaml
kubectl create -f nodeaffinity.yaml 
kubectl get all
kubectl get all -o wide
vim nodeaffinity.yaml 
ls -ltrj
ls -ltrh
kubectl get nodes
kubectl get pods -A
kubectl apply -f https://k8s.io/examples/controllers/daemonset.yaml
kubectl get all
kubectl get daemonset
kubectl get daemonset -A
kubectl get daemonset
kubectl get daemonset -A
kubectl get pods
kubectl get pods -A
kubectl get pods -n kube-system
kubectl get pods -n kube-system -o wide
kubectl get daemonset -A
kubectl get pods
kubectl describe pods/myapp-nodeaffinity
ls -ltrh
vim Podwithresources.yaml
kubectl create -f Podwithresources.yaml 
kubectl get pods
kubectl describe pods/myapp-with-defined-resources
kubectl describe pods/myapp-with-defined-resources | less
ls -ltrh
vim limitrange-cpu.yaml
kubectl create -f limitrange-cpu.yaml 
kubectl get all
kubectl get limitrange
kubectl describe limitrange/cpu-limitrange-training
vim limitrange-cpu.yaml
ls -ltrh
kubectl create -f limitrange-memory.yaml
kubectl get limitrange
kubectl describe limitrange/memory-limitrange-training
vim limitrange-memory.yaml 
kubectl delete limitrange/memory-limitrange-training
kubectl get limitrange
vim limitrange-memory.yaml 
kubectl create -f limitrange-memory.yaml
kubectl get limitrange
kubectl describe limitrange/memory-limitrange-training
ls -ltrh
cd yaml/
ls l-trh
ls -lth
rm -rf *
ls -ltrh
vim deployment.yaml
vim service.yaml
vim ingress.yaml
kubectl get all
kubectl delete all --all
kubectl create -f deployment.yaml
vim ingress.yaml
vim deployment.yaml
kubectl create -f deployment.yaml
vim deployment.yaml 
vim service.yaml 
vim ingress.yaml 
kubectl create -f deployment.yaml 
kubectl create -f service.yaml 
kubectl create -f ingress.yaml 
kubectl get all
kubectl get ingress
wget https://github.com/haproxytech/kubernetes-ingress/blob/master/deploy/haproxy-ingress.yaml
ls -ltrh
vim haproxy-ingress.yaml
cat haproxy-ingress.yaml 
kubectl apply -f deploy/haproxy-ingress.yaml
ls- ltrh
ls -ltrh
kubectl apply -f haproxy-ingress.yaml
cd
ls -ltrh
cat resourcequota.yaml
kubectl get all
kubectl delete -f haproxy-ingress.yaml
kubectl get all
kubectl delete deployment.apps/sample-app
kubectl get all
kubectl delete service/sample-app-service
kubectl get all
ls -ltrh
cd yaml/
ls -ltrh
rm -rf *
ls -ltrh
vim deployment-definition.yaml
kubectl apply -f deployment-definition.yaml 
vim deployment-definition.yaml
kubectl apply -f deployment-definition.yaml 
vim deployment-definition.yaml
kubectl apply -f deployment-definition.yaml 
vim deployment-definition.yaml
kubectl apply -f deployment-definition.yaml 
vim deployment-definition.yaml
kubectl apply -f deployment-definition.yaml 
vim deployment-definition.yaml
kubectl apply -f deployment-definition.yaml 
vim deployment-definition.yaml
vim deploy.yaml
kubectl apply -f deploy.yaml 
vim deploy.yaml
kubectl apply -f deploy.yaml 
vim deploy.yaml
kubectl apply -f deploy.yaml 
kubectl get all
ls -ltrh
kubectl delete -f deployment-definition.yaml
kubectl get all
rm -rf deployment-definition.yaml
mv deploy.yaml deployment-definition.yaml
ls -ltrh
kubectl get all
vim deployment-definition.yaml
kubectl apply -f deployment-definition.yaml
kubectl get all
kubectl delete deployment.apps/sample-app
kubectl get all
ls -ltrh
rm 1
ls -ltrh
kubectl get all
kubectl set image deployment.apps/myapp-deployment nginx-container=nginx:1.9.1
kubectl get all
kubectl set image deployment.apps/myapp-deployment nginx-container=docker.io/nginx:1.9.1
kubectl get all
vim service.yaml
ls -lrh
cp deployment-definition.yaml Pod-Env-Variable.yaml
vim Pod-Env-Variable.yaml
rm Pod-Env-Variable.yaml 
ls -ltrh
cd ..
ls -ltrh
cp pod.yml /yaml/
cd yanml
cd yaml/
ls -ltrh
cd ..
cp pod.yml yaml/
ls -ltrh
cd yaml/
ls -ltrh
vim pod.yml
kubectl apply -f pod.yml 
vim pod.yml
ls -ltrh
vim configmap.yaml
kubectl create configmap.yaml 
kubectl create -f configmap.yaml 
kubectl version --short
kubectl config current-context
kubectl get crds
vim configmap.yaml
kubectl create -f configmap.yaml 
vim configmap.yaml
kubectl create -f configmap.yaml 
kubectl get configmap
kubectl describe cm/app-config
ls -ltrh
rm 1
ls -ltrh
vim configmap.yaml
cp pod.yml inject-in-to-pod.yml
vim inject-in-to-pod.yml
kubectl create -f inject-in-to-pod.yml 
vim inject-in-to-pod.yml
kubectl create -f inject-in-to-pod.yml 
vim inject-in-to-pod.yml
kubectl create -f inject-in-to-pod.yml 
vim inject-in-to-pod.yml
kubectl create -f inject-in-to-pod.yml 
vim inject-in-to-pod.yml
kubectl create -f inject-in-to-pod.yml 
vim inject-in-to-pod.yml
kubectl create -f inject-in-to-pod.yml 
vim inject-in-to-pod.yml
kubectl create -f inject-in-to-pod.yml 
kubectl get all
kubectl describe pods/pod/env-var-pod
ls -ltrh
cp inject-in-to-pod.yml configmap-inject-in-to-pod.yml
ls -ltrh
rm inject-in-to-pod.yml
rm 1
ls -ltrh
kubectl get all
kubectl describe pod/env-var-pod
kubectl delete all --all
ls -ltrh
cat configmap
cat configmap.yaml 
ls -ltrh
vim secret.yaml
kubectl create -f secret.yaml 
cp configmap-inject-in-to-pod.yml secret-inject-in-to-pod.yml
ls -ltrh
vim secret-inject-in-to-pod.yml
kubectl create -f secret-inject-in-to-pod.yml 
vim secret-inject-in-to-pod.yml
vim configmap-inject-in-to-pod.yml
kubectl get all
kubectl create -f configmap-inject-in-to-pod.yml
kubectl create -f secret-inject-in-to-pod.yml 
kubectl get all
vim configmap-inject-in-to-pod.yml
vim secret-inject-in-to-pod.yml
vim secret
vim secret.yaml 
ls -ltrh
cat deployment-definition.yaml
vim deployment-definition.yaml
kubectl apply -f deployment-definition.yaml 
kubectl get all
kubectl describe deployment.apps/myapp-deployment
ls -ltrh
vim hpa.yaml
kubectl create -f hpa.yaml 
kubectl get all
kubectl describe deployment.apps/php-apache
kubectl get hpa -A
kubectl get hpa
kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
kubectl get hpa
kubectl describe deployment.apps/php-apache
kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"
ls -ltrh
kubectl get all
kubectl get pods -A
kubectl get deployment -A
kubectl describe deployment/metrics-server -n kube-system
kubectl restart kubelet.service
systemctl restart kubelet.service
systemctl status kubelet.service
kubectl top nodes
kubectl get deployment -n kube-system
kubectl delete deployment/metrics-server
kubectl delete deployment/metrics-server -n kube-system
kubectl get deployment -n kube-system
kubectl get pods -n kube-system
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl get all
kubectl get all -n
kubectl get all -A
kubectl edit deployment.apps/metrics-server -n kube-system
kubectl get pods -A
kubectl get pods -A -n kube-system
kubectl get pods -n kube-system
kuectl logs pod/metrics-server-75bf97fcc9-hsshd
kuectl logs pod/metrics-server-75bf97fcc9-hsshd -n kube-system
kubectl logs pod/metrics-server-75bf97fcc9-hsshd -n kube-system
kubectl get pods -n kube-system
kubectl top nodes
kubectl top pods
kubectl logs pod/metrics-server-6cdc968f96-gltnr
kubectl logs pod/metrics-server-6cdc968f96-gltnr -n kube-system
kubectl top nodes
ls -ltrh
kubectl get all
kubectl delete all --all
kubectl top nodes
kubectl get pods -A
kubectl get deployment -n kube-system
kubectl escribe deployment/metrics-server
kubectl describe deployment/metrics-server
kubectl describe deployment/metrics-server -n kuve-system
kubectl describe deployment/metrics-server -n kube-system
kubectl get pods
kubectl get pods -A
kubectl logs pods/metrics-server-6cdc968f96-gltnr -n kube-system
kubectl delete pod/metrics-server-6cdc968f96-gltnr
kubectl delete pod/metrics-server-6cdc968f96-gltnr -n kube-system
kubectl get pods -A
kubectl adm top pods
kubectl top pods
kubectl get deploy -A
kubectl edit deployment/metrics-server -n kube-system
kubectl top pods
kubectl top pods -A
kubectl top pods
kubectl get pods -A
kubectl top pods
kubectl delete -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl top pods
kubectl get pods -A
kubectl edit deployment/metrics-server -n kube-system
kubectl get pods -A
kubectl get pods -A -w
kubectl get pods -A
kubectl describe pod/metrics-server-545567965f-2bmwr -n kube-system
kubectl get pods -A
kubectl logs pod/metrics-server-545567965f-2bmwr -n kube-system
kubectl edit deployment/metrics-server -n kube-system
kubectl get pods -A
kubectl get pods -A -w
kubectl top pods
kubectl get pods -A
kubectl logs pod/metrics-server-6cdc968f96-9mvzt -n kube-system
ls -ltrh
cd
kubectel apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
kubectl get all -A
kubectl get namespace
kubectl get all -n ingress-nginx
kubectl describe pods/pod/ingress-nginx-controller-69b8bc4c4f-2s5j4
kubectl describe pod/ingress-nginx-controller-69b8bc4c4f-2s5j4
kubectl describe pod/ingress-nginx-controller-69b8bc4c4f-2s5j4 -n ingress-nginx
kubectl get nodes --show-labels
kubectl label node worker size-
kubectl get all -n ingress-nginx
kubectl get nodes --show-labels
kubectl describe pods/pod/ingress-nginx-controller-69b8bc4c4f-2s5j4
kubectl describe pods/pod/ingress-nginx-controller-69b8bc4c4f-2s5j4 -n ingress-nginx
kubectl describe pods/ingress-nginx-controller-69b8bc4c4f-2s5j4 -n ingress-nginx
kubectl describe nodes | grep -i taint
kubectl get all -n ingress-nginx -o wide
kubectl get nodes --show-labels
kubectl get all -n ingress-nginx
kubectl get all -A
kubectl delete daemonset.apps/fluentd-elasticsearch
kubectl delete daemonset.apps/fluentd-elasticsearch -n kube-system
kubectl get all -A
kubectl get pods
kubectl top pods
kubectl get deployment
kubectl get deployment -A
kubectl get all -A
kubectl get all -n ingress-nginx
kubectl describe pods/pod/ingress-nginx-controller-69b8bc4c4f-2s5j4 -n ingress-nginx
kubectl describe pods/ingress-nginx-controller-69b8bc4c4f-2s5j4 -n ingress-nginx
kubectl get deployment -n ingress-nginx
kubectl describe deployment/ingress-nginx-controller -n ingress-nginx
kubectl describe deployment/ingress-nginx-controller -n ingress-nginx | grep -i affinity
kubectl describe pod/ingress-nginx-controller-69b8bc4c4f-2s5j4 -n ingress-nginx | grep -i affinity
kubectl describe deployment/ingress-nginx-controller -n ingress-nginx | grep -i selector
kubectl logs pod/ingress-nginx-controller-69b8bc4c4f-2s5j4 -n ingress-nginx
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
kubectl get deployment -n ingress-nginx
kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
kubectl get deployment -n ingress-nginx
kubectl get pods
kubectl get all -A
kubectl top pods
kubectl get --raw /apis/metrics.k8s.io/v1beta1/pods
kubectl get clusterrole metrics-server
kubectl get clusterrolebinding metrics-server
kubectl get clusterrole metrics-server -n kube-system
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
[200~--enable-aggregator-runtime-config=metrics.k8s.io/v1beta1
kubectl edit deployment.apps/metrics-server
kubectl edit deployment.apps/metrics-server -n kube-system
kubectl get pods -n kube-system
kubectl describe pods/metrics-server-5464dc75b6-kbtv6 -n kube-system
kubectl get componentstatuses
kubectl get apiservice v1beta1.metrics.k8s.io
kubectl top pods --all-namespaces
ps aux | grep apiserver
kubectl get apiservice v1beta1.metrics.k8s.io
kubectl edit deployment.apps/metrics-server -n kube-system
kubectl top pods --all-namespaces
kubectl get pods --all-namespaces
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl get apiservice v1beta1.metrics.k8s.io
kubectl get svc metrics-server -n kube-system
kubectl get apiservice v1beta1.metrics.k8s.io
kubectl get all
kubectl get all -A
kubectl delete deployment.apps/metrics-server
kubectl delete deployment.apps/metrics-server -n kube-system
kubectl get all -A
kubectk delete daemonset.apps/kube-proxy -n kube-system
kubectl delete daemonset.apps/kube-proxy -n kube-system
kubectl get all -A
kubectl get nodes --show-labels
kubectl top pods
reboot
kubectl get all
kubectl get all -A
kubectl get all -
kubectl get all -A
reboot
kubectl get all -A
ls -ltrh
kubectl create -f pod.yml
kubectl get pods
kubectl delete deployment.apps/calico-kube-controllers -n kube-system
kubectl get all -A
kubectl delete daemonset.apps/calico-node -n kube-system
kubectl get all -A
kubectl create deploy sample-1 --image=devopsprosamples/next-path-sample-1
kubectl get all
kubectl create deploy sample-2 --image=docker.io/devopsprosamples/next-path-sample-1
kubectl get all
ls -ltrh
cd yaml
ls -ltrh
cat pod.yml
cat Podwithresources.yaml
cd ..
vim Podwithresources.yaml
vim deployment-definition.yaml
vim configmap.yaml
vim pod.yml
cat  configmap-inject-in-to-pod.yml
cd yaml/
ls -ltrh
cat configmap.yaml
cat pod.yml
vim pod.yml
cat deployment-definition.yaml
cat configmap-inject-in-to-pod.yml
vim configmap-inject-in-to-pod.yml
ls -ltrh
cat secret-inject-in-to-pod.yml
vim secret-inject-in-to-pod.yml
ls -ltrh
cat deployment-definition.yaml
vim deployment-definition.yaml
ls -ltrh
cd ..
ls -ltrh
kubectl get all -A
exit
ls -ltrh
ftp 20.127.173.93
passwd root
pwd
mkdir /tmp/yaml
rm 1
ls -ltrh
cp * /tmp/yaml/
cp -r * /tmp/yaml/
cd /tmp/yaml/
ls -ltrh
