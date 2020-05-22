class EditorialServicesController < ApplicationController
    layout :resolve_layout
  
    def book_editing
    end
  
    def copy_editing
    end
  
    def full_package
    end
  
    def pricing
    end

    def file_safety
      @page_title = "File Safety"
      @page_description = "Discover how we ensure your manuscript is kept safe." 
    end

    private

    def resolve_layout
      case action_name
      when "book_editing"
        "template_no_container"
      when "file_safety"
        "template_narrow"
      else
        "application"
      end
    end

  end