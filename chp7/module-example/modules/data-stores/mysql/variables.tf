
variable "db_username" {
  description = "user for db"
  type = string
  sensitive = true
}

variable "db_password" {
  description = "pw for db"
  type = string
  sensitive = true
}
