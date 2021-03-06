
# AWS

variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "owner" {
  type = string
  default = ""
}

variable "vm_count" {
  type = number
  default = "1"
}

variable "department" {
  type        = string
  description = "Department requesting the infrastructure"
  default     = ""
}

variable "purpose" {
  type        = string
  description = "Purpose of the infrastructure"
  default     = ""
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type = map(string)
  default = {
    department = ""
    purpose = ""
  }
}

variable "aws_allow_cidr_range" {
    type = string
    default = "0.0.0.0/0"
}

variable "amifilter_osname" {
    type = string
    default = "*jaware*"
}

variable "amifilter_osarch" {
    type = string
    default = "x86_64"
}

variable "amifilter_osvirtualizationtype" {
    type = string
    default = "hvm"
}

variable "amifilter_owner" {
    type = string
    default = "711129375688" # CentOS 7.9
}

variable "aws_instance_type" {
    type = string
    default = "t2.micro"
}

variable "aws_sshuser" {
    type = string
    default = "centos"
}

variable "aws_privatekey" {
    type = string
    sensitive = true
    default = ""
}

variable "aws_keyname" {
    type = string
    default = ""
}

variable "AWS_ACCESS_KEY_ID" {
    type = string
    default = ""
}

variable "AWS_SECRET_ACCESS_KEY" {
    type = string
    default = ""
    sensitive = true
}

variable "AWS_SESSION_TOKEN" {
    type = string
    default = ""
    sensitive = true
}