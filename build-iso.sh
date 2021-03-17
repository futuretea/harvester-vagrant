#!/usr/bin/env bash
[[ -n $DEBUG ]] && set -x
set -eou pipefail

usage() {
    cat <<HELP
USAGE:
    build-iso NAME ISO [SIZE] [DIR]
HELP
}

exit_err() {
    echo >&2 "${1}"
    exit 1
}

if [ $# -lt 2 ]; then
    usage
    exit 1
fi

NAME=$1
ISO=$2
SIZE=${3:-200}
DIR=${4:-output-qemu}

mkdir -p $DIR
pushd $DIR
# box.img
qemu-img create -f qcow2 box.img ${SIZE}G
qemu-system-x86_64 -drive file=box.img,if=virtio,cache=writeback,discard=ignore,format=qcow2 -drive file=$ISO,media=cdrom -name packer-qemu -smp cpus=16,sockets=16 -boot once=d -machine type=pc,accel=kvm -vnc 127.0.0.1:9 -netdev user,id=user.0,hostfwd=tcp::2773-:22 -device virtio-net,netdev=user.0 -m 16384M -display gtk
# Vagrantfile
cat <<EOF> Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.provider :libvirt do |libvirt|
    libvirt.driver = "kvm"
  end
end
EOF
# metadata.json
cat <<EOF> metadata.json
{"provider": "libvirt", "format": "qcow2", "virtual_size": ${SIZE}}
EOF
# box
tar czf $NAME Vagrantfile metadata.json box.img
popd
