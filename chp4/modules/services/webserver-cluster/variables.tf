
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


variable "instance_type" {
  description = "tyep of ec2 instance to run (e.g. t2.micro)"
  type = string
}

variable "min_size" {
  description = "min # of ec2 instances in ASG"
  type = number
}

variable "max_size" {
  description = "max # of ec2 instances in ASG"
  type = number
}
