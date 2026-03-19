
variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}


variable "cluster_name" {
  description = "The name to use for all cluster resources"
  type        = string
}

variable "db_remote_state_bucket" {
  description = "name of s3 bucket for database's remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "path for db's remote state in s3"
  type        = string
}
