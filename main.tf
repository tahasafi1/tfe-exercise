terraform {
  cloud {
    organization = "024_2023-summer-cloud-t"

    workspaces {
      name = "tfe-workspace-exercise"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

data "tfe_organization" "foo" {
  name = "024_2023-summer-cloud-t"
}

locals {
  execution_type = "local"
  customers = [
    "workspace-for-class1",
    "apple",
    "google",
    "twitter"
  ]
}


resource "tfe_workspace" "test1" {
  for_each       = toset(local.customers)
  name           = each.key
  organization   = data.tfe_organization.foo.name
  execution_mode = local.execution_type
}
 