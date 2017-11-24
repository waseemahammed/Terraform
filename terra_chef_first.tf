export PATH=$PATH:/home/terraform

sudo ln -s /home/terraform terraform



provider "aws" {
  access_key = "Access_Key_Here"
  secret_key = "Secret_Key_Here"
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}

  provisioner "chef" {
    environment     = "production"
    run_list        = ["tomcat::server"]
    node_name       = "webserver1"
    server_url      = "Chef_manage_URL"
    recreate_client = true
    user_name       = "username"
    user_key        = "${file("../")}"
    version         = "12.4.1"
  }
}
