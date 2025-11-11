### 🧩 Understanding Labels in Terraform

In Terraform, a label is the name that identifies a specific block (like a resource, module, or provider) or its instance.

Let’s look at your example and identify the labels:

```bash
resource "aws_s3_bucket" "name" {
    bucket = local.bucket_name
    tags = {
      Name = local.bucket_name
      Enviroment = local.enviroment
    }
}
```
### 🔹 Breaking down the line:
```bash
resource "aws_s3_bucket" "name" { ... }
```

- `resource` → This is the block type. It tells Terraform you’re defining a resource.

- `"aws_s3_bucket"` → This is the first label — it tells Terraform what kind of resource it is (in this case, an AWS S3 bucket).

- `"name"` → This is the second label — it’s the logical name you give this specific resource inside your configuration.

---

### 🧠 Why Labels Are Important

Terraform uses labels to uniquely identify and reference resources.

For example:
```bash
aws_s3_bucket.name.bucket
```

means:

- `aws_s3_bucket` → resource type

- `name` → label (the logical name you gave)

- `bucket` → attribute of that resource

💡 Analogy:
Think of “labels” like file names in folders:

- You can have many “folders” (resources of the same type),

- but each one needs a unique “file name” (label) so Terraform knows which one you mean.

---

### 🧩 Now, about locals

This part of your code:

```bash
locals {
  bucket_name = "mlops-swinal"
  enviroment  = "dev"
}
```

Defines local variables — reusable values you can refer to anywhere in your code.

You can use them with the `local.` prefix:

```bash
bucket = local.bucket_name
```

💡 Why use locals?

- To avoid repeating the same string multiple times.

- To make code cleaner and easier to maintain.

- If you ever change the bucket name or environment, you only update it once in locals.


<image src="..\images\local\S3.png">