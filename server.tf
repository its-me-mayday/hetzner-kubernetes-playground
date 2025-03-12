resource "hcloud_server" "controlplane" {
  name        = var.hcloud_server_name
  image       = var.hcloud_server_image_name
  server_type = var.hcloud_server_type_name
  location    = var.hcloud_server_location_name
  ssh_keys    = [hcloud_ssh_key.ssh_public_key.name]

  network {
    network_id = hcloud_network.k8s_network.id
    ip         = "10.0.0.2"
  }

  firewall_ids = [hcloud_firewall.controlplane_fw.id]

  depends_on = [hcloud_ssh_key.ssh_public_key, hcloud_firewall.controlplane_fw]
}
