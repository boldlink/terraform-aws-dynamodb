module "dynamodb_table" {
  source             = "../../"
  name               = "minimum-example"
  billing_mode       = "PROVISIONED"
  enable_autoscaling = true
  read_capacity      = 3
  write_capacity     = 4
  hash_key           = "UserId"
  range_key          = "BookTitle"

  attributes = [
    {
      name = "UserId"
      type = "S"
    },
    {
      name = "BookTitle"
      type = "S"
    },
    {
      name = "HighestPoints"
      type = "N"
    }
  ]

  global_secondary_index = [
    {
      name               = "BookTitleIndex"
      hash_key           = "BookTitle"
      range_key          = "HighestPoints"
      write_capacity     = 7
      read_capacity      = 5
      projection_type    = "INCLUDE"
      non_key_attributes = ["UserId"]
    }
  ]

  tags = {
    Name        = "minimum-example"
    Environment = "dev"
  }
}
