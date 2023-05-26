terraform {
    required_version = ">= 1.4.0"
    required_providers{
        aws = {
            source = "hashicorp/aws"
        }
    }
}

# Import providers from providers.tf
terraform {
    # cloud {
    #     organization = "example_corp"
    #     ## Required for Terraform Enterprise; Defaults to app.terraform.io for Terraform Cloud
    #     hostname = "app.terraform.io"

    #     workspaces {
    #     tags = ["app"]
    #     }
    }


# VPC resource
resource "aws_vpc" "example_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

# Subnet resource
resource "aws_subnet" "example_subnet" {
  vpc_id     = aws_vpc.example_vpc.id
  cidr_block = var.subnet_cidr

  tags = {
    Name = var.subnet_name
  }
}

# EC2 instances
resource "aws_instance" "example_instance1" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.example_subnet.id
  vpc_security_group_ids = [aws_security_group.example.id]



#   key_name = "<<keyname>>" #key name for ssh access
#   associate_public_ip_address = true  # Auto-assign a public IP address

  root_block_device {
    volume_size = var.instance_volume_size
  }

  tags = {
    Name = var.instance1_name
  }
}

resource "aws_instance" "example_instance2" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.example_subnet.id

#   key_name = "<<keyname>>" #key name for ssh access
#   associate_public_ip_address = true  # Auto-assign a public IP address

  root_block_device {
    volume_size = var.instance_volume_size
  }

  tags = {
    Name = var.instance2_name
  }
}

resource "aws_security_group" "example" {
  name        = "example-security-group"
  description = "Example security group"
  vpc_id      = aws_vpc.example_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# S3 bucket resource
resource "aws_s3_bucket" "example_bucket" {
  bucket = var.bucket_name
  

  tags = {
    Name = var.bucket_name
  }
}

resource "aws_s3_bucket_ownership_controls" "example_bucket_ownership_controls" {
  bucket = aws_s3_bucket.example_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_public_access_block_example" {
  bucket = aws_s3_bucket.example_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_acl" "bucket_example_acl" {
  depends_on = [
  aws_s3_bucket_ownership_controls.example_bucket_ownership_controls,
  aws_s3_bucket_public_access_block.bucket_public_access_block_example]

  bucket = aws_s3_bucket.example_bucket.id
  acl    = "public-read"
}
