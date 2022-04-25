data "terraform_remote_state" "backend" {
  backend = "remote"

  config = {
    organization = "jaware-hc-demos"
    workspaces = {
      name = "demo-backend-multicloud-vpn"
    }
  }
}

