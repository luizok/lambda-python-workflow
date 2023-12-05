provider "aws" {
  default_tags {
    tags = {
      project = var.project-name
    }
  }
}

provider "archive" {}

terraform {
  backend "s3" {}
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name
}

data "archive_file" "source_code" {
  type        = "zip"
  source_dir  = "../app/"
  output_path = "../out/lambda.zip"
}

data "archive_file" "packages" {
  type        = "zip"
  source_dir  = "../out/packages/"
  output_path = "../out/packages.zip"

  depends_on = [ null_resource.install_packages ]
}

resource "null_resource" "install_packages" {
  provisioner "local-exec" {
    command = "sh ./install_packages.sh"
  }

  triggers = {
    requirements_changed = filebase64sha256("../requirements.txt")
    script_changed = filebase64sha256("./install_packages.sh")
  }
}
