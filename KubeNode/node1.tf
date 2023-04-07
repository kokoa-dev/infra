terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.11"
    }
  }
}

provider "proxmox" {
  pm_api_token_id = "root@pam!qiita-sample"
  pm_api_token_secret = "fe8414cd-75b2-404c-a7bc-75b0940df13b"
  pm_api_url = "https://192.168.10.81:8006/api2/json"
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "kube_node_prox_0" {
  name = "KubeProx0"
  target_node = "prox1"
  clone = "ubuntu-22.04a"
  os_type = "cloud-init"
  boot = "order=virtio0"
  cores   = "4"
  memory  = "8192"
  disk {
    storage = "local-lvm"
    type = "virtio"
    size = "60G"
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
    firewall = false
  }
  ipconfig0 = "ip=192.168.10.61/24,gw=192.168.10.1"
  ciuser = "neo"
  sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAlgiMt4kQhpbEgsjDBQIEqGVjzW73Dt8mRETtbRYAbZN1oS/8NMmO06p6bb2+7bsEfMJpWjjhTaqp8NiEg2bHPj64XKZb/XZQf8MszrYmEs1cYDpG25Ue8+t/qOG38PEQBHE/vKy39uEZ6K61oqOQmniXXaW7zfce/64AGx11lCYwaufVtRHe3I5EEm/DNNUTd6Jq/cszR2/fomM03JMyrqSirfuVSPIPJtqzv3J4QY+/zomqdkM187vp855jXXh+Dwaf+bgZ2S471qjlTYDaitkEjJow1Ufz67eGqKcJKboKGz205sWLMN2ftpdAeXQXlWVGESbxZz+G4lMTwWWMdQ== kokoa@DESKTOP-H9BFNSU
EOF

}