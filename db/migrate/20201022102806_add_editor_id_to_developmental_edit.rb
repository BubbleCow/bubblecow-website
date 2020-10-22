class AddEditorIdToDevelopmentalEdit < ActiveRecord::Migration[6.0]
  def change
    add_column :developmental_edits, :editor_id, :integer
  end
end
