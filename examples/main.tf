module "dynamodb_table" {
  source             = "./.."
  name               = "GameScores"
  billing_mode       = "PROVISIONED"
  enable_autoscaling = true
  read_capacity      = 100
  write_capacity     = 100
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
    attribute_name = "TimeToExist"
    enabled        = false
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

module "ppr_dynamodb_table" {
  source           = "./.."
  name             = "ppr-table"
  hash_key         = "TestTableHashKey"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attributes = [
    {
      name = "TestTableHashKey"
      type = "S"
    }
  ]

  replica = {
    region_name = "eu-west-2"
  }
}
