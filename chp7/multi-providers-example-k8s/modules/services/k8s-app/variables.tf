
variable "name" {
  description = "name for all resources created by this module"
  type        = string
}

variable "image" {
  description = "docker img to run"
  type        = string
}

variable "container_port" {
  description = "port docker img listens on"
  type        = number
}

variable "replicas" {
  description = "num replicas to run"
  type        = number
}

variable "environment_variables" {
  description = "env vars"
  type        = map(string)
  default     = {}
}
