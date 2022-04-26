module "ppr_dynamodb_table" {
  source             = "boldlink/dynamodb/aws"
  name               = "GameScores"
  billing_mode       = "PAY_PER_REQUEST"
  enable_autoscaling = true
  hash_key           = "UserId"
  range_key          = "GameTitle"

  attributes = [
    {
      name = "UserId"
      type = "S"
    },
    {
      name = "GameTitle"
      type = "S"
    },
    {
      name = "TopScore"
      type = "N"
    }
  ]

  ttl = {
    attribute_name = "TopScore"
    enabled        = true
  }

  global_secondary_index = [
    {
      name               = "GameTitleIndex"
      hash_key           = "GameTitle"
      range_key          = "TopScore"
      write_capacity     = 10
      read_capacity      = 10
      projection_type    = "INCLUDE"
      non_key_attributes = ["UserId"]
    }
  ]

  tags = {
    Name        = "sample-dynamodb-table"
    Environment = "dev"
  }
}

output "outputs" {
  value = [
    module.ppr_dynamodb_table,
  ]
}
