class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :sender_first_name
      t.string :sender_last_name
      t.text :content
      t.string :sender_email
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
