class Ebook < ApplicationRecord
    has_one_attached :cover
    has_one_attached :pdf_file
    has_one_attached :epub_file
  
    validates :title, presence: true
    validates :description, presence: true
    validates :version, presence: true
  
    validate :at_least_one_format

    # Friendly_id
    extend FriendlyId
    friendly_id :title, use: :slugged
    
    # Alters friendly ID if title changed
    def should_generate_new_friendly_id?
        title_changed?
    end 
  
    private
  
    def at_least_one_format
      errors.add(:base, "Must have at least one file (PDF or ePub)") unless pdf_file.attached? || epub_file.attached?
    end
  end
  