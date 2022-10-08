resource "aws_instance" "wp-site" {
ami = "ami-0ea0f26a6d50850c5"
instance_type = "t2.micro"
vpc_security_group_ids = [aws_security_group.instance.id]

user_data = <<-EOF
#!/bin/bash
echo "Hello, World" > index.html
nohup busybox httpd -f -p 8080 &
EOF

    tags = {
        Name = "wp-site"
    }
}

resource "aws_security_group" "instance" {
  name = "terraform-sg"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}