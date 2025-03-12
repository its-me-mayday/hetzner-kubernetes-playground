# Hetzner Kubernetes Playground

Using `opentofu` we can build a simple controlplane node on Hetzner Cloud;

## Getting Started
You must have:
- an account on:
  - hetzner (for cloud perspective).

## Configure
In root project, create a `.tfvars` file in this way:

```tfvars
hcloud_token=<hetzner-api-token>
```

## Usage
In root project:

```bash
$ make init
$ make plan
$ make apply
```

## Utility
- delete `known_hosts`: `ssh-keygen -f '~/.ssh/known_hosts' -R 'cloudflare_domain_name'`
