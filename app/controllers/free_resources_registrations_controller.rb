class FreeResourcesRegistrationsController < ApplicationController
  layout :set_layout

    def free_signup
      # Set up a blank user for the form_for method
      @user = User.new
      @resource = @user
      @resource_name = :user
    end
  
    def paid_signup
      # Your logic here
    end
    
  private

    def set_layout
        case action_name
        when 'free_signup'
            'page_templates/page_devise'
        else
          'application'
        end
    end

end
  