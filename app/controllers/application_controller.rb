class ApplicationController < ActionController::Base
  before_action :redirect_subdomain
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :masquerade_user!

  include Pundit
  protect_from_forgery with: :exception

  protected

    def redirect_subdomain
      if request.host == 'www.bubblecow.com'
        redirect_to 'http://bubblecow.com' + request.fullpath, :status => 301
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
