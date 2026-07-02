# Use Terraform to deploy Online Boutique on an EKS cluster

This page walks you through the steps required to deploy the [Online Boutique](https://github.com/GoogleCloudPlatform/microservices-demo) sample application on an [Amazon EKS](https://aws.amazon.com/eks/) cluster using Terraform.

## Prerequisites

1. An active [AWS account](https://aws.amazon.com/) with billing enabled.
2. [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) installed and configured (`aws configure`).
3. [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) >= 1.0 installed.
4. [kubectl](https://kubernetes.io/docs/tasks/tools/) installed.

## Deploy the sample application

1. Clone the Github repository.

    ```bash
    git clone https://github.com/GoogleCloudPlatform/microservices-demo.git
    ```

1. Move into the `terraform/` directory which contains the Terraform installation scripts.

    ```bash
    cd microservices-demo/terraform
    ```

1. Open the `terraform.tfvars` file and set your preferred AWS region (default is `us-east-1`).

1. (Optional) If you want to provision an [Amazon ElastiCache (Redis)](https://aws.amazon.com/elasticache/) instance, change the value of `elasticache = false` to `elasticache = true` in this `terraform.tfvars` file.

1. Initialize Terraform.

    ```bash
    terraform init
    ```

1. See what resources will be created.

    ```bash
    terraform plan
    ```

1. Create the resources and deploy the sample.

    ```bash
    terraform apply
    ```

    1. If there is a confirmation prompt, type `yes` and hit Enter/Return.

    Note: This step can take about 15 minutes. Do not interrupt the process.

Once the Terraform script has finished, you can locate the frontend's external IP address to access the sample application:

```bash
kubectl get service frontend-external | awk '{print $4}'
```

## Clean up

To avoid incurring charges to your AWS account for the resources used in this sample application, either delete the AWS resources or keep the account and delete the individual resources.

To remove the individual resources created by Terraform:

1. Navigate to the `terraform/` directory.

1. Run the following command:

   ```bash
   terraform destroy
   ```

   1. If there is a confirmation prompt, type `yes` and hit Enter/Return.
