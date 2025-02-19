variable "instances" {
  type = map(object({
    target = optional(string)
  }))
  default = {
    "microcloud" = {}
  }
  description = "Instance definitions"
}

variable "remote" {
    type        = string
    default     = ""
    description = "LXD remote to use"
}

variable "storage_pool" {
  type        = string
  default     = "default"
  description = "Storage pool to use"
}

variable "network" {
  type        = string
  default     = "lxdbr0"
  description = "Network to use"
}

variable "instance_image" {
  type        = string
  default     = "ubuntu-minimal:24.04"
  description = "The image to use for LXD instances"
}
