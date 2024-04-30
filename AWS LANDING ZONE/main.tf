provider "aws" {
  region = "us-east-1"
}

module "networking_components" {
  source                        = "./networking components"
  vpc_cidr                      = var.vpc_cidr
  vpc_name                      = var.vpc_name
  public_subnets_cidir_numbers  = var.public_subnets_cidir_numbers
  private_subnets_cidir_numbers = var.private_subnets_cidir_numbers
  azs                           = var.azs
  ig_name                       = var.ig_name
  nat_name                      = var.nat_name
  public_route_table_name       = var.public_route_table_name
  private_route_table_name      = var.private_route_table_name
  public_acl_name               = var.public_acl_name
  private_acl_name              = var.private_acl_name    
}

resource "aws_controltower_landing_zone" "example" {
  manifest_json = file("./controltower/LandingZoneManifest.json")
  version       = "3.3"
}

module "aft" {
  source = "github.com/aws-ia/terraform-aws-control_tower_account_factory"
  
  ct_management_account_id    = "891377115604"
  log_archive_account_id      = "975050247636"
  audit_account_id            = "381491881126"
  aft_management_account_id   = "211125486960"
  ct_home_region              = "us-east-1"
  tf_backend_secondary_region = "us-east-2"
  }
