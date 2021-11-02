output "service_account_email" {
  value = google_service_account.service_broker.email
}

output "csb_db_name" {
  value = google_sql_database_instance.csb.name
}
output "csb_db_connecion_name" {
  value = google_sql_database_instance.csb.connection_name
}