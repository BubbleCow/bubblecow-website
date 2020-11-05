class ActiveCampaignService

    def contact_sync(user)
      client.contact_sync(
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name
      )
    end
  
    def contact_tag_add(email, tags)
       client.contact_tag_add(email: email, tags: tags)
    end
  
    # private
  
    def client
      @client ||= ActiveCampaign.new(
        api_endpoint: Rails.application.credentials.active_campaign[:AC_CAMPAIGN_URL],
        api_key: Rails.application.credentials.active_campaign[:AC_CAMPAIGN_KEY])
    end

  end
