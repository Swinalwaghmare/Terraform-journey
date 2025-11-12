### 📝 Summary

This Terraform resource uses a **for-expression** to dynamically generate multiple ingress (incoming) rules inside a single AWS Security Group. Instead of repeating identical `ingress` blocks, the code loops over a list of ports and builds an ingress object for each port (22, 89, 443, 8080, 9000, 3000, 8082, 8081, 3306). The security group allows those TCP ports from `0.0.0.0/0` and allows all outbound traffic. This approach keeps the code concise, easier to maintain, and simple to parameterize (e.g., making the ports a variable).

**Benefits**: shorter code, fewer errors, easy to update port list, and more reusable for modules.

**One-line TL;DR:**
Creates a single Security Group with multiple dynamically generated TCP ingress rules (one per port) using a for-expression, keeping the config clean and configurable.

<image src="../images/SecurityGroup/SameCIDR.png">