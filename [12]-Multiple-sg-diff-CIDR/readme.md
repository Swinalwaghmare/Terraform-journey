### 📝 Summary — Port → CIDR map + dynamic ingress rules

This Terraform pattern uses a **map** of `port → cidr` together with a `dynamic` block to create one `ingress` rule per map entry inside a single AWS Security Group.
Each map entry defines which CIDR is allowed to reach a specific TCP port. The `dynamic "ingress"` loop iterates the map and emits an `ingress { ... }` block for every port.

**Important gotcha:** Terraform map keys are strings (e.g. `"22"`). `from_port` and `to_port` require **numbers**, so you must convert the key with `tonumber(ingress.key)` (or use numeric values in a different structure). Without this conversion the plan will fail with a type error.

**Key features**

- One resource produces multiple ingress rules — avoids repeating blocks.

- Each rule opens a specific port to its corresponding CIDR.

- Easily configurable by changing the map values.

<image src="..\images\SecurityGroup\DiffCIDR.png">