class RemoveDevEditSamplesAndDevEdits < ActiveRecord::Migration[7.0]
  def change
    drop_table :dev_edit_samples
    drop_table :dev_edits
  end
end
