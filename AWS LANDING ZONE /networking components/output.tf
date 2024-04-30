output "vpc_id" {
  value = aws_vpc.awsroot_vpc.id
 
}
 
output "vpc_cidr" {
  value = aws_vpc.awsroot_vpc.cidr_block
 
}
 
output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}
 
output "private_subnet_ids" {
  value = aws_subnet.private_subnet[*].id
}
 
output "public_route_table_id" {
  value = aws_route_table.public_route_table.id
 
}
 
output "private_route_table_id" {
  value = aws_route_table.private_route_table.id
 
}
 
output "public_acl_id" {
  value = aws_network_acl.public_acl.id
}
 
output "private_acl_id" {
  value = aws_network_acl.private_acl.id
}
 
# //production account

# output "prod_vpc_id" {
#   value = aws_vpc.prod_vpc.id
 
# }
 
# output "prod_vpc_cidr" {
#   value = aws_vpc.prod_vpc.cidr_block
 
# }
 
# output "prod_public_subnet_ids" {
#   value = aws_subnet.prod_public_subnet[*].id
# }
 
# output "prod_private_subnet_ids" {
#   value = aws_subnet.prod_private_subnet[*].id
# }
 
# output "prod_public_route_table_id" {
#   value = aws_route_table.prod_public_route_table.id
 
# }
 
# output "prod_private_route_table_id" {
#   value = aws_route_table.prod_private_route_table.id
 
# }
 
# output "prod_public_acl_id" {
#   value = aws_network_acl.prod_public_acl.id
# }
 
# output "prod_private_acl_id" {
#   value = aws_network_acl.prod_private_acl.id
# }
 
# //non production account
# output "nonprod_vpc_id" {
#   value = aws_vpc.nonprod_vpc.id
 
# }
 
# output "nonprod_vpc_cidr" {
#   value = aws_vpc.nonprod_vpc.cidr_block
 
# }
 
# output "nonprod_public_subnet_ids" {
#   value = aws_subnet.nonprod_public_subnet[*].id
# }
 
# output "nonprod_private_subnet_ids" {
#   value = aws_subnet.nonprod_private_subnet[*].id
# }
 
# output "nonprod_public_route_table_id" {
#   value = aws_route_table.nonprod_public_route_table.id
 
# }
 
# output "nonprod_private_route_table_id" {
#   value = aws_route_table.nonprod_private_route_table.id
 
# }
 
# output "nonprod_public_acl_id" {
#   value = aws_network_acl.nonprod_public_acl.id
# }
 
# output "nonprod_private_acl_id" {
#   value = aws_network_acl.nonprod_private_acl.id
# }
 
