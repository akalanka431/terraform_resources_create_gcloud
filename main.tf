provider "google" {
  project = "steam-circlet-355619"
  credentials = "${file("credintials.json")}"
  region = "us-central1"
  zone = "us-central1-c"
}

resource "google_compute_instance" "my_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"
  zone         = "us-central1-a"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"  # Use a valid image name or family
    }
  }

  network_interface {
    network = google_compute_network.terraform_network.self_link
    subnetwork = google_compute_subnetwork.terraform_subnet.self_link
    access_config {
      // Leave this empty or configure additional settings as needed
    }
  }
}

resource "google_compute_network" "terraform_network" {
  name = "terraform-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "terraform_subnet" {
  name = "terraform-subnetwork"
  ip_cidr_range = "10.20.0.0/16"
  region = "us-central1"
  network = google_compute_network.terraform_network.id
}

