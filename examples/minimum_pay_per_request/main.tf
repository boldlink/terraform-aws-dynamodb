locals {
  name_prefix = "ProfessionalTitle"
}

resource "random_pet" "main" {
  length = 2
}

module "ppr_dynamodb_table" {
  source             = "boldlink/dynamodb/aws"
  name               = "${local.name_prefix}-${random_pet.main.id}"
  billing_mode       = "PAY_PER_REQUEST"
  enable_autoscaling = true
  hash_key           = "UserId"
  range_key          = "ProfessionalTitle"

  attributes = [
    {
      name = "UserId"
      type = "S"
    },
    {
      name = "ProfessionalTitle"
      type = "S"
    },
    {
      name = "SocialScore"
      type = "N"
    }
  ]

  global_secondary_index = [
    {
      name               = "ProfessionalTitleIndex"
      hash_key           = "ProfessionalTitle"
      range_key          = "SocialScore"
      write_capacity     = 10
      read_capacity      = 10
      projection_type    = "INCLUDE"
      non_key_attributes = ["UserId"]
    }
  ]

  tags = {
    Name        = "${local.name_prefix}-${random_pet.main.id}"
    Environment = "dev"
  }
}
