
# apache-security
resource "aws_security_group" "apache4" {
  name        = "apache4"
  description = "Allow  inbound traffic"
  vpc_id      = aws_vpc.stag-vpc.id

  ingress {
    description = "from admin"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  ingress {
    description = "from admin"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "apache4"

  }
}

resource "aws_instance" "apache4" {
  ami                    = "ami-06489866022e12a14"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.stag-public1[0].id
  vpc_security_group_ids = [aws_security_group.apache4.id]
  key_name               = aws_key_pair.pavan2.id
  user_data              = <<-EOF
 #!/bin/bash
 yum update -y 
 yum install httpd -y 
 systemctl start httpd
 systemctl enable httpd
  EOF


  tags = {
    Name = "apache4"
  }
}

resource "aws_security_group" "cicd1" {
  name        = "cicd1"
  description = "Allow apachi inbound traffic"
  vpc_id      = aws_vpc.stag-vpc.id
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }


  ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "stage-cicd"
  }
}


# cicd:
resource "aws_instance" "jenkins4" {
  ami                    = "ami-06489866022e12a14"
  instance_type          = "c5.xlarge"
  subnet_id              = aws_subnet.stag-public1[0].id
  vpc_security_group_ids = [aws_security_group.cicd1.id]
  key_name               = aws_key_pair.pavan2.id
  iam_instance_profile   =aws_iam_instance_profile.cicd-iam.name
  user_data              = <<-EOF
 #!/bin/bash
 yum update -y
 sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
 sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
 yum install epel-release # repository that provides 'daemonize'
 amazon-linux-extras install epel -y
 amazon-linux-extras install java-openjdk11 -y
#  yum install java-11-openjdk-devel
 yum install jenkins -y
 systemctl start jenkins
 systemctl enable jenkins
 cd /opt/
 wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz
 tar -xzvf apache-maven-3.8.6-bin.tar.gz
 mv apache-maven-3.8.6 maven38
  EOF



  tags = {
    Name = "stage-cicd2"
  }
}

