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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDN/xCr0xHmaeVVWylGeWWOT6rJj9RUpFneQ2IY9VXe0JyDFrLplXf8V9Snb9Th6r9xxVFOpIO6JqlUhvY6Q89r1/g8xpiLXbjXpzMj6hEcQYum0fe0wlM0ju6AQlxX7+v/b+S7qpGl938m5V5CRiiHERaFEn/VSNXK351ad2fM42BkQ7rSh0/DC1RQ9ni/1OlsjA3UBbashdC8XSiHwTgcX7cK4uw/roxDjcmN4tD+9vH5ISqM0mK7M75ermXXB+aaZWUe5E9XG/VSmubjvBEmBCo5KSlxJy9cVFzalXK4bnpIU94Al5llJ9fsSUxazzanI6ILeDJxJlzlm3LlPPgX"
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