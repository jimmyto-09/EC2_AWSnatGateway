resource "aws_instance" "mi_ec2v1" {
  ami           = "ami-08f9a9c699d2ab3f9"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.sg_publico.id]
  

  tags = {
    Name = "mi-ec2v1"
  }
}

resource "aws_instance" "mi_ec2v2" {
  ami           = "ami-08f9a9c699d2ab3f9"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.sg_privado.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_ssm_profile.name

  tags = {
    Name = "mi-ec2v2"
  }
}