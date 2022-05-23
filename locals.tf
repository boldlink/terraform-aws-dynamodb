locals {
  name                = var.name
  account_id          = data.aws_caller_identity.current.account_id
  partition           = data.aws_partition.current.partition
  default_ddb_kms_key = data.aws_kms_alias.aws_default.target_key_arn
  dns_suffix          = data.aws_partition.current.dns_suffix
}
