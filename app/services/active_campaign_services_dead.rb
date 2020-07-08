class ActiveCampaignService
  
  #   def contact_tag_add(email, tags)
  #       return unless is_production?
  #       client.contact_tag_add(email: email, tags: tags)
  #   end
  
  #   private
  
  #   def client
  #     @client ||= ActiveCampaign.new(
  #       api_endpoint: Rails.application.credentials.active_campaign[:AC_CAMPAIGN_URL],
  #       api_key: Rails.application.credentials.active_campaign[:AC_CAMPAIGN_KEY])
  #   end
  
  #   def is_production?
  #     Rails.env.production?
  #   end
  # end