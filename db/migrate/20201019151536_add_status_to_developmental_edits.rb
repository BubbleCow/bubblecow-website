class AddStatusToDevelopmentalEdits < ActiveRecord::Migration[6.0]
  def change
    add_column :developmental_edits, :status, :string, default: 'developmental_edit_created'
  end
end
