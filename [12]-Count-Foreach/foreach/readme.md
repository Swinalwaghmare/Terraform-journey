### 📝 Summary

This Terraform configuration demonstrates the use of the `for_each` **meta-argument**, a powerful and flexible way to create multiple AWS resources dynamically.

- A variable `env` holds a list of environments: `["dev", "prod", "test"]`.

- Using `for_each = toset(var.env)`, Terraform loops through each value in the list and creates **one EC2 instance per environment**.

- Inside the resource, `each.value` represents the current environment, allowing unique tagging like `env-dev`, `env-prod`, and `env-test`.

- Unlike `count`, `for_each` identifies resources by **name (key)** rather than **index**, making infrastructure changes safer and easier to track.

💡 **In short**:
Terraform uses `for_each` to create clearly labeled, environment-specific EC2 instances — making your deployments more readable, scalable, and resilient to list order changes.

<image src="..\..\images\for-each\for-each.png">
