terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + Okta Auto Approval Integration

# Details: https://github.com/indentapis/integrations/tree/c31c0a2f5371078d198ff8ae1a847404c628620e/packages/stable/indent-integration-okta
# Last Change: https://github.com/indentapis/integrations/commit/c31c0a2f5371078d198ff8ae1a847404c628620e

module "idt-okta-auto-approval-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-okta-auto-approval-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/okta-auto-approval-c31c0a2f5371078d198ff8ae1a847404c628620e-function.zip"
    deps_key     = "webhooks/aws/lambda/okta-auto-approval-c31c0a2f5371078d198ff8ae1a847404c628620e-deps.zip"
  }
  env = {
    OKTA_DOMAIN               = var.okta_domain
    OKTA_TOKEN                = var.okta_token
    OKTA_SLACK_APP_ID         = var.okta_slack_app_id
    OKTA_CLIENT_ID            = var.okta_client_id
    OKTA_PRIVATE_KEY          = var.okta_private_key
    AUTO_APPROVAL_OKTA_GROUPS = var.auto_approval_okta_groups
    AUTO_APPROVAL_DURATION    = var.auto_approval_duration
  }
}

