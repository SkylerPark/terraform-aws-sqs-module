locals {
  region = "ap-northeast-2"
}

module "queue" {
  source         = "../../modules/queue"
  name           = "parksm-sqs"
  policy_enabled = true
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "S3Publish",
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "s3.amazonaws.com"
          },
          "Action" : "sqs:SendMessage",
          "Resource" : "arn:aws:sqs:ap-northeast-2:111111111:tail-log",
          "Condition" : {
            "StringEquals" : {
              "aws:SourceAccount" : "111111111"
            },
            "ArnLike" : {
              "aws:SourceArn" : "arn:aws:s3:::tail-log"
            }
          }
        }
      ]
    }
  )
}
