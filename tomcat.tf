# resource "aws_security_group" "tomcat" {
#   name        = "allow_tomcat"
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
#     from_port        = 8080
#     to_port          = 8080
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

# resource "aws_instance" "tomcat1" {
#   ami                    = "ami-0e6329e222e662a52"
#   instance_type          = "t3.micro"
#   subnet_id              = aws_subnet.stag-private1[0].id
#   vpc_security_group_ids = [aws_security_group.tomcat.id]
#   key_name               = aws_key_pair.pavan1.id
# user_data = <<EOF
#              #!/bin/bash
     
#  yum update -y
#  sudo amazon-linux-extras install java-openjdk11 -y
#  java -version
# wget -O /opt/apache-tomcat-9.0.68-windows-x64.zip https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.68/bin/apache-tomcat-9.0.68-windows-x64.zip
# cd /opt
# unzip apache-tomcat-9.0.68-windows-x64.zip
# mv apache-tomcat-9.0.68 tomcat9
# rm -rf apache-tomcat-9.0.68-windows-x64.zip
# cd tomcat9/
# cd bin
# ls -ltrh *.sh
# chmod 755 *.sh
# ./startup.sh
# EOF

#   tags = {
#     Name = "tomcat"

#   }
# }