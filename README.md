# ☁️ AWS Terraform Infrastructure

A production-style, multi-environment AWS infrastructure built entirely with Terraform — provisioned, managed, and deployed through code with zero manual clicking on AWS Console.

---

## 🏗️ Architecture Overview

```
GitHub Push / PR
        ↓
GitHub Actions Pipeline
        ↓
Terraform Init → Plan → Apply
        ↓
┌─────────────────────────────────────┐
│           AWS Infrastructure         │
│                                     │
│  VPC (Private Network)              │
│    └── Public Subnet                │
│         └── EC2 Instance            │
│              └── Spring Boot App    │
│                   (Docker)          │
│  S3 Bucket (App Storage)            │
│  Security Groups (Firewall Rules)   │
└─────────────────────────────────────┘
        ↓
Terraform State → S3 Bucket (Remote Backend)
State Locking   → DynamoDB Table
```

---

## 🔹 Features

- **Modular Infrastructure** — Reusable Terraform modules for VPC, EC2, and S3
- **Multi-Environment** — Separate dev and prod environments from the same codebase
- **Remote State** — Terraform state stored securely in S3 with DynamoDB locking
- **Automated Pipeline** — GitHub Actions runs `terraform plan` on PRs and `terraform apply` on merge
- **Security First** — No hardcoded credentials, least-privilege security groups, encrypted S3 buckets
- **Containerized App** — Spring Boot application runs via Docker on EC2

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| Terraform | Infrastructure as Code |
| AWS VPC | Private Network |
| AWS EC2 | Application Server |
| AWS S3 | Remote State + App Storage |
| AWS DynamoDB | State Locking |
| Docker | Application Containerization |
| GitHub Actions | CI/CD Pipeline |

---

## 📁 Repository Structure

```
aws-terraform-infrastructure/
├── bootstrap/                  # Run once — creates S3 + DynamoDB for remote state
│   └── main.tf
├── modules/                    # Reusable Terraform modules
│   ├── vpc/
│   │   ├── main.tf             # VPC, Subnet, Internet Gateway, Route Table
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ec2/
│   │   ├── main.tf             # EC2 Instance, Security Group, Docker startup
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── s3/
│       ├── main.tf             # App storage bucket with versioning
│       ├── variables.tf
│       └── outputs.tf
├── environments/
│   ├── dev/                    # Dev environment — small, cheap, for testing
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   └── prod/                   # Prod environment — isolated from dev
│       ├── main.tf
│       ├── variables.tf
│       └── terraform.tfvars
├── .github/
│   └── workflows/
│       └── terraform.yml       # GitHub Actions CI/CD pipeline
├── backend.tf                  # Root backend configuration
└── .gitignore
```

---

## 🌍 Multi-Environment Design

The same Terraform modules power both environments — only the variable values differ:

| Config | Dev | Prod |
|--------|-----|------|
| VPC CIDR | 10.0.0.0/16 | 10.1.0.0/16 |
| Subnet | 10.0.1.0/24 | 10.1.1.0/24 |
| Instance Type | t2.micro | t2.micro |
| State File | dev/terraform.tfstate | prod/terraform.tfstate |

This guarantees dev and prod are always built identically — eliminating "works on dev, breaks on prod" issues.

---

## 🔄 CI/CD Pipeline

```
Developer opens PR
        ↓
GitHub Actions triggers automatically
        ↓
terraform init → terraform plan (shows what will change)
        ↓
Team reviews the plan in PR comments
        ↓
PR merged to main
        ↓
terraform apply runs automatically
        ↓
Infrastructure updated on AWS ✅
```

No manual `terraform apply` — every infrastructure change is reviewed and audited through Git.

---

## 🔐 Security

- AWS credentials stored in **GitHub Secrets** — never hardcoded
- Terraform state encrypted at rest in **S3**
- S3 buckets have **public access blocked**
- Security groups follow **least privilege** — only required ports open
- DynamoDB prevents **concurrent state modifications**

---

## 🚀 How to Deploy

### Prerequisites
- AWS Account (Free Tier)
- Terraform installed
- AWS CLI configured

### Step 1 — Bootstrap (run once)
```bash
cd bootstrap
terraform init
terraform apply
```

### Step 2 — Deploy Dev Environment
```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

### Step 3 — Deploy Prod Environment
```bash
cd environments/prod
terraform init
terraform plan
terraform apply
```

### Step 4 — Destroy (to avoid AWS charges)
```bash
terraform destroy
```

