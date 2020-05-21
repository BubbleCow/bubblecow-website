json.extract! post_author, :id, :name, :slug, :created_at, :updated_at
json.url post_author_url(post_author, format: :json)
