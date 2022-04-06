variable "lambda_bucket" {
  type        = string
  default     = "ferdaus-uploads"
  description = "S3 bucket containing the module Lambda source code."
}

variable "lambda_key" {
  type        = string
  default     = "appstream_expiry_function.zip"
  description = "The path to the Lambda ZIP file in the source S3 bucket."
}

variable "lambda_key_sha256" {
  type        = string
  default     = "appstream_expiry_function.zip.sha256.txt"
  description = "The path to the Lambda ZIP file SHA256 hash in the source S3 bucket, generated using: openssl dgst -sha256 -binary appstream_expiry_function.zip | openssl enc -base64 > appstream_expiry_function.zip.sha256.txt"
}

variable "app_name" {
  type        = string
  description = "Application name. Use only alhpanumeric characters plus '_' and '-'."
}

variable "app_description" {
  type        = string
  description = "Application description."
}

variable "image_name" {
  type        = string
  description = "The name of the image for instances."
}

/* variable "fleet_subnets" {
  type        = list(string)
  description = "A list of Subnet IDs for the Fleet. Example: [\"subnet-asdkjh2398732jk\", \"subnet-lkj890734jhb35\"]"
}

variable "fleet_security_groups" {
  type        = list(string)
  description = "A list of Security Group IDs for the fleet. Example: [\"sg-kjh3465\", \"sg-567kjhk\"]"
} */

variable "feedback_url" {
  type        = string
  description = "URL for feedback form. Use null to disable."
}

variable "redirect_url" {
  type        = string
  description = "URL to redirect users after logging out. Use null to disable."
}

variable "application_persistence" {
  type        = bool
  default     = false
  description = "Whether to enable application settings persistence between sessions."
}

variable "file_upload" {
  type        = string
  default     = "DISABLED"
  description = "Whether to allow file uploads to the virtual instance."
}

variable "file_download" {
  type        = string
  default     = "DISABLED"
  description = "Whether to allow file downloads from the virtual instance."
}

variable "copy_to" {
  type        = string
  default     = "ENABLED"
  description = "Whether to allow clipboard copy to local device."
}

variable "copy_from" {
  type        = string
  default     = "ENABLED"
  description = "Whether to allow clipboard copy from local device."
}

variable "local_print" {
  type        = string
  default     = "DISABLED"
  description = "Whether to allow printing to local device."
}

variable "compute_capacity" {
  type        = number
  default     = 1
  description = "How many instances in the fleet."
}

variable "enable_internet" {
  type        = bool
  default     = false
  description = "Whether to allow instances to have Internet access."
}

variable "fleet_type" {
  type        = string
  default     = "ON_DEMAND"
  description = "Whether to use ON_DEMAND or ALWAYS_ON instances."
}

variable "instance_type" {
  type        = string
  default     = "stream.standard.medium"
  description = "The instance type to use for the Fleet."
}

variable "idle_disconnect" {
  type        = number
  default     = 300
  description = "How many seconds before an idle session disconnects."
}

variable "max_user_duration" {
  type        = number
  default     = 7200
  description = "How many seconds a user can stay online continuously per session."
}

variable "stream_view" {
  type        = string
  default     = "DESKTOP"
  description = "Whether to stream a specific APP or the entire DESKTOP."
}

variable "db_recovery" {
  type        = bool
  default     = false
  description = "Whether to allow point-in-time recovery for DynamoDB tables."
}

variable "expired_user_age" {
  type        = number
  default     = 7
  description = "How many days before a registered user is considered expired and removed from the User Pool. Set to 0 to disable."
}

variable "auth_type" {
  type        = string
  default     = "USERPOOL"
  description = "User authentication type for all operations."
}
