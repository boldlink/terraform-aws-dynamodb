# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased
- Feature: Streams in example
- Feature: Cloudwatch Contributor Insights for DynamoDB
- Feature: Support for DDB DAX Cluster accelerator
- Feature: Allow for a custom KMS policy, this will allow to change the default KMS policies and resolve checkov warnings
- Feature: Overwriting the key policy (partially/entirely)
- Add: Usage of local secondary index in example(s)
- Feature: Modify main module to ensure values in gsi/lsi match autoscaling values to avoid inconsistencies.
- fix: CKV_AWS_111 #Ensure IAM policies does not allow write access without constraints
- fix: CKV_AWS_109 #Ensure IAM policies does not allow permissions management / resource exposure without constraints
- fix: CKV_AWS_119 #Ensure DynamoDB Tables are encrypted using a KMS Customer Managed CMK
- fix: CKV_AWS_356 #"Ensure no IAM policies documents allow "*" as a statement's resource for restrictable actions"

## [1.2.0] - 2022-08-16
- feat: showcased restore option in the complete example
- feat: added hash_key output

## [1.1.2] - 2022-08-16
- fix: added CKV_AWS_356 exception to `.checkov.yaml` file

## [1.1.1] - 2022-06-08

### Changes
- Fix: Error(s) that arise using table item(s).
- Feature: Table items in example


## [1.1.0] - 2022-05-17
### Added
- Added the `.github/workflow` folder (not supposed to run gitcommit)
- Re-factored examples (`minimum`, `complete` and additional)
- Added `CHANGELOG.md`
- Added `CODEOWNERS`
- Added `versions.tf`, which is important for pre-commit checks
- Added `Makefile` for examples automation
- Added `.gitignore` file
- Added `.checkov.yml` file to skip checkov checks `CKV_AWS_119` `CKV_AWS_111` and `CKV_AWS_109`. **NOTE**: Correcting these checks results in malformed IAM policy

### Changes/Fixes
- READMEs in root and examples folders to have a new header and footer
- Point-In-Time-Recovery enabled by default
- Modified the `.pre-commit-config.yaml`
- Locked module to terraform version `0.14.11` due to previous github actions jobs failing when using TF v0.13.7 and terraform-docs 0.16.0.
- Added more contraints in IAM policy as shown in `data.tf` file
- Resolved resource/feature update-in-place/recreation on `terraform apply` for tables Global Index with `On-demand`/`PAY_PER_REQUEST` billing mode

## [1.0.1] - 2022-04-21

### Added
- Added table and index autoscaling
- Added different encryption options (default, external kms_key, module-created kms_key)

### Changes/Fixes
- Split examples

## [1.0.0] - 2022-04-07

### Added
- Dynamodb table without app autoscaling
- Added table item
- One example with many features
- Initial commit

Unreleased]: https://github.com/boldlink/terraform-aws-dynamodb/compare/1.2.0...HEAD

[1.2.0]: https://github.com/boldlink/terraform-aws-dynamodb/releases/tag/1.2.0
[1.1.2]: https://github.com/boldlink/terraform-aws-dynamodb/releases/tag/1.1.2
[1.1.1]: https://github.com/boldlink/terraform-aws-dynamodb/releases/tag/1.1.1
[1.1.0]: https://github.com/boldlink/terraform-aws-dynamodb/releases/tag/1.1.0
[1.0.1]: https://github.com/boldlink/terraform-aws-dynamodb/releases/tag/1.0.1
[1.0.0]: https://github.com/boldlink/terraform-aws-dynamodb/releases/tag/1.0.0
