# terraform-aws-sqs-module

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=flat-square)](https://github.com/pre-commit/pre-commit)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Component

아래 도구를 이용하여 모듈작성을 하였습니다. 링크를 참고하여 OS 에 맞게 설치 합니다.

> **macos** : ./bin/install-macos.sh

- [pre-commit](https://pre-commit.com)
- [terraform](https://terraform.io)
- [tfenv](https://github.com/tfutils/tfenv)
- [terraform-docs](https://github.com/segmentio/terraform-docs)
- [tfsec](https://github.com/tfsec/tfsec)
- [tflint](https://github.com/terraform-linters/tflint)

## Services

Terraform 모듈을 사용하여 아래 서비스를 관리 합니다.

- **AWS SQS (Simple Queue Service)**
  - queue

## Usage

아래 예시를 활용하여 작성가능하며 examples 코드를 참고 부탁드립니다.

### Queue

Queue 를 생성하면서 권한 부여되는 예시 입니다.

```hcl
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
```
