# ☁️ Healix Infrastructure | AWS 3-Tier Architecture

## Overview

**Healix Infrastructure** is a fully automated, production-ready infrastructure built using **Terraform**. It provisions a highly available, secure, and scalable **3-Tier Architecture** on AWS to host the Healix web application.

The project follows DevOps best practices, including **modularity**, **state management**, and **least privilege security**.

---

## Architecture Design

<img width="2816" height="1536" alt="Cloud Architecture" src="https://github.com/user-attachments/assets/926027d5-cedd-4183-9ca2-1748e2192df1" />

### Key Components

| Layer | Component | Description |
| :--- | :--- | :--- |
| **Network** 🌐 | **VPC & Subnets** | Custom VPC with public & private subnets across 2 Availability Zones (Multi-AZ) for high availability. |
| **Security** 🛡️ | **Security Groups** | Strict firewall rules ensuring only necessary ports are open (e.g., HTTP/S for LB, SQL for DB). |
| **Compute** 💻 | **EC2 & Auto Scaling** | Auto Scaling Group (ASG) ensures the app scales out/in based on traffic load. |
| **Load Balancing** ⚖️ | **Application Load Balancer** | Distributes incoming traffic across healthy instances in multiple AZs. |
| **Database** 🗄️ | **RDS SQL Server** | Managed Relational Database with **Multi-AZ** enabled for failover and redundancy. |
| **CDN / Edge** 🌍 | **CloudFront** | Content Delivery Network to cache static content and reduce latency for global users. |

---

## 📂 Project Structure

```bash
healix-infrastructure/
├── modules/
│   ├── vpc/          # Network configuration (IGW, NAT, Route Tables)
│   ├── security/     # Security Groups & Rules
│   ├── database/     # RDS SQL Server configuration
│   ├── compute/      # EC2, Launch Templates, ASG, ALB
│   └── edge/         # CloudFront Distribution
├── main.tf           # Root module integrating all components
├── variables.tf      # Global variables
├── outputs.tf        # Important outputs (ALB DNS, CloudFront URL)
└── provider.tf       # AWS Provider setup
```

---

## 🛠️ Prerequisites

Before you begin, ensure you have the following installed:

- **Terraform** (v1.0+)
- **AWS CLI** (Configured with `aws configure`)

---

## 🚀 How to Deploy

### 1. Clone the Repository

```bash
git clone https://github.com/MostafaSaad21/healix-infrastructure.git
cd healix-infrastructure
```

### 2. Initialize Terraform

Downloads the necessary providers and initializes the backend.

```bash
terraform init
```

### 3. Plan the Deployment

Preview the resources that will be created.

```bash
terraform plan
```

### 4. Apply Changes

Provision the infrastructure on AWS.

```bash
terraform apply --auto-approve
```

---

## 🧹 Cleanup

To destroy all resources and avoid AWS charges:

```bash
terraform destroy --auto-approve
```