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

    private

    def resolve_layout
      case action_name
      when "book_editing"
        "template_no_container"
      else
        "application"
      end
    end

  end