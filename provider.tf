terraform {
  backend "s3" {
    bucket         = "iti-terrafrom-state"
    region         = "us-east-1"
    key            = "terraform.tfstate"
    dynamodb_table = "iti-terrafrom-LockID"
  }
  required_providers {
    aws = "~> 3.0"
  }
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "mohamedanwer006"

}
