# --------------------------------------------------------------------------
# SSM Activation
# --------------------------------------------------------------------------
resource "time_rotating" "activation_code_rotation" {
  count         = module.context.enabled ? 1 : 0
  rotation_days = var.registration_instance_limit_days
}

resource "aws_ssm_activation" "ssm_activation" {
  count              = module.context.enabled ? 1 : 0
  name               = "${module.context.id}-ssm-activation"
  description        = "SSM Activation Code"
  iam_role           = var.iam_role_arn
  registration_limit = var.registration_instance_limit
  expiration_date    = try(time_rotating.activation_code_rotation[0].id, "")
  tags               = module.context.tags
}


# --------------------------------------------------------------------------
# SSM Activation Secret
# --------------------------------------------------------------------------
locals {
  secret_string = {
    activation_id : try(aws_ssm_activation.ssm_activation[0].id, "")
    activation_code : try(aws_ssm_activation.ssm_activation[0].activation_code, "")
  }
}

module "ssm_activation_secret" {
  source  = "registry.terraform.io/SevenPico/secret/aws"
  version = "3.2.9"
  context = module.context.self
  enabled = module.context.enabled

  create_sns                      = false
  description                     = "SSM Activation Secret"
  kms_key_id                      = var.kms_key_id
  replica_regions                 = var.replica_regions
  kms_key_deletion_window_in_days = var.kms_key_deletion_window_in_days
  kms_key_enable_key_rotation     = var.kms_key_enable_key_rotation
  kms_key_multi_region            = var.kms_key_multi_region
  secret_ignore_changes           = false
  secret_read_principals          = var.secret_read_principals
  secret_string                   = jsonencode(local.secret_string)
  sns_pub_principals              = var.secret_update_sns_pub_principals
  sns_sub_principals              = var.secret_update_sns_sub_principals
}