module "dynamodb_table" {
  source         = "../../"
  name           = "minimum-example"
  billing_mode   = "PROVISIONED"
  read_capacity  = 3
  write_capacity = 4
  hash_key       = "UserId"
  range_key      = "BookTitle"

  attributes = [
    {
      name = "UserId"
      type = "S"
    },
    {
      name = "BookTitle"
      type = "S"
    }
  ]

  tags = {
    Name        = "minimum-example"
    Environment = "dev"
  }
}
