# terraform import google_kms_key_ring.vault_keyring projects/starfly/locations/europe-west1/keyRings/vault-raft-3
# terraform import google_kms_crypto_key.vault_key projects/starfly/locations/europe-west1/keyRings/vault-raft-3/cryptoKeys/unseal_key-3

resource "google_service_account" "kms_access" {
  account_id   = "${var.project_name}-kms"
  display_name = "${var.project_name} Account"
}

resource "random_string" "number" {
  length  = 16
  upper   = false
  lower   = false
  number  = true
  special = false
}

resource "google_kms_key_ring" "vault_keyring" {
  name     = random_string.number.result
  project  = var.project_name
  location = var.gkms_location
}

resource "google_kms_crypto_key" "vault_key" {
  name     = var.gkms_vault_key
  key_ring = google_kms_key_ring.vault_keyring.self_link
}

resource "google_kms_key_ring_iam_binding" "vault_iam_kms_binding" {
  key_ring_id = "${var.project_name}/${var.gkms_location}/${var.gkms_vault_key_ring}"
  role        = "roles/owner"

  members = [
    "serviceAccount:${var.project_name}-kms@${var.project_name}.iam.gserviceaccount.com",
  ]
  depends_on = [google_kms_crypto_key.vault_key]
}

resource "google_project_iam_member" "project" {
  project = "starfly"
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member  = "serviceAccount:${var.project_name}-kms@${var.project_name}.iam.gserviceaccount.com"
  depends_on = [google_kms_crypto_key.vault_key]
}
