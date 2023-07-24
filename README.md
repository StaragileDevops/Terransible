# Terransible
This is to check terraform and ansible integration with Jenkins
Steps to be taken:
Install Terraform on EC2/cloud instance and as a plugin in Jenkins
Use Export function to export the access key and secret access key (export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
 export AWS_REGION="us-west-2")
 Refer Terraform docs for further information:https://registry.terraform.io/providers/hashicorp/aws/latest/docs
 If using Jenkins add the above credentials with credentials binding option in pipeline syntax generator
 Modify and assign Admin access IAM role to EC2 instance to give Jenkins necessary permissions.
 Edit Visudo file and give Jenkins superuser permission, if running via Jenkins.
