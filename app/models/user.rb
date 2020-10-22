class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable

  has_person_name
  
  enum role: [:writer, :editor, :admin]

  after_initialize do
    if self.new_record?
      self.role ||= :writer
    end
  end

  has_many :notifications, foreign_key: :recipient_id
  has_many :services
  has_many :developmental_edits, dependent: :destroy

  # Scopes
  scope :staff, -> { where('role=? OR role=?', 1, 2) }
  scope :admin, -> { where(role: 2) }
  scope :editor, -> { where('role=? OR role=?', 1, 2) }
  scope :writer, -> { where(role: 0) }

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

end
