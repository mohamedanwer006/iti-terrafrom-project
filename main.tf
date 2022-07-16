
#---------------- network module ---------------------
module "network" {
    source = "./network"
    vpc_cidr = var.vpc_cidr
    iti_public_subnet1_cidr=var.iti_public_subnet1_cidr
    iti_public_subnet2_cidr=var.iti_public_subnet2_cidr
    iti_private_subnet1_cidr=var.iti_private_subnet1_cidr
    iti_private_subnet2_cidr=var.iti_private_subnet2_cidr
    region=var.region   
}