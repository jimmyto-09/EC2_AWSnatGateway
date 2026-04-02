# Security group para EC2 privada
resource "aws_security_group" "sg_privado" {
  name        = "sg_privado"
  description = "Permitir salida a internet"
  vpc_id      = aws_vpc.red_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_privado"
  }
}


resource "aws_security_group" "sg_publico" {
  name        = "sg_publico"
  description = "Acceso a EC2 publica"
  vpc_id      = aws_vpc.red_vpc.id

  ingress {
    description = "Ping"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_publico"
  }
}