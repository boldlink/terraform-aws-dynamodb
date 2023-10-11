module "dynamodb_table" {
  source                         = "../../"
  name                           = "minimum-example"
  read_capacity                  = 3
  write_capacity                 = 4
  hash_key                       = "UserId"
  point_in_time_recovery_enabled = false

  attributes = [
    {
      name = "UserId"
      type = "S"
    }
  ]

  tags = {
    Name        = "minimum-example"
    Environment = "dev"
  }
}
