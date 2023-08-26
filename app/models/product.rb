class Product < ApplicationRecord
    
    # Relationships
    has_many :orders
    has_many :books, through: :orders

    # Action text
    has_rich_text :description
  
    # Sets frienndly_id on full name
    extend FriendlyId
    friendly_id :name, use: :slugged

    # Changes friendly_id on name change
    def should_generate_new_friendly_id?
        name_changed?
    end

end
