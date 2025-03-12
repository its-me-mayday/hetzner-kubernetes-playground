output "server_ip" {
  value = hcloud_server.controlplane.ipv4_address
}

output "ssh_public_key" {
  value = hcloud_ssh_key.ssh_public_key.public_key
}

output "kubeconfig" {
  value     = "scp root@${hcloud_server.controlplane.ipv4_address}:/etc/kubernetes/admin.conf ./kubeconfig"
  sensitive = true
}

output "join_command" {
  value     = "ssh root@${hcloud_server.controlplane.ipv4_address} 'kubeadm token create --print-join-command'"
  sensitive = true
}
