module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "7.1.0"
  identifier = "my-rds-instance"

  engine            = "mysql"
  engine_version = "8.4.7"
  major_engine_version = "8.4"  #found after getiiong error for major version
  family = "mysql8.4"   #found after getiiong error for family
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "mydb"
  username = "admin"
#   password = "StrongPassword123!"   # ⚠️ avoid hardcoding in real use

  publicly_accessible = true
  skip_final_snapshot = true

#   subnet_ids = ["subnet-0e7ff6b8e7c2fc142", "subnet-016a4fbed17bb0f15"]
  
}