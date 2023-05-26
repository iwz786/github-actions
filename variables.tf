variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "example-vpc"
}

variable "subnet_cidr" {
  description = "Subnet CIDR block"
  type        = string
  default     = "10.0.0.0/24"
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
  default     = "example-subnet"
}

variable "instance_ami" {
  description = "EC2 instance AMI"
  type        = string
  default     = "ami-12345678"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_volume_size" {
  description = "EC2 instance root volume size (in GB)"
  type        = number
  default     = 8
}

variable "instance1_name" {
  description = "Name for EC2 instance 1"
  type        = string
  default     = "example-instance1"
}

variable "instance2_name" {
  description = "Name for EC2 instance 2"
  type        = string
  default     = "example-instance2"
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        =  string
  default     = "example-bucket"
}