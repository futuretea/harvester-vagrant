# harvester-vagrant

## build libvirt box with packer
You need to manually press Enter twice on the grub page
```bash
sudo packer build ./template.json
```

## define network
```bash
sudo virsh net-define --file network.xml
```

## up box
```bash
sudo vagrant up
```
