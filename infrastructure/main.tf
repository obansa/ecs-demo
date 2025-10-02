module "vpc" {
  source = "./modules/vpc"
  vpc_cider = "10.0.0.0/16"
}


module "ecs" {
  source = "./modules/ecs"
  cluster_name = "main-cluster"
  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.subnets
  lb_tg_arn = module.alb.alb_target_group_arn
  lb_listener_arn = module.alb.lb_listener
}

module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.public_subnets
}

output "alb_listener_dns" {
  value = module.alb.dns_name
}
