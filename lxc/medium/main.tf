provider "proxmox" {
  pm_api_url = "https://1.1.1.1:8006/api2/json"

  pm_api_token_id = "terraform-prov@pam!terraform"

  pm_api_token_secret = "xxxx-xxxx-xxxx-xxxx"

  pm_tls_insecure = true

  }

resource "proxmox_lxc" "flavor_medium" {
  target_node  = "pve"
  count        = 1
  hostname     = "lxc-medium-${count.index + 1}"
  ostemplate   = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
  unprivileged = true
  ostype       = "ubuntu"

  //flavor
  cores = 2
  memory = "2048"
  swap = "512"
  start = true


  ssh_public_keys = <<-EOT
    ssh-rsa <public_key_1> user@example.com
  EOT

  rootfs {
    storage = "local-lvm"
    size    = "20G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
    ip6    = "dhcp"
  }
}