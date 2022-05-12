provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  alias  = "euwest2"
  region = "eu-west-2"
}

locals {
  name_prefix = "GameScores"
}

#########################
# Supporting Resources
#########################

resource "random_pet" "main" {
  length = 2
}

resource "aws_kms_key" "primary" {
  description = "CMK for primary region"
  tags = {
    Name        = "${local.name_prefix}-${random_pet.main.id}"
    Environment = "dev"
  }
}

resource "aws_kms_key" "secondary" {
  provider = aws.euwest2

  description = "CMK for secondary region"
  tags = {
    Name        = "${local.name_prefix}-${random_pet.main.id}"
    Environment = "dev"
  }
}

###########################################################################################################
### DDB Table
### [Has an issue](https://github.com/aws/aws-cdk/issues/11346) with global table with `PROVISIONED` mode
###########################################################################################################
module "dynamodb_table" {
  source       = "boldlink/dynamodb/aws"
  name         = "${local.name_prefix}-${random_pet.main.id}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"
  range_key    = "GameTitle"

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

  global_secondary_index = [
    {
      name               = "GameTitleIndex"
      hash_key           = "GameTitle"
      range_key          = "TopScore"
      write_capacity     = 4
      read_capacity      = 4
      projection_type    = "INCLUDE"
      non_key_attributes = ["UserId"]
    }
  ]

  sse_kms_key_arn = aws_kms_key.primary.arn

  replica = {
    region_name = "eu-west-2"
    kms_key_arn = aws_kms_key.secondary.arn
  }

  tags = {
    Name        = "${local.name_prefix}-${random_pet.main.id}"
    Environment = "dev"
  }
}
