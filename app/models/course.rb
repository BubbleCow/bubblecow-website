class Course < ApplicationRecord

    # Relationships
    has_many :lessons, dependent: :destroy
    
    # Access Level
    enum access_level: { free: 0, paid: 1 }

    # Validations
    validates :title, presence: true
    validates :description, presence: true, length: { minimum: 10, maximum: 1000 }
    validates :description_short, presence: true, length: { minimum: 10, maximum: 500 }
    validates :access_level, presence: true, inclusion: { in: access_levels.keys }
    
    # Friendly_id
    extend FriendlyId
    friendly_id :title, use: :slugged
        
    # Alters friendly ID if title changed
    def should_generate_new_friendly_id?
        title_changed?
    end 

end
