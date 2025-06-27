resource "aws_instance" "vpn" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.vpn_sg_id]
  subnet_id = local.public_subnet_id
  key_name = aws_key_pair.vpn_key.key_name
  user_data = file("openvpn.sh")
  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-vpn-server"
    }
  )
}

resource "aws_key_pair" "vpn_key" {
  key_name   = "vpn-key"
  public_key = file("C:/personal/Join-Devops/roboshop-dev-infra/30-vpn/vpn_key.pub")
}