variable "vms" {
  description = "A map of VMs to create"
  type = map(object({
    username = string
    public_key = string
    cores = number
    memory = number
    disk_size = number
    ip_address = string
  }))
}

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

resource "proxmox_vm_qemu" "kube-vm" {
  for_each = var.vms

  name = "vm-${each.key}"
  target_node = "prox1"
  clone = "ubuntu-20.04a"
  os_type = "cloud-init"
  boot = "order=virtio0"
  cores   = each.value.cores
  memory  = each.value.memory
  disk {
    storage = "local-lvm"
    type = "virtio"
    size = "${each.value.disk_size}G"
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
    firewall = false
  }
  ipconfig0 = "ip=${each.value.ip_address}/24,gw=192.168.10.1"
  ciuser = each.value.username
  sshkeys = each.value.public_key
}