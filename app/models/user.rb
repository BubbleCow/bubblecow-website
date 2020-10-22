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

end
