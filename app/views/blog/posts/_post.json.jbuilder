json.extract! post, :id, :title, :slug, :post_category_id, :post_author_id, :created_at, :updated_at
json.url post_url(post, format: :json)
