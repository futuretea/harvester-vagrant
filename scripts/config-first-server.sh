#!/bin/bash

mkdir -p /mnt
mount /dev/vda1 /mnt
HOSTNAME=$(hostname)
cat > /mnt/k3os/system/config.yaml <<EOF
hostname: ${HOSTNAME}
k3os:
  dnsNameservers:
  - 8.8.8.8
  k3sArgs:
  - server
  - --cluster-init
  - --disable
  - local-storage
  - --disable
  - servicelb
  - --disable
  - traefik
  - --cluster-cidr
  - 10.52.0.0/16
  - --service-cidr
  - 10.53.0.0/16
  - --cluster-dns
  - 10.53.0.10
  - --flannel-iface
  - eth0
  labels:
    harvester.cattle.io/managed: "true"
  modules:
  - kvm
  - vhost_net
  ntpServers:
  - ntp.ubuntu.com
  password: vagrant
  token: vagrant
EOF
umount /mnt
sudo rc-update add k3s-service default
sudo rc-update add ccapply default
sudo rc-service ccapply restart
sudo rc-service sshd restart
