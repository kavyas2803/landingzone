  source_name                   = "./networking components"
  vpc_cidr                      = "192.32.0.0/16"
  vpc_name                      = "awsroot_vpc"
  public_subnets_cidir_numbers  = ["192.32.3.0/24", "192.32.4.0/24"]
  private_subnets_cidir_numbers = ["192.32.1.0/24", "192.32.2.0/24"]
  azs                           = ["us-east-1a", "us-east-1b"]
  ig_name                       = "internet gateway"
  nat_name                      = "private-gateway"
  public_route_table_name       = "public subnet route table"
  private_route_table_name      = "private subnet route table"
  public_acl_name               = "public subnet acl"
  private_acl_name              = "private subnet acl"

  