# harvester-vagrant

## clone repo

```bash
git clone -b dev https://github.com/futuretea/harvester-vagrant.git
cd harvester-vagrant
```

## build iso
```bash
git clone -b box https://github.com/futuretea/harvester-installer.git harvester-installer-box
make -C harvester-installer-box
```

## build box
```bash
./build-iso.sh harvester-dev.box ./harvester-installer-box/dist/artifacts/harvester-amd64.iso
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
