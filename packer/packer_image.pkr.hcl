locals { 
    timestamp  = formatdate("YYYY-MM-DD", timestamp())
    ami_name   = var.ami_name
}

source "amazon-ebs" "ec2" {
  ami_name      = "${local.ami_name}-${local.timestamp}"
  instance_type = "t2.micro"
  region        = var.region
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.ec2"]

  provisioner "file" {
    source      = "../files/id_rsa.pub"
    destination = "/tmp/id_rsa.pub"
  }
  provisioner "shell" {
    script = "../scripts/setup.sh"
  }
  provisioner "shell" {
   inline = [
      "ls /var/www/html ; sudo echo 'hello world ${local.timestamp}' > /var/www/html/index.html && cat /var/www/html/index.html" ,
    ]
  }
}


