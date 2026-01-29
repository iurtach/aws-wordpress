# AWS High Availability WordPress (Terraform)

This project automates the deployment of a fault-tolerant, scalable 3-tier WordPress architecture on AWS using **Terraform**.

## 🏗 Infrastructure as Code (IaC)

Unlike manual setups, this infrastructure is defined entirely in code, ensuring consistency, version control, and rapid disaster recovery.

### Architecture Components
* **Compute:** Auto Scaling Group (ASG) with Amazon Linux 2023 instances.
* **Networking:** Custom VPC with Public/Private subnets, NAT Gateway, and Internet Gateway.
* **Storage:**
    * **Amazon EFS:** Shared file system for WordPress files (mounted via TLS).
    * **Amazon RDS:** Managed MySQL database for data persistence.
* **Traffic Management:** Application Load Balancer (ALB) with Target Groups.
* **Security:** Strictly scoped Security Groups (Chaining methodology).

## 📂 Project Structure

* `network.tf` - VPC, Subnets, Gateways, Route Tables.
* `compute.tf` - EC2 Launch Templates, ASG, Load Balancer.
* `database.tf` - RDS MySQL & EFS File System.
* `security.tf` - Security Groups firewall rules.
* `variables.tf` - Configurable parameters (Region, CIDR, etc.).
* `outputs.tf` - Useful outputs (ALB DNS URL, DB Endpoint).
* `user_data.sh` - Bash script for automated server provisioning.

## 🚀 How to Deploy

### 1. Prerequisites
* [Terraform](https://www.terraform.io/) installed.
* [AWS CLI](https://aws.amazon.com/cli/) configured with valid credentials.

### 2. Initialization
Initialize Terraform to download the AWS provider:
```bash
terraform init
