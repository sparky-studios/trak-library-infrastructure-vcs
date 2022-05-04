variable "environment" {
  description = "The environment the Terraform configuration will create resources for."
  type        = string
  default     = "testing"
}

variable "region" {
  description = "The AWS-specific region to create the Terraform configuration within."
  type        = string
  default     = "eu-west-2"
}