resource "aws_lambda_function" "lambda" {
  filename         = data.archive_file.source_code.output_path
  function_name    = var.lambda-name
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "lambda_function.lambda_handler"
  source_code_hash = filebase64sha256(data.archive_file.source_code.output_path)
  runtime          = "python3.11"
  timeout          = 60

  layers = [
    aws_lambda_layer_version.packages.arn
  ]
}

resource "aws_lambda_layer_version" "packages" {
  filename         = data.archive_file.packages.output_path
  layer_name       = "${var.lambda-name}-packages"
  description      = "Packages for ${var.lambda-name} >> ${file("../requirements.txt")}"
  source_code_hash = filebase64sha256(data.archive_file.packages.output_path)
  compatible_runtimes = [
    "python3.11"
  ]
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "${var.lambda-name}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  inline_policy {
    name = "${var.lambda-name}-policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ]
          Effect   = "Allow"
          Resource = "*"
        }
      ]
    })
  }
}
