provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "web" {
  ami           = "ami-0a6b2839d44d781b2"
  instance_type = "t2.micro"
  count = 1
  tags = {
    Name    = "Jenkins Agent"
    Owner   = "devops"
	Project = "tf"
  }
  
}