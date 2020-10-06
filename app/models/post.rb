class Post < ApplicationRecord
    belongs_to :post_category
    belongs_to :post_author

    before_update :set_published_date
    before_save :set_seo

    has_rich_text :seo_description
    has_rich_text :body
    has_rich_text :post_description
    has_one_attached :post_image

    extend FriendlyId
    friendly_id :title, use: :slugged

    def should_generate_new_friendly_id?
        title_changed?
    end

    validates :post_title, presence: true
    
    # Scopes
    default_scope { order(created_at: :desc) }
    scope :published, -> {where(published: true)}

    private

    # Sets published at date, removes if unpublished
    def set_published_date
        if published_changed?
            if published == false
                self.published_at = nil
            else
                self.published_at = Time.now
            end
        end
    end

    # set SEO values
    def set_seo
        if self.seo_title.blank?
            self.seo_title = self.title
        end
        if self.seo_description.blank?
            self.seo_description = self.description
        end
    end
end
