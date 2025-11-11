## 🧩 What is a Workspace?

Each workspace in Terraform has its own separate state file.

That means you can use the same configuration, but Terraform will track different sets of resources for each workspace.

👉 Example:

- `terraform apply` in the `dev` workspace → creates dev EC2s.

- `terraform apply` in the `prod` workspace → creates an independent prod environment.


## 🧭 Step-by-Step: Managing Workspaces
### 1️⃣ Check your current workspace
```bash
terraform workspace show
```

Output example:
```cpp
default
```

Every new Terraform project starts with a default workspace.

---

### 2️⃣ List all workspaces
```bash
terraform workspace list
```


Output:
```cpp
*  default
   dev
   prod
```


The `*` indicates the active workspace.

---

### 3️⃣ Create a new workspace
```bash
terraform workspace new dev
```

This:

- Creates a new workspace called dev

- Switches into it automatically

Terraform now creates a new state file under:

```bash
.terraform/terraform.tfstate.d/dev/terraform.tfstate
```
---

### 4️⃣ Switch between existing workspaces
```bash
terraform workspace select prod
```

✅ Terraform switches to `prod` state — meaning future `plan` or `apply` commands operate on `prod` resources.

---

### 5️⃣ Delete a workspace (only if no resources inside)
```bash
terraform workspace delete dev
```

If there are resources managed by that workspace, Terraform won’t delete it until you destroy them.

---

### ⚙️ Using workspace name in configuration (optional)

You can dynamically change names or tags using the active workspace:

```bash
resource "aws_s3_bucket" "example" {
  bucket = "my-app-${terraform.workspace}"

```


When you run:

- `terraform workspace select dev` → creates bucket `my-app-dev`

- `terraform workspace select prod` → creates bucket `my-app-prod`

---
### S3

<image src="..\images\Workspace\S3.png">
