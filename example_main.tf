provider "proxmox" {
  pm_api_url = "https://1.1.1.1:8006/api2/json"

  pm_api_token_id = "terraform-prov@pam!terraform"

  pm_api_token_secret = "xxxx-xxxx-xxxx-xxxx"

  pm_tls_insecure = true

  }
