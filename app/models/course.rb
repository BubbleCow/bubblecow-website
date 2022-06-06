class Course < ApplicationRecord

    # Relationships
    has_many :lessons, dependent: :destroy
    
    extend FriendlyId
    friendly_id :title, use: :slugged

    def should_generate_new_friendly_id?
        title_changed?
    end

    # validations
    validates :title, presence: true

end
