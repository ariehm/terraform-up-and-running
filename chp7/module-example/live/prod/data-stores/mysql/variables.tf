
variable "db_username" {
  description = "username for db"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "pw for db"
  type        = string
  sensitive   = true
}
