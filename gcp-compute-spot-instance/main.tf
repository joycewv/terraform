terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

variable "projectid" {
  type = string
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

provider "google" {
  credentials = file("service_account_key.json")
  project = var.projectid
  region  = var.region
  zone    = var.zone

}

#resource "google_compute_network" "vpc_network" {
#  name = "terraform-network"
#}

resource "google_compute_instance" "spot_instance" {
  name         = "my-spot-vm"
  machine_type = "n1-standard-1"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }
  scheduling {
    preemptible = true
    automatic_restart = false
  }
}