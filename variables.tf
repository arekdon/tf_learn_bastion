variable "instance_type" {
  description = "Type and family of instance"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet id where machine is deployed"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of secruity groups attached to instance"
  type        = list(string)
}


