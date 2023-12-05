resource "aws_instance" "pro_instance" {
  ami           = var.ami_id
  count         = var.number_of_instance
  instance_type = var.instance_type
  key_name      = var.key_pair
  subnet_id     = aws_subnet.pro_sub[count.index].id

  security_groups = [aws_security_group.loadbalancer.id]

  user_data = file("user_data.sh")
  # Additional EC2 instance configuration, e.g., user data, tags, etc.

  tags = {
    Name = "ayotf-ec2-instance"
  }
}

