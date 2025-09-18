
module "key_pair" {
  source     = "../key_pair"
  key_name   = var.key_name
  public_key = file("/root/.ssh/terraform-key.pub")
}

module "web_sg" {
  source      = "../security_group"
  name        = "${var.project}-web-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = var.vpc_id
  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  tags = {
    Name = "${var.project}-web-sg"
  }
}


resource "aws_instance" "web" {
  ami                         = "ami-0e35ddab05955cf57" # Amazon Linux 2 (us-east-1)
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  key_name                    = module.key_pair.key_name
  vpc_security_group_ids      = [module.web_sg.security_group_id]
  tags = {
    Name = "${var.project}-web"
  }
}
