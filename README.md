This repository contains a collection of sample YAML Manifest for Kubernetes and Red Hat OpenShift containerized applications.
To complete the course you need to fork this repo into your personal Github account.

For more info follow: https://www.linkedin.com/in/ankitkkjain/

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

## Prerequisite

To follow along in this tutorial, you’ll need the following:

Understanding of Kubernetes and Linux commands.
This tutorial uses a Linux machine with an Ubuntu 22.04 LTS (recommended) distribution. Any other version will work fine too.
Virtual machines (VMs) as master and worker with at least the minimum specifications below:

Nodes	Specifications	IP Address
Master	2GB RAM and 2CPUs	170.187.169.145
Worker	1GB RAM and 1CPU	170.187.169.226

```
kubectl apply -f https://reweave.azurewebsites.net/k8s/v1.29/net.yaml
```

Replace `v1.29` with the version on Kubernetes on your cluster.

That endpoint is provided by the companion project [weave-endpoint](https://github.com/rajch/weave-endpoint).

## Configuring Kernel Modules, Sysctl Settings, and Swap

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

## Installing a container runtime

Reference Documentation [kubernetes.io/Installing a container runtime](https://v1-29.docs.kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-runtime)

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
Provide networking capabilities to containers by executing the following command:
```
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
EOF
```
Be sure to run the command below so the sysctl settings above take effect for the current session:
```
sysctl --system
```


## Documentation status

The public documentation that used to exist in the `site` directory has been moved to the `original/site` directory. A new `website` directory has been created, and populated with the content of the `original/site` directory, rearranged and reformatted for being built with Jekyll and published to the GitHub pages site [https://rajch.github.io/weave](https://rajch.github.io/weave).

The documentation will now be maintained and published from the `website` directory exclusively.
