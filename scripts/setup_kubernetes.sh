#!/usr/bin/env bash

#Install kubernetes on ubuntudocker

VERSION_STRING=17.03


# Set up Docker repositories and install from them, for ease of installation and upgrade tasks. 
# This is the recommended approach.

#Steps:-
# 1. Update the apt package index:
sudo su
apt-get update -y
# 2. Install dependency packages to allow apt to use a repository over HTTPS:
# sudo apt-get install -y apt-transport-https curl
# 3. Add Kubernetes official GPG key
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
# 4.Update source repo list 
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
    deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
# 5. Install kubelet kubeadm kubectl
#    ** kubelet =>>> Node/Worker agent that runs on each node in the cluster.
#    ** kubeadm =>>> Performs the actions necessary to get a minimum viable cluster up and running
#    ** kubectl =>>> A CLI for running commands against Kubernetes clusters
apt-get install -y kubelet kubeadm kubectl
# 6. Making package cannot be installed, upgraded, or removed bt APT
apt-mark hold kubelet kubeadm kubectl
# 7. Kubelet requires swap off
swapoff -a
# 8. keep swap off after reboot /permanent
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
# 9. get ip of this box
IP_ADDR=`ifconfig enp0s8 | grep Mask | awk '{print $2}'| cut -f2 -d:`
# 10. set node-ip
sudo sed -i "/^[^#]*KUBELET_EXTRA_ARGS=/c\KUBELET_EXTRA_ARGS=--node-ip=$IP_ADDR" /etc/default/kubelet
# 11. Restart kubelet service
sudo systemctl restart kubelet
echo $IP_ADDR


###############################################################
#===== Post installation of common kubernetes components =====#
###############################################################
### ============ Kubernetes Master ===================
# ip of this box
# >>IP_ADDR=`ifconfig enp0s8 | grep Mask | awk '{print $2}'| cut -f2 -d:`
# Install k8s master
# >>HOST_NAME=$(hostname -s)
# >>kubeadm init --apiserver-advertise-address=$IP_ADDR --apiserver-cert-extra-sans=$IP_ADDR  --node-name $HOST_NAME --pod-network-cidr=172.16.0.0/16
# copying credentials to regular user - vagrant
# >>sudo --user=vagrant mkdir -p /home/vagrant/.kube
# >>cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
# >>chown $(id -u vagrant):$(id -g vagrant) /home/vagrant/.kube/config
# Install Calico pod network addon
# >>export KUBECONFIG=/etc/kubernetes/admin.conf
# >>kubectl apply -f https://raw.githubusercontent.com/ecomm-integration-ballerina/kubernetes-cluster/master/calico/rbac-kdd.yaml
# >>kubectl apply -f https://raw.githubusercontent.com/ecomm-integration-ballerina/kubernetes-cluster/master/calico/calico.yaml
# >>kubeadm token create --print-join-command >> /etc/kubeadm_join_cmd.sh
# >>chmod +x /etc/kubeadm_join_cmd.sh
# required for setting up password less ssh between guest VMs
# >>sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
# >>sudo service sshd restart
### ============ Kubernetes Worker ===================
# Install k8s worker/nodes
# >>apt-get install -y sshpass
# >>sshpass -p "vagrant" scp -o StrictHostKeyChecking=no vagrant@$IP_ADDR:/etc/kubeadm_join_cmd.sh .
# >>sh ./kubeadm_join_cmd.sh
###############################################################