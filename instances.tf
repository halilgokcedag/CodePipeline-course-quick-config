data "aws_vpc" "myvpc" { default = true }

resource "aws_key_pair" "demo-key" {
  key_name   = "demo-ec2-key"
  public_key = file("${path.cwd}/${var.keypair}")

}

resource "aws_instance" "quick-ec2_ubuntu" {
  instance_type          = var.ec_instance_type
  ami                    = var.ec2_ami
  key_name               = aws_key_pair.demo-key.id
  user_data              = file("user-data.tpl")
  vpc_security_group_ids = [aws_security_group.allow_HTTP_SSH.id]
  iam_instance_profile = aws_iam_instance_profile.aws-codeDeploy-ec2-profile.name
  tags = {
    "Name" = "Angular-EC2"
  }
}


resource "aws_security_group" "allow_HTTP_SSH" {
  name        = "allow_HTTP_SSH"
  description = "Allow quick EC2 instance inbound traffic"
  vpc_id      = data.aws_vpc.myvpc.id

  ingress {
    description      = "HTTP from anywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description      = "SSh from anywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["0.0.0.0/0"]
  }
   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_some ports"
  }
}
