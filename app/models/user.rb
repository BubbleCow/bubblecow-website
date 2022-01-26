class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable

  has_many :notifications, foreign_key: :recipient_id
  has_many :services
  has_many :books, dependent: :destroy
  has_many :developmental_edits, dependent: :destroy
  has_many :sample_developmental_edits, dependent: :destroy

  has_rich_text :note

  has_person_name

  enum role: [:writer, :content_creator, :editor, :manager, :admin]

  after_initialize do
    if self.new_record?
      self.role ||= :writer
    end
  end

  def full_name
    [first_name, last_name].join(' ').titleize
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
  scope :staff, -> { where('role=? OR role=?', 1, 2) }
  scope :admins, -> { where(role: 2) }
  scope :editors, -> { where('role=? OR role=?', 1, 2) }
  scope :writers, -> { where(role: 0) }

end
