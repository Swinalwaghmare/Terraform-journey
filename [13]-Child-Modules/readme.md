

# 📘 Terraform — Modular VPC, EC2, and RDS Architecture (Summary)

This Terraform setup uses a clean, production-ready **modular architecture** to provision:

* A complete **VPC networking layer**
* One or more **EC2 instances** running inside that VPC
* An **RDS database** placed inside private subnets

Each component lives inside its own module, and the root module connects everything using module outputs and variables.

---

## 🧩 Architecture Overview

```
Root Module
   │
   ├── VPC Module
   │     ├── Creates VPC
   │     ├── Creates public & private subnets
   │     ├── (Optional) route tables, IGW, NAT
   │     └── Outputs subnet IDs
   │
   ├── EC2 Module
   │     ├── Receives public_subnet_id from VPC
   │     ├── Creates EC2 instance(s)
   │     └── Applies correct SG + user-data (if provided)
   │
   ├── RDS Module
   │      ├── Receives private_subnet_ids from VPC
   │      ├── Creates DB subnet group
   │      │
   │      └── Deploys RDS instance
   │
   └── main.tf
```

The root module orchestrates these modules to build a fully functional application environment.

---

# 🏗️ VPC Module

### **Responsibilities**

* Creates the VPC
    <image src="..\images\child-modules\VPC.png">

* Creates multiple subnets (public + private)
    <image src="..\images\child-modules\Subnet.png">
* Spreads subnets across AZs
* Outputs subnet IDs for other modules

### **Key Outputs**

```hcl
public_subnet_ids
private_subnet_ids
vpc_id
```

These are consumed by the EC2 and RDS modules.

---

# 🏗️ EC2 Module

### **Responsibilities**

* Creates EC2 instances inside the VPC
* Uses **DB subnets** for EC2s (bastion, web server, etc.)
<image src="..\images\child-modules\EC2.png">


### **Inputs**

```hcl
subnet_id = module.vpc.public_subnet_ids[0]
```

### **Outputs**

(Optional)

* EC2 public IP
* EC2 private IP
* EC2 instance ID

This makes the EC2 module completely reusable.

---

# 🏗️ RDS Module

### **Responsibilities**

* Accepts private subnet IDs from VPC
* Creates a DB subnet group
    <image src="..\images\child-modules\DB-Subnet-Group.png">
* Deploys RDS instance inside **private subnets**
    <image src="..\images\child-modules\DB.png">
* Applies security groups for DB access

### **Inputs**

```hcl
subnet_ids = module.vpc.private_subnet_ids
```

### **Outputs**

* RDS endpoint
* DB subnet group name

---

# 🔗 Root Module – Connecting Everything

The root module wires all modules together:

```hcl
module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source     = "./modules/ec2"
  subnet_id  = module.vpc.public_subnet_ids[0]
}

module "rds" {
  source      = "./modules/rds"
  subnet_ids  = module.vpc.private_subnet_ids
}
```

Terraform automatically ensures that:

1. VPC and subnets are created first
2. EC2 and RDS modules run after subnet outputs are available

No manual `depends_on` required — outputs enforce the dependency graph.

---

# 🎯 Why This Architecture Is Strong

### ✔️ Highly reusable

Each module (VPC, EC2, RDS) can be reused in dev/stage/prod by simply changing variables.

### ✔️ Clean separation of responsibilities

* VPC = networking
* EC2 = compute
* RDS = database

### ✔️ Scales well

You can easily add autoscaling, load balancers, NAT gateways, or additional RDS replicas.

### ✔️ Safe and maintainable

Modules expose only what is needed (like subnet IDs), keeping infrastructure clean and predictable.

---

# 🟢 Summary (One Paragraph)

This Terraform design follows a clean module-based structure where the **VPC module** generates networking resources and subnet IDs, the **EC2 module** deploys compute instances inside public subnets, and the **RDS module** builds a DB subnet group and RDS instance inside private subnets. The root module links them together using outputs, creating a scalable, reusable, and production-grade infrastructure layout.


