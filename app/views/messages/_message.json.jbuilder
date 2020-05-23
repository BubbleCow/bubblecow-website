json.extract! message, :id, :sender_first_name, :sender_last_name, :content, :sender_email, :read, :created_at, :updated_at
json.url message_url(message, format: :json)
