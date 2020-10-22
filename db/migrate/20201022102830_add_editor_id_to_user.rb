class AddEditorIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :editor_id, :integer
  end
end
