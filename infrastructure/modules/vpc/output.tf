output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnets" {
  value = [aws_subnet.public.id]
}

output "public_subnets" {
  value = [aws_subnet.public.id, aws_subnet.public_2.id]
}
