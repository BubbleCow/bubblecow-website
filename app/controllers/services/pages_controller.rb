module Services
  
  class PagesController < Services::ApplicationController
    skip_before_action :authenticate_user!

    def file_safety
      @page_title = "File Safety"
      @page_description = "Discover how we ensure your manuscript is kept safe." 
    end
  
    def copy_editing
    end
  
    def mentoring
    end

    def manuscript_assessment
    end

  end
end