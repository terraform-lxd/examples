resource "lxd_volume" "disk" {
  for_each = var.instances

  name         = "${each.key}-disk"
  description  = "Data disk for ${each.key}"
  type         = "custom"
  content_type = "block"
  pool         = var.storage_pool
  target       = each.value.target
  remote       = var.remote

  config = {
    size = "10GiB"
  }
}

resource "lxd_instance" "microcloud" {
  for_each = var.instances

  name             = each.key
  type             = "virtual-machine"
  image            = var.instance_image
  target           = each.value.target
  remote           = var.remote

  wait_for_network = true

  limits = {
    cpu    = "2"
    memory = "2GiB"
  }

  config = {
    "user.access_interface" : "eth0"
  }

  profiles = []

  # Uplink.
  device {
    name = "eth0"
    type = "nic"
    properties = {
      network = var.network
    }
  }

  # Root disk.
  device {
    name = "root"
    type = "disk"
    properties = {
      path = "/"
      pool = var.storage_pool
    }
  }

  # Data disk.
  device {
    name = "disk"
    type = "disk"
    properties = {
      pool   = var.storage_pool
      source = lxd_volume.disk[each.key].name
    }
  }
}

# Return instance information from the module.
output "instance_info" {
  value = {
    for instance in lxd_instance.microcloud : instance.name => {
      ip4 = instance.ipv4_address
      ip6 = instance.ipv6_address
      mac = instance.mac_address
    }
  }
}
