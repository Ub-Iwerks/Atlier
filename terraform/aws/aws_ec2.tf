##EC2(atlier-web01_tf)
resource "aws_instance" "atlier-web01_tf" {
  ami                     = var.ami
  instance_type           = var.instance_type
  disable_api_termination = false
  key_name                = "atlier-prod-web1a"
  vpc_security_group_ids  = [aws_security_group.atlier-web_tf.id]
  subnet_id               = aws_subnet.public-a.id

  root_block_device {
    volume_type = "gp2"
    volume_size = var.volume_size
  }

  tags = {
    Name = "atlier-web01_tf"
  }
}

##EIP(atlier-web01_tf)
resource "aws_eip" "atlier-web01_tf" {
  instance = aws_instance.atlier-web01_tf.id
  vpc      = true
}