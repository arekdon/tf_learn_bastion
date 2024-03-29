// Get latest AMI for Ubuntu 18.04
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/*18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

// Create and associate Elastic IP to bastion host
resource "aws_eip" "bastion_eip" {
  
  instance = aws_instance.bastion.id
  vpc      = true
  
}

resource "aws_key_pair" "bastionkey" {
  key_name   = "bastion-key"
  public_key = var.bastion_pkey
}

// Create bastion host insntace
resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name               = aws_key_pair.bastionkey.key_name

  tags = {
    Name = "GuacamoleBastionHost"
  }

}