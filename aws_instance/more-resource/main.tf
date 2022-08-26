locals {
  ami_id = "ami-0e040c48614ad1327"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMdUwZnfdmS2LSIi3zIfCNMadzqlPBb9HEuuh6m5AURY lukma@winten"
}

resource "random_pet" "rp" {
  length    = 3

  keepers = {
    ami_id_from_random = local.ami_id
  }
}

resource "aws_instance" "app_server" {
  ami           = "${random_pet.rp.keepers.ami_id_from_random}" 	
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]

  connection {
    type = "ssh"
    user = "ubuntu"
    host = self.public_ip
    port = 22
    timeout = "2m"
    private_key = file("${path.module}/test")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y",
    ]
  }

  tags = {
    Name = random_pet.rp.id
  }

  depends_on = [random_pet.rp, aws_key_pair.deployer, aws_security_group.allow_http_ssh]
}