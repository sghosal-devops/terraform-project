terraform {
  backend "s3" {
    bucket         = "ssouvik-tf-state-mumbai-20250917-001"
    key            = "global/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-south-1"
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
