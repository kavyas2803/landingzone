 resource "aws_vpc" "awsroot_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnets_cidir_numbers)
  vpc_id            = aws_vpc.awsroot_vpc.id
  cidr_block        = element(var.public_subnets_cidir_numbers, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.awsroot_vpc.id
  tags = {
    Name = var.ig_name
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.awsroot_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = var.public_route_table_name
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  count          = length(aws_subnet.public_subnet[*].id)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnets_cidir_numbers)
  vpc_id            = aws_vpc.awsroot_vpc.id
  cidr_block        = element(var.private_subnets_cidir_numbers, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "Private Subnet ${count.index + 1}"
  }
}

resource "aws_eip" "nat-gateway-eip" {
  depends_on = [aws_route_table.public_route_table]
  domain     = "vpc"
}

resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.nat-gateway-eip.id
  subnet_id     = aws_subnet.public_subnet[0].id
  depends_on    = [aws_internet_gateway.internet_gateway]
  tags = {
    Name = var.nat_name
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.awsroot_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway.id
  }

  tags = {
    Name = var.private_route_table_name
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  count          = length(aws_subnet.private_subnet[*].id)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_network_acl" "public_acl" {
  vpc_id = aws_vpc.awsroot_vpc.id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = var.public_acl_name
  }
}

resource "aws_network_acl_association" "public_acl_association" {
  count          = length(aws_subnet.public_subnet[*].id)
  network_acl_id = aws_network_acl.public_acl.id
  subnet_id      = aws_subnet.public_subnet[count.index].id
}

resource "aws_network_acl" "private_acl" {
  vpc_id = aws_vpc.awsroot_vpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = aws_subnet.public_subnet[0].cidr_block
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = var.private_acl_name
  }
}

resource "aws_network_acl_association" "private_acl_association" {
  count          = length(aws_subnet.private_subnet[*].id)
  network_acl_id = aws_network_acl.private_acl.id
  subnet_id      = aws_subnet.private_subnet[count.index].id
}

# //PRODUCTION ACCOUNT
# resource "aws_vpc" "prod_vpc" {
#   cidr_block = var.prod_vpc_cidr
#   tags = {
#     Name = var.prod_vpc_name
#   }
# }

# resource "aws_subnet" "prod_public_subnet" {
#   count             = length(var.prod_public_subnets_cidir_numbers)
#   vpc_id            = aws_vpc.prod_vpc.id
#   cidr_block        = element(var.prod_public_subnets_cidir_numbers, count.index)
#   availability_zone = element(var.prod_azs, count.index)
#   tags = {
#     Name = "Public Subnet ${count.index + 1}"
#   }
# }

# resource "aws_internet_gateway" "prod_internet_gateway" {
#   vpc_id = aws_vpc.prod_vpc.id
#   tags = {
#     Name = var.prod_ig_name
#   }
# }

# resource "aws_route_table" "prod_public_route_table" {
#   vpc_id = aws_vpc.prod_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.prod_internet_gateway.id
#   }

#   tags = {
#     Name = var.prod_public_route_table_name
#   }
# }

# resource "aws_route_table_association" "prod_public_route_table_association" {
#   count          = length(aws_subnet.prod_public_subnet[*].id)
#   subnet_id      = aws_subnet.prod_public_subnet[count.index].id
#   route_table_id = aws_route_table.prod_public_route_table.id
# }

# resource "aws_subnet" "prod_private_subnet" {
#   count             = length(var.prod_private_subnets_cidir_numbers)
#   vpc_id            = aws_vpc.prod_vpc.id
#   cidr_block        = element(var.prod_private_subnets_cidir_numbers, count.index)
#   availability_zone = element(var.prod_azs, count.index)
#   tags = {
#     Name = "Private Subnet ${count.index + 1}"
#   }
# }

# resource "aws_eip" "prod_nat-gateway-eip" {
#   depends_on = [aws_route_table.prod_public_route_table]
#   domain     = "vpc"
# }

# resource "aws_nat_gateway" "prod_nat-gateway" {
#   allocation_id = aws_eip.prod_nat-gateway-eip.id
#   subnet_id     = aws_subnet.prod_public_subnet[0].id
#   depends_on    = [aws_internet_gateway.prod_internet_gateway]
#   tags = {
#     Name = var.prod_nat_name
#   }
# }

# resource "aws_route_table" "prod_private_route_table" {
#   vpc_id = aws_vpc.prod_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_nat_gateway.prod_nat-gateway.id
#   }

#   tags = {
#     Name = var.prod_private_route_table_name
#   }
# }

# resource "aws_route_table_association" "prod_private_route_table_association" {
#   count          = length(aws_subnet.prod_private_subnet[*].id)
#   subnet_id      = aws_subnet.prod_private_subnet[count.index].id
#   route_table_id = aws_route_table.prod_private_route_table.id
# }

# resource "aws_network_acl" "prod_public_acl" {
#   vpc_id = aws_vpc.prod_vpc.id

#   ingress {
#     protocol   = -1
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 0
#     to_port    = 0
#   }

#   egress {
#     protocol   = -1
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 0
#     to_port    = 0
#   }

#   tags = {
#     Name = var.prod_public_acl_name
#   }
# }

# resource "aws_network_acl_association" "prod_public_acl_association" {
#   count          = length(aws_subnet.prod_public_subnet[*].id)
#   network_acl_id = aws_network_acl.prod_public_acl.id
#   subnet_id      = aws_subnet.prod_public_subnet[count.index].id
# }

