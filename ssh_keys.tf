resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  filename        = "${path.module}/.ssh/hetzner_k8s_id_rsa"
  content         = tls_private_key.ssh_key.private_key_openssh
  file_permission = "0600"

  depends_on = [tls_private_key.ssh_key]
}

resource "hcloud_ssh_key" "ssh_public_key" {
  name       = var.ssh_key_name
  public_key = tls_private_key.ssh_key.public_key_openssh

  depends_on = [tls_private_key.ssh_key]
}
