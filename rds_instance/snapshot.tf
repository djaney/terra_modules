data "external" "rds_final_snapshot_exists" {
    program = [
        "./check-rds-snapshot.sh",
        var.db_identifier
    ]
}


data "aws_db_snapshot" "latest_snapshot" {
    count                  = data.external.rds_final_snapshot_exists.result.db_exists ? 1 : 0
    db_instance_identifier = var.db_identifier
    most_recent            = true
}