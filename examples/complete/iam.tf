# --------------------------------------------------------------------------
# SSM Activation Role
# --------------------------------------------------------------------------
module "ssm_activation_iam_role" {
  source  = "registry.terraform.io/SevenPicoForks/iam-role/aws"
  version = "2.0.0"
  context = module.context.self

  assume_role_actions = ["sts:AssumeRole"]
  assume_role_conditions = [
    {
      test     = "aws:SourceAccount"
      variable = "StringEquals"
      values   = [local.account_id]
    },
    {
      test     = "aws:SourceArn"
      variable = "StringEquals"
      values   = ["${local.arn_prefix}:ssm:${local.region}:${local.account_id}:*"]
  }]
  instance_profile_enabled = false
  managed_policy_arns      = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  max_session_duration     = 3600
  path                     = "/"
  permissions_boundary     = ""
  policy_description       = ""
  policy_document_count    = 0
  policy_documents         = []
  principals = {
    Service : [
      "ssm.amazonaws.com"
    ]
  }
  role_description = "SSM Activation role"
  use_fullname     = true
}