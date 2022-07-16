# ------------- create aws secret manager --------------------------

resource "aws_secretsmanager_secret" "iti_secret" {
  name                    = "iti_secret"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "iti_secret_version" {
  secret_id     = aws_secretsmanager_secret.iti_secret.id
  secret_string = tls_private_key.iti_key.private_key_pem

}

