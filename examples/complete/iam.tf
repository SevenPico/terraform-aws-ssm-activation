# --------------------------------------------------------------------------
# SSM Activation Role
# --------------------------------------------------------------------------
data "aws_iam_policy_document" "role_policy_doc" {
  count = module.context.enabled ? 1 : 0
  statement {
    sid    = "AllowIam"
    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]
    resources = [
      "${local.arn_prefix}:iam::${local.account_id}:role/${module.context.id}"
    ]
  }
}

module "ssm_activation_iam_role" {
  source  = "registry.terraform.io/SevenPicoForks/iam-role/aws"
  version = "2.0.0"
  context = module.context.self

  assume_role_actions = ["sts:AssumeRole"]
  assume_role_conditions = [
    {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [local.account_id]
    },
    {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["${local.arn_prefix}:ssm:${local.region}:${local.account_id}:*"]
  }]
  instance_profile_enabled = true
  managed_policy_arns      = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  max_session_duration     = 3600
  path                     = "/"
  permissions_boundary     = ""
  policy_description       = ""
  policy_document_count    = 1
  policy_documents         = data.aws_iam_policy_document.role_policy_doc.*.json
  principals = {
    Service : [
      "ssm.amazonaws.com"
    ]
  }
  role_description = "SSM Activation role"
  use_fullname     = true
}