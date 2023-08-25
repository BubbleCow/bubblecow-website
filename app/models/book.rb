class Book < ApplicationRecord
    
    # Relationships
    belongs_to :user
    belongs_to :genre
    has_many :orders
    accepts_nested_attributes_for :orders
    has_many :products, through: :orders

    # Action text
    has_rich_text :description

    # Validations
    validates :title, presence: true
    validates :description, presence: true
    validates :word_count, numericality: { greater_than_or_equal_to: 15000,  only_integer: true }
    validates :language, presence: true
    validates :genre, presence: true

    # Friendly_id
    extend FriendlyId
    friendly_id :title, use: :slugged

    # Alters friendly ID if title changed
    def should_generate_new_friendly_id?
        title_changed?
    end 

end
