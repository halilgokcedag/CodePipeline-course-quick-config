variable "region" {
  default = "us-east-1"
}
variable "keypair" {
  default = "demokey.pub"
}
variable "ec2_ami" {
  default = "ami-0cff7528ff583bf9a"
}
variable "ec2_instance_type" {
  default = "t2.micro"  
}