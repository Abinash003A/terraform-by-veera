variable "allowed_ports" {
    type = map(string)
    default = {
    #   "key    = "value"
    22= "103.186.128.245/32"
    80= "0.0.0.0/0"
    443= "0.0.0.0/0"
    3000= "0.0.0.0/0"
    }
  
}
resource "aws_security_group" "my_sg"{
  name = "abinash-sg-1"
  description = "Allow TLS inbound traffic" 
  tags = {
    Name = "my-sg"
  }

#customizable cidr connection

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
        description = "allowed_ports $(ingress.key)"
        from_port = ingress.key
        to_port = ingress.key
        protocol = "tcp"
        cidr_blocks = [ingress.value]      
    }
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}