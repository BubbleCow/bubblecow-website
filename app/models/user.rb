class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, :trackable

  # Relationships
  has_many :visits, class_name: "Ahoy::Visit"
  has_many :notifications, foreign_key: :recipient_id
  has_many :services
  has_many :books
  has_many :orders
  has_many :developmental_edits
  has_many :sample_developmental_edits


  # attachments
  has_rich_text :note

  # roles
  enum role: [:writer, :content_creator, :editor, :manager, :admin]

  after_initialize do
    if self.new_record?
      self.role ||= :writer
    end
  end

  extend FriendlyId
  friendly_id :full_name, use: :slugged

  def should_generate_new_friendly_id?
    first_name_changed? || last_name_changed?
  end

  def user_location(country)
    case country
    when "GB", "UK", "United Kingdom"
      "United Kingdom"
    when "US", "United States", "America"
      "United States"
    when "CA", "Canada"
      "Canada"
    when "Austria", "AT", "Belgium", "BE", "Cyprus", "CY", "Estonia", "EE", "Finland", "FI", "France", "FR", "Germany", "DE", "Greece", "GR", "Ireland", "IE", "Italy", "IT", "Latvia", "LV", "Lithuania", "LT", "Luxembourg", "LU", "Malta", "MT", "Netherlands", "NL", "Portugal", "PT", "Slovakia", "SK", "Slovenia", "SI", "Spain", "SA"
      "Europe"
    when "Australia", "AU"
      "Australia"
    when "New Zealand", "NZ"
      "New Zealand"
    when "India", "IN"
      "India"
    else
      "Undefined"
    end
  end

  # Scopes
  scope :staff, -> { where('role=? OR role=? OR role=? OR role=?', 1, 2, 3, 4) }
  scope :editorial_staff, -> { where('role=? OR role=? OR role=?', 2, 3, 4) }
  scope :marketing_staff, -> { where('role=? OR role=? OR role=?', 1, 3, 4) }
  scope :management, -> { where('role=? OR role=?', 2, 3) }

  # Methods
  has_person_name

  def full_name
    [first_name, last_name].join(' ').titleize
  end

  # ACTIVE CAMPAIGN
  # Calls the ac api on creation and update
  after_create :add_contact_to_active_campaign
  after_update :sync_contact_to_active_campaign

  # Add tag to active campaign - Stays out of private so can be called from non-User models
  def add_tag_to_active_campaign(tag_name)
    api = ActiveCampaignApi.new
    api.add_tag_to_contact(self.email, tag_name)
  end

  private

  # set params for active campaign 
  def contact_params
    {
      email: self.email,
      firstName: self.first_name,
      lastName: self.last_name
    }
  end

  # add contact to active campaign 
  def add_contact_to_active_campaign
    api = ActiveCampaignApi.new
    response = api.sync_contact(contact_params)
  end

  # Syncs for active campaign 
  def sync_contact_to_active_campaign

    api = ActiveCampaignApi.new
    api.sync_contact(contact_params)
  end

end
