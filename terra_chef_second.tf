provider "aws" {
  access_key = "Access_Key_Here"
  secret_key = "Secret_Key_Here"
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
  key_name   = "chef"
  security_groups = [
   "alltraffic"
  ]

  provisioner "chef" {
    environment     = "production"
    run_list        = ["tomcat::server"]
    node_name       = "webserver1"
    server_url      = "https://URL"
    recreate_client = true
    user_name       = "username"
    user_key        = "${file("/path/*.pem")}"
    version         = "12.4.1"
  }
}

connection {
  type        = "ssh"
  user        = "ubuntu"
  key    = "${file("/home/chef.pem")}"
}

