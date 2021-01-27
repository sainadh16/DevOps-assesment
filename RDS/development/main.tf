locals {
  json_credentials = {
    db_user = var.username
    db_pass = random_password.password.result
  }
}

resource "random_password" "password" {
  length = 16
  special = true
  override_special = "_%@"
}

module "secrets" {
  source = "../modules/secrets/"
  json_string = jsonencode(local.json_credentials)
  secret_id = "devel-rds"
}



module "RDS" {
  source                              = "../modules/Rds/"
  identifier                          = var.identifier
  engine                              = var.engine
  engine_version                      = var.engine_version
  instance_class                      = var.instance_class
  allocated_storage                   = var.allocated_storage
  max_allocated_storage               = var.max_allocated_storage
  storage_type                        = var.storage_type
  storage_encrypted                   = var.storage_encrypted
  kms_key_id                           = var.kms_key_id
  license_model                       = var.license_model
  name                                = var.name
  username                            = var.username
  password                            = jsondecode(module.secrets.secrets)["db_pass"]
  port                                = var.port
  vpc_security_group_ids              = var.vpc_security_group_ids
  db_subnet_group_name                = var.db_subnet_group_name
  parameter_group_name                = var.parameter_group_name_id
  availability_zone                   = var.availability_zone
  multi_az                            = var.multi_az
  publicly_accessible                 = var.publicly_accessible
  allow_major_version_upgrade         = var.allow_major_version_upgrade
  auto_minor_version_upgrade          = var.auto_minor_version_upgrade
  apply_immediately                   = var.apply_immediately
  maintenance_window                  = var.maintenance_window
  skip_final_snapshot                 = var.skip_final_snapshot
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  backup_retention_period             = var.backup_retention_period
  backup_window                       = var.backup_window
  timezone                            = var.timezone
  deletion_protection                 = var.deletion_protection
  delete_automated_backups            = var.delete_automated_backups

}
