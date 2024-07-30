# queue

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.10 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_sqs_queue.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [aws_sqs_queue_redrive_allow_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_redrive_allow_policy) | resource |
| [aws_sqs_queue_redrive_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_redrive_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deduplication_scope"></a> [deduplication\_scope](#input\_deduplication\_scope) | (선택) 메세지 중복 제거가 메시지 그룹 `messageGroup` 또는 큐 `queue` 수준에서 발생하는지 설정. Default: `null` | `string` | `null` | no |
| <a name="input_delay_seconds"></a> [delay\_seconds](#input\_delay\_seconds) | (선택) 대기열에 있는 모든 메시지 전달이 지연되는 시간(초). 0-900(15분). Default: `0`. | `number` | `0` | no |
| <a name="input_fifo"></a> [fifo](#input\_fifo) | (선택) SQS FIFO 형식의 설정값. `fifo` 블록 내용.<br>    (선택) `enabled` - FIFO 형식으로 생성 할지여부. Default: `false`.<br>    (선택) `throughput_limit` - FIFO 대기열 처리량 할당량이 전체 대기열에 적용 `perQueue` 되는지 혹은 메세지 그룹별 `perMessageGroupId` 로 적용되는지 설정. Default: `perQueue`<br>    (선택) `content_based_deduplication` - FIFO 대기열에 대한 콘텐츠 기반 중복제거를 활성화 여부. Default: `true`. | <pre>object({<br>    enabled                     = optional(bool, false)<br>    throughput_limit            = optional(string, "perQueue")<br>    content_based_deduplication = optional(bool, true)<br>  })</pre> | `{}` | no |
| <a name="input_kms"></a> [kms](#input\_kms) | (선택) SQS 에 대한 KMS 설정값. `kms` 블록 내용.<br>    (선택) `enabled` - kms 를 사용하는지 여부. Default: `false`.<br>    (선택) `data_key_reuse_period_seconds` - kms 암/복호화시 재사용 호출 시간(초). 60초(1분)-86,400(24시간) 사이에 초를 나타내는 정수. Default: `300(분)`.<br>    (선택) `master_key_id` - 사용자지정 CMK 에 대한 ID. | <pre>object({<br>    enabled                       = optional(bool, false)<br>    data_key_reuse_period_seconds = optional(number, 300)<br>    master_key_id                 = optional(string, null)<br>  })</pre> | `{}` | no |
| <a name="input_max_message_size"></a> [max\_message\_size](#input\_max\_message\_size) | (선택) SQS 메세지를 포함할수 있는 바이트 수 제한. 1024바이트(1KiB)에서 262144바이트(256KiB)까지의 정수. Default: `262144(256KiB)` | `number` | `262144` | no |
| <a name="input_message_retention_seconds"></a> [message\_retention\_seconds](#input\_message\_retention\_seconds) | (선택) SQS 가 메세지를 보관하는 초. 60(1분)에서 1209600(14일) 까지의 초를 나타내는 정수. Default: `345600(4일)` | `number` | `345600` | no |
| <a name="input_name"></a> [name](#input\_name) | (필수) SQS 이름. | `string` | n/a | yes |
| <a name="input_policy"></a> [policy](#input\_policy) | (선택) JSON 형식의 정책 문서. | `string` | `null` | no |
| <a name="input_policy_enabled"></a> [policy\_enabled](#input\_policy\_enabled) | (선택) SQS Policy 를 설정 할지에 대한 여부. Default: `false` | `bool` | `false` | no |
| <a name="input_receive_wait_time_seconds"></a> [receive\_wait\_time\_seconds](#input\_receive\_wait\_time\_seconds) | (선택) ReceiveMessage 호출이 반환하기 전에 메시지가 도착할 때까지 기다리는 시간. 0~20(초)의 정수. Default: `0` | `number` | `0` | no |
| <a name="input_redrive_allow_policy"></a> [redrive\_allow\_policy](#input\_redrive\_allow\_policy) | (선택) JSON 형식의 Redrive Allow 정책 문서. | `string` | `null` | no |
| <a name="input_redrive_allow_policy_enabled"></a> [redrive\_allow\_policy\_enabled](#input\_redrive\_allow\_policy\_enabled) | (선택) Redrive Allow policy 를 설정 할지에 대한 여부. Default: `false` | `bool` | `false` | no |
| <a name="input_redrive_policy"></a> [redrive\_policy](#input\_redrive\_policy) | (선택) JSON 형식의 Redrive 정책 문서. | `string` | `null` | no |
| <a name="input_redrive_policy_enabled"></a> [redrive\_policy\_enabled](#input\_redrive\_policy\_enabled) | (선택) Redrive policy 를 설정 할지에 대한 여부. Default: `false` | `bool` | `false` | no |
| <a name="input_sqs_managed_sse_enabled"></a> [sqs\_managed\_sse\_enabled](#input\_sqs\_managed\_sse\_enabled) | (선택) SQS 소유 암호화 키로 메시지 콘텐츠 서버 측 암호화(SSE) 활성화 여부. Default: `true` | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (선택) 리소스 태그 내용 | `map(string)` | `{}` | no |
| <a name="input_visibility_timeout_seconds"></a> [visibility\_timeout\_seconds](#input\_visibility\_timeout\_seconds) | (선택) 대기열에 대한 가시성 시간 초과. 0-43200(12시간)의 정수. Default: `30` | `number` | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | SQS queue ARN. |
| <a name="output_id"></a> [id](#output\_id) | SQS queue URL or ID. |
| <a name="output_name"></a> [name](#output\_name) | SQS queue 이름. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
