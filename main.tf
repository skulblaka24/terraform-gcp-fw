# Configure the Google Cloud provider
provider "google" {
  region  = var.region
  project = var.project_name
}

resource "google_compute_firewall" "allow-inbound-nginx" {
  name    = "tf-demo1-allow-inbound-nginx"
  network = "default"
 
  allow {
    protocol = "tcp"
    ports    = ["443"]
  } 

  target_tags = ["nginx"]
}



