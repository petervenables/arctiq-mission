
terraform {
  required_providers {
    sysdig = {
      source  = "sysdiglabs/sysdig"
    }
  }
}
provider "sysdig" {
  sysdig_secure_url       = "https://app.us4.sysdig.com"
  sysdig_secure_api_token = "4d2817a3-57e2-42bb-8e53-e16773fd25fc"
}
provider "google" {
  project = "pvenables-arctiq-mission"
  region = "us-central1"
}
provider "google-beta" {
  project = "pvenables-arctiq-mission"
  region = "us-central1"
}
module "secure-for-cloud_example_single-project" {
  source = "sysdiglabs/secure-for-cloud/google//examples/single-project"
}