variable "region"{
  default = "ap-south-1"
}
variable "vpc_cidr"{
  default = "192.168.0.0/16"
}
variable "subnet_cidr"{
  type = list(string)
  default = ["192.168.1.0/24","192.168.2.0/24","192.168.3.0/24"]
}
variable "azs"{
  type = list(string)
  default = ["ap-south-1a","ap-south-1b","ap-south-1c"]
}
