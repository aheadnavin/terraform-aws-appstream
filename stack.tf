resource "aws_appstream_stack" "stack" {
  name         = var.app_name
  description  = var.app_description
  display_name = var.app_name
  feedback_url = var.feedback_url
  redirect_url = var.redirect_url

  storage_connectors {
    connector_type = "HOMEFOLDERS"
  }

  /* user_settings {
    action     = "CLIPBOARD_COPY_FROM_LOCAL_DEVICE"
    permission = var.copy_from
  }
  user_settings {
    action     = "CLIPBOARD_COPY_TO_LOCAL_DEVICE"
    permission = var.copy_to
  }
  user_settings {
    action     = "FILE_UPLOAD"
    permission = var.file_upload
  }
  user_settings {
    action     = "FILE_DOWNLOAD"
    permission = var.file_download
  }
  user_settings {
    action     = "PRINTING_TO_LOCAL_DEVICE"
    permission = var.local_print
  }
  user_settings {
    action     = "DOMAIN_PASSWORD_SIGNIN"
    permission = var.domain_password
  }
  user_settings {
    action     = "DOMAIN_SMART_CARD_SIGNIN"
    permission = var.domain_smartcard
  } */

  application_settings {
    enabled        = var.application_persistence
    settings_group = "SettingsGroup"
  }
}
