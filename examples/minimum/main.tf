module "dynamodb_table" {
  source         = "../../"
  name           = "minimum-example"
  read_capacity  = 3
  write_capacity = 4
  hash_key       = "UserId"

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
