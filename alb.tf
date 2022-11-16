# resource "aws_security_group" "pavan-alb-sg" {
#   name        = "alb-sg"
#   description = "this is using for securitygroup"
#   vpc_id      = aws_vpc.stag-vpc.id

# #   ingress {
# #     description = "this is inbound rule"
# #     from_port   = 22
# #     to_port     = 22
# #     protocol    = "tcp"
# #     cidr_blocks = ["103.110.170.84/32"]
# #   }
#   ingress {
#     description = "this is inbound rule"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "all"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "pavan-alb-sg"
#   }
# }


# resource "aws_lb" "pavan-test-alb" {
#   name               = "pavan-test-alb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.pavan-alb-sg.id]
#   subnets            = [aws_subnet.stag-public1[0].id,aws_subnet.stag-public1[1].id]

# #   enable_deletion_protection = true

# #   access_logs {
# #     bucket  = aws_s3_bucket.lb_logs.bucket
# #     prefix  = "test-lb"
# #     enabled = true
# #   }

#   tags = {
#     Environment = "pavan-alb"
#   }
# }

# resource "aws_lb_target_group" "pavan-tg-apache" {
#   name     = "tg-apache"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.stag-vpc.id
# }

# resource "aws_lb_target_group_attachment" "pavan-tg-attachment-apache" {
#   target_group_arn = aws_lb_target_group.pavan-tg-apache.arn
#   target_id        = aws_instance.apache.id
#  port             = 8080
# }


# resource "aws_lb_target_group" "pavan-tg-tomcat" {
#   name     = "tg-tomcat"
#   port     = 8080
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.stag-vpc.id
# }

# resource "aws_lb_target_group_attachment" "pavan-tg-attachment-tomcat" {
#   target_group_arn = aws_lb_target_group.pavan-tg-tomcat.arn
#   target_id        = aws_instance.tomcat1.id
#   port             = 8080
# }


# resource "aws_lb_listener" "pavan-alb-listener" {
#   load_balancer_arn = aws_lb.pavan-test-alb.arn
#   port              = "80"
#   protocol          = "HTTP"
# #   ssl_policy        = "ELBSecurityPolicy-2016-08"
# #   certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.pavan-tg-apache.arn
#   }
# }

# resource "aws_lb_listener_rule" "pavan-apache-hostbased" {
#   listener_arn = aws_lb_listener.pavan-alb-listener.arn
# #   priority     = 99

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.pavan-tg-tomcat.arn
#      }

#   condition {
#     host_header {
#       values = ["apache.pavan.quest"]
#     }
#   }
# }

# resource "aws_lb_listener_rule" "pavan-tomcat-hostbased" {
#   listener_arn = aws_lb_listener.pavan-alb-listener.arn
# #   priority     = 98

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.pavan-tg-tomcat.arn
#   }

#   condition {
#     host_header {
#       values = ["tomcat.pavan.quest"]
#     }
#   }
   
# }