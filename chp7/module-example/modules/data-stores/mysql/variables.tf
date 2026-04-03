
variable "db_name" {
  description = "name of db"
  type        = string
  default     = null
}

variable "db_username" {
  description = "user for db"
  type        = string
  sensitive   = true
  default     = null
}

variable "db_password" {
  description = "pw for db"
  type        = string
  sensitive   = true
  default     = null
}

variable "backup_retention_period" {
  description = "how long to keep backups, > 0 to enable"
  type        = number
  default     = null
}

variable "replicate_source_db" {
  description = "if specified, will replicate to given ARN"
  type        = string
  default     = null
}
