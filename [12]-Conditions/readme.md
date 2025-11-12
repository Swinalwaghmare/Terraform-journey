## Validation

### 📝 Terraform – AWS Region Variable and S3 Bucket Creation

### 📌 Overview

This Terraform configuration demonstrates how to:

* Define and validate AWS region variables
* Configure the AWS provider
* Dynamically name an S3 bucket using the selected region

### ⚙️ Example 1 : How It Works

1. **Variable Definition (`aws_region`)**

   * Accepts only `"us-east-1"` or `"eu-west-1"` as valid values.
   * Defaults to `"us-east-1"` if no value is provided.
   * Ensures invalid regions trigger a Terraform validation error.
    <image src="..\images\Conditions\ex1-error.png">

2. **Provider Configuration**

   * Specifies which AWS region Terraform uses to deploy resources.
   * Currently hard-coded to `"us-west-2"`, meaning all resources are created in that region.

3. **S3 Bucket Resource**

   * Creates an S3 bucket named dynamically based on the selected region:

     ```
     mlops-swinal-${var.aws_region}
     ```
   * Example: if `aws_region = "us-east-1"`, the bucket name becomes `mlops-swinal-us-east-1`.

---

### ⚠️ Note

Even though the bucket name includes the region (`us-east-1` or `eu-west-1`), the **actual deployment region** is determined by the AWS provider (`us-west-2` in this case).
To deploy in the selected region, update the provider block to:

```hcl
provider "aws" {
  region = var.aws_region
}
```

---

### ✅ Summary

| Component               | Purpose                                        |
| ----------------------- | ---------------------------------------------- |
| `variable "aws_region"` | Defines and validates allowed AWS regions      |
| `provider "aws"`        | Configures which region Terraform connects to  |
| `aws_s3_bucket`         | Creates a bucket with the region name embedded |

---

### 💡 Example Usage

```bash
terraform init
terraform plan -var="aws_region=eu-west-1"
terraform apply
```

This will create a bucket named `mlops-swinal-eu-west-1` in your selected region.

<image src="..\images\Conditions\ex1-s3.png">


## 📝 Terraform – Conditional Resource Creation Examples
### 📌 Overview

These examples demonstrate how to use conditional expressions `(? :)` and `count` in Terraform to control when and how many resources are created dynamically.

### ⚙️ Example 2 – Conditional S3 Bucket Creation
```bash
variable "create_bucket" {
  type    = bool
  default = true
}

resource "aws_s3_bucket" "name" {
  count  = var.create_bucket ? 1 : 0
  bucket = "mlops-swinal"
}
```

**Explanation**:

- Uses a boolean variable create_bucket to decide whether to create an S3 bucket.

- If create_bucket = true → Terraform creates 1 bucket. 
  <image src="..\images\Conditions\ex2-s3.png">

- If create_bucket = false → Terraform creates 0 buckets (skips creation).
  <image src="..\images\Conditions\ex2-skip.png">

- This pattern is useful for optional resources (e.g., enable/disable based on environment).



### ⚙️ Example 3 – Conditional EC2 Instance Count
```bash
variable "environment" {
  type    = bool
  default = true
}

resource "aws_instance" "name" {
  count         = var.environment == "prod" ? 3 : 1
  ami           = "ami-0cae6d6fe6048ca2c"
  instance_type = "t2.micro"

  tags = {
    Name = "example-${count.index}"
  }
}
```

**Explanation**:

- Uses a conditional count to create a different number of EC2 instances depending on the environment.

- If `environment == "prod"` → creates **3 EC2 instances**.

- Otherwise → creates **1 EC2 instance**.

- Each instance gets a unique tag (`example-0`, `example-1`, etc.).

<image src="..\images\Conditions\ex3-0.png">


### ⚠️ The issue


Right now, your variable is declared as a boolean, but your conditional is checking:

```bash
var.environment == "prod"
```


That’s comparing a boolean (true) to a string ("prod") → ❌ invalid comparison.

Terraform will throw:
```
Error: Invalid operation
│  var.environment is boolean, but string is required
```

### ⚙️ Example 4 - Conditional EC2 Instance Creation

- A variable named environment defines the environment type (e.g., prod, dev).

- The count meta-argument uses a conditional expression to decide:
    - If the environment is prod → create 3 instances
      <image src="..\images\Conditions\ex-4.png">

    - Otherwise → create 1 instance
      <image src="..\images\Conditions\ex3-0.png">

- Each EC2 instance is tagged uniquely using the built-in variable count.index.

### 🧩 Example Behavior
| Variable Value | Instances Created | Tag Names                       |
| -------------- | ----------------- | ------------------------------- |
| `prod`         | 3                 | example-0, example-1, example-2 |
| `dev`          | 1                 | example-0                       |



### ✅ Key Concepts
| Concept       | Description                                          |
| ------------- | ---------------------------------------------------- |
| `count`       | Determines how many copies of a resource to create   |
| `count.index` | Gives the current instance’s index (0, 1, 2...)      |
| `? :`         | Terraform’s conditional operator (if-else shorthand) |
| `tags`        | Used to assign unique names to each EC2 instance     |
