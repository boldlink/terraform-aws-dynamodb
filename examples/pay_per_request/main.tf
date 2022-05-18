module "ppr_dynamodb_table" {
  source             = "../../"
  name               = "pay-per-request-example"
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
      projection_type    = "INCLUDE"
      non_key_attributes = ["UserId"]
    }
  ]

  tags = {
    Name        = "pay-per-request-example"
    Environment = "dev"
  }
}
