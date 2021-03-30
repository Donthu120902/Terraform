provider "aws"{
  region = "${var.region}"

}
resource "aws_vpc" "MyVpc"{
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "MyVpc-Tf"
  }

}
resource "aws_subnet" "subnets"{
  count = "${length(var.azs)}"
  vpc_id = "${aws_vpc.MyVpc.id}"
  cidr_block = "${element(var.subnet_cidr,count.index)}"
  
  tags = {

    Name = "Subnets-Tf${count.index+1}"
  }

}
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.MyVpc.id}"

  tags = {
    Name = "My-Igw-Tf"
  }
}
