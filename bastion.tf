# # apache-security
# resource "aws_security_group" "bastion5" {
#   name        = "bastion"
#   description = "Allow  inbound traffic"
#   vpc_id      = aws_vpc.stag-vpc.id

#   ingress {
#     description = "from admin"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#     # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
#   }
#   # ingress {
#   #   description = "from admin"
#   #   from_port   = 22
#   #   to_port     = 22
#   #   protocol    = "tcp"
#   #   cidr_blocks = ["0.0.0.0/0"]
#   #   # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
#   # }
#   #   ingress {
#   #   description = "from end users"
#   #   from_port   = 80
#   #   to_port     = 80
#   #   protocol    = "tcp"
#   #   cidr_blocks      = ["0.0.0.0/0"]
#   #   # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
#   # }
#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "bastion"

#   }
# }

# resource "aws_instance" "bastion" {
#   count =1
#   ami                    = "ami-0e6329e222e662a52"
#   instance_type          = "t3.micro"
#   subnet_id              = aws_subnet.stag-private1[0].id
#   vpc_security_group_ids = [aws_security_group.bastion5.id]
#   key_name               = aws_key_pair.pavan1.id
    
    
#     tags = {
#     Name = "bastion-sg"

#   }
# }