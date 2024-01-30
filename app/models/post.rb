class Post < ApplicationRecord
    before_update :set_published_date
    before_save :set_seo

    belongs_to :post_category
    belongs_to :post_author

    acts_as_taggable_on :tags

    has_rich_text :seo_description
    has_rich_text :body
    has_rich_text :post_description
    has_one_attached :post_image

    extend FriendlyId
    friendly_id :title, use: :slugged

    visitable :ahoy_visit

    def should_generate_new_friendly_id?
        title_changed?
    end

    validates :post_title, presence: true
    
    # Scopes
    default_scope { order(created_at: :desc) }
    scope :published, -> {where(published: true)}

    # finds posts in the same post category
    scope :in_same_post_category_except_current, -> (post_category_id, current_post_id) {
        where(post_category_id: post_category_id).where.not(id: current_post_id)
    }

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
            self.seo_title = self.post_title
        end
        if self.seo_description.blank?
            self.seo_description = self.post_description
        end
    end
end
