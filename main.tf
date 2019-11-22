// Get latest AMI for Ubuntu 18.04
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/*14.04-amd64-server-*"]
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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7uRjphuGD4lJ6AGPujMBhbrzOrTei5i0T9xarbZ4Xs2hV18tkjI4ILrNnHsPRuwLHrVIFTeg8qtbrLRGpRMkqMy7A3/KP3zQM89Cibw/YpjdsPt6igBfrhi5lLde1Of64bh9c70npMCu7AZPwIOr0ZNI78rj1qk76kf77nL6ppH8gP6QpCg6e8dOpKO6sDpGSk476zxn0CszQS/uTiJ3nzcMmqJGHgAu0FMIg8vrJ9TpKZ4ab51kqTMluZ0nFXWaj/wS9zwIstlqGUtjvos5opMMF0w+XaOxGIUOYw0Frbk3AnUYu/8BWm2lbG3LocXnlZjxzCCnicrCVpnmbQ13B arekd@arek-pc"
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