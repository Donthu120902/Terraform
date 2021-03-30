resource "aws_instance" "Linux"{
  ami 	= "ami-081bb417559035fe8"
  instance_type = "t2.micro"
  availability_zone = "ap-south-1a"
  associate_public_ip_address = "true"  
  key_name = "AWSAutomation"
  tags = {
   
    Name = "LinuxHost-Tf"
  }

}
