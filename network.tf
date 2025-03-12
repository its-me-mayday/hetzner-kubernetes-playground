resource "hcloud_network" "k8s_network" {
  name     = "k8s-private-network"
  ip_range = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "k8s_subnet" {
  network_id   = hcloud_network.k8s_network.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = "10.0.0.0/24"
}

resource "hcloud_firewall" "controlplane_fw" {
  name = "k8s-controlplane-fw"

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "6443"
    source_ips = [
      "0.0.0.0/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "179"
    source_ips = [
      hcloud_network.k8s_network.ip_range
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "5473"
    source_ips = [
      hcloud_network.k8s_network.ip_range
    ]
  }
}
