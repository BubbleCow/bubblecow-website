json.extract! book, :id, :title, :user_id, :language, :genre_id, :word_count, :slug, :created_at, :updated_at
json.url book_url(book, format: :json)
