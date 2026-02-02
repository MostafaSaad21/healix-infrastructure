# 🏥 Healix Medical Infrastructure (IaC)


## 📖 Overview
**Healix Infrastructure** is a fully automated, HIPAA-compliant cloud environment designed to host a critical .NET Medical Application. Built with **Terraform**, this project provisions a generic 3-Tier Architecture on AWS focusing on **High Availability (HA)** and **Security**.

---

## 🏗️ Architecture Design

### 1. Network Layer (VPC) 🌐
* **Isolation:** Public & Private Subnets across **2 Availability Zones**.
* **Gateways:** NAT Gateway for secure outbound traffic from private instances.

### 2. Compute Layer (App Tier) 💻
* **Load Balancing:** Application Load Balancer (ALB) to distribute traffic.
* **Auto Scaling:** EC2 Auto Scaling Group to handle traffic spikes automatically.
* **CDN:** AWS CloudFront with WAF integration for edge security and caching.

### 3. Data Layer (Persistence) 🗄️
* **Engine:** Microsoft SQL Server Standard Edition.
* **High Availability:** Deployed with **Multi-AZ** enabled (Synchronous replication to a standby instance in a different zone).
* **Security:** Isolated in private subnets with strict Security Group rules.

---

## 🚀 How to Deploy

### Prerequisites
1.  Terraform v1.5+ installed.
2.  AWS CLI configured with appropriate credentials.

### Deployment Steps
1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/YOUR_USERNAME/healix-infrastructure.git](https://github.com/YOUR_USERNAME/healix-infrastructure.git)
    cd healix-infrastructure
    ```

2.  **Configure Secrets:**
    Create a `terraform.tfvars` file (do not commit this):
    ```hcl
    db_username = "admin"
    db_password = "YourStrongPassword123!"
    project_name = "healix-medical"
    ```

3.  **Apply Infrastructure:**
    ```bash
    terraform init
    terraform apply
    ```

---
