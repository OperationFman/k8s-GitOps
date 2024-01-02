# k8s-GitOps

Pipeline using Kubernetes, Jenkins, AWS and ArgoCD to spin up a cluster with a
running up and maintain it in a modern approach for reliability ease of
development

# Prerequisites

Install:

- Brew https://brew.sh/
- AWS Account https://aws.amazon.com/resources/create-account/
- AWS CLI https://aws.amazon.com/cli/
- Kubectl https://kubernetes.io/docs/tasks/tools/
- Terraform
  https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

Configuration:

- Sign up with Docker Hub https://hub.docker.com/signup then Find-and-Replace
  anywhere in this repo with `<your-docker-id>`
- Create a Github account https://github.com/signup then enter your credentials
  in `/manifest/JenkinsFile`, replacing `<your-github-id>` and
  `<your-github-username>`

# Setup CI

Note: You should only need to set this up once

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

6. Create a pipeline called 'buildimage' and link this repository under SCM and
   change /master to /main

7. Create another pipeline called 'updatemanifest' a. Select 'This prompt is
   parametised' b. Add the name 'DOCKERTAG' with default value `latest` c. Link
   this repo under under SCM to the `/manifest` directory d. Change /master to
   /main

8. Return to the 'buildimage' pipeline and run it to test it creates an image
   from the app and uploads it to Docker Hub automatically

# Setup CD

1. Run `aws create cluster`, Note: this costs a fortune if left running

2. Install ArgoCD by following the official docs:
   https://argo-cd.readthedocs.io/en/stable/getting_started/

3. Log in to the ArgoCD UI

4. Create app and under source paste this repo link with the path `/manifest`.
   For destination, select the cluster and write 'default' under namespace,
   unless you're using another namespace

5. Once the app is running you can type `kubectl get svc` and copy the External
   IP beside the Load Balancer to see the deployed site in your browser. Note:
   It can take a few minutes

6. Don't forget to checkout the app flow in ArgoCD to see how the deployment is
   looking. Test the visuals are working by deleting a pod in kubectl and watch
   ArgoCD spin up a new one

7. Add a webhook so that whenever your/this repo is updated then a new image
   will be created through the CI pipeline which will then trigger ArgoCD to
   deploy the new app automatically:
   https://www.blazemeter.com/blog/how-to-integrate-your-github-repository-to-your-jenkins-project
