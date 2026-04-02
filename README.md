# AWS Terraform Project: Private EC2 with NAT Gateway

## Description
This project deploys a secure AWS architecture using Terraform where an EC2 instance in a **private subnet**:

- Is NOT accessible from the internet  
- CAN access the internet via a NAT Gateway

- Access to the instance is handled securely using **AWS Systems Manager (Session Manager)** without opening SSH ports.

---

## Architecture

- VPC (10.0.0.0/16)
- Public Subnet (10.0.1.0/24)
- Private Subnet (10.0.2.0/24)
- Internet Gateway
- NAT Gateway (with Elastic IP)
- Public Route Table → Internet Gateway
- Private Route Table → NAT Gateway
- EC2 Instance (Private)
- IAM Role for SSM access

---
##  Security

- No public IP assigned to the private EC2
- No inbound rules for SSH
- Access via **SSM Session Manager**
- IAM Role attached:
  - `AmazonSSMManagedInstanceCore`

