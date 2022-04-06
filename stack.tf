resource "aws_appstream_stack" "stack" {
  name         = var.app_name
  description  = var.app_description
  display_name = var.app_name
  feedback_url = var.feedback_url
  redirect_url = var.redirect_url

  storage_connectors {
    connector_type = "HOMEFOLDERS"
  }

  user_settings {
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

  application_settings {
    enabled        = var.application_persistence
    settings_group = "SettingsGroup"
  }
}
