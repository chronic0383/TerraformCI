variable "application_name" {
  description = "The name of the application."
  type        = string
}

variable "environment_name" {
  description = "The deployment environment (e.g., dev, test, prod)."
  type        = string
}

variable "primary_location" {
  type        = string
  description = "The primary location for resource deployment."
}
