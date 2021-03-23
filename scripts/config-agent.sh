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
  - agent
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
  server_url: https://10.5.6.11:6443
EOF

umount /mnt
