 output "app_external_ip" {
   value = google_compute_instance.app[count.index].network_interface.0.access_config.0.nat_ip
 }
