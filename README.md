# Azure Enterprise Landing Zones

Production-grade Terraform framework implementing Microsoft Cloud Adoption Framework (CAF) with Hub-and-Spoke network topology, Privileged Identity Management (PIM), and Azure Policy guardrails.

## Architecture

```
Root Management Group
├── Platform
│   ├── Connectivity (Hub VNet, Firewall, ExpressRoute)
│   ├── Identity (Entra ID, PIM, Key Vault)
│   └── Management (Log Analytics, Monitor, Defender)
└── Landing Zones
    ├── Corp (Private workloads via Hub)
    └── Online (Public-facing workloads)
```

## Features
- Hub-and-Spoke topology with Azure Firewall Premium (TLS inspection)
- Terraform parent/child module design with remote state
- CIS Azure Benchmark v2.0 enforcement via Checkov
- GitHub Actions CI/CD with plan/apply gates
- Infracost PR budget enforcement

## Quick Start

```bash
cd landing-zones/platform
terraform init -backend-config=backend.conf
terraform plan -var-file=terraform.tfvars
```

## CI/CD Pipeline
Push to `main` → Auto plan on PR → Manual approve → Apply
