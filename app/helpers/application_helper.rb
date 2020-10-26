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

  def is_active?(path)       
    return 'active' if request.path == path     
  end

  def side_navigation_title(path)
    case path
    when admin_area_blog_path
      "Blog"
    when services_developmental_edits_path
      "Editing"
    when admin_area_users_path
      "Users"
    when admin_area_testimonials_path
      "Testimonials"
    else
      "Dashboard"
    end
  end

end
