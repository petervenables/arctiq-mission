terraform {
  backend "gcs" {
    bucket = "b4ebadf740d96109-bucket-tfstate"
    prefix = "terraform/state"
  }
}