#create a vpc for rds
resource "aws_vpc" "rds_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "rds_vpc"
  }
}

#create two az subnet for rds
resource "aws_subnet" "rds_subnet_1" {
  vpc_id = aws_vpc.rds_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "rds_subnet_1"
  }
}
resource "aws_subnet" "rds_subnet_2" {
  vpc_id = aws_vpc.rds_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "rds_subnet_2"
  }
}
#create a db subnet group for rds
resource "aws_db_subnet_group" "rds_db_subnet_group" {
  name = "rds_db_subnet_group"
  description = "DB subnet group for RDS"
  subnet_ids = [aws_subnet.rds_subnet_1.id, aws_subnet.rds_subnet_2.id]
  tags = {
    Name = "rds_db_subnet_group"
  }
}
#create a security group for rds
resource "aws_security_group" "rds_sg" {
  name = "rds_sg"
  description = "Security group for RDS"
  vpc_id = aws_vpc.rds_vpc.id
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "rds_sg"
  }
}

#Create a RDS instance
resource "aws_db_instance" "rds_instance" {
  engine = "mysql"
  engine_version = "8.4.7"
  multi_az = false
  identifier = "database-1"
  username = "admin"
  #manage_master_user_password = true     #dont use secret if creating replica, use own password instead
  password = "StrongPassword123!"         #else use own password if creating read replica
  instance_class = "db.t4g.micro"
  storage_type = "gp2"
  allocated_storage = 20
  max_allocated_storage = 1000
  db_subnet_group_name = aws_db_subnet_group.rds_db_subnet_group.name
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  availability_zone = "us-east-1a"
  ca_cert_identifier = "rds-ca-rsa2048-g1"
  port = 3306
  tags = {
    Name = "rds_instance-tf"
  }
  # performance_insights_enabled = true
  parameter_group_name = "default.mysql8.4"

  backup_retention_period = 7
  backup_window = "03:00-04:00"

  storage_encrypted = true
  maintenance_window = "Mon:05:00-Mon:06:00"

  deletion_protection = true

    # Skip final snapshot appears when you delete a DB instance, and the DB instance is not retained as a final snapshot. 
    #If you don't enable this, a final snapshot will be created before the DB instance is deleted, 
    #and the DB instance will be retained until the snapshot is created. 
    #If you enable this, no final snapshot will be created, and the DB instance will be deleted immediately.
  skip_final_snapshot = true
  depends_on = [ aws_db_subnet_group.rds_db_subnet_group ] # Ensure subnet group is created before the DB instance
}
#creating Read Replica of RDS instance
resource "aws_db_instance" "rds_read_replica" {
  replicate_source_db = aws_db_instance.rds_instance.arn
  #engine = "mysql"
  identifier = "database-1-replica"
  instance_class = "db.t4g.micro"
  multi_az = false
  publicly_accessible = false
  db_subnet_group_name = aws_db_subnet_group.rds_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  availability_zone = "us-east-1b"
  #ca_cert_identifier = "rds-ca-rsa2048-g1"
  #port = 3306
  tags = {
    Name = "rds_read_replica-tf"
  }
  deletion_protection = true
  skip_final_snapshot = true
}