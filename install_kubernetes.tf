resource "null_resource" "install_kubernetes" { 
  connection {
    type        = "ssh"
    user        = "root"
    host        = hcloud_server.controlplane.ipv4_address
    private_key = file("./.ssh/hetzner_k8s_id_rsa")
  }

  provisioner "remote-exec" {
 inline = [
      # Disable swap & configure kernel
      "swapoff -a",
      "sed -i '/ swap / s/^/#/' /etc/fstab",
      "modprobe br_netfilter",
      "echo 'br_netfilter' | tee /etc/modules-load.d/br_netfilter.conf",
      
      # Configure sysctl
      "echo 'net.bridge.bridge-nf-call-iptables = 1' | tee /etc/sysctl.d/k8s.conf",
      "echo 'net.ipv4.ip_forward = 1' | tee -a /etc/sysctl.d/k8s.conf",
      "sysctl --system",

      # Install container runtime (containerd)
      "apt-get update",
      "apt-get install -y containerd",
      "mkdir -p /etc/containerd",
      "containerd config default | tee /etc/containerd/config.toml",
      "sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml",
      "systemctl restart containerd",
      "systemctl enable containerd",

      # Install Kubernetes components
      "curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg",
      "echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' > /etc/apt/sources.list.d/kubernetes.list",
      "apt-get update",
      "apt-get install -y kubelet=1.28.15-1.1 kubeadm=1.28.15-1.1 kubectl=1.28.15-1.1",
      "apt-mark hold kubelet kubeadm kubectl",

      # Init cluster
     "kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=${hcloud_server.controlplane.ipv4_address} --control-plane-endpoint=${hcloud_server.controlplane.ipv4_address}",

      # Configure root access
      "mkdir -p /root/.kube",
      "cp /etc/kubernetes/admin.conf /root/.kube/config",
      "chown -R root:root /root/.kube",

      # Install Calico CNI
      "kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml",
      "kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml",

      # Check installation
      "sleep 30",
      "kubectl get nodes",
      "kubectl get pods -n kube-system"
    ]  
  }
}
