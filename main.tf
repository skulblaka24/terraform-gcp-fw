# Configure the Google Cloud provider
provider "google" {
  region  = var.region
  project = var.project_name
  #https://console.cloud.google.com/apis/credentials/serviceaccountkey
  credentials = file(var.account_file_path)
}

resource "google_compute_firewall" "allow-inbound-nginx" {
  name    = "allow-inbound-nginx"
  network = "default"
 
  allow {
    protocol = "tcp"
    ports    = ["443"]
  } 

  target_tags = ["nginx"]
}



