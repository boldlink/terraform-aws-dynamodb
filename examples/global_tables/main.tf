provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  alias  = "euwest2"
  region = "eu-west-2"
}

#############################################################################################################
# Supporting Resources: Reason => All replica keys must either be Customer Managed CMK or AWS Managed CMK.
# Default KMS Key(AWS Managed CMK) may not be available is some regions
#############################################################################################################
resource "aws_kms_key" "primary" {
  description         = "CMK for primary region"
  enable_key_rotation = true
  tags = {
    Name        = "Global-tables-example"
    Environment = "dev"
  }
}

resource "aws_kms_key" "secondary" {
  provider = aws.euwest2

  description         = "CMK for secondary region"
  enable_key_rotation = true
  tags = {
    Name        = "Global-tables-example"
    Environment = "dev"
  }
}

###########################################################################################################
### DDB Table
### [Has an issue](https://github.com/aws/aws-cdk/issues/11346) with global table with `PROVISIONED` mode
###########################################################################################################
module "dynamodb_table" {
  source           = "../../"
  name             = "global-tables-example"
  billing_mode     = "PAY_PER_REQUEST"
  hash_key         = "UserId"
  range_key        = "GameTitle"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

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
    Name        = "global-tables-example"
    Environment = "dev"
  }
}
