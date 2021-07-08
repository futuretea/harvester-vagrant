# harvester-vagrant

## clone repo

```bash
git clone -b dev https://github.com/futuretea/harvester-vagrant.git
cd harvester-vagrant
```

## download iso
Download iso from https://github.com/futuretea/harvester-autobuild/releases

## build box
```bash
./build-box.sh harvester-dev.box ./harvester-amd64.iso
```

## add box
```bash
sudo vagrant box add harvester-dev ./output-qemu/harvester-dev.box
```

## define network
```bash
sudo virsh net-define --file network.xml
```

## up harvester cluster
```bash
sudo vagrant up
```
