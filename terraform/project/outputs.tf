output "gcp_credentials_json" {
  value = base64decode(google_service_account_key.ci_bot_key.private_key)
}