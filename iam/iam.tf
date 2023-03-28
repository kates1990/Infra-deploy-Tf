variable "name" {
    type = string
    description = "name tag value"
  
}

variable "tags" {
    type = map(any)
    description = "tags for the vpc module"
  
}

resource "aws_iam_role" "iam_role" {
    name = join("", [var.name, "-", "iam-role"])

    #
    #
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Sid = ""
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            },
        ]

    })

    inline_policy {
      name = join("", [var.name, "-", "iam-policy"])
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    "logs:CreateLogStream",
                    "logs:DescribeLogStreams",
                    "logs:CreatelogGroup",
                    "logs:PutLogEvent"
                ]
                Effect = "Allow"
                Resource = "*"
            },
        ]
      })
    }

    tags = var.tags
    # permissions_boundary = "arn:aws:iam::ACCOUNT_NUMBER:policy/ALBIngressControllerIAMPolicy"
  
}
