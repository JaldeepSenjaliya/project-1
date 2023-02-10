# Create resources on Azure and AWS using Terraform #

Install Microsoft Azure CLI in your system [Documentation](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).

Install Microsoft AWS CLI in your system [Documentation](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

Install Terraform in your system [Documentation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).

To Authenticate Terraform From Azure [Documentation](https://learn.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure?tabs=bash).


To Authenticate Terraform From Aws [Documentation](https://aws.amazon.com/blogs/apn/using-terraform-to-manage-aws-programmable-infrastructures/).

## Use below commands to run the code

Clone the repository and run `terraform init` command.

To validate your code run `terraform validate` command.

To check resource confirgution before creating the resources run `terraform plan` command.

To create the resources run `terraform apply` command and follow the prompt.
You can also use `terraform apply --auto-approve` command.

To destroy the resources run `terraform destroy` command and follow the prompt.
You can also use `terraform destroy --auto-approve` command.

To format the code run `terraform fmt`command.

For more command please go to this [Documentation](https://developer.hashicorp.com/terraform/cli/commands).
or run `terraform --help` command.