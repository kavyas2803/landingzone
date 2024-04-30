variable "vpc_name" {
  description = "vpc name"
  type        = string
}

variable "vpc_cidr" {
  description = "vpc_cdir"
  type        = string
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}

variable "public_subnets_cidir_numbers" {
  description = "public_subnet cidr numbers"
  type        = list(string)
}

variable "private_subnets_cidir_numbers" {
  description = "private_subnet cidr numbers"
  type        = list(string)
}

variable "ig_name" {
  description = "Internet gateway name"
  type        = string
}

variable "public_route_table_name" {
  description = "Public subnet route table name"
  type        = string
}

variable "nat_name" {
  description = "nat gateway name"
  type        = string
}

variable "private_route_table_name" {
  description = "Private subnet route table name"
  type        = string
}

variable "public_acl_name" {
  description = "public subnet acl name"
  type        = string
}

variable "private_acl_name" {
  description = "private subnet acl name"
  type        = string
}

variable "source_name" {
  description = "source name"
  type        = string
}

