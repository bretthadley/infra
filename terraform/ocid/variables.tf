variable "project_id" {
  type        = string
  description = "The project id to create WIF pool and example SA"
}

variable "sa_name" {
  type        = string
  description = "The service account name"
}

variable "sa_roles" {
  type        = list(string)
  description = "The service account roles"
}