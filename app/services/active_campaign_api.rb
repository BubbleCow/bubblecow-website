require 'httparty'

class ActiveCampaignApi
  include HTTParty

  def initialize
    creds = Rails.application.credentials
    @options = {
      headers: {
        'Api-Token' => creds.active_campaign[:AC_CAMPAIGN_KEY],
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
    }
    self.class.base_uri creds.active_campaign[:AC_CAMPAIGN_URL]
  end

  # Create a new contact
  def create_contact(contact_params)
    body = {
      contact: contact_params
    }.to_json

    self.class.post('/api/3/contacts', @options.merge({ body: body }))
  end

  # Sync a contact (create or update)
  def sync_contact(contact_params)
    body = {
      contact: contact_params
    }.to_json

    self.class.post('/api/3/contact/sync', @options.merge({ body: body }))
  end

  # Add a tag to a contact
  def add_tag_to_contact(email, tag_name)
    contact = find_contact_by_email(email)
    return unless contact.present?
  
    tag_id = find_tag_id_by_name(tag_name)
    return unless tag_id.present?
  
    body = {
      contactTag: {
        contact: contact['id'],
        tag: tag_id
      }
    }.to_json
  
    self.class.post('/api/3/contactTags', @options.merge({ body: body }))
  end
  
  private
  
  # Find a contact by email
  def find_contact_by_email(email)
    query = {
      search: email,
      search_field: 'email'
    }
  
    response = self.class.get('/api/3/contacts', @options.merge({ query: query }))
    if response.code == 200 && response['contacts'].present?
      return response['contacts'].first
    end
  
    nil
  end
  
  # Find a tag ID by name
  def find_tag_id_by_name(tag_name)
    query = {
      search: tag_name,
      search_field: 'tag',
      limit: 1
    }
  
    response = self.class.get('/api/3/tags', @options.merge({ query: query }))
    if response.code == 200 && response['tags'].present?
      return response['tags'].first['id']
    end
  
    nil
  end
end
