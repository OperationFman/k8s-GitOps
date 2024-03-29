yum update -y
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

yum upgrade
dnf install java-17-amazon-corretto -y
yum install jenkins -y
yum install -y git
yum install -y docker

service docker start
systemctl enable jenkins
systemctl start jenkins

echo !***********Jenkins Password***********!
cat /var/lib/jenkins/secrets/initialAdminPassword