provider "aws" {
  region  = var.region
}

# Will be used to store the configuration files for the Trak Library API.
resource "aws_codecommit_repository" "configuration_repository" {
  repository_name = "trak-library-${var.environment}-configuration"
  description     = "Stores configuration properties of different profiles for the Trak Library API."
  default_branch  = "main"

  tags = {
    "sparkystudios:environment" = var.environment
    "sparkystudios:project"     = "trak-library"
  }
}

# Create a user policy that allows for reading from the trak-library-configuration repository.
resource "aws_iam_user_policy" "configuration_user_policy" {
  name = "trak-library.${var.environment}.codecommit.readonly.policy"
  user = aws_iam_user.configuration_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "codecommit:GetRepository",
        "codecommit:GitPull"
      ],
      Resource = "${aws_codecommit_repository.configuration_repository.arn}"
    }]
  })
}

# Create the IAM user for readonly API access to the trak-library-configuration repository.
resource "aws_iam_user" "configuration_user" {
  name          = "trak-library.${var.environment}.codecommit.user"
  force_destroy = true

  tags = {
    "sparkystudios:environment" = var.environment
    "sparkystudios:project"     = "trak-library"
  }
}
