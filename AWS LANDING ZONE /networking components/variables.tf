variable "vpc_name" {
  description = "vpc name"
  type        = string
  default     = ""
}
 
variable "vpc_cidr" {
  description = "vpc_cidr"
  type        = string
  default     = ""
}
 
variable "azs" {
 
  type        = list(string)
  description = "Availability Zones"
  default     = null
 
}
 
variable "public_subnets_cidir_numbers" {
  description = "public_subnet cidr numbers"
  type        = list(string)
  default     = null
}
 
variable "private_subnets_cidir_numbers" {
  description = "private_subnet cidr numbers"
  type        = list(string)
  default     = null
}
 
variable "ig_name" {
  description = "Internet gateway name"
  type        = string
  default     = ""
 
}
 
variable "nat_name" {
  description = "nat gateway name"
  type        = string
  default     = ""
}
 
variable "public_route_table_name" {
  description = "Public subnet route table name"
  type        = string
  default     = ""
 
}
 
variable "private_route_table_name" {
  description = "Private subnet route table name"
  type        = string
  default     = ""
 
}
 
variable "public_acl_name" {
  description = "public subnet acl name"
  type        = string
  default     = ""
}
 
variable "private_acl_name" {
  description = "private subnet acl name"
  type        = string
  default     = ""
}
 
variable "source_name" {
  description = "source name"
  type        = string
  default     = ""
}
#  //production account
#  variable "prod_vpc_name" {
#   description = "vpc name"
#   type        = string
#   default     = ""
# }
 
# variable "prod_vpc_cidr" {
#   description = "vpc_cidr"
#   type        = string
#   default     = ""
# }
 
# variable "prod_azs" {
 
#   type        = list(string)
#   description = "Availability Zones"
#   default     = null
 
# }
 
# variable "prod_public_subnets_cidir_numbers" {
#   description = "public_subnet cidr numbers"
#   type        = list(string)
#   default     = null
# }
 
# variable "prod_private_subnets_cidir_numbers" {
#   description = "private_subnet cidr numbers"
#   type        = list(string)
#   default     = null
# }
 
# variable "prod_ig_name" {
#   description = "Internet gateway name"
#   type        = string
#   default     = ""
 
# }
 
# variable "prod_nat_name" {
#   description = "nat gateway name"
#   type        = string
#   default     = ""
# }
 
# variable "prod_public_route_table_name" {
#   description = "Public subnet route table name"
#   type        = string
#   default     = ""
 
# }
 
# variable "prod_private_route_table_name" {
#   description = "Private subnet route table name"
#   type        = string
#   default     = ""
 
# }
 
# variable "prod_public_acl_name" {
#   description = "public subnet acl name"
#   type        = string
#   default     = ""
# }
 
# variable "prod_private_acl_name" {
#   description = "private subnet acl name"
#   type        = string
#   default     = ""
# }
 
# variable "prod_source_name" {
#   description = "source name"
#   type        = string
#   default     = ""
# }
#  //non production account
#  variable "nonprod_vpc_name" {
#   description = "vpc name"
#   type        = string
#   default     = ""
# }
 
# variable "nonprod_vpc_cidr" {
#   description = "vpc_cidr"
#   type        = string
#   default     = ""
# }
 
# variable "nonprod_azs" {
 
#   type        = list(string)
#   description = "Availability Zones"
#   default     = null
 
# }
 
# variable "nonprod_public_subnets_cidir_numbers" {
#   description = "public_subnet cidr numbers"
#   type        = list(string)
#   default     = null
# }
 
# variable "nonprod_private_subnets_cidir_numbers" {
#   description = "private_subnet cidr numbers"
#   type        = list(string)
#   default     = null
# }
 
# variable "nonprod_ig_name" {
#   description = "Internet gateway name"
#   type        = string
#   default     = ""
 
# }
 
# variable "nonprod_nat_name" {
#   description = "nat gateway name"
#   type        = string
#   default     = ""
# }
 
# variable "nonprod_public_route_table_name" {
#   description = "Public subnet route table name"
#   type        = string
#   default     = ""
 
# }
 
# variable "nonprod_private_route_table_name" {
#   description = "Private subnet route table name"
#   type        = string
#   default     = ""
 
# }
 
# variable "nonprod_public_acl_name" {
#   description = "public subnet acl name"
#   type        = string
#   default     = ""
# }
 
# variable "nonprod_private_acl_name" {
#   description = "private subnet acl name"
#   type        = string
#   default     = ""
# }
 
# variable "nonprod_source_name" {
#   description = "source name"
#   type        = string
#   default     = ""
# }
 