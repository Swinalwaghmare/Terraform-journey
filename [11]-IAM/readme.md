## 📝 Summary

This Terraform project provisions a complete AWS environment consisting of networking, security, IAM roles, and an EC2 instance configured with CloudWatch monitoring.

### 1️⃣ network.tf

- Sets up the networking foundation for the infrastructure.

- Creates:

    - A **VPC** with CIDR block `10.0.0.0/16`

    - A **public subnet** in `us-east-1a`

    - An **Internet Gateway (IGW)** for outbound internet access

    - A **Route Table** with a route to the IGW

    - Associates the route table with the subnet

- 💡 *Purpose*: Provides the network environment where other AWS resources (like EC2) will reside.

---

### 2️⃣ sg.tf (Security Group)

- Creates a **security group** named `EC2-Connection`.

- Allows **SSH (port 22)** access from anywhere (`0.0.0.0/0`).

- Allows **all outbound traffic** for updates or internet communication.

- 💡 Purpose: Defines firewall rules that control inbound and outbound traffic for the EC2 instance.

---


### 3️⃣ iam-role.tf (IAM Role and Permissions)

- Creates an IAM Role for the EC2 instance with the name **EC2-CloudWatch**.

- Grants permissions using two attached AWS managed policies:

    - `CloudWatchAgentServerPolicy` → Allows EC2 to send logs and metrics to CloudWatch.

    - `AdministratorAccess` → Provides full administrative privileges (use carefully).

- Creates an **IAM Instance Profile** that links the role to the **EC2 instance**.

- 💡 *Purpose*: Enables the EC2 instance to securely communicate with AWS services (like CloudWatch) without using access keys.

---


### 4️⃣ ec2.tf (Compute Instance Setup)

- Launches an **EC2 instance** in the created subnet (`t2.micro` type).

- Associates it with:

    - The **security group** for SSH access

    - The **IAM role** via the instance profile

    - A **public IP** for external connectivity

- Uses user data to automatically install the **CloudWatch agent** on startup.

- Copies a configuration file (`config.json`) to the instance and starts the agent.

- 💡 *Purpose*: Deploys a monitored EC2 instance that reports metrics to CloudWatch for visibility.

---

### 🧠 Overall Purpose

- This setup demonstrates a **complete and minimal AWS infrastructure** for running an EC2 instance with:

- Proper **networking (VPC, subnet, routing)**

- **Secure access (Security Group)**

- **Monitoring (CloudWatch integration)**

- **Role-based permissions (IAM Role and Profile)**

---
### EC2
<image src="..\images\IAM\EC2.png">

### CloudWatch
<image src="..\images\IAM\cloudwatch.png">

---