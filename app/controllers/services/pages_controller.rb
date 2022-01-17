module Services
  
  class PagesController < Services::ApplicationController
    skip_before_action :authenticate_user!
  
    def copy_editing
    end
  
    def mentoring
    end

    def manuscript_assessment
    end

  end
end