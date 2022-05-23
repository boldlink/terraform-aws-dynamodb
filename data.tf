data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_kms_alias" "aws_default" {
  name = "alias/aws/dynamodb"
}

#### Policy document for sse kms key
#### for dynamodb
data "aws_iam_policy_document" "sse_kms_policy" {

  statement {
    sid = "Allow Administrators to manage the key"

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

  dynamic "statement" {
    for_each = var.additional_kms_permissions
    content {
      sid = try(statement.value.sid, null)

      actions = try(statement.value.actions, null)

      effect = try(statement.value.effect, null)

      dynamic "principals" {
        for_each = try([statement.value.principals], [])
        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = try([statement.value.condition], [])

        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
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

      identifiers = ["dynamodb.${local.dns_suffix}"]
    }
    resources = ["*"]
  }
}
