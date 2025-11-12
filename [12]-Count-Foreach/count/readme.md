### 📝 Summary

This Terraform configuration demonstrates the use of the `count` **meta-argument** to create multiple AWS EC2 instances dynamically from a **list variable**.

- A variable `env` holds a list of environment names: `["dev", "prod", "test"]`.

- The resource block uses `count = length(var.env)` to create **one EC2 instance per environment**.

- Each instance gets a unique tag `(Name = var.env[count.index])` — resulting in instances named **dev, prod,** and **test**.

- This approach enables **scalable and repeatable deployments** — simply updating the list automatically increases or decreases the number of instances.

💡 **In short**:
Terraform loops through the environment list and provisions **multiple EC2 instances**, each uniquely tagged based on its environment name.

<image src="..\..\images\Count\count.png">