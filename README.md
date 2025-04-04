# Deploying a Highly Available Web Application with Auto Scaling and S3 Backup

## Scenario:
This repository contains the Terraform configuration for deploying a **highly available web application** on AWS, which includes the following features:

- **Application Load Balancer (ALB)** distributing traffic across instances in an **Auto Scaling Group (ASG)**.
- A **bastion host** for SSH access to private instances.
- **S3 backup storage** for data backups.
- Secure network configurations using **public and private subnets** with a **NAT Gateway** for outbound internet access from private instances.

---

## Objective:
The goal is to deploy a highly available web application on AWS using Terraform. The infrastructure includes:

- An ALB to distribute traffic.
- Auto Scaling for dynamic scaling of EC2 instances.
- A bastion host for secure SSH access to private instances.
- S3 storage for backups.
- Secure networking through public and private subnets.

---

## Infrastructure Setup:

### 1. AWS Provider:
- Configured to deploy resources in the `us-east-1` region.

### 2. VPC and Subnets:
- A **VPC** with CIDR block `192.168.0.0/16` is created.
- Four **subnets**:
  - **Public Subnets**: For resources like ALB and bastion host.
  - **Private Subnets**: For the EC2 instances in the Auto Scaling Group (ASG).

### 3. Internet Gateway & NAT Gateway:
- **Internet Gateway**: Provides public internet access for the public subnets.
- **NAT Gateway**: Provides outbound internet access to private instances via the NAT gateway located in the public subnet.

### 4. Security Groups:
- **ALB and EC2 Instances Security Group**: Allows inbound HTTP (port 80) and SSH (port 22) traffic from the internet.
- **Bastion Host Security Group**: Allows SSH access, enabling the management of private instances through the bastion host.

### 5. Application Load Balancer (ALB):
- The **ALB** listens on **port 80** and forwards traffic to an **Auto Scaling Group (ASG)** through a **target group**.
- Health checks are performed on the  path `/home/ec2-user/index.html` to ensure instance availability.

### 6. Auto Scaling Group (ASG):
- The **ASG** dynamically scales the number of instances between **1 to 3**, ensuring high availability.
- Each EC2 instance hosts a simple Python web server that serves a "Hello, World" page.
- The **ASG** is configured to use an **EC2 Launch Configuration**, which installs necessary software (e.g., Python).

### 7. Bastion Host:
- A **bastion host** (EC2 instance) is deployed in the public subnet to securely SSH into private EC2 instances.
- Users upload an SSH key to the bastion host to enable SSH access to private instances.

### 8. IAM Roles and S3 Integration:
- An **IAM role** is assigned to EC2 instances, allowing them to interact with an **S3 bucket**.
- The EC2 instances can **read and write** to the `S3 bucket` bucket for backup or other storage purposes.

### 9. Private Subnet EC2 Access and Internet Connectivity:
- **SSH access** is established from the bastion host to instances in private subnets.
- **Private instances** can connect to the internet via the **NAT Gateway** to download necessary software and updates.

---

## How to Deploy:

1. **Initialize Terraform**:
   Run the following command to initialize your Terraform working directory:
   ```bash
   terraform init
   ```

2. **Review the Execution Plan**:
   You can check what Terraform will do before applying it by running:
   ```bash
   terraform plan
   ```

3. **Apply the Configuration**:
   Deploy the infrastructure by running:
   ```bash
   terraform apply
   ```

4. **Access the Application**:
   After successful deployment, use the **ALB DNS name** to access the application in your browser.

5. **Connect via Bastion Host**:
   SSH into the bastion host and then connect to private EC2 instances to confirm that configuration is done properly.

6. **Check outbound traffic**
   `ping google.com` after SSH to the private EC2 to confirm it's conncted to th internet properly through the NGW.   

---
