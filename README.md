# Terransible
This is to check terraform and ansible integration with Jenkins
Steps to be taken:
1.	Install Terraform on EC2/cloud instance and as a plugin in Jenkins
2.	Use Export function to export the access key and secret access key (export AWS_ACCESS_KEY_ID="anaccesskey"   export AWS_SECRET_ACCESS_KEY="asecretkey" export AWS_REGION="us-west-2")
3.	 Refer Terraform docs for further information:https://registry.terraform.io/providers/hashicorp/aws/latest/docs
4.	 If using Jenkins add the above credentials with credentials binding option in pipeline syntax generator
5.	 Modify and assign Admin access IAM role to EC2 instance to give Jenkins necessary permissions.
6.	 Edit Visudo file and give Jenkins superuser permission, if running via Jenkins.
7.	 Grant chmod 666 to /etc/anisble/hosts, and copy the .pem file in ansible credentials section
