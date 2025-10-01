output "alb_dns_name" {
  value = aws_lb.main_alb.dns_name
}

output "alb_target_group_arn" {
  value = aws_lb_target_group.main_tg.arn
}

output "lb_listener" {
  value = aws_lb_listener.main_listener.arn
}