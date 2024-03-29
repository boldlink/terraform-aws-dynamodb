[![License](https://img.shields.io/badge/License-Apache-blue.svg)](https://github.com/boldlink/terraform-aws-dynamodb/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/github/release/boldlink/terraform-aws-dynamodb.svg)](https://github.com/boldlink/terraform-aws-dynamodb/releases/latest)
[![Build Status](https://github.com/boldlink/terraform-aws-dynamodb/actions/workflows/update.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-dynamodb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-dynamodb/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-dynamodb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-dynamodb/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-dynamodb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-dynamodb/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-dynamodb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-dynamodb/actions/workflows/module-examples-tests.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-dynamodb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-dynamodb/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-dynamodb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-dynamodb/actions/workflows/auto-merge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-dynamodb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-dynamodb/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-dynamodb/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# Terraform module example showing dynamodb table with an item
This example with item is more for testing or when you want to create a DDB on dev/qa to run some tests on data.
*NOTE*: AWS Dynamodb Table Item is **NOT** meant to be used for managing large amounts of data in your table and it is also not designed to scale.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_table_with_item"></a> [table\_with\_item](#module\_table\_with\_item) | ../../ | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_outputs"></a> [outputs](#output\_outputs) | Various output values for the dynamodb table with item |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Third party software
This repository uses third party software:
* [pre-commit](https://pre-commit.com/) - Used to help ensure code and documentation consistency
  * Install with `brew install pre-commit`
  * Manually use with `pre-commit run`
* [terraform 0.14.11](https://releases.hashicorp.com/terraform/0.14.11/) For backwards compatibility we are using version 0.14.11 for testing making this the min version tested and without issues with terraform-docs.
* [terraform-docs](https://github.com/segmentio/terraform-docs) - Used to generate the [Inputs](#Inputs) and [Outputs](#Outputs) sections
  * Install with `brew install terraform-docs`
  * Manually use via pre-commit
* [tflint](https://github.com/terraform-linters/tflint) - Used to lint the Terraform code
  * Install with `brew install tflint`
  * Manually use via pre-commit

#### BOLDLink-SIG 2022
