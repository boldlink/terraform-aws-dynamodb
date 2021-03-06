module "table_with_item" {
  source         = "../../"
  name           = "item-example-table"
  read_capacity  = 4
  write_capacity = 4
  hash_key       = "exampleHashKey"

  attributes = [
    {
      name = "exampleHashKey"
      type = "S"
    }
  ]

  ### **NOTE**: aws_dynamodb_table_item is **NOT** meant to be used for managing large amounts of data in your table,
  ### it is not designed to scale. You should perform regular backups of all data in the table

  table_items = {
    item = jsonencode(
      {
        exampleHashKey = {
          S = "something"
        }
        four = {
          N = "44444"
        }
        one = {
          N = "11111"
        }
        three = {
          N = "33333"
        }
        two = {
          N = "22222"
        }
      }
    )
  }
}
