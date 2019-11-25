output "bastion_server_id" {
  value = aws_instance.bastion.id
}

output "bastion_server_arn" {
  value = aws_instance.bastion.arn
}

output "bastion_server_private_ip" {
  value = aws_instance.bastion.private_ip
}

output "bastion_server_public_ip" {
  value = aws_instance.aws_eip.bastion_eip
}