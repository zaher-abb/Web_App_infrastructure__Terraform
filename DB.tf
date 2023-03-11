
data "aws_db_snapshot" "db_snapshot" {
  most_recent            = true
  db_instance_identifier = "hier wird die Identifier von dem Snapshot geschrieben"
}

resource "aws_db_instance" "db" {
  instance_class         = "db.t2.micro"
  identifier             = ""
  username               = "admin"
  password               = "admin123456789"
  db_subnet_group_name   = aws_subnet.private_subnet_1
  snapshot_identifier    = data.aws_db_snapshot.db_snapshot.id
  vpc_security_group_ids = [aws_security_group.database-security-group]
  skip_final_snapshot    = false
}