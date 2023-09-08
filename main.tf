terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + Okta Auto Approval Integration

# Details: https://github.com/indentapis/integrations/tree/089e36c98bd88726dc6751edf90767725d3d0b35/packages/stable/indent-integration-okta
# Last Change: https://github.com/indentapis/integrations/commit/089e36c98bd88726dc6751edf90767725d3d0b35

module "idt-okta-auto-approval-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-okta-auto-approval-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/okta-auto-approval-089e36c98bd88726dc6751edf90767725d3d0b35-function.zip"
    deps_key     = "webhooks/aws/lambda/okta-auto-approval-089e36c98bd88726dc6751edf90767725d3d0b35-deps.zip"
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

