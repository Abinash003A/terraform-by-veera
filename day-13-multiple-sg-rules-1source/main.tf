resource "aws_security_group" "this" {
    name = "abinash-sg-1"
    description = "Allow TLS inbound traffic" 
    tags = {
      Name = "my-sg"
    }
    #manually adding rules for each port
    # ingress {
    #     description = "allow all traffic"
    #     from_port = 22
    #     to_port = 22
    #     protocol = "tcp"
    #     cidr_blocks = ["0.0.0.0/0"]
    # }
    # ingress {
    #     description = "allow all traffic"
    #     from_port = 80
    #     to_port = 80
    #     protocol = "tcp"
    #     cidr_blocks = ["0.0.0.0/0"]
    # }
    
    #using for loop
    ingress = [ 
        for port in [22,80,443,8080] : {
            description ="inbound rules"
            from_port = port
            to_port = port
            protocol = "tcp"
            cidr_blocks= ["0.0.0.0/0"]
            ipv6_cidr_blocks= []
            prefix_list_ids = []
            security_groups = []
            self = false
        }
     ]  

     egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}