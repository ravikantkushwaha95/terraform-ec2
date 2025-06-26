variable "created_by" {
  type        = string
  description = "Created by "
}

variable "ami" {
  description = "Please provide ami for instance"
  type        = string

  validation {
    condition     = length(var.ami) > 0 && substr(var.ami, 0, 4) == "ami-"
    error_message = "Please provide a valid ami id "
  }
}