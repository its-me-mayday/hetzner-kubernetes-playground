output "server_ip" {
  value = hcloud_server.frontend_server.ipv4_address
}

output "ssh_public_key" {
  value = hcloud_ssh_key.ssh_public_key.public_key
}
