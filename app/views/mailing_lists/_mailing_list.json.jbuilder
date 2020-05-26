json.extract! mailing_list, :id, :email, :tag, :created_at, :updated_at
json.url mailing_list_url(mailing_list, format: :json)
