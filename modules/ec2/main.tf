resource "aws_security_group" "main" {
  name        = "${var.environment}-sg"
  description = "Security group for ${var.environment} environment"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-sg"
    Environment = var.environment
  }
}

resource "aws_instance" "main" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.main.id]
  key_name               = var.key_name

  user_data = <<-EOF
#!/bin/bash
exec > /var/log/user-data.log 2>&1
amazon-linux-extras install docker -y
systemctl start docker
systemctl enable docker
sleep 10
docker pull mohdsufiyan04/spring-boot-web:7
docker run -d -p 8080:8080 mohdsufiyan04/spring-boot-web:7
echo "Setup complete!"
EOF

  tags = {
    Name        = "${var.environment}-server"
    Environment = var.environment
  }
}