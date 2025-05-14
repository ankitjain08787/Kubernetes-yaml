This repository contains a collection of sample YAML Manifest for Kubernetes and Red Hat OpenShift containerized applications.
To complete the course you need to fork this repo into your personal Github account.

[Documentation Author: Ankit Jain](https://www.linkedin.com/in/ankitkkjain/)

# Kubernetes Cluster Installation and Commands

Deploy a Kubernetes Cluster Using the CRI-O Container Runtime

[![Go Report Card](https://goreportcard.com/badge/github.com/rajch/weave)](https://goreportcard.com/report/github.com/rajch/weave)
[![Docker Pulls](https://img.shields.io/docker/pulls/rajchaudhuri/weave-kube "Number of times the weave-kube image was pulled from the Docker Hub")](https://hub.docker.com/r/rajchaudhuri/weave-kube)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/rajch/weave?include_prereleases)](https://github.com/rajch/weave/releases)
[![Unique CVE count in all images](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Frajch%2Fweave%2Fmaster%2Freweave%2Fscans%2Fbadge.json&label=CVE%20count "The number of unique CVEs reported by scanning all images")](reweave/scans/report.md)

This article explains how to deploy Kubernetes CRI-O. Earthly streamlines the build process for Kubernetes applications.
Kubernetes is a powerful platform for managing containerized applications, providing a unified API for managing containers and their associated resources, such as networking, storage, and security. And with the ability to work with different container runtimes like Docker, Containerd, CRI-O etc. you can choose the runtime that’s best for your needs.

CRI-O is an optimized container engine specifically designed for Kubernetes. With CRI-O, you can enjoy all the benefits of Kubernetes while using a container runtime that is tailored to your needs.

In this article, you will learn how to deploy a Kubernetes cluster using the CRI-O container runtime. You’ll learn everything you need to know, from setting up the necessary components to configuring your cluster and deploying your first application.

## Read Before you begin
1.  A compatible Linux host. The Kubernetes project provides generic instructions for Linux distributions based on Debian and Red Hat, and those distributions without a package manager.
2.  2 GB or more of RAM per machine (any less will leave little room for your apps).
3.  2 CPUs or more.
4.  Full network connectivity between all machines in the cluster (public or private network is fine).
5.  Unique hostname, MAC address, and product_uuid for every node. See here for more details.
6.Certain ports are open on your machines. See here for more details.
7.  Swap configuration. The default behavior of a kubelet was to fail to start if swap memory was detected on a node. Swap has been supported since v1.22. And since v1.28, Swap is supported for cgroup v2 only; the NodeSwap feature gate of the kubelet is beta but disabled by default.  You MUST disable swap if the kubelet is not properly configured to use swap. For example, sudo swapoff -a will disable swapping temporarily. To make this change persistent across reboots, make sure swap is disabled in config files like /etc/fstab, systemd.swap, depending how it was configured on your system.

To follow along in this tutorial, you’ll need the following:

Understanding of Kubernetes and Linux commands.
This tutorial uses a Linux machine with an **Ubuntu 22.04 LTS** (recommended) distribution. Any other version will work fine too.
Virtual machines (VMs) as master and worker with at least the reommended minimum specifications.

## Prerequisite: Configuring Kernel Modules, Sysctl Settings, and Swap

Execute the following command on both of your servers (master and worker node) to disable swap. This step is crucial as leaving swap enabled can interfere with the performance and stability of the Kubernetes cluster:

```
swapoff -a
```
Remove any reference to swap space from the /etc/fstab file on both servers using the command below:
```
sed -i '/swap/d' /etc/fstab
```
Now display the status of swap devices or files on your servers using the following command:
```
swapon -s
```

## Prerequisite: Setting Up Firewall  (Optional)
Setting up a firewall when deploying a Kubernetes cluster is important because it helps secure the cluster and prevent unauthorized access to the Kubernetes cluster by blocking incoming traffic from external sources that are not explicitly allowed. It also limits the scope of potential attacks, making it harder for attackers to gain unauthorized access to the cluster.

Therefore, you will follow the steps in this section to set up a firewall on your servers.
Firstly, execute the following command on both servers to enable the Uncomplicated Firewall (UFW) on the system. Once enabled, UFW will start automatically at boot and enforce the firewall rules you configure:
```
ufw enable
```
According to the Kubernetes official documentation, the required ports needed for your Kubernetes cluster are as follows. These ports are only to be open on the server you’d like to use as the control plane:

Port 6443 for the Kubernetes API server.
Port 2379:2380 for the ETCD server client API.
Port 10250 for the Kubelet API.
Port 10259 for the kube scheduler.
Port 10257 for the Kube controller manager.
```
# Opening ports for Control Plane
sudo ufw allow 6443/tcp
sudo ufw allow 2379:2380/tcp
sudo ufw allow 10250/tcp
sudo ufw allow 10259/tcp
sudo ufw allow 10257/tcp
```
Then execute the following commands on the same server to open ports for the Calico CNI as this is the Kubernetes network plugin we will be using:
```
# Opening ports for Calico CNI

sudo ufw allow 179/tcp #allows incoming TCP traffic on port 179, 
#which is used by the Kubernetes API server for communication with the etcd datastore
sudo ufw allow 4789/udp #allows incoming UDP traffic on port 4789, 
#which is used by the Kubernetes networking plugin (e.g. Calico) for overlay networking.
sudo ufw allow 4789/tcp #allows incoming TCP traffic on port 4789, 
#which is also used by the Kubernetes networking plugin for overlay networking.
sudo ufw allow 2379/tcp #allows incoming TCP traffic on port 2379, 
#which is used by the etcd datastore for communication between cluster nodes.
```
Now display the current status of the Uncomplicated Firewall (UFW) on the supposed control plane using the following command:
```
sudo ufw status
```
Next, run the following commands on the server that will be used as a worker node. If you have multiple worker nodes, execute these commands on all of them:
```
# Opening ports for Worker Nodes
sudo ufw allow 10250/tcp #Kubelet API
sudo ufw allow 30000:32767/tcp #NodePort Services

# Opening ports for Calico CNI
sudo ufw allow 179/tcp
sudo ufw allow 4789/udp
sudo ufw allow 4789/tcp
sudo ufw allow 2379/tcp
```
Display the current status of the Uncomplicated Firewall (UFW) on the supposed worker node(s) using the following command:
```
sudo ufw status
```

## Prerequisite: Before the installation of CRI-O container runtime

Reference kubernetes Official Documentation [kubernetes.io/Installing a container runtime](https://v1-29.docs.kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-runtime)

Append the **overlay** and **br_netfilterkernel modules to the/etc/modulesload.d/crio.conf** file which is necessary for the proper functioning of the CRI-O container runtime when your servers reboot.
```
cat >>/etc/modules-load.d/crio.conf<<EOF
overlay
br_netfilter
EOF
```
Enable the kernel modules for the current session manually using the following commands:
```
modprobe overlay
modprobe br_netfilter
```
Confirm that the kernel modules required by CRI-O are loaded and available on both servers using the following commands:
```
lsmod | grep overlay
lsmod | grep br_netfilter
```
Provide networking capabilities to containers by executing the following command, This command will append the following lines net.bridge.bridge-nf-call-ip6tables = 1, net.bridge.bridge-nf-call-iptables = 1, and net.ipv4.ip_forward = 1 to the /etc/sysctl.d/kubernetes.conf file.
```
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
EOF
```
These lines set some important kernel parameters that are required for Kubernetes and CRI-O to function properly:
1.  net.bridge.bridge-nf-call-ip6tables = 1 and net.bridge.bridge-nf-call-iptables = 1 enable the kernel to forward network traffic between containers using bridge networking. This is important because Kubernetes and CRI-O use bridge networking to create a single network interface for all containers on a given host.
2.  net.ipv4.ip_forward = 1 enables IP forwarding, which allows packets to be forwarded from one network interface to another. This is important for Kubernetes because it needs to route traffic between different pods in a cluster.

Be sure to run the command below so the sysctl settings above take effect for the current session:
```
sysctl --system
```
##  Installing the CRI-O Container Runtime

In Kubernetes, a container runtime is responsible for managing the lifecycle of containers. It is the component that actually runs the container images and provides an interface between Kubernetes and the container. Since the container runtime we will be using is CRI-O, we’ll go ahead to install it on our two servers (master and worker nodes).

Create two environment variables OS* and CRIO-VERSION on all your servers and set them to the following values 22.04 and 1.26 using the commands below:

```
OS=xUbuntu_22.04
CRIO_VERSION=1.26
```
This ensures that the correct version of CRI-O is installed on the specific version of the operating system. The OS variable ensures that the package repository used to install the software is the one that corresponds to the operating system version, while the CRIO_VERSION variable ensures that the correct version of the software is installed.

Execute the following commands to add the cri-o repository via apt, so that the package manager can find and install the required packages:
```
echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /"|sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
echo "deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$CRIO_VERSION/$OS/ /"|sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION.list
```
Download the GPG key of the CRI-O repository via curl:
```
curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$CRI_VERSION/$OS/Release.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/libcontainers.gpg add -
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/libcontainers.gpg add -
```
What is GPG Key ?
GPG (GNU Privacy Guard) is a tool used for secure communication and data encryption. A GPG key is a unique code used to verify the authenticity and integrity of a software package or repository.
In the context of the CRI-O repository, downloading the GPG key helps to ensure that the packages we are downloading are genuine and have not been tampered with. This is important for security reasons, as it helps to prevent the installation of malicious software on our system.

Update the package repository and install the CRI-O container runtime along with its dependencies using the following commands:
```
sudo apt-get update 
sudo apt-get install -qq -y cri-o cri-o-runc cri-tools
```
Run the following commands to reload the systemd configuration and then enable and start the CRI-O service:
```
systemctl daemon-reload
systemctl enable --now crio
```

Verify the status and configuration of the CRI-O container runtime after installation with the following command:
```
crictl info
```
You can further check the CRI-O version with the following command:
```
crictl version
```

##  Installing Kubernetes Components (For Debian-based distributions only)
Reference kubernetes Official Documentation [kubernetes.io/Installing a container runtime](https://v1-29.docs.kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl)

You will install these packages on all of your machines:
1.  kubeadm: the command to bootstrap the cluster.
2.  kubelet: the component that runs on all of the machines in your cluster and does things like starting pods and containers.
3.  kubectl: the command line util to talk to your cluster.

kubeadm will not install or manage kubelet or kubectl for you

These instructions are for Kubernetes v1.29.

1.  Update the apt package index and install packages needed to use the Kubernetes apt repository:
```
sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
```
2.  Download the public signing key for the Kubernetes package repositories. The same signing key is used for all repositories so you can disregard the version in the URL:
```
# If the directory `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
# sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
```
'Note: In releases older than Debian 12 and Ubuntu 22.04, directory /etc/apt/keyrings does not exist by default, and it should be created before the curl command.'

3.  Add the appropriate Kubernetes apt repository. Please note that this repository have packages only for Kubernetes 1.29; for other Kubernetes minor versions, you need to change the Kubernetes minor version in the URL to match your desired minor version (you should also check that you are reading the documentation for the version of Kubernetes that you plan to install).
```
# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```
4.  Update the apt package index, install kubelet, kubeadm and kubectl, and pin their version:
```
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```
5.  (Optional) Enable the kubelet service before running kubeadm:
```
sudo systemctl enable --now kubelet
```

##  Initializing Kubernetes Cluster on Control Plane
Initializing a Kubernetes cluster on the control plane involves setting up the master node of the cluster. The master node (The server with the highest number of resources like storage, cpu etc) is responsible for managing the state of the cluster, scheduling workloads, and monitoring the overall health of the cluster.

First, run the following commands to enable the kubelet service and initialize the master node as the machine to run the control plane components (the API server, etcd, controller manager, and scheduler) :
```
# Enable the Kubelet service
systemctl enable kubelet
# Lists and pulls all images that Kubeadm requires \
#specified in the configuration file
kubeadm config images pull
```

To initialize a Kubernetes cluster on the control plane, execute the following command:
```
kubeadm init --pod-network-cidr=192.168.0.0/16 --cri-socket unix:///var/run/crio/crio.sock
```
This initializes a Kubernetes control plane with CRI-O as the container runtime and specifies the Pod network CIDR range as well as the CRI socket for communication with the container runtime.

The kubeadm init command creates a new Kubernetes cluster with a control plane node and generates a set of certificates and keys for secure communication within the cluster. It also writes out a kubeconfig file that provides the necessary credentials for kubectl to communicate with the cluster.
1.  The -pod-network-cidr flag: Specifies the Pod network CIDR range that will be used by the cluster. The Pod network is a flat network that connects all the Pods in the cluster, and this CIDR range specifies the IP address range for this network.
2.  The -cri-socket flag: Specifies the CRI socket that Kubernetes should use to communicate with the container runtime. In this case, it specifies the Unix socket for CRI-O located at /var/run/crio/crio.sock.
Once the Kubernetes cluster has been initialized successfully, you should have the below output:
```
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a Pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  /docs/concepts/cluster-administration/addons/

You can now join any number of machines by running the following on each node
as root:

  kubeadm join <control-plane-host>:<control-plane-port> --token <token> --discovery-token-ca-cert-hash sha256:<hash>
```
To make kubectl work for your non-root user, run these commands, which are also part of the kubeadm init output:
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
Alternatively, if you are the root user, you can run:
```
export KUBECONFIG=/etc/kubernetes/admin.conf
```
##  Join Worker node or Compute plane Nodes in Kubernetes Cluster
Make a record of the kubeadm join command that kubeadm init outputs. You need this command to join nodes to your cluster.
```
kubeadm join <control-plane-host>:<control-plane-port> --token <token> --discovery-token-ca-cert-hash sha256:<hash>
```

