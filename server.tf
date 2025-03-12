resource "hcloud_server" "frontend_server" {
  name        = var.hcloud_server_name
  image       = var.hcloud_server_image_name
  server_type = var.hcloud_server_type_name
  location    = var.hcloud_server_location_name
  ssh_keys    = [hcloud_ssh_key.ssh_public_key.name]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }

  depends_on = [hcloud_ssh_key.ssh_public_key]
}
