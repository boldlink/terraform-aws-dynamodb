[![Build Status](https://github.com/boldlink/terraform-aws-dynamodb/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/boldlink/terraform-aws-dynamodb/actions)

<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>

# Example with DynamoDB pay-per-request billing mode configuration

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ppr_dynamodb_table"></a> [ppr\_dynamodb\_table](#module\_ppr\_dynamodb\_table) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [random_pet.main](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_outputs"></a> [outputs](#output\_outputs) | Various output values for dynamodb table with pay-per-request billing mode |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

#### BOLDLink-SIG 2022
