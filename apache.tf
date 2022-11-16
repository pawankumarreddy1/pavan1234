# resource "aws_security_group" "apache" {
#   name        = "allow_admin"
#   description = "Allow TLS inbound traffic"
#   vpc_id      = aws_vpc.stag-vpc.id

#   ingress {
#     description      = "TLS from VPC"
#     from_port        = 22
#     to_port          = 22
#     protocol         = "tcp"
#     security_groups = [aws_security_group.bastion5.id]
#     # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
#   }

#     ingress {
#     description      = "TLS from VPC"
#     from_port        = 80
#     to_port          = 80
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#     # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "apache"
#   }
# }
# resource "aws_instance" "apache" {
#   ami                    = "ami-0e6329e222e662a52"
#   instance_type          = "t3.micro"
#   subnet_id              = aws_subnet.stag-private1[0].id
#   vpc_security_group_ids = [aws_security_group.apache.id]
#   key_name               = aws_key_pair.pavan1.id
#   user_data = <<EOF
#   #!/bin/bash
#   yum update -y
#   yum install httpd -y
#   systemctl start httpd
#   systemctl enable httpd

# EOF

#    tags = {
#     Name = "apache"

#   }
# }