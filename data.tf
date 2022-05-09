data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_kms_alias" "aws_default" {
  name = "alias/aws/dynamodb"
}

data "aws_kms_key" "default" {
  key_id = data.aws_kms_alias.aws_default.target_key_id
}

#### Policy document for sse kms key
#### for dynamodb
data "aws_iam_policy_document" "main" {

  statement {
    sid = "Allow access for all principals in the account that are authorized to use Amazon DynamoDB"

    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]

    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = ["*"]
    }

    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = [local.account_id]
    }
    condition {
      test     = "StringLike"
      variable = "kms:ViaService"
      values   = ["dynamodb.*.amazonaws.com"]
    }
  }

  statement {
    sid = "Allow direct access to key metadata to the account"

    actions = [
      "kms:*",
    ]

    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = ["arn:${local.partition}:iam::${local.account_id}:root"]
    }

    resources = ["*"]
  }

  statement {
    sid = "Allow DynamoDB to directly describe the key"

    actions = [
      "kms:Describe*",
      "kms:Get*",
      "kms:List*"
    ]

    effect = "Allow"

    principals {
      type = "Service"

      identifiers = ["dynamodb.amazonaws.com"]
    }

    resources = ["*"]
  }
}
