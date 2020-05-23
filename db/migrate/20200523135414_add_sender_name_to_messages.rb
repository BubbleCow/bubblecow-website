class AddSenderNameToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :sender_name, :string
  end
end
