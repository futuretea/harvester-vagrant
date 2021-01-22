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
  - --disable
  - local-storage
  - --flannel-iface
  - eth0
  labels:
    svccontroller.k3s.cattle.io/enablelb: "true"
  modules:
  - kvm
  - vhost_net
  ntpServers:
  - ntp.ubuntu.com
  password: vagrant
  token: vagrant
writeFiles:
- content: |
    apiVersion: v1
    kind: Namespace
    metadata:
      name: harvester-system
    ---
    apiVersion: helm.cattle.io/v1
    kind: HelmChart
    metadata:
      name: harvester
      namespace: kube-system
    spec:
      chart: https://%{KUBERNETES_API}%/static/charts/harvester-0.1.0.tgz
      targetNamespace: harvester-system
      set:
        containers.apiserver.authMode: "localUser"
        multus.enabled: "true"
        longhorn.enabled: "true"
        minio.persistence.storageClass: "longhorn"
        containers.apiserver.image.imagePullPolicy: "IfNotPresent"
        harvester-network-controller.image.pullPolicy: "IfNotPresent"
        service.harvester.type: "LoadBalancer"
  encoding: ""
  owner: root
  path: /var/lib/rancher/k3s/server/manifests/harvester.yaml
  permissions: "0600"
- content: |
    options kvm ignore_msrs=1
  path: /etc/modprobe.d/kvm.conf
  owner: root
  permissions: ''
EOF
umount /mnt
sudo rc-service ccapply restart
sudo rc-service sshd restart
