variable "json_string" {}
variable "secret_id" {}

resource "aws_secretsmanager_secret" "example" {
  name = var.secret_id
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.example.id
  secret_string = var.json_string
}

output "secrets" {
    value = aws_secretsmanager_secret_version.example.secret_string
}

