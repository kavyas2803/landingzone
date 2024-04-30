module "production-account-01" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail = "kavya+8@1cloudhub.com"
    AccountName  = "production-account-01"
    
    ManagedOrganizationalUnit = "production"
    
    SSOUserEmail     = "kavya@1cloudhub.com"
    SSOUserFirstName = "Kavya"
    SSOUserLastName  = "S"
  }
  account_tags = {
    "Learn Tutorial" = "AFT"
  }


  change_management_parameters = {
    change_requested_by = "Kavya S"
    change_reason       = "testing the account vending process"
  }

  custom_fields = {
    custom1 = "a"
    custom2 = "b"
  }

  account_customizations_name = "production-customizations"
}
module "nonproduction-account-01" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail = "kavya+7@1cloudhub.com"
    AccountName  = "nonproduction-account-01"
    
    ManagedOrganizationalUnit = "nonproduction"
    
    SSOUserEmail     = "kavya@1cloudhub.com"
    SSOUserFirstName = "Kavya"
    SSOUserLastName  = "S"
  }

  account_tags = {
    "Learn Tutorial" = "AFT"
  }


  change_management_parameters = {
    change_requested_by = "Kavya S"
    change_reason       = "testing the account vending process"
  }

  custom_fields = {
    custom1 = "a"
    custom2 = "b"
  }

  account_customizations_name = "nonproduction-customizations"
}
