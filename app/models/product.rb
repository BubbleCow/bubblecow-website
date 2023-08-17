class Product < ApplicationRecord

    # relatopnships
    has_many :order_items
    has_many :orders, through: :order_items
    
    extend FriendlyId
    friendly_id :name, use: :slugged

    validates :name, presence: true

    def should_generate_new_friendly_id?
        name_changed?
    end

end
