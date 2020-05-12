variable "region" {
  description = "GCP region targeted"
  default     = "europe-west1"
}

variable "region_zone" {
  description = "GCP zone targeted"
  default     = "europe-west1-c"
}

variable "project_name" {
  description = "GCP project targeted"
}

# Remember to paste the one-line json into the variable value
variable "GOOGLE_CREDENTIALS" {
  description = "GCP access credentials"
}
