


# Abrufen des letzten Snapshots
data "aws_db_snapshot" "db_snapshot" {
  most_recent            = true
  db_instance_identifier = " DatenBank Identifier "
}
# Erstellung eine neue Datenbank von dem Snapshot
resource "aws_db_instance" "db" {
  instance_class         = "db.t2.micro"
  identifier             = "db-uat"
  username               = "xxx"
  password               = "xxx"
  db_subnet_group_name   = aws_subnet.private_subnet_1
  snapshot_identifier    = data.aws_db_snapshot.db_snapshot.id
  vpc_security_group_ids = [aws_security_group.database-security-group]
  skip_final_snapshot    = true
}