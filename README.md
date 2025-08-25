# kubernetes-the-hard-way-ansible

An Ansible-driven rendition of “Kubernetes The Hard Way” (KTHW).  The original course is here https://github.com/kelseyhightower/kubernetes-the-hard-way 

This repository converts most of the course’s shell commands into idempotent Ansible tasks so you can stand up the lab environment with repeatable playbook runs instead of executing commands manually.

This code was written mainly as a learning exercise for my own use, so there are some assumptions that only work in my lab (eg: jumpbox URL, path to ssh keys etc).  Adjust accordingly for your own use. 

## What this repository does

- Translates the majority of KTHW steps into Ansible, including:
  - Preparing a jumpbox with base tooling (e.g., CLI utilities)
  - Fetching required upstream materials
  - Preparing TLS assets via a local CA for components and nodes
  - Generating kubeconfig files for components and users
  - Downloading Kubernetes binaries needed by the lab
  - Configures SSH on lab nodes and installs an authorized key for root (lab convenience)
  - Applies static routes required by typical lab topologies

Where blocks of shell commands are used exactly as per the original KTHW, this project aims to make them idempotent to avoid re-running unnecessarily.

## Requirements

The project assumes you have provided four Debian 12 (bookworm) hosts as per the "Prerequisites" section:

https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/01-prerequisites.md

Your host running ansible should be able to get to the jumpbox but other hosts are configured using the jumpbox as a proxy. 

## How this maps to “Kubernetes The Hard Way”

This repository aligns with the major phases of the course and turns their shell commands into Ansible tasks. At a high level:
- Tooling and sources: installs prerequisites and retrieves upstream materials on the jumpbox
- TLS and certificates: creates a local CA and signs component/node certificates
- Kubeconfigs: generates the kubeconfig files for components and users
- Binaries: downloads the required Kubernetes component binaries to expected locations

## Configuration notes

- Root SSH login: Tasks enable root login and push an authorized key for lab convenience. This is not recommended for production. Adjust to your policy (e.g., disable, or set `PermitRootLogin prohibit-password`).
- Authorized key: Ensure the public key path you provide exists on the control node. Use placeholders like `/home/<you>/.ssh/<your_key>.pub`.
- Static routes: If your lab requires custom routing, provide variables that your routes template expects (destination CIDRs, next-hops, interfaces).

## Design goals and scope

- Faithful to the KTHW learning path while leveraging Ansible’s idempotency
- Minimal assumptions about your infrastructure—intended for disposable/lab systems
- Avoids copying course content; focuses on automating the same steps

Non-goals:
- Production hardening or cluster lifecycle management
- Abstracting away all learning details; you should still read the course materials

## Security considerations

- Enabling root SSH login is risky; prefer key-based access and non-root users. Restrict to isolated lab environments.
- Do not commit private keys or sensitive artifacts. Store them securely and use placeholders in examples.
- Review all tasks and templates before running them on systems you care about.

## Contributing

- Keep tasks idempotent and aligned with the KTHW flow
- Prefer explicit, readable tasks over opaque shell blocks

## License

MIT
```

