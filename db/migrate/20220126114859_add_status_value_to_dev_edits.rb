class AddStatusValueToDevEdits < ActiveRecord::Migration[7.0]
  def change
    add_column :dev_edits, :status_value, :integer, default: 1
  end
end
