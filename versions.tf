terraform {
  required_version = ">= 0.14.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }

    github = {
      source  = "integrations/github"
      version = ">= 4.24.1"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}
