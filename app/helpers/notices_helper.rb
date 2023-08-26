module NoticesHelper

    # sets flash for notices
    def bootstrap_class_for(flash_type)
        {
        success: "alert-success",
        error: "alert-danger",
        alert: "alert-warning",
        notice: "alert-success"
        }.stringify_keys[flash_type.to_s] || flash_type.to_s
    end
  
    # formats the error messages
    def format_error_message(message)
      formatted_message = message.gsub(/\.+/, '.').split('. ').map(&:capitalize).join('. ')
      formatted_message[-1] == '.' ? formatted_message : formatted_message + '.'
    end

end