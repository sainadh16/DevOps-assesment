

# data "aws_iam_policy_document" "enhanced_monitoring" {
#   statement {
#     actions = [
#       "sts:AssumeRole",
#     ]

#     principals {
#       type        = "Service"
#       identifiers = ["monitoring.rds.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_role" "enhanced_monitoring" {
#   count = var.create_monitoring_role ? 1 : 0

#   name               = var.monitoring_role_name
#   assume_role_policy = data.aws_iam_policy_document.enhanced_monitoring.json

#   tags = merge(
#     {
#       "Name" = format("%s", var.monitoring_role_name)
#     },
#     var.tags,
#   )
# }

# resource "aws_iam_role_policy_attachment" "enhanced_monitoring" {
#   count = var.create_monitoring_role ? 1 : 0

#   role       = aws_iam_role.enhanced_monitoring[0].name
#   policy_arn = "arn:${var.iam_partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
# }

#### subnet group 




resource "aws_db_instance" "this" {


  identifier = var.identifier

  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type
  storage_encrypted = var.storage_encrypted
  kms_key_id        = var.kms_key_id
  license_model     = var.license_model

  name                                = var.name
  username                            = var.username
  password                            = var.password
  port                                = var.port
  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name   = var.db_subnet_group_name
  parameter_group_name   = var.parameter_group_name
  availability_zone   = var.availability_zone
  multi_az            = var.multi_az
  iops                = var.iops
  publicly_accessible = var.publicly_accessible
  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = var.monitoring_interval > 0 ? coalesce(var.monitoring_role_arn, join(", ", aws_iam_role.enhanced_monitoring.*.arn), null) : null
  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  apply_immediately           = var.apply_immediately
  maintenance_window          = var.maintenance_window
  skip_final_snapshot         = var.skip_final_snapshot
  copy_tags_to_snapshot       = var.copy_tags_to_snapshot
  final_snapshot_identifier   = var.final_snapshot_identifier
  max_allocated_storage       = var.max_allocated_storage
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  deletion_protection      = var.deletion_protection
  delete_automated_backups = var.delete_automated_backups

  tags = merge(
    var.tags,
    {
      "Name" = format("%s", var.identifier)
    },
  )
}


