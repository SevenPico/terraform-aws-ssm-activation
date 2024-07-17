module "ssm_activation" {
  source  = "../../"
  context = module.context.self
  enabled = module.context.enabled

  kms_key_deletion_window_in_days  = 30
  kms_key_enable_key_rotation      = true
  kms_key_id                       = ""
  kms_key_multi_region             = false
  registration_limit               = "5"
  replica_regions                  = []
  secret_read_principals           = {}
  secret_update_sns_pub_principals = {}
  secret_update_sns_sub_principals = {}
  rotation_days                    = 365
}