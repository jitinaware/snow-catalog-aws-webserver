

locals {
  # AWS Resources
  vpc_id              = data.terraform_remote_state.backend.outputs.aws_vpc_id
  vpc_pubsubnet_id    = data.terraform_remote_state.backend.outputs.aws_public_subnet_ids[0]
}



resource "aws_security_group" "aws-vm" {
  name = "aws-vm"
  vpc_id = local.vpc_id
  egress = [
    {
      cidr_blocks      = [ var.aws_allow_cidr_range, ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ var.aws_allow_cidr_range, ]
     description      = "ssh"
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  },
   {
     cidr_blocks      = [ var.aws_allow_cidr_range, ]
     description      = "web"
     from_port        = 8888
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 8888
  }
  ]
}


resource "aws_instance" "aws-vm" {
  count = var.vm_count
  subnet_id = local.vpc_pubsubnet_id
  ami = data.aws_ami.ami_os_filter.id
  instance_type = var.aws_instance_type
  key_name = var.aws_keyname

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 100
  }

  vpc_security_group_ids = [aws_security_group.aws-vm.id]

  provisioner "remote-exec" {
    connection {
      host = aws_instance.aws-vm[count.index]
      type = "ssh"
      user = var.aws_sshuser
      timeout = "3m"
      private_key = var.aws_privatekey
    }
    inline = [
      "sudo yum install -y yum-utils && sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo",
      "sudo yum install -y docker-ce docker-ce-cli containerd.io && sudo systemctl start docker",
      "sudo docker run --name nginx -d -p 8888:80 nginx"
    ]
  }
  tags = merge(
    #var.resource_tags,
    {
      Name = "aws-vm"
    }
  )

  #volume_tags = var.resource_tags
  
}


#AMI Filter for Linux CentOS 7

data "aws_ami" "ami_os_filter" {
     most_recent = true

     filter {
        name   = "name"
        values = [var.amifilter_osname]
     }
     filter {
        name = "architecture"
        values = [var.amifilter_osarch]

 }

     filter {
       name   = "virtualization-type"
       values = [var.amifilter_osvirtualizationtype]

 }

     owners = [var.amifilter_owner] # Canonical

 }