resource "aws_key_pair" "deployer" {
  key_name = "aws-key"
  # public_key = file("${path.module}/ssh.txt")
  public_key = var.ssh_pub
}

resource "aws_instance" "vm" {
  ami                         = "ami-0c7217cdde317cfec"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.deployer.key_name
  subnet_id                   = aws_subnet.subnet.id
  vpc_security_group_ids      = [aws_security_group.security_group.id]
  associate_public_ip_address = true # ip public

  tags = {
    Name = "VM-terraform"
  }
}

resource "aws_eip" "ip_elastico" {
  instance   = aws_instance.vm.id
  domain     = "vpc"
  depends_on = [aws_internet_gateway.internet_gateway]

  tags = {
    Name = "ip_elastico-terraform"
  }
}

resource "aws_route53_zone" "main" {
  name = "thalesdev.com.br"
}

resource "aws_route53_record" "www_record" {
  zone_id    = aws_route53_zone.main.zone_id
  name       = "thalesdev.com.br"
  type       = "A"
  ttl        = 300
  records    = [aws_eip.ip_elastico.public_ip]
  depends_on = [aws_eip.ip_elastico]
}
