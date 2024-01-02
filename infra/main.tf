resource "aws_instance" "ec2-instance" {
    ami = "ami-09eebd0b9bd845bf1"
    instance_type = "t2.medium"

    vpc_security_group_ids = [
        aws_security_group.ssh.id,
        aws_security_group.jenkins.id,
    ]

    user_data = "${file("user_data.sh")}"
}