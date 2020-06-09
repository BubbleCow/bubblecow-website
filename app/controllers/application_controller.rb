class ApplicationController < ActionController::Base
  before_filter :add_www_subdomain
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :masquerade_user!

  include Pundit
  protect_from_forgery with: :exception

  protected

    def add_www_subdomain
      unless /^www/.match(request.host)
        redirect_to("#{request.protocol}x.com#{request.request_uri}",
                    :status => 301)
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

    def after_sign_in_path_for(resource)
      dashboard_path
    end
  
    def after_sign_out_path_for(resource)
      root_path
    end
end
