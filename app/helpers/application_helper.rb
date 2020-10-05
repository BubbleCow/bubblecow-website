module ApplicationHelper
  def bootstrap_class_for(flash_type)
    {
      success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-info"
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def bubblecow_name
    content_tag(:span, "Bubble", class: "first-word") + content_tag(:span, "Cow", class: "last-word")
  end
end
