#!/bin/bash

sudo rc-update add k3s-service default
sudo rc-update add ccapply default

/k3os/system/k3os/current/k3os config
sudo rc-service k3s-service restart
sudo rc-service sshd restart
