class PostCategory < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged

    def should_generate_new_friendly_id?
        name_changed?
    end

    has_many :posts

    # Scopes
    default_scope { order(created_at: :desc) }
end
