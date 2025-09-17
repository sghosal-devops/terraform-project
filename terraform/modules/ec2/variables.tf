# terraform/modules/ec2/variables.tf
variable "project" {
  description = "Project name for tagging"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to launch the instance in"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}

variable "key_name" {
  description = "Name of the AWS key pair"
  type        = string
}
