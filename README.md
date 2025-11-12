# 🚀 Terraform Journey

[](https://www.google.com/search?q=LICENSE)
[](https://www.terraform.io/)

This repository is a comprehensive document of my **personal learning path with Terraform**. It's a hands-on collection of experiments, core concepts, design patterns, and real-world **Infrastructure as Code (IaC)** projects, primarily focused on **AWS cloud automation**.

-----

## 📖 Table of Contents

  * [Overview](https://www.google.com/search?q=%23-overview)
  * [Prerequisites](https://www.google.com/search?q=%23-prerequisites)
  * [Journey Outline](https://www.google.com/search?q=%23-journey-outline)
  * [How to Use](https://www.google.com/search?q=%23-how-to-use)
  * [Project]()

-----

## 💡 Overview

The goal of this repository is to systematically learn and demonstrate various Terraform functionalities, from the basics of code syntax and state management to advanced topics like modules, provisioners, and multi-cloud/multi-account setups. Each numbered directory represents a key concept explored in depth.

-----

## 🛠️ Prerequisites

To run the configurations in this repository, you'll need the following installed and configured:

1.  **[Terraform CLI](https://developer.hashicorp.com/terraform/install)**
2.  **[AWS Account](https://aws.amazon.com/)** and **[AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)** (with configured credentials).
3.  **`git`**

-----

## 🗺️ Journey Outline

The repository is structured into sequential folders to follow a logical learning progression.

| Section | Folders | Topics Covered |
| :--- | :--- | :--- |
| **I. Fundamentals** | `[01]-Basic-Code` | Basic HCL syntax, resources, and providers. |
| | `[02]-terraform-setup-files` | Working with variables, outputs, and local files. |
| | `[03]-terraform-statefile` | Understanding and managing the local state file. |
| | `[04]-state-locking` | Implementing remote backend (like S3/DynamoDB) to prevent concurrent state modifications. |
| **II. Core Concepts** | `[05] (Networking, etc.)` | Custom Networking, `lifecycle` rules, and targeting specific resources. |
| | `[06]-import` | Importing existing cloud resources into Terraform state. |
| | `[07]-modules` | Creating and consuming reusable infrastructure modules. |
| | `[10]-Provisioners` | Using `local-exec` and `remote-exec` to execute scripts. |
| **III. Advanced Topics** | `[11]` (Advanced) | Workspace management, `locals` for expressions, `taint` command, IAM, multi-account, and multiple provider configurations. |
| **IV. Resource Examples** | `[08]-RDS` | Deploying a managed Relational Database Service. |
| | `[09]-lambda` | Automating the deployment of AWS Lambda functions. |
| | `[11]-IAM` | Created a custom VPC network, attached an IAM role to an EC2 instance, and configured it with the CloudWatch Agent for monitoring using user data and null resource block. |

-----

## 💻 How to Use

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/Swinalwaghmare/Terraform-journey.git
    cd Terraform-journey
    ```
2.  **Navigate to a specific concept folder:**
    ```bash
    cd [07]-modules 
    # or cd Project/3-Tier-Project
    ```
3.  **Initialize Terraform:**
    ```bash
    terraform init
    ```
4.  **Review the execution plan:**
    ```bash
    terraform plan
    ```
5.  **Apply the configuration:**
    ```bash
    terraform apply
    ```
6.  **Clean up resources (when done):**
    ```bash
    terraform destroy
    ```

-----

## 🏗️ Project

The **`Project/3-Tier-Project`** directory contains a comprehensive example of a real-world architecture.

This project demonstrates deploying a complete application stack, typically consisting of:

  * **Presentation Tier:** Load Balancer and Auto Scaling Group for web servers.
  * **Application Tier:** Private subnets for application servers.
  * **Data Tier:** Private subnets for a managed database (like RDS).
  * Configured **VPC, Subnets, Route Tables, and Security Groups** for secure networking.