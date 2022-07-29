# ---------------------- create rds instance -----------------------


resource "aws_db_instance" "iti_mysql_instance" {
  allocated_storage    = 10
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  name                 = var.name
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  availability_zone = "${var.region}a"
  skip_final_snapshot  = true

}


# ---------------------- create elasticache instance ----------------------

# resource "aws_elasticache_cluster" "iti_elasticache" {
#   cluster_id            = var.name
#   engine                = var.engine
#   engine_version        = var.engine_version
#   node_type             = var.instance_class
#   num_cache_nodes       = 1
#   port                  = 6379
#   subnet_group_name     = aws_subnet_group.iti_elasticache_subnet_group.name
#   security_group_ids    = [aws_security_group.iti_sg.id]
#   tags = {
#     Name      = var.name
#     createdBy = "terraform"
#   }
# }

resource "aws_elasticache_subnet_group" "elasticache_subnet_group" {

  name       = "iti-cache-subnets"
  subnet_ids = ["${module.network.iti_private_subnet1_id}", "${module.network.iti_private_subnet2_id}"]
}

resource "aws_elasticache_cluster" "iti_elasticache_cluster" {
  cluster_id           = "cluster-example"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.elasticache_subnet_group.name
}
