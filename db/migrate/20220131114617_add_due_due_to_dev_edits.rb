class AddDueDueToDevEdits < ActiveRecord::Migration[7.0]
  def change
    add_column :dev_edits, :due_date, :datetime
  end
end
