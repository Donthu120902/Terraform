resource "aws_instance" "web"{
  ami   = "ami-081bb417559035fe8"
  instance_type = "t2.micro"
  availability_zone = "ap-south-1b"
  associate_public_ip_address = "true"
  key_name = "AWSAutomation"
  tags = {

    Name = "webserver"
  }
   provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 775 /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
  }
  connection {
    type = "ssh"
    user = "ec2-user"
    host = "${aws_instance.web.public_ip}"
    private_key = file("AWSAutomation.pem")
    agent = false
    timeout = "2m"
  }
}
