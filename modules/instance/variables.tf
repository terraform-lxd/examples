variable "instances" {
  type = map(object({
    target = string
  }))
  description = "Instance definitions"
}

variable "remote" {
    type        = string
    description = "LXD remote to use"
}

variable "storage_pool" {
  type        = string
  description = "Storage pool to use"
}

variable "network" {
  type        = string
  description = "Network pool to use"
}

variable "instance_image" {
  type        = string
  description = "The image to use for LXD instances"
}
