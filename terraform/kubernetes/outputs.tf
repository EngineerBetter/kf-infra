output "service_account_email" {
  value = google_service_account.default.email
}

output "service_account_name" {
  value = google_service_account.default.name
}