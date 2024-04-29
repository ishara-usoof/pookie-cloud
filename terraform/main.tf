locals {
  vpc_id              = aws_vpc.main.id
  private_a_subnet_id = aws_subnet.private_1.id
  private_b_subnet_id = aws_subnet.private_2.id
  public_a_subnet_id  = aws_subnet.public_1.id
  public_b_subnet_id  = aws_subnet.public_2.id

  ubuntu_ami = "ami-01dad638e8f31ab9a"

  encoded_user_data_blue  = "IyEvYmluL2Jhc2gNCg0Kc2V0IC1lDQoNCiMgSW5zdGFsbCBhd3NjbGkNCnN1ZG8gYXB0LWdldCB1cGRhdGUNCnN1ZG8gYXB0LWdldCBpbnN0YWxsIGF3c2NsaQ0KY2htb2QgK3ggY29uZmlndXJlX2F3c19jbGkuc2gNCi4vY29uZmlndXJlX2F3c19jbGkuc2gNCg0KDQoNCiMgQ29uZmlndXJlIEFXUyBDTEkNCmF3cyBjb25maWd1cmUgc2V0IGF3c19hY2Nlc3Nfa2V5X2lkICIkQVdTX0FDQ0VTU19LRVlfSUQiDQphd3MgY29uZmlndXJlIHNldCBhd3Nfc2VjcmV0X2FjY2Vzc19rZXkgIiRBV1NfU0VDUkVUX0FDQ0VTU19LRVkiDQphd3MgY29uZmlndXJlIHNldCBkZWZhdWx0LnJlZ2lvbiAiJEFXU19ERUZBVUxUX1JFR0lPTiINCmF3cyBjb25maWd1cmUgc2V0IGRlZmF1bHQub3V0cHV0ICIkQVdTX09VVFBVVF9GT1JNQVQiDQoNCiMgSW5zdGFsbCBrdWJlY3RsDQpjdXJsIC1MTyBodHRwczovL3MzLnVzLXdlc3QtMi5hbWF6b25hd3MuY29tL2FtYXpvbi1la3MvMS4yOS4wLzIwMjQtMDEtMDQvYmluL2xpbnV4L2FtZDY0L2t1YmVjdGwNCmNobW9kICt4IC4va3ViZWN0bA0Kc3VkbyBtdiAuL2t1YmVjdGwgL3Vzci9sb2NhbC9iaW4va3ViZWN0bA0KDQojIENvbmZpZ3VyZSBrdWJlY29uZmlnIHRvIGNvbm5lY3QgdG8geW91ciBLdWJlcm5ldGVzIGNsdXN0ZXINCmF3cyBla3MgLS1yZWdpb24gZXUtbm9ydGgtMSB1cGRhdGUta3ViZWNvbmZpZyAtLW5hbWUgZWtzDQoNCmNkIGs4cw0KZWNobw0Ka3ViZWN0bCBhcHBseSAtZiBnaGNyLXNlY3JldC55YW1sDQprdWJlY3RsIGFwcGx5IC1mIDEtbW9uZ29kYi1kZXBsb3ltZW50LWJsdWUueWFtbA0Ka3ViZWN0bCBhcHBseSAtZiAxLW1vbmdvZGItc2VydmljZS1ibHVlLnlhbWwgDQprdWJlY3RsIGFwcGx5IC1mIDItcmFiYml0bXEtZGVwbG95bWVudC1ibHVlLnlhbWwNCmt1YmVjdGwgYXBwbHkgLWYgMi1yYWJiaXRtcS1zZXJ2aWNlLWJsdWUueWFtbCANCmt1YmVjdGwgYXBwbHkgLWYgMy1jdXN0b21lci1kZXBsb3ltZW50LWJsdWUueWFtbA0Ka3ViZWN0bCBhcHBseSAtZiAzLWN1c3RvbWVyLXNlcnZpY2UtYmx1ZS55YW1sIA0Ka3ViZWN0bCBhcHBseSAtZiA0LXByb2R1Y3RzLWRlcGxveW1lbnQtYmx1ZS55YW1sDQprdWJlY3RsIGFwcGx5IC1mIDQtcHJvZHVjdHMtc2VydmljZS1ibHVlLnlhbWwgDQprdWJlY3RsIGFwcGx5IC1mIDUtc2hvcHBpbmctZGVwbG95bWVudC1ibHVlLnlhbWwNCmt1YmVjdGwgYXBwbHkgLWYgNS1zaG9wcGluZy1zZXJ2aWNlLWJsdWUueWFtbCANCmt1YmVjdGwgYXBwbHkgLWYgYXBwLWJsdWUueWFtbA0Ka3ViZWN0bCBhcHBseSAtZiBpbmdyZXNzLnlhbWwNCg=="
  encoded_user_data_green = "DQojIS9iaW4vYmFzaA0Kc2V0IC1lDQoNCnN1ZG8gLXMNCg0KDQojIEluc3RhbGwgYXdzY2xpDQpzdWRvIGFwdC1nZXQgdXBkYXRlDQpzdWRvIGFwdC1nZXQgaW5zdGFsbCBhd3NjbGkNCmNobW9kICt4IGNvbmZpZ3VyZV9hd3NfY2xpLnNoDQouL2NvbmZpZ3VyZV9hd3NfY2xpLnNoDQoNCg0KIyBJbnN0YWxsIGt1YmVjdGwNCmN1cmwgLUxPIGh0dHBzOi8vczMudXMtd2VzdC0yLmFtYXpvbmF3cy5jb20vYW1hem9uLWVrcy8xLjI5LjAvMjAyNC0wMS0wNC9iaW4vbGludXgvYW1kNjQva3ViZWN0bA0KY2htb2QgK3ggLi9rdWJlY3RsDQpzdWRvIG12IC4va3ViZWN0bCAvdXNyL2xvY2FsL2Jpbi9rdWJlY3RsDQoNCiMgQ29uZmlndXJlIGt1YmVjb25maWcgdG8gY29ubmVjdCB0byB5b3VyIHNLdWJlcm5ldGVzIGNsdXN0ZXINCmF3cyBla3MgLS1yZWdpb24gZXUtbm9ydGgtMSB1cGRhdGUta3ViZWNvbmZpZyAtLW5hbWUgZWtzDQoNCmNkIGNkIGs4cw0Ka3ViZWN0bCBhcHBseSAtZiBnaGNyLXNlY3JldC55YW1sDQprdWJlY3RsIGFwcGx5IC1mIDEtbW9uZ29kYi1kZXBsb3ltZW50LWdyZWVuLnlhbWwNCmt1YmVjdGwgYXBwbHkgLWYgMS1tb25nb2RiLXNlcnZpY2UtZ3JlZW4ueWFtbCANCmt1YmVjdGwgYXBwbHkgLWYgMi1yYWJiaXRtcS1kZXBsb3ltZW50LWdyZWVuLnlhbWwNCmt1YmVjdGwgYXBwbHkgLWYgMi1yYWJiaXRtcS1zZXJ2aWNlLWdyZWVuLnlhbWwgDQprdWJlY3RsIGFwcGx5IC1mIDMtY3VzdG9tZXItZGVwbG95bWVudC1ncmVlbi55YW1sDQprdWJlY3RsIGFwcGx5IC1mIDMtY3VzdG9tZXItc2VydmljZS1ncmVlbi55YW1sIA0Ka3ViZWN0bCBhcHBseSAtZiA0LXByb2R1Y3RzLWRlcGxveW1lbnQtZ3JlZW4ueWFtbA0Ka3ViZWN0bCBhcHBseSAtZiA0LXByb2R1Y3RzLXNlcnZpY2UtZ3JlZW4ueWFtbCANCmt1YmVjdGwgYXBwbHkgLWYgNS1zaG9wcGluZy1kZXBsb3ltZW50LWdyZWVuLnlhbWwNCmt1YmVjdGwgYXBwbHkgLWYgNS1zaG9wcGluZy1zZXJ2aWNlLWdyZWVuLnlhbWwgDQprdWJlY3RsIGFwcGx5IC1mIGFwcC1ncmVlbi55YW1sDQprdWJlY3RsIGFwcGx5IC1mIGluZ3Jlc3MueWFtbA=="

  traffic_dist_map = {
    blue = {
      blue  = 100
      green = 0
    }
    blue-90 = {
      blue  = 90
      green = 10
    }
    split = {
      blue  = 50
      green = 50
    }
    green-90 = {
      blue  = 10
      green = 90
    }
    green = {
      blue  = 0
      green = 100
    }
  }
}

# Security Group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "web" {
  name        = "web-sg"
  description = "Security group for web-servers with HTTP ports open within VPC"
  vpc_id      = local.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


# Application Load Balancer
# At least two subnets in two different Availability Zones must be specified
# aws_lb: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
resource "aws_lb" "app" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  subnets = [
    local.public_a_subnet_id,
    local.public_b_subnet_id
  ]
  security_groups = [aws_security_group.web.id]
}

# Load Balancer Listener
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    # target_group_arn = aws_lb_target_group.blue.arn
    forward {
      target_group {
        arn    = aws_lb_target_group.blue.arn
        weight = lookup(local.traffic_dist_map[var.traffic_distribution], "blue", 100)
      }

      target_group {
        arn    = aws_lb_target_group.green.arn
        weight = lookup(local.traffic_dist_map[var.traffic_distribution], "green", 0)
      }

      stickiness {
        enabled  = false
        duration = 1
      }
    }
  }
}
