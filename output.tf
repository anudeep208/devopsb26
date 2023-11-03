output "vpc_id" {
  value = aws_vpc.default.id
}

output "subnet1_id" {
  value = aws_subnet.subnet1-public.id
}

output "subnet2_id" {
  value = aws_subnet.subnet2-public.id
}

output "subnet3_id" {
  value = aws_subnet.subnet3-public.id
}

output "gateway_id" {
  value = aws_internet_gateway.default.id
}

output "security_id" {
  value = aws_security_group.allow_all.id
}

