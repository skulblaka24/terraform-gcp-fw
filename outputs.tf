# Print out the vault node IPs.
output "gcp_instances_vault_ip" {
  value = google_compute_instance.vault.*.network_interface.0.access_config.0.nat_ip
}

output "gcp_dns_zone_nameservers" {
  value = google_dns_managed_zone.dns_zone.*.name_servers
}

output "gcp_key_ring_name" {
	value = google_kms_key_ring.vault_keyring.name
}