provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "example_role-debut" {
  name               = "example-role-debut"
  assume_role_policy = file("assume-role-policy.json")
}

resource "aws_iam_policy" "example_policy-debut" {
  name        = "example-policy-debut"
  description = "A custom policy for S3 access"
  policy      = file("policy.json")
}

resource "aws_iam_role_policy_attachment" "example_attachment" {
  role       = aws_iam_role.example_role-debut.name
  policy_arn = aws_iam_policy.example_policy-debut.arn
}
