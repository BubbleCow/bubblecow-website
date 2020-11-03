class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable

  after_create :set_country_and_currency

  has_many :notifications, foreign_key: :recipient_id
  has_many :services
  has_many :developmental_edits, dependent: :destroy
  has_many :sample_developmental_edits, dependent: :destroy

  has_person_name

  enum role: [:writer, :editor, :admin]

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

  # Scopes
  scope :staff, -> { where('role=? OR role=?', 1, 2) }
  scope :admins, -> { where(role: 2) }
  scope :editors, -> { where('role=? OR role=?', 1, 2) }
  scope :writers, -> { where(role: 0) }

end
