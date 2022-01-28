class CreateDevEdits < ActiveRecord::Migration[7.0]
  def change
    create_table :dev_edits do |t|
      t.integer :book_id
      t.string :status, default: "developmental_edit_created"
      t.integer :user_id
      t.datetime :accepted_date
      t.datetime :rejected_date
      t.datetime :invoice_due_date
      t.datetime :invoice_paid_date
      t.datetime :return_date

      t.timestamps
    end
  end
end
