class CoursesRegistrationsController < ApplicationController
    def free_signup
        # Set up a blank user for the form_for method
  @user = User.new
  @resource = @user
  @resource_name = :user
    end
  
    def paid_signup
      # Your logic here
    end
    
    # ... any other actions ...
  end
  