# --- ELASTIC FILE SYSTEM (EFS) ---

resource "aws_efs_file_system" "wordpress_efs" {
  creation_token = "wordpress-efs"
  encrypted      = true

  tags = {
    Name = "${var.project_name}-efs"
  }
}

#EFS in first private subnet
resource "aws_efs_mount_target" "mount_1" {
  file_system_id  = aws_efs_file_system.wordpress_efs.id
  subnet_id       = aws_subnet.private_1.id
  security_groups = [aws_security_group.efs_sg.id]
}

#EFS in second private subnet
resource "aws_efs_mount_target" "mount_2" {
  file_system_id  = aws_efs_file_system.wordpress_efs.id
  subnet_id       = aws_subnet.private_2.id
  security_groups = [aws_security_group.efs_sg.id]
}


# --- RELATIONAL DATABASE SERVICE (RDS) ---

#Group subnets for DB
resource "aws_db_subnet_group" "wordpress_db_subnet_group" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

#DB
resource "aws_db_instance" "wordpress_db" {
  identifier        = "wordpress-db"
  allocated_storage = 20 # ГБ
  storage_type      = "gp2"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro" #Free Tier

  db_name  = "wordpress"
  username = var.db_username
  password = var.db_password

  #Network configuration
  db_subnet_group_name   = aws_db_subnet_group.wordpress_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  multi_az               = false #Save some cents
  publicly_accessible    = false
  skip_final_snapshot    = true #Save time when delete
}
