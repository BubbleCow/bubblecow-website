class AddArchivedToMessage < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :archived, :boolean, default: false
  end
end
