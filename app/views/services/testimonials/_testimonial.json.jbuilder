json.extract! testimonial, :id, :writer, :approved, :created_at, :updated_at
json.url testimonial_url(testimonial, format: :json)
