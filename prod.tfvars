region                   = "us-east-1"
ami                      = "ami-052efd3df9dad4825"
vpc_cidr                 = "10.0.0.0/16"
iti_public_subnet1_cidr  = "10.0.0.0/24"
iti_public_subnet2_cidr  = "10.0.1.0/24"
iti_private_subnet1_cidr = "10.0.2.0/24"
iti_private_subnet2_cidr = "10.0.3.0/24"
ec2_instance_type        = "t2.micro"

# database configuration
engine               = "mysql"
engine_version       = "5.7"
instance_class       = "db.t2.micro"
name                 = "mydb"
username             = "user1"
password             = "password"
parameter_group_name = "default.mysql5.7"

