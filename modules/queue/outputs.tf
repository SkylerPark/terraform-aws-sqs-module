output "id" {
  description = "SQS queue URL or ID."
  value       = aws_sqs_queue.this.id
}

output "arn" {
  description = "SQS queue ARN."
  value       = aws_sqs_queue.this.arn
}

output "name" {
  description = "SQS queue 이름."
  value       = aws_sqs_queue.this.name
}
