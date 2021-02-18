variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  default = "kpctopoc"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default = "eastus"
}

variable "mypublicip" {
  description = "Public IP used to access Azure resources"
  default = "67.84.98.51"
}