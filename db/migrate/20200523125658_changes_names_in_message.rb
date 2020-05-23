class ChangesNamesInMessage < ActiveRecord::Migration[6.0]
  def change
    rename_column :messages, :sender_first_name, :first_name
    rename_column :messages, :sender_last_name, :last_name
  end
end