# resource "aws_network_acl" "prod_private_acl" {
#   vpc_id = aws_vpc.prod_vpc.id

#   egress {
#     protocol   = "tcp"
#     rule_no    = 200
#     action     = "allow"
#     cidr_block = aws_subnet.prod_public_subnet[0].cidr_block
#     from_port  = 443
#     to_port    = 443
#   }

#   ingress {
#     protocol   = -1
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 0
#     to_port    = 0
#   }

#   tags = {
#     Name = var.prod_private_acl_name
#   }
# }

# resource "aws_network_acl_association" "prod_private_acl_association" {
#   count          = length(aws_subnet.prod_private_subnet[*].id)
#   network_acl_id = aws_network_acl.prod_private_acl.id
#   subnet_id      = aws_subnet.prod_private_subnet[count.index].id
# }

# //non production
# resource "aws_vpc" "nonprod_vpc" {
#   cidr_block = var.nonprod_vpc_cidr
#   tags = {
#     Name = var.nonprod_vpc_name
#   }
# }

# resource "aws_subnet" "nonprod_public_subnet" {
#   count             = length(var.nonprod_public_subnets_cidir_numbers)
#   vpc_id            = aws_vpc.nonprod_vpc.id
#   cidr_block        = element(var.nonprod_public_subnets_cidir_numbers, count.index)
#   availability_zone = element(var.nonprod_azs, count.index)
#   tags = {
#     Name = "Public Subnet ${count.index + 1}"
#   }
# }

# resource "aws_internet_gateway" "nonprod_internet_gateway" {
#   vpc_id = aws_vpc.nonprod_vpc.id
#   tags = {
#     Name = var.nonprod_ig_name
#   }
# }

# resource "aws_route_table" "nonprod_public_route_table" {
#   vpc_id = aws_vpc.nonprod_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.nonprod_internet_gateway.id
#   }

#   tags = {
#     Name = var.nonprod_public_route_table_name
#   }
# }

# resource "aws_route_table_association" "nonprod_public_route_table_association" {
#   count          = length(aws_subnet.nonprod_public_subnet[*].id)
#   subnet_id      = aws_subnet.nonprod_public_subnet[count.index].id
#   route_table_id = aws_route_table.nonprod_public_route_table.id
# }

# resource "aws_subnet" "nonprod_private_subnet" {
#   count             = length(var.nonprod_private_subnets_cidir_numbers)
#   vpc_id            = aws_vpc.nonprod_vpc.id
#   cidr_block        = element(var.nonprod_private_subnets_cidir_numbers, count.index)
#   availability_zone = element(var.nonprod_azs, count.index)
#   tags = {
#     Name = "Private Subnet ${count.index + 1}"
#   }
# }

# resource "aws_eip" "nonprod_nat-gateway-eip" {
#   depends_on = [aws_route_table.nonprod_public_route_table]
#   domain     = "vpc"
# }

# resource "aws_nat_gateway" "nonprod_nat-gateway" {
#   allocation_id = aws_eip.nonprod_nat-gateway-eip.id
#   subnet_id     = aws_subnet.nonprod_public_subnet[0].id
#   depends_on    = [aws_internet_gateway.nonprod_internet_gateway]
#   tags = {
#     Name = var.nonprod_nat_name
#   }
# }

# resource "aws_route_table" "nonprod_private_route_table" {
#   vpc_id = aws_vpc.nonprod_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_nat_gateway.nonprod_nat-gateway.id
#   }

#   tags = {
#     Name = var.nonprod_private_route_table_name
#   }
# }

# resource "aws_route_table_association" "nonprod_private_route_table_association" {
#   count          = length(aws_subnet.nonprod_private_subnet[*].id)
#   subnet_id      = aws_subnet.nonprod_private_subnet[count.index].id
#   route_table_id = aws_route_table.nonprod_private_route_table.id
# }

# resource "aws_network_acl" "nonprod_public_acl" {
#   vpc_id = aws_vpc.nonprod_vpc.id

#   ingress {
#     protocol   = -1
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 0
#     to_port    = 0
#   }

#   egress {
#     protocol   = -1
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 0
#     to_port    = 0
#   }

#   tags = {
#     Name = var.nonprod_public_acl_name
#   }
# }

# resource "aws_network_acl_association" "nonprod_public_acl_association" {
#   count          = length(aws_subnet.nonprod_public_subnet[*].id)
#   network_acl_id = aws_network_acl.nonprod_public_acl.id
#   subnet_id      = aws_subnet.nonprod_public_subnet[count.index].id
# }

# resource "aws_network_acl" "nonprod_private_acl" {
#   vpc_id = aws_vpc.nonprod_vpc.id

#   egress {
#     protocol   = "tcp"
#     rule_no    = 200
#     action     = "allow"
#     cidr_block = aws_subnet.nonprod_public_subnet[0].cidr_block
#     from_port  = 443
#     to_port    = 443
#   }

#   ingress {
#     protocol   = -1
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 0
#     to_port    = 0
#   }

#   tags = {
#     Name = var.nonprod_private_acl_name
#   }
# }

# resource "aws_network_acl_association" "nonprod_private_acl_association" {
#   count          = length(aws_subnet.nonprod_private_subnet[*].id)
#   network_acl_id = aws_network_acl.nonprod_private_acl.id
#   subnet_id      = aws_subnet.nonprod_private_subnet[count.index].id
# }

