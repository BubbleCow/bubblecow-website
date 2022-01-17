class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  before_action :redirect_subdomain
  before_action :masquerade_user!

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_country, if: :devise_controller?
  before_action :sync_user, unless: :devise_controller?

  include Pundit
  protect_from_forgery with: :exception

  # Locks down staging - https://dzone.com/articles/block-web-crawlers-with-rails
  if ENV["DISALLOW_ALL_WEB_CRAWLERS"].present?

    http_basic_authenticate_with(
      name: ENV.fetch("BASIC_AUTH_USERNAME"),
      password: ENV.fetch("BASIC_AUTH_PASSWORD"),
    )

  end  

  protected

    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
    end

    def store_user_location!
      # :user is the scope we are authenticating
      store_location_for(:user, request.fullpath)
    end

    def redirect_subdomain
      if request.host == 'www.bubblecow.com'
        redirect_to 'http://bubblecow.com' + request.fullpath, :status => 301
      end
    end

    def after_sign_in_path_for(resource)
      if current_user.admin?
        admin_dashboard_path
      elsif current_user.writer?
        if stored_location_for(resource) == new_services_sample_developmental_edit_path
          new_services_sample_developmental_edit_path
        elsif stored_location_for(resource) == new_services_developmental_edit_path
          new_services_developmental_edit_path
        else 
          writer_dashboard_path
        end
      end
    end
  
    def after_sign_out_path_for(resource)
      root_path
    end

    # DEVISE ACTIONS

    # White lists and sets variables
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :country, :currency, :note])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :country, :currency, :note])

    end

    def sync_user
      return unless user_signed_in?
      ActiveCampaignService.new.contact_sync(current_user)
    end

    # Finds user country and adds correct currency
    def set_country
      if Rails.env.development?
        @country = "local host"
        @currency = "usd"
      else
        case request.location.country_code
        when "UK", "GB"
          @country = request.location.country_code
          @currency = "gbp"
        when "us"
          @country = request.location.country_code
          @currency = "usd"
        when "BE", "EL", "LT", "PT", "BG", "ES", "LU", "RO", "CZ", "FR", "HU", "SI", "DK", "HR", "MT", "SK", "DE", "IT", "NL", "FI", "EE", "CY", "AT", "SE", "IE", "LV", "PL"
          @country = request.location.country_code
          @currency = "euro"
        when "AU"
          @country = request.location.country_code
          @currency = "aud"
        else
          @country = request.location.country_code
          @currency = "usd"
        end
      end
    end
    
end
