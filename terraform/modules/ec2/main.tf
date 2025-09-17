resource "aws_instance" "web" {
  ami                         = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 (us-east-1)
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  key_name                    = var.key_name # must match AWS KeyPair name

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "${var.project}-web"
  }
}
