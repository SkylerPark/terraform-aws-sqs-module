variable "name" {
  description = "(필수) SQS 이름."
  type        = string
  nullable    = false
}

variable "fifo" {
  description = <<EOF
  (선택) SQS FIFO 형식의 설정값. `fifo` 블록 내용.
    (선택) `enabled` - FIFO 형식으로 생성 할지여부. Default: `false`.
    (선택) `throughput_limit` - FIFO 대기열 처리량 할당량이 전체 대기열에 적용 `perQueue` 되는지 혹은 메세지 그룹별 `perMessageGroupId` 로 적용되는지 설정. Default: `perQueue`
    (선택) `content_based_deduplication` - FIFO 대기열에 대한 콘텐츠 기반 중복제거를 활성화 여부. Default: `true`.
  EOF
  type = object({
    enabled                     = optional(bool, false)
    throughput_limit            = optional(string, "perQueue")
    content_based_deduplication = optional(bool, true)
  })
  default  = {}
  nullable = false

  validation {
    condition     = contains(["perQueue", "perMessageGroupId"], var.fifo.throughput_limit)
    error_message = "fifo 에 throughput_limit 값은 `perQueue`, `perMessageGroupId` 중 하나를 설정 해야 합니다."
  }
}

variable "deduplication_scope" {
  description = "(선택) 메세지 중복 제거가 메시지 그룹 `messageGroup` 또는 큐 `queue` 수준에서 발생하는지 설정. Default: `null`"
  type        = string
  default     = null
  nullable    = true
}

variable "delay_seconds" {
  description = "(선택) 대기열에 있는 모든 메시지 전달이 지연되는 시간(초). 0-900(15분). Default: `0`."
  type        = number
  default     = 0
  nullable    = false

  validation {
    condition = alltrue([
      var.delay_seconds >= 0,
      var.delay_seconds <= 900
    ])
    error_message = "delay_seconds 는 0-900 까지의 정수여야 합니다."
  }
}

variable "kms" {
  description = <<EOF
  (선택) SQS 에 대한 KMS 설정값. `kms` 블록 내용.
    (선택) `enabled` - kms 를 사용하는지 여부. Default: `false`.
    (선택) `data_key_reuse_period_seconds` - kms 암/복호화시 재사용 호출 시간(초). 60초(1분)-86,400(24시간) 사이에 초를 나타내는 정수. Default: `300(분)`.
    (선택) `master_key_id` - 사용자지정 CMK 에 대한 ID.
  EOF
  type = object({
    enabled                       = optional(bool, false)
    data_key_reuse_period_seconds = optional(number, 300)
    master_key_id                 = optional(string, null)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      var.kms.data_key_reuse_period_seconds >= 60,
      var.kms.data_key_reuse_period_seconds <= 86400
    ])
    error_message = "kms 에 data_key_reuse_period_seconds 는 60-86400 까지의 정수여야 합니다."
  }
}

variable "sqs_managed_sse_enabled" {
  description = "(선택) SQS 소유 암호화 키로 메시지 콘텐츠 서버 측 암호화(SSE) 활성화 여부. Default: `true`"
  type        = bool
  default     = true
  nullable    = false
}

variable "max_message_size" {
  description = "(선택) SQS 메세지를 포함할수 있는 바이트 수 제한. 1024바이트(1KiB)에서 262144바이트(256KiB)까지의 정수. Default: `262144(256KiB)`"
  type        = number
  default     = 262144
  nullable    = false

  validation {
    condition = alltrue([
      var.max_message_size >= 1024,
      var.max_message_size <= 262144
    ])
    error_message = "max_message_size 는 1024(1KiB)-262144(256KiB) 까지의 정수여야 합니다."
  }
}

variable "message_retention_seconds" {
  description = "(선택) SQS 가 메세지를 보관하는 초. 60(1분)에서 1209600(14일) 까지의 초를 나타내는 정수. Default: `345600(4일)`"
  type        = number
  default     = 345600
  nullable    = false

  validation {
    condition = alltrue([
      var.message_retention_seconds >= 60,
      var.message_retention_seconds <= 1209600
    ])
    error_message = "message_retention_seconds 는 60(1분)-1209600(14일) 까지의 정수여야 합니다."
  }
}

variable "receive_wait_time_seconds" {
  description = "(선택) ReceiveMessage 호출이 반환하기 전에 메시지가 도착할 때까지 기다리는 시간. 0~20(초)의 정수. Default: `0`"
  type        = number
  default     = 0
  nullable    = false

  validation {
    condition = alltrue([
      var.receive_wait_time_seconds >= 0,
      var.receive_wait_time_seconds <= 20
    ])
    error_message = "receive_wait_time_seconds 는 0-20 까지의 정수여야 합니다."
  }
}

variable "visibility_timeout_seconds" {
  description = "(선택) 대기열에 대한 가시성 시간 초과. 0-43200(12시간)의 정수. Default: `30`"
  type        = number
  default     = 30
  nullable    = false

  validation {
    condition = alltrue([
      var.visibility_timeout_seconds >= 0,
      var.visibility_timeout_seconds <= 43200
    ])
    error_message = "visibility_timeout_seconds 는 0-43200 까지의 정수여야 합니다."
  }
}

variable "tags" {
  description = "(선택) 리소스 태그 내용"
  type        = map(string)
  default     = {}
}

variable "policy_enabled" {
  description = "(선택) SQS Policy 를 설정 할지에 대한 여부. Default: `false`"
  type        = bool
  default     = false
  nullable    = false
}

variable "policy" {
  description = "(선택) JSON 형식의 정책 문서."
  type        = string
  default     = null
  nullable    = true
}

variable "redrive_policy_enabled" {
  description = "(선택) Redrive policy 를 설정 할지에 대한 여부. Default: `false`"
  type        = bool
  default     = false
  nullable    = false
}

variable "redrive_policy" {
  description = "(선택) JSON 형식의 Redrive 정책 문서."
  type        = string
  default     = null
  nullable    = true
}

variable "redrive_allow_policy_enabled" {
  description = "(선택) Redrive Allow policy 를 설정 할지에 대한 여부. Default: `false`"
  type        = bool
  default     = false
  nullable    = false
}

variable "redrive_allow_policy" {
  description = "(선택) JSON 형식의 Redrive Allow 정책 문서."
  type        = string
  default     = null
  nullable    = true
}
