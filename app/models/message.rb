class Message < ApplicationRecord
    has_rich_text :content
    has_person_name

    validates :sender_name, :sender_email, :content, presence: true

    # Scopes
    default_scope { order(created_at: :desc) }
    scope :read, -> {where(read: true)}
    scope :unread, -> {where(read: false)}
end
