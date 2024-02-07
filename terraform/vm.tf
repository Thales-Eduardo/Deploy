resource "aws_key_pair" "deployer" {
  key_name   = "aws-key"
  public_key = file("${path.module}/ssh.txt")
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
