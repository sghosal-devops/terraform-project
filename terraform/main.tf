terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-12345"
    key            = "global/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source  = "./modules/vpc"
  project = "demo"
  tags = {
    Project     = "demo"
    Environment = "dev"
    Owner       = "souvik"
  }
}


module "ec2" {
  source    = "./modules/ec2"
  project   = "demo"
  subnet_id = module.vpc.public_subnet_id   # ✅ using output
  vpc_id    = module.vpc.vpc_id             # ✅ using output
  key_name  = "terraform-key"
}
