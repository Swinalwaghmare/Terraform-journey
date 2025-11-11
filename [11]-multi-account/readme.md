### 📝 Summary

This Terraform configuration demonstrates how to deploy AWS resources across multiple regions using provider aliases.

- The default AWS provider is configured for us-east-1 (N. Virginia), where an EC2 instance is created.

- A second provider, aliased as west2, targets us-west-2 (Oregon) and profile is apex which is different account creadentials is used to create an S3 bucket named mlops-swinal.

- This setup illustrates how to manage resources in different regions within the same Terraform project.

- The EC2 instance acts as the compute resource, while the S3 bucket serves as storage in a separate location for redundancy or data separation.

### Code Snippet
```provide.tf
provider "aws" {
    region = "us-east-1"
}

provider "aws" {
    region = "us-west-2"
    alias = "west2"
    profile = "apex" # second account profile name
}
```

### EC 2 (Us-East-1)
<image src="..\images\multi-account\EC2.png">

### S3 2 (Us-West-2)
<image src="..\images\multi-account\S3.png">