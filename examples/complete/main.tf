locals {
  name_prefix = "test-table"
}

resource "random_pet" "main" {
  length = 2
}

module "complete" {
  #source                         = "boldlink/dynamodb/aws"
  source                         = "../../"
  name                           = "${local.name_prefix}-${random_pet.main.id}"
  hash_key                       = "id"
  range_key                      = "title"
  billing_mode                   = "PROVISIONED"
  read_capacity                  = 3 ## 3 strongly consistent read per second, or 6 eventually consistent reads per second
  write_capacity                 = 4 ## 4 writes per second, for an item up to 1 KB in size.
  enable_autoscaling             = true
  point_in_time_recovery_enabled = true

  ## For both read and write, these values are set like so to allow faster scale out and slow scale down
  ## Max and min_capacities: provisioned capacity that your table will allow. Cannot scale above/below these values.
  autoscaling_read = {
    scale_in_cooldown  = 180
    scale_out_cooldown = 60
    target_value       = 50
    max_capacity       = 10
  }

  autoscaling_write = {
    scale_in_cooldown  = 180
    scale_out_cooldown = 60
    target_value       = 50
    max_capacity       = 10
  }

  autoscaling_indexes = {
    TitleIndex = {
      read_max_capacity  = 15
      read_min_capacity  = 8
      write_max_capacity = 20
      write_min_capacity = 10
    }
  }

  attributes = [
    {
      name = "id"
      type = "N"
    },
    {
      name = "title"
      type = "S"
    },
    {
      name = "age"
      type = "N"
    }
  ]

  global_secondary_index = [
    {
      name               = "TitleIndex"
      hash_key           = "title"
      range_key          = "age"
      projection_type    = "INCLUDE"
      non_key_attributes = ["id"]
      write_capacity     = 10
      read_capacity      = 10
    }
  ]

  tags = {
    Name        = "${local.name_prefix}-${random_pet.main.id}"
    Environment = "staging"
  }
}
