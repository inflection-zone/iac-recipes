terraform {
  required_version = ">= 1.10.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.85.0"
    }
  }
}

provider "aws" {
  region = local.aws-region

  # shared_config_files = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]

  default_tags {
    tags = {
      Environment = local.aws-default-tags-Environment
      ManagedBy   = local.aws-default-tags-ManagedBy
    }
  }
}
