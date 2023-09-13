resource "aws_security_group" "terraform_security_group" {
  name        = "terraform_sg"
  description = "Teste com terraform para criacao de um security group"
  vpc_id      = aws_vpc.terraform_vpc.id
}

resource "aws_security_group_rule" "terraform_security_group_rule_out" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.terraform_security_group.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "terraform_security_group_rule_in" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.terraform_security_group.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "terraform_security_group_rule_http_in" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.terraform_security_group.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_key_pair" "terraform_key_pair" {
  key_name   = "terraform-key-ec2"
  public_key = file("~/.ssh/terraform-key-ec2.pub")
}

resource "aws_instance" "terraform_instance_ec2" {
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.terraform_key_pair.id
  vpc_security_group_ids = [aws_security_group.terraform_security_group.id]
  subnet_id              = aws_subnet.terraform_subnet.id
  ami                    = data.aws_ami.terraform_ami.id
  user_data              = file("./userdata.tpl")

  root_block_device {
    volume_size = 8
  }

  tags = {
    "Name" = "terraform instance ec2"
  }
}
