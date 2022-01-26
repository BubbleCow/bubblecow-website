class CreateDevEditSamples < ActiveRecord::Migration[7.0]
  def change
    create_table :dev_edit_samples do |t|
      t.integer :book_id
      t.string :status, default: "sample_developmental_edit_created"
      t.string :user_id
      t.datetime :accepted_date
      t.datetime :rejected_date
      t.datetime :return_date

      t.timestamps
    end
  end
end
