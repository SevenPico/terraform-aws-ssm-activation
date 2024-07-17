## ----------------------------------------------------------------------------
##  Copyright 2023 SevenPico, Inc.
##
##  Licensed under the Apache License, Version 2.0 (the "License");
##  you may not use this file except in compliance with the License.
##  You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
##  Unless required by applicable law or agreed to in writing, software
##  distributed under the License is distributed on an "AS IS" BASIS,
##  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##  See the License for the specific language governing permissions and
##  limitations under the License.
## ----------------------------------------------------------------------------

## ----------------------------------------------------------------------------
##  ./_variables.tf
##  This file contains code written by SevenPico, Inc.
## ----------------------------------------------------------------------------
variable "registration_instance_limit_days" {
  type    = number
  default = 30
  description = "(Number) Number of days to add to the base timestamp to configure the rotation timestamp."
}

variable "registration_instance_limit"{
  type    = number
  default = 1
  description = "(Optional) The maximum number of managed instances you want to register. The default value is 1 instance."
}

variable "kms_key_deletion_window_in_days" {
  description = "Deletion window for KMS Keys created in this module. This is disable when kms_key_id != null."
  type        = number
  default     = 30
}

variable "kms_key_enable_key_rotation" {
  description = "Turn on KMS Key rotation for KMS Keys created in this module. This is disable when kms_key_id != null."
  type        = bool
  default     = true
}

variable "kms_key_multi_region" {
  type        = bool
  default     = false
  description = "Indicates whether the KMS key is a multi-Region (true) or regional (false) key. This is disable when kms_key_id != null."
}

variable "replica_regions" {
  type        = list(string)
  default     = []
  description = "Secrets Manager Secondary Region"
}

variable "kms_key_id" {
  type        = string
  default     = null
  description = "If kms_key_id != null then kms_key_enable_key_rotation, kms_key_deletion_window_in_days, kms_key_multi_region are ignored"
}

variable "secret_read_principals" {
  type    = map(any)
  default = {}
}

variable "secret_update_sns_pub_principals" {
  type    = map(any)
  default = {}
}

variable "secret_update_sns_sub_principals" {
  type    = map(any)
  default = {}
}

variable "iam_role_arn" {
  type = string
  default = ""
}
