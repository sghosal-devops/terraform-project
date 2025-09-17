resource "aws_security_group" "web_sg" {
  name        = "${var.project}-web-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-web-sg"
  }
}


# Import existing public key to AWS as a Key Pair
resource "aws_key_pair" "terraform_key" {
  key_name   = var.key_name              # e.g., "terraform-key"
  public_key = file("/root/.ssh/terraform-key.pub")
}


resource "aws_instance" "web" {
  ami                         = "ami-0e35ddab05955cf57" # Amazon Linux 2 (us-east-1)
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.terraform_key.key_name # must match AWS KeyPair name

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "${var.project}-web"
  }
}
