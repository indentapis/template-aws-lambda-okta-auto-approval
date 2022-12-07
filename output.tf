output "idt-okta-auto-approval-webhook-url" {
  value       = module.idt-okta-auto-approval-webhook.function_url
  description = "The URL of the deployed Lambda"
}

