# harvester-vagrant

## build box
```bash
./build-iso.sh harvester-dev.box ./harvester-amd64.iso
```

## add box
```bash
sudo vagrant box add harvester-dev harvester-dev.box
```

## define network
```bash
sudo virsh net-define --file network.xml
```

## up box
```bash
sudo vagrant up
```
