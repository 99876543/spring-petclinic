terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "my_virginia_vpc" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_iam_user" "Ad" {
  name = "Adnan"
  path = "/system/"

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_access_key" "Ad" {
  user = aws_iam_user.Ad.name
}

data "aws_iam_policy_document" "Ad_ro" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:Describe*"]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "Ad_ro" {
  name   = "test"
  user   = aws_iam_user.Ad.name
  policy = data.aws_iam_policy_document.Ad_ro.json

}
resource "aws_iam_group" "test" {
  name = "test"
  path = "/system/"
}
resource "aws_iam_user_group_membership" "example1" {
  user = aws_iam_user.Ad.name

  groups = [
    aws_iam_group.test.name
  ]
}
resource "aws_iam_user" "test" {
  name = "test"
}

resource "aws_iam_user_policy" "lb_ro" {
  name = "test"
  user = aws_iam_user.Ad.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
resource "aws_iam_user" "Syed" {
  name = "newgroup"
}

resource "aws_iam_service_specific_credential" "Syed" {
  service_name = "codecommit.amazonaws.com"
  user_name    = aws_iam_user.test.name
},
"engine" = {
   "Description": "database engine type",
   "Type": "String",
   "Default": "mysql",
   "AllowedValues": [
   "mysql",
   "postgres"
            ]
},
"portno" = {
   "host": 10.0.0.247,
   "port": 3306,
   "dbinstancename": "mydatabase",
   "myusername": "Adnan",
   "mypassword": "Adnan123/*"
}