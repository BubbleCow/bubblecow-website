module ApplicationHelper

  # sets flash for notices
  def bootstrap_class_for(flash_type)
    {
      success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-success"
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  # Outputs 'bubblecow'
  def bubblecow_name
    content_tag(:span, "Bubble", class: "brand-first-word") + content_tag(:span, "Cow", class: "brand-second-word")
  end

  # sets active path
  def is_active?(path)       
    return 'active' if request.path == path     
  end

end
