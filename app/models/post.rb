class Post < ApplicationRecord
    belongs_to :post_category
    belongs_to :post_author

    has_rich_text :seo_description
    has_rich_text :body
    has_rich_text :post_description
    has_one_attached :post_image

    extend FriendlyId
    friendly_id :permalink, use: :slugged

    def should_generate_new_friendly_id?
        permalink_changed?
    end

    validates :title, :post_image, presence: true
    
    # Scopes
    default_scope { order(created_at: :desc) }
    scope :published, -> {where(published: true)}
end
