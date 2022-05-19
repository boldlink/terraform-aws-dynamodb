# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
- Fix: The error(s) that arise because of using table item(s).
- Add: Table items in example
- Add: Streams in example
- Add: Cloudwatch Contributor Insights for DynamoDB
- Add: Allow for a custom KMS policy

## [1.1.0] - 2022-05-17

### Added
- Added the `.github/workflow` folder (not supposed to run gitcommit)
- Re-factored examples (`minimum`, `complete` and additional)
- Added `CHANGELOG.md`
- Added `CODEOWNERS`
- Added `versions.tf`, which is important for pre-commit checks
- Added `Makefile` for examples automation
- Added `.gitignore` file
- Added `..checkov.yml` file to skip checkov checks `CKV_AWS_111` and `CKV_AWS_109`. **NOTE**: Correcting these checks result in malformed IAM policy

### Changes/Fixes
- READMEs in root and examples folders to have a new header and footer
- Point-In-Time-Recovery enabled by default
- Modified the `.pre-commit-config.yaml`
- Locked module to terraform version `0.14.11` due to previous github actions jobs failing due to use of v0.13.7
- Used more contraint in IAM policy as shown in `data.tf` file
- Resolved resource/feature update-in-place/recreation on `terraform apply` for tables with `On-demand`/`PAY_PER_REQUEST` billing mode

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

[1.0.0]: https://github.com/boldlink/terraform-aws-dynamodb/releases/tag/1.0.0
