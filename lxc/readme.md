first we need an image to work with.

open a shell on your pve node (if clustered, the one that hosts your lxc containers), this can be done through shell access in the webinterface also.

` pveam update `

` pveam available `

` pveam download local ubuntu-21.04-standard_21.04-1_amd64.tar.gz `

` pveam list local `

Now given that you have terraform installed, your keys, users and roles setup and downloaded this repo and run terraform init on the init file, your all set to:

**change the main.tf provider settings**

**cd into small, medium or large folder and run:** `terraform apply`