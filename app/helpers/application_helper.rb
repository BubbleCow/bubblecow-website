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

  # Sets structured data schema
  def structured_data_schema(type)
   
    case type

    when 'organization'
      render partial: 'structured_data_schemas/organization'
    when 'local_business'
      render partial: 'structured_data_schemas/local_business'
    when 'product_developmental_editiing'
      render partial: 'structured_data_schemas/product_developmental_editing'
    when 'product_mentoring'
      render partial: 'structured_data_schemas/product_mentoring'
    when 'blog_post'
      render partial: 'structured_data_schemas/blog_post'
    else 
      render partial: 'structured_data_schemas/webpage'
    end
      
    
  end

end
