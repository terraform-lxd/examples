module "instances" {
  source = "./modules/instance"

  instances      = var.instances
  instance_image = var.instance_image
  storage_pool   = var.storage_pool
  network        = var.network
  remote         = var.remote
}
