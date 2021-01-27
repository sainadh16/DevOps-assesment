variable "json_string" {}
variable "secret_id" {}

resource "aws_secretsmanager_secret" "rdssql" {
  name = var.secret_id
}

resource "aws_secretsmanager_secret_version" "rdssql" {
  secret_id     = aws_secretsmanager_secret.rdssql.id
  secret_string = var.json_string
  recovery_window_in_days = 0
}

output "secrets" {
    value = aws_secretsmanager_secret_version.rdssql.secret_string
}

