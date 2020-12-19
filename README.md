# harvester-vagrant

## build box
You need to manually press Enter on the grub page
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
