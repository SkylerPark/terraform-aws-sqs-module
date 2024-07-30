locals {
  name = try(trimsuffix(var.name, ".fifo"), "")
}

resource "aws_sqs_queue" "this" {
  name = var.fifo.enabled ? "${local.name}.fifo" : local.name

  fifo_queue                  = var.fifo.enabled
  fifo_throughput_limit       = var.fifo.enabled ? var.fifo.throughput_limit : null
  content_based_deduplication = var.fifo.enabled ? var.fifo.content_based_deduplication : null

  deduplication_scope = var.deduplication_scope
  delay_seconds       = var.delay_seconds

  kms_data_key_reuse_period_seconds = var.kms.enabled ? var.kms.data_key_reuse_period_seconds : null
  kms_master_key_id                 = var.kms.enabled ? var.kms.master_key_id : null
  sqs_managed_sse_enabled           = var.kms.enabled ? null : var.sqs_managed_sse_enabled

  max_message_size           = var.max_message_size
  message_retention_seconds  = var.message_retention_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds

  tags = var.tags
}

resource "aws_sqs_queue_policy" "this" {
  count = var.policy_enabled ? 1 : 0

  queue_url = aws_sqs_queue.this.url
  policy    = var.policy
}

resource "aws_sqs_queue_redrive_policy" "this" {
  count = var.redrive_policy_enabled ? 1 : 0

  queue_url      = aws_sqs_queue.this.url
  redrive_policy = var.redrive_policy
}

resource "aws_sqs_queue_redrive_allow_policy" "this" {
  count = var.redrive_allow_policy_enabled ? 1 : 0

  queue_url            = aws_sqs_queue.this.url
  redrive_allow_policy = var.redrive_allow_policy
}
