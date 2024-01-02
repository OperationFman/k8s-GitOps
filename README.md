# k8s-GitOps

Pipeline using Kubernetes, Jenkins, AWS and ArgoCD to spin up a cluster with a
running up and maintain it in a modern approach for reliability ease of
development

# Prerequisites

- Brew https://brew.sh/
- Terraform
  https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

# First Time Setup

1. Create a new IAM role within the AWS account you want to use and save the
   access id/key

2. Install and configure the AWS CLI:
   https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

3. Clone this repo and navigate to the infra folder `cd infra`

4. Run `terraform init && terraform apply` which will spin up an EC2 small
   instance (Not free) and start jenkins on it

5. Navigate to http://<your_server_public_DNS>:8080 and follow these steps to
   configure Jenkins:
   https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/#configuring-jenkins:~:text=systemctl%20status%20jenkins-,Configuring%20Jenkins,-Jenkins%20is%20now
