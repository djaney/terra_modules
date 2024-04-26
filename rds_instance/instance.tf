resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_db_instance" "db" {
    allocated_storage         = var.allocated_storage
    identifier                = var.db_identifier
    db_name                   = var.db_name
    engine                    = var.engine
    engine_version            = var.engine_version
    instance_class            = var.instance_type
    storage_type              = "gp3"
    username                  = "root"
    password                  = random_password.db_password.result


    /*
    On first deployment, no snapshot exists. So database is deployed without snapshot.
    If database is replaced, always use last snapshot.
    */
    final_snapshot_identifier = "${var.db_identifier}-${formatdate("YYYYMMDDhhmmss", timestamp())}"
    snapshot_identifier       = try(data.aws_db_snapshot.latest_snapshot.0.id, null)
    skip_final_snapshot       = false

    storage_encrypted         = false

    backup_retention_period = 5
    backup_window           = "07:00-09:00"

    maintenance_window = "Tue:05:00-Tue:07:00"

    vpc_security_group_ids = [aws_security_group.allow_db_access]

    db_subnet_group_name = aws_db_subnet_group.main.name

    lifecycle {
        ignore_changes = [
        snapshot_identifier,
        final_snapshot_identifier
        ]
    }
}