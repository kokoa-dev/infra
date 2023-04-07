# kokoa-home

```
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img -O ubuntu-22.04-server-cloudimg-amd64.img
# Base VM configuration
qm create 9100 --net0 virtio,bridge=vmbr0
qm importdisk 9100 ubuntu-22.04-server-cloudimg-amd64.img local-lvm
qm set 9100 --name ubuntu-22.04a
qm set 9100 --scsihw virtio-scsi-pci --virtio0 local-lvm:vm-9100-disk-0
qm set 9100 --boot order=virtio0
qm set 9100 --ide2 local-lvm:cloudinit
qm set 9100 --nameserver 192.168.0.1 --searchdomain example.com
# Convert VM to VM Template
qm template 9100
```