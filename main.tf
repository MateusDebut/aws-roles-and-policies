provider "aws" {
  region = "us-east-1"
}

# Verificar se a Role já existe
data "aws_iam_role" "existing_role" {
  name = "example-role-debut"
}

# Verificar se a Policy já existe
data "aws_iam_policy" "existing_policy" {
  arn = "arn:aws:iam::975050139769:policy/example-policy-debut"
}

# Criar Role se não existir
resource "aws_iam_role" "example_role_debut" {
  count = length(data.aws_iam_role.existing_role.id) == 0 ? 1 : 0

  name               = "example-role-debut"
  assume_role_policy = file("assume-role-policy.json")
}

# Criar Policy se não existir
resource "aws_iam_policy" "example_policy_debut" {
  count = length(data.aws_iam_policy.existing_policy.id) == 0 ? 1 : 0

  name        = "example-policy-debut"
  description = "A custom policy for S3 access"
  policy      = file("policy.json")
}

# Associar Policy à Role
resource "aws_iam_role_policy_attachment" "example_attachment" {
  count = length(data.aws_iam_role.existing_role.id) > 0 && length(data.aws_iam_policy.existing_policy.id) > 0 ? 0 : 1

  role       = aws_iam_role.example_role_debut[count.index].name
  policy_arn = aws_iam_policy.example_policy_debut[count.index].arn
}
