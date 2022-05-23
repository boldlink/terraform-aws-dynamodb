provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  alias  = "euwest2"
  region = "eu-west-2"
}

################################################################################################################
# Since all replica keys must either be Customer Managed CMK or AWS Managed CMK, this example
# uses the default AWS Managed CMK in both regions respectively. To encrypt primary table
# with AWS Managed CMK (default KMS Key for DynamoDB) set `sse_enabled` to `true`
################################################################################################################
data "aws_kms_alias" "aws_default" {
  provider = aws.euwest2
  name     = "alias/aws/dynamodb"
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
  sse_enabled      = true

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

  replica = {
    region_name = "eu-west-2"
    kms_key_arn = data.aws_kms_alias.aws_default.target_key_arn
  }

  tags = {
    Name        = "global-tables-example"
    Environment = "dev"
  }
}
