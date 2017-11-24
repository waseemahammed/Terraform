provider "aws" {
  access_key = "Access_Key_Here"
  secret_key = "Secret_Key_Here"
  region     = "us-east-1"
}


resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"

provisioner "chef" {
  server_url      = "${var.chef_provision.["server_url"]}"
  user_name       = "${var.chef_provision.["user_name"]}"
  user_key        = "${file("${var.chef_provision.["user_key_path"]}")}"
  node_name       = "${var.file_server.["hostname_prefix"]}-${count.index}"
  run_list        = ["role[fileserver]"]
  recreate_client = "${var.chef_provision.["recreate_client"]}"
  on_failure      = "continue"

  attributes_json = <<-EOF
  {
    "tags": [
      "fileserver"
    ]
  }
  EOF
  }
}

variable "chef_provision" { 
  type                      = "map"
  description               = "Configuration details for chef server"

  default = {
    server_url              = "https://URL"
    user_name               = "username"
    user_key_path           = "/path/*.pem"
    recreate_client         = true
    }
}  
