json.extract! dev_edit, :id, :status, :user_id, :accepted_date, :rejected_date, :invoice_due_date, :invoice_paid_date, :return_date, :due_date, :created_at, :updated_at
json.url dev_edit_url(dev_edit, format: :json)
