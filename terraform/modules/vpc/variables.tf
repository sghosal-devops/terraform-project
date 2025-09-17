variable "project" {
  description = "Project name used for tagging AWS resources"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}
