provider "aws" {
  shared_credentials_file  = "${var.cred-file}"
  profile                  = "${var.profile}"
  region     = "${var.region}"
}

resource "aws_iam_role" "remove-lambda" {
  name = "${var.prefix}.remove-lambda"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


resource "aws_iam_role_policy" "allowcloudwatchlogging" {
  name = "${var.prefix}-Enable-login"
  role = "${aws_iam_role.remove-lambda.id}"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "attach-default-iam-read-only" {
    role = "${aws_iam_role.remove-lambda.id}"
    policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}

resource "aws_iam_role_policy" "enable-delete-key" {
  name = "${var.prefix}-Enable-deletekey"
  role = "${aws_iam_role.remove-lambda.id}"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:DeleteAccessKey"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
POLICY
}

resource "aws_lambda_function" "DeleteUserKeys" {
  filename         = "remove.py.zip"
  source_code_hash = "${base64sha256(file("remove.py.zip"))}"
  function_name    = "${var.prefix}-Remove-users-access-secrect-keys"
  role             = "${aws_iam_role.remove-lambda.arn}"
  handler          = "remove.handler"
  runtime          = "python2.7"
  publish          = "true"
  timeout          = 15
  memory_size      = 128
  description      = "This function delete all the access and secrect keys from the IAM users, except for the ones specified in the variable"

  environment {
    variables = {
      exclusions = "${var.myexclusionlist}"
    }
  }
}
