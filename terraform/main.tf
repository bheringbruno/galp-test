locals {

  public_subnet_count  = floor(var.subnet_count / 2)
  private_subnet_count = ceil(var.subnet_count / 2)
  vpc_cidr             = "20.20.0.0/16"
}



module "network" {
source = "./modules/network"
  vpc_cidr             = local.vpc_cidr
  public_subnet_count  = local.public_subnet_count
  private_subnet_count = local.private_subnet_count
  environment          = var.name
}

module "ec2" {
source = "./modules/instance_ec2"
  subnet_count         = var.subnet_count
  private_subnet       = module.network.private_subnet
  bastion_subnet       = module.network.public_subnet
  vpc_id               = module.network.vpc_id
  vpc_cidr_block       = [module.network.vpc_cidr_block]
  instance_type        = "t3.micro"
  launch_template_name = "${var.name}-launch-template"
  environment          = var.name
}  


resource "local_file" "ssh_cert" {
  content  = filebase64("../files/ssh_crt.txt")
  filename = "teste-ssh-crt"
}
