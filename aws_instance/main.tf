resource "aws_instance" "app_server" {
  ami           = "ami-0e040c48614ad1327" #ami-830c94e3 	
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}