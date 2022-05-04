#cloud provider-like containers in proxmox with terraform

dependencies: terraform, proxmox, proxmox-provider (https://registry.terraform.io/providers/Telmate/proxmox/latest/docs)

install terraform:
(https://learn.hashicorp.com/tutorials/terraform/install-cli)

create user and role in proxmox:
```
pveum role add TerraformProv -privs "VM.Allocate VM.Clone VM.Config.CDROM VM.Config.CPU VM.Config.Cloudinit VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Monitor VM.Audit VM.PowerMgmt Datastore.AllocateSpace Datastore.Audit"
pveum user add terraform-prov@pve --password <password>
pveum aclmod / -user terraform-prov@pve -role TerraformProv
```
create token under `Datacenter > Permissions > API Tokens`

clone this repo and initialize init.tf

`/repo/init.tf: terraform init`

now look in example_main.tf, you have two options, either export your pm_api variables as enviroment variables or change the paramaters for your own and paste it into every main.tf file in the `small`, `medium` and `large` folders. Neither of these two are preferred, rather look into vault for storing secrets.

(https://registry.terraform.io/providers/hashicorp/vault/latest/docs)

*enviroment variable:*
`export PM_API_TOKEN_ID="terraform-prov@pve!mytoken"`
`export PM_API_TOKEN_SECRET="afcd8f45-acc1-4d0f-bb12-a70b0777ec11"`

*or paste main.tf:*
```
terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.10" #update for latest version
    }
  }
}

  pm_api_url = "https://1.1.1.1:8006/api2/json"

  pm_api_token_id = "terraform-prov@pam!terraform"

  pm_api_token_secret = "xxxx-xxxx-xxxx-xxxx"

  pm_tls_insecure = true
```

pm_api_url: fqdn or ip of your proxmox instance, if you have several nodes, this is the one that serves your api.

pm_api_token_id: tokenid created in proxmox in the form of user@pam!whateveryounamedyourtoken

pm_api_token_secret: the secret you saved when you created the token

pm_tls_insecure: set this to true if you havent sorted your proxmox certificates, you will know if you have done this.

optional, check if token is valid:
`curl -k -d 'username=terraform-prov@pam!terraform' --data-urlencode 'password=xxxxxxxxx' https://10.0.0.1:8006/api2/json/access/ticket`











