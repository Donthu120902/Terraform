provider "aws"{
  region = var.region

}
resource "aws_vpc" "MyVpc"{
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "MyVpc-Tf"
  }

}
resource "aws_subnet" "subnet1"{

  vpc_id = "${aws_vpc.MyVpc.id}"
  cidr_block = "192.168.1.0/24"

  tags = {

    Name = "Subnet1-Tf"
  }

}
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.MyVpc.id}"

  tags = {
    Name = "My-Igw-Tf"
  }
}
resource "aws_route_table" "CustomRoute" {
  vpc_id = aws_vpc.MyVpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Customroute"
  }
}

resource "aws_route_table_association" "r" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.CustomRoute.id
}

resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.MyVpc.id

  ingress {
    description = "HTTPS"
    from_port   = 0
    to_port     = 65535
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
    Name = "webSG-Tf"
  }
}
resource "aws_instance" "Linux"{
  ami   = "ami-081bb417559035fe8"
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  key_name = "AWSAutomation"
  subnet_id = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.allow_web.id]
  tags = {

    Name = "LinuxHost-Tf"
  }

}
