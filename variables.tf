variable "hcloud_token" {
  description = "Hetzner Cloud API Token"
  type        = string
  sensitive   = true
}

variable "hcloud_server_name" {
  description = "Hetzner Cloud Server Name"
  type        = string
  sensitive   = false
  default     = "control-plane-node"
}

variable "hcloud_server_image_name" {
  description = "Hetzner Cloud Server Image Name"
  type        = string
  sensitive   = false
  default     = "debian-12"
}

variable "hcloud_server_type_name" {
  description = "Hetzner Cloud Server Type Name"
  type        = string
  sensitive   = false
  default     = "cax11"
}

variable "hcloud_server_location_name" {
  description = "Hetzner Cloud Server location Name"
  type        = string
  sensitive   = false
  default     = "fsn1"
}

variable "ssh_key_name" {
  description = "SSH key name"
  type        = string
  sensitive   = false
  default     = "my-ssh-key"
}
